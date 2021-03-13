Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB0E339E5C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 14:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbhCMNtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 08:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbhCMNtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 08:49:10 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA35C061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 05:49:09 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id f8so4894196otp.8
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 05:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tZwx4uoitMPlIP/+C0LMHguJC+wX3FLo7/Ylqt3ivMo=;
        b=JHi4bGKA7ekAeY1zvXIhGvq7vxoHWPGtgNkotPtgimrD9I9zfIrH9IS0oFr3wXuzfG
         PZWJRhAKuB+XOYFMaW8LBoYwae+zkv/jd4+YAc4oqEYpf++STcVDj4MsF/bX/c+63JpO
         F0Q77FmK9ZmMXkNPypc01ImhZDShfMv1/ES5mSAnFmjNfT0zzeUIHvnqmIErghePcFap
         waVKSQd7faKl/LThs5kxeSf2u79VK0jYe9cCRGlz1UdBawEoL6imC3p/gHvLVKuzM7BJ
         R3fhzQXgkPikASv0Nr3ypYecrbDyigkhGiPXPxG3cfc7XL8f9BTtXWKc02oAFVyyknPQ
         9PAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tZwx4uoitMPlIP/+C0LMHguJC+wX3FLo7/Ylqt3ivMo=;
        b=gSnarXbiKtvsU3QDYKEqKhnmk0alxfgyUuCxkVt/YRPE0tmR+8YKZnP+6D2oh6zdIx
         3hkafxxDhgQRZc/tX1+r30RE4vBVg5pJv0uKj3wHn1EpQR+ktkPMPLUiULJA2Pjit+rI
         k8d6JD6KKkj7Ddg4JTF/5lSaPmQ1KCzH8ruHnzf7hQlzzhZG0w3j7fdD3ix7LiZVWJoL
         f+8E5IdA8H3lRp8BxGW+VUQdi+KVKcgUizu7GSjBjStOyKe1EwPw7SszeO3ft0qgBC2t
         ulpLSnlNORKRn7NrasI8JvmMlBARrL1YiaGwBNQ0a4d/ZQAhED0nwBrWFsGrX2gQv1kQ
         Vg+w==
X-Gm-Message-State: AOAM5300dyzjwFThgrh0JMzgeNQi/yodcSSIlkTDy4ci+vG6Af2UPlBt
        xhpufNRs7a5oZlTvwwLztVMS/cX0XoeouSYXdq1gFva7Ig+IzA==
X-Google-Smtp-Source: ABdhPJyRjVjY0tgN2nMjy1KtVbE8XWxiaMcp+dkhkEQtjs5WfKiR2LfWVNI5LUc9SJgv3/Q4YjI3q1F4hhcnSVFCtYs=
X-Received: by 2002:a9d:2241:: with SMTP id o59mr7401911ota.8.1615643349315;
 Sat, 13 Mar 2021 05:49:09 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:12d9:0:0:0:0 with HTTP; Sat, 13 Mar 2021 05:49:08
 -0800 (PST)
In-Reply-To: <20210312134114.GA21436@chenyu-desktop>
References: <1f6d32e14f121a8ccf8807b8343597c3ae88c7d2.1587196252.git.yu.c.chen@intel.com>
 <20210308134957.23852-1-youling257@gmail.com> <CAAYoRsXec2eq=t-pSn5TOqNt0G6kfZCKkDuEhCnX5SgL0zgkBg@mail.gmail.com>
 <20210308161548.GA37664@chenyu-desktop> <CAAYoRsVkrHberSgM42dqYjdVwz8vumURJ1_DGeV1R5-=LMdjVA@mail.gmail.com>
 <20210312134114.GA21436@chenyu-desktop>
From:   youling 257 <youling257@gmail.com>
Date:   Sat, 13 Mar 2021 21:49:08 +0800
Message-ID: <CAOzgRdYZM53OC-7DwnmKr3WBOAkKmqstvvs36cMVTOQUZ8qrUg@mail.gmail.com>
Subject: Re: [3/3,v3] tools/power turbostat: Enable accumulate RAPL display
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Doug Smythies <dsmythies@telus.net>, bas@basnieuwenhuizen.nl,
        Bingsong Si <owen.si@ucloud.cn>, erwanaliasr1@gmail.com,
        lenb@kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        Len Brown <len.brown@intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

test this patch, turbostat can work.

2021-03-12 21:41 GMT+08:00, Chen Yu <yu.c.chen@intel.com>:
> Hi Youling, Bas, and Bingsong,
> On Wed, Mar 10, 2021 at 04:03:31PM -0800, Doug Smythies wrote:
>> Hi Yu,
>>
>> I am just resending your e-mail, adjusting the "To:" list to
>> include the 3 others that have submitted similar patches.
>>
>> ... Doug
>>
> Could you please help check if the following combined patch works?
>
> Thanks,
> Chenyu
>
>
> From 00e0622b1b693a5c7dc343aeb3aa51614a9e125e Mon Sep 17 00:00:00 2001
> From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> Date: Fri, 12 Mar 2021 21:27:40 +0800
> Subject: [PATCH] tools/power/turbostat: Fix turbostat for AMD Zen CPUs
>
> It was reported that on Zen+ system turbostat started exiting,
> which was tracked down to the MSR_PKG_ENERGY_STAT read failing because
> offset_to_idx wasn't returning a non-negative index.
>
> This patch combined the modification from Bingsong Si and
> Bas Nieuwenhuizen and addd the MSR to the index system as alternative for
> MSR_PKG_ENERGY_STATUS.
>
> Fixes: 9972d5d84d76 ("tools/power turbostat: Enable accumulate RAPL
> display")
> Reported-by: youling257 <youling257@gmail.com>
> Co-developed-by: Bingsong Si <owen.si@ucloud.cn>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  tools/power/x86/turbostat/turbostat.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/tools/power/x86/turbostat/turbostat.c
> b/tools/power/x86/turbostat/turbostat.c
> index a7c4f0772e53..a7c965734fdf 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -297,7 +297,10 @@ int idx_to_offset(int idx)
>
>  	switch (idx) {
>  	case IDX_PKG_ENERGY:
> -		offset = MSR_PKG_ENERGY_STATUS;
> +		if (do_rapl & RAPL_AMD_F17H)
> +			offset = MSR_PKG_ENERGY_STAT;
> +		else
> +			offset = MSR_PKG_ENERGY_STATUS;
>  		break;
>  	case IDX_DRAM_ENERGY:
>  		offset = MSR_DRAM_ENERGY_STATUS;
> @@ -326,6 +329,7 @@ int offset_to_idx(int offset)
>
>  	switch (offset) {
>  	case MSR_PKG_ENERGY_STATUS:
> +	case MSR_PKG_ENERGY_STAT:
>  		idx = IDX_PKG_ENERGY;
>  		break;
>  	case MSR_DRAM_ENERGY_STATUS:
> @@ -353,7 +357,7 @@ int idx_valid(int idx)
>  {
>  	switch (idx) {
>  	case IDX_PKG_ENERGY:
> -		return do_rapl & RAPL_PKG;
> +		return do_rapl & (RAPL_PKG | RAPL_AMD_F17H);
>  	case IDX_DRAM_ENERGY:
>  		return do_rapl & RAPL_DRAM;
>  	case IDX_PP0_ENERGY:
> --
> 2.25.1
>
>
