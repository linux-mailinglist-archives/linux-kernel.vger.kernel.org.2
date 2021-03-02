Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A8832A232
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 15:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1836777AbhCBHUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 02:20:50 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:26978 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347841AbhCBGqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 01:46:03 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614667543; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=lPBgyd1J7Yq8i540u5i8VAgbFU7w/HyUwEY4QeeVj30=;
 b=rZ7B5UbJJF3c0hQoqC6EBp13bmk+UmBBorhjl7Z3P1KWyycHxWB+Uk5EqG17oSvyl27dJX7L
 6Q+bScqahhQYjZp1E/82JlEbBAY0F4QkWUyirEaU9X42SRgW5gDXZUXmTTD5GzvRAoHhoL0U
 tYvnhwTU1T9viRV6TXvlW/bpCzo=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 603ddef6832f19b9efab1642 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 02 Mar 2021 06:45:10
 GMT
Sender: saiprakash.ranjan=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5D6B4C43467; Tue,  2 Mar 2021 06:45:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 60477C433C6;
        Tue,  2 Mar 2021 06:45:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 02 Mar 2021 12:15:09 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, coresight@lists.linaro.org,
        Stephen Boyd <swboyd@chromium.org>,
        Denis Nikitin <denik@chromium.org>,
        Mattias Nissler <mnissler@chromium.org>,
        Al Grant <al.grant@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCHv2 2/4] perf evsel: Print warning for excluding kernel mode
 instruction tracing
In-Reply-To: <CAD=FV=UQbVpOLz_xavCPXQ9gN-9G4J8qN3+5f0E3jYZDDx4Cjw@mail.gmail.com>
References: <cover.1614624041.git.saiprakash.ranjan@codeaurora.org>
 <523a5af43615b804aa1211a3f27e06226d7159bc.1614624041.git.saiprakash.ranjan@codeaurora.org>
 <CAD=FV=UQbVpOLz_xavCPXQ9gN-9G4J8qN3+5f0E3jYZDDx4Cjw@mail.gmail.com>
Message-ID: <cca9ed70d86fb7781bdf242e8761c520@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 2021-03-02 04:13, Doug Anderson wrote:
> Hi,
> 
> On Mon, Mar 1, 2021 at 11:05 AM Sai Prakash Ranjan
> <saiprakash.ranjan@codeaurora.org> wrote:
>> 
>> Add a warning message to check CONFIG_EXCLUDE_KERNEL_HW_ITRACE kernel
>> config which excludes kernel mode instruction tracing to help perf 
>> tool
>> users identify the perf event open failure when they attempt kernel 
>> mode
>> tracing with this config enabled.
>> 
>> Tested-by: Denis Nikitin <denik@chromium.org>
>> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>> ---
>>  tools/perf/util/evsel.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> I'm not really knowledgeable at all about the perf subsystem so my
> review doesn't hold a lot of weight.  However, Sai's patch seems sane
> to me.
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Thanks for the review, I carefully modified all the patch commit 
messages
to change the config and wording from CONFIG_EXCLUDE_KERNEL_HW_ITRACE to
CONFIG_EXCLUDE_KERNEL_PMU_TRACE but missed this commit message. I will
fix this up in v3, but will hold off posting v3 till I get some feedback
on other patches.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
