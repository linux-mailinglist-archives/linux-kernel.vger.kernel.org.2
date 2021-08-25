Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 234013F7771
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 16:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241741AbhHYOdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 10:33:09 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3691 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbhHYOdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 10:33:08 -0400
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GvpLY2dMHz67w73;
        Wed, 25 Aug 2021 22:31:01 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Wed, 25 Aug 2021 16:32:20 +0200
Received: from [10.47.26.214] (10.47.26.214) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 25 Aug
 2021 15:32:19 +0100
Subject: Re: [Question] perf tools: lex parsing issue
To:     Ian Rogers <irogers@google.com>
CC:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
References: <2e52bc21-8e60-f1fc-804b-d8993ca7c482@huawei.com>
 <CAP-5=fXqM4Y5R5BXJb9Caf8NO1Oyz+qFaote3AqFu0MDGCvgAQ@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <e6157b05-fadd-b15d-17cf-9d964517da9c@huawei.com>
Date:   Wed, 25 Aug 2021 15:36:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <CAP-5=fXqM4Y5R5BXJb9Caf8NO1Oyz+qFaote3AqFu0MDGCvgAQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.26.214]
X-ClientProxiedBy: lhreml721-chm.china.huawei.com (10.201.108.72) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/08/2021 01:13, Ian Rogers wrote:

Thanks for getting back to me


>> + if (term->type_term == PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD) {
>> +       term->config = strdup("period");
>> + }
>> +
>> if (!head) {
>>          parse_events_term__delete(term);
>>          YYABORT;
>> --
>>
>> ----8-----
> Agreed this is hacky,

This might be a *bit* better:

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index e5eae23cfceb..e597beaaa179 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1058,6 +1058,13 @@ static const char 
*config_term_names[__PARSE_EVENTS__TERM_TYPE_NR] = {
  	[PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE]	= "aux-sample-size",
  };

+const char * get_config_term(int term_type)
+{
+	if (term_type >= __PARSE_EVENTS__TERM_TYPE_NR)
+		return "";
+	return config_term_names[term_type];
+}
+
  static bool config_term_shrinked;

  static bool
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index bf6e41aa9b6a..0f658732535f 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -90,6 +90,8 @@ enum {
  	__PARSE_EVENTS__TERM_TYPE_NR,
  };

+const char *get_config_term(int term_type);
+
  struct parse_events_array {
  	size_t nr_ranges;
  	struct {
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 9321bd0e2f76..8d6d3fae226d 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -832,8 +832,9 @@ PE_TERM '=' PE_NAME
  PE_TERM '=' PE_VALUE
  {
  	struct parse_events_term *term;
+	char *config = strdup(get_config_term($1));

-	ABORT_ON(parse_events_term__num(&term, (int)$1, NULL, $3, false, &@1, 
&@3));
+	ABORT_ON(parse_events_term__num(&term, (int)$1, config, $3, false, 
&@1, &@3));
  	$$ = term;
  }


> I think it'd be better to fix this up in the
> output. For example:
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 6cdbee8a12e7..c77c42275efa 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -365,15 +365,21 @@ static int __perf_pmu__new_alias(struct
> list_head *list, char *dir, char *name,
>          memset(newval, 0, sizeof(newval));
>          ret = 0;
>          list_for_each_entry(term, &alias->terms, list) {
> +               const char * config = term->config;
> +
>                  if (ret)
>                          ret += scnprintf(newval + ret, sizeof(newval) - ret,
>                                           ",");
> +               if (!config) {
> +                       /* Note: config_term_names in parse_events.c
> isn't accessible */
> +                       config = config_term_names[term->type_term];

We could just expose some parse-events.c API, like above.

> +               }
>                  if (term->type_val == PARSE_EVENTS__TERM_TYPE_NUM)
>                          ret += scnprintf(newval + ret, sizeof(newval) - ret,
> -                                        "%s=%#x", term->config, term->val.num);
> +                                        "%s=%#x", config, term->val.num);
>                  else if (term->type_val == PARSE_EVENTS__TERM_TYPE_STR)
>                          ret += scnprintf(newval + ret, sizeof(newval) - ret,
> -                                        "%s=%s", term->config, term->val.str);
> +                                        "%s=%s", config, term->val.str);
>          }
> 
>          alias->name = strdup(name);

But how about this alternative simple one:

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index e5eae23cfceb..9e5df934d22d 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -3084,7 +3084,7 @@ int parse_events_term__num(struct 
parse_events_term **term,
  	struct parse_events_term temp = {
  		.type_val  = PARSE_EVENTS__TERM_TYPE_NUM,
  		.type_term = type_term,
-		.config    = config,
+		.config    = config ? : strdup(config_term_names[type_term]),
  		.no_value  = no_value,
  		.err_term  = loc_term ? loc_term->first_column : 0,
  		.err_val   = loc_val  ? loc_val->first_column  : 0,
-- 

> 
> It looks like a similar fix is needed in format_alias.

And the change in parse_events_term__num(), above, seems to resolve that.

Previously we would have something like these in format_alias():

buf=i915/bcs0-busy, pmu name=i915, alias->name=bcs0-busy ->str=(null)=0x1000

And now:

buf=i915/bcs0-busy, pmu name=i915, alias->name=bcs0-busy ->str=config=0x1000


Thoughts?

Thanks,
John

