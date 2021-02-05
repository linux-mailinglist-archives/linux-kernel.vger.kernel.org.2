Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C765E310862
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 10:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhBEJwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 04:52:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47053 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229683AbhBEJvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 04:51:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612518594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mE0Sa25QJft8h1gG6TUmzfzDauFUSY+0f4sXeQe7gzY=;
        b=ZOFne7APrh4kueXitaERddi3eGJIyQGRVCCM0CYB8/jMh5WuDJ7Oyw+599lAwg5iwbiM8f
        T9cMD4Me+WI/aMYY0VVamyhV290g54upLaj4r3PkCE/WYZHH+HrKhyynY86CQUZhGiStVQ
        79iNi4opOccc9MWlHOUS+L8RbUvyjbU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-VAxqb7yAMSyio1gwyHhsEw-1; Fri, 05 Feb 2021 04:49:52 -0500
X-MC-Unique: VAxqb7yAMSyio1gwyHhsEw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4AF51100CC88;
        Fri,  5 Feb 2021 09:49:51 +0000 (UTC)
Received: from krava (unknown [10.40.195.59])
        by smtp.corp.redhat.com (Postfix) with SMTP id 344F71971C;
        Fri,  5 Feb 2021 09:49:49 +0000 (UTC)
Date:   Fri, 5 Feb 2021 10:49:48 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 2/2] perf script: Support filtering by hex address
Message-ID: <YB0UvM6t+BSqQkkk@krava>
References: <20210129070854.29312-1-yao.jin@linux.intel.com>
 <20210129070854.29312-2-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129070854.29312-2-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 29, 2021 at 03:08:54PM +0800, Jin Yao wrote:

SNIP

> +			}
> +		}
> +
>  		if (!ret)
>  			al->filtered |= (1 << HIST_FILTER__SYMBOL);
>  	}
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 64a039cbba1b..2c13f6acda7f 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -2406,6 +2406,39 @@ int setup_intlist(struct intlist **list, const char *list_str,
>  	return 0;
>  }
>  
> +static int setup_addrlist(struct intlist **addr_list, struct strlist *sym_list)
> +{
> +	struct str_node *pos, *tmp;
> +	unsigned long val;
> +	char *sep;
> +	int err = 0, i = 0;
> +
> +	*addr_list = intlist__new(NULL);
> +	if (!*addr_list)
> +		return -1;
> +
> +	strlist__for_each_entry_safe(pos, tmp, sym_list) {
> +		val = strtoul(pos->s, &sep, 16);
> +		if (*sep != ',' && *sep != '\0')
> +			continue;

I think you also need to check that val is valid and errno
(check other strtoul we call in perf)
because above could pass for:

	$ ./perf script -S ",7fd0f1b69a13"
	ls 651468 410180.795577:      90098 cycles:u:      7fd0f1b69a13 __GI___tunables_init+0x73 (/usr/lib64/ld-2.32.so)


plus check for " " so we could do:

	$ ./perf script -S "7fd0f1b69a13 ,7fd0f1b5e189"
	ls 651468 410180.796055:     190731 cycles:u:      7fd0f1b5e189 _dl_relocate_object+0x4b9 (/usr/lib64/ld-2.32.so)

	$ ./perf script -S "7fd0f1b69a13,7fd0f1b5e189"
	ls 651468 410180.795577:      90098 cycles:u:      7fd0f1b69a13 __GI___tunables_init+0x73 (/usr/lib64/ld-2.32.so)
	ls 651468 410180.796055:     190731 cycles:u:      7fd0f1b5e189 _dl_relocate_object+0x4b9 (/usr/lib64/ld-2.32.so)


thanks,
jirka

