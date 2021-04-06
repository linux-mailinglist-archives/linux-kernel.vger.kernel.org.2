Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4F6354FEA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 11:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235748AbhDFJcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 05:32:03 -0400
Received: from mail.codeweavers.com ([50.203.203.244]:50604 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbhDFJcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 05:32:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5FkcxajTibeYdrCIX51k3meJRElahfxK2YPLhmX0I1c=; b=gmdRsi5f7JMJKFwJ+1YhLU0mvt
        9E4WpZ2lQyLMWLK1YZ4nbgFn4Qv0c/n2CjsDB87410om8vgGJdLy7RqJOMklH46TnGYvA1k49U83D
        xCG0fG7PtUX5UBGAlTLttKLhkw0nkH6CdwoBFTfr8mA6npBz/MIfIufgllDdYC0grlFI=;
Received: from 198-48-224-11.cpe.pppoe.ca ([198.48.224.11] helo=[192.168.1.180])
        by mail.codeweavers.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <nfraser@codeweavers.com>)
        id 1lTi3t-00053P-EA; Tue, 06 Apr 2021 04:31:53 -0500
Subject: Re: [PATCH] perf data: Add JSON export
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Jin Yao <yao.jin@linux.intel.com>, linux-kernel@vger.kernel.org
References: <c4d0b0f1-79f4-f08d-3d7e-00046120f845@codeweavers.com>
 <YGXIDGfCLVtFuxgT@krava>
From:   Nicholas Fraser <nfraser@codeweavers.com>
Message-ID: <0831d8ee-12d5-dd28-dde4-a46e4781a76f@codeweavers.com>
Date:   Tue, 6 Apr 2021 05:31:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YGXIDGfCLVtFuxgT@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

Thanks again for the review. I've fixed the issues you mentioned. Some notes
below:


On 2021-04-01 8:15 a.m., Jiri Olsa wrote:
> I recall you did not add support for walltime clock,
> don't you need it to sync with other events?

Not necessarily. As long as the perf recording and the GPU trace are made from
the same clock, the events should line up; the real time doesn't matter. I've
added it anyway though since it's good to have. It now outputs "clockid",
"clock-time" and "real-time" in the headers if clock info was included in the
recording.


On 2021-04-01 9:18 a.m., Jiri Olsa wrote:
> also I will not push hard for test, becase we don't have any for CTF ;-)
> but if you could think of any, that'd be great

I'm not sure what kind of tests would be useful. We could include a small
perf.data file and its JSON output and verify that they match. This is probably
pointless because almost any change to the JSON code would be expected to
change the output so we'd just be resetting the test on each change.


> I was wondering how to make this \t mess more readable,
> how about you define function like output_json:
> 
> 	output_json(FILE, level, field, format, ...);
> 
> and use it:
> 
> 	output_json(c->out, 3, "data-offset", "PRIu64", header->data_offset);
> 	output_json(c->out, 3, "data-size", "PRIu64", header->data_size);
> 	output_json(c->out, 3, "feat-offset", PRIu64, header->feat_offset);
> 
> similar way as we do for pr_debug -> eprintf

I've cleaned up the output with some additional helper functions. This is
essentially turning into its own mini JSON encoder which I was hoping to avoid
but I suppose it's necessary to make the code maintainable.


I'll be sending a new patch shortly.

Nick

