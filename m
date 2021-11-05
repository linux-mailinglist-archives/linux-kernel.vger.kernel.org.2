Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54952446038
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 08:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbhKEHqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 03:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbhKEHqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 03:46:02 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A47C061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 00:43:23 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id y14-20020a17090a2b4e00b001a5824f4918so2745850pjc.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 00:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:organization:subject:in-reply-to
         :content-transfer-encoding;
        bh=hDOoOkqRZ7U9ysDeiWkOoUcmQQBlu93F6tJYyIDCxVk=;
        b=qIV/iMxGnqY+SrKQFhXzwhCjA+mJZjeC/aj7xv7NZp2J53z0LWlVShTsOoZ7rZLwgr
         KE/BPTK9aJdhQoia3fvkLfecfa7VCbn00ffEnE4lX2f84AhlQ8IRi7v4Opd894pe0Qyj
         mPJ5lxrd3VmcD+d7PIkCseBdEb+CaMIJs3dUcsvjvkv0Z6+hE2UBOqIgxjA0RK6SdIhe
         gZPhdAhWlS9xdKrctdkXKXSvMezcJHMlA2C7PZYRACZ7/l4a/3Nu3zFcZCICn8wNkikG
         t+N8/En5FrFHBdh9gEsyOANQbps87szXAixWuATuKgqzgiqLow9j2X7kRXOFvg4VRHLp
         7yFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=hDOoOkqRZ7U9ysDeiWkOoUcmQQBlu93F6tJYyIDCxVk=;
        b=d7kPUYdWARvsSMjHl4eATIwuzjW37XPtoTgA9DPvuzQZrCrIMeZ5QFJL35MYbsAax5
         T1xLIcFNNZbQZMLRtDYb3T7jWcZW6ZGCA3eiE+a+owEDPu/tbefn601NEb5u4oG1LcdG
         H9Dsv84O/zoTapvBpwqi2PtZ51m/dSfro8RKA2oW2wYC5JgWMOGtl+ZIS+eqUgwxh46E
         UQi4aJNA+LFgc9V/aBkiuAKWnNpa2DLwB/00MSvOre8Jbmod8REGSNeaGrdDcbpHWwzZ
         c6/1ktT50QfRomnrbN5QjMjAjqFBA6xZfUMcepS+nPg0741o+45DMPGuJiS29Dv+uf7p
         z3dg==
X-Gm-Message-State: AOAM531dK9+Eb48yKnNU8bc6dsqrHI9PMTf0oPij4lIxWdCFD+lD0JXT
        OxRBzHLsjGiYKYzyjSVsFRo=
X-Google-Smtp-Source: ABdhPJxsAev7Nat0AaISjDgyc0QjNCqB0whT2n66cTZgqMzPVXhMnliaHu4aD32t1E3bfmcirV18nQ==
X-Received: by 2002:a17:90b:1812:: with SMTP id lw18mr28000822pjb.96.1636098202874;
        Fri, 05 Nov 2021 00:43:22 -0700 (PDT)
Received: from [192.168.255.10] ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id u8sm1933735pfk.22.2021.11.05.00.43.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Nov 2021 00:43:22 -0700 (PDT)
Message-ID: <bba6a29e-7ef6-c21f-745e-527210a1a181@gmail.com>
Date:   Fri, 5 Nov 2021 15:43:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Content-Language: en-US
To:     Wanpeng Li <kernellwp@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Like Xu <likexu@tencent.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1636096851-36623-1-git-send-email-wanpengli@tencent.com>
From:   Like Xu <like.xu.linux@gmail.com>
Organization: Tencent
Subject: Re: [PATCH] perf/x86/lbr: Reset LBR_SELECT during vlbr reset
In-Reply-To: <1636096851-36623-1-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/2021 3:20 pm, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> lbr_select in kvm guest has residual data even if kvm guest is poweroff.
> We can get residual data in the next boot. Because lbr_select is not
> reset during kvm vlbr release. Let's reset LBR_SELECT during vlbr reset.

This is because when a new vlbr event is first scheduled in the current CPU,
the lbr_select is not reset, which causes the previous lbr_select value
to be visible to the next vcpu.

Considering that the requested lbr_select will be reconfigured
when the event is enabled. It is trivial, but a valid fix. Thanks.

> 
> Cc: Like Xu <likexu@tencent.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>   arch/x86/events/intel/lbr.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
> index 9e6d6eaeb4cb..1076de93a2f5 100644
> --- a/arch/x86/events/intel/lbr.c
> +++ b/arch/x86/events/intel/lbr.c
> @@ -279,6 +279,8 @@ void intel_pmu_lbr_reset(void)
>   
>   	cpuc->last_task_ctx = NULL;
>   	cpuc->last_log_id = 0;
> +	if (!static_cpu_has(X86_FEATURE_ARCH_LBR) && cpuc->lbr_select)
> +		wrmsrl(MSR_LBR_SELECT, 0);
>   }
>   
>   /*
> 
