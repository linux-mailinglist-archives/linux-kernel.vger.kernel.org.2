Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6ED459AB0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 04:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbhKWDtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 22:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbhKWDtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 22:49:18 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8843CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 19:46:10 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id i12so17399208wmq.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 19:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bp7mEUVEt5QqG8xtFw9E/AxBIVfYeYYO56kVpuGbx0w=;
        b=KyN9plmEYyF3x0xQCMBvv/ru9mWfjMMKqxC5jgl0lp/npQTuCiJHJwFP7tGG1y5TJd
         viO7MgOcbUYXROE6Fdvaq95av8hNE8fIZB0y4/sEKguAibSAlzCbgZcjoRSbHOW5r2fr
         jyO8qXc6/Ye0pzZXBQ8o0vAe01kTq+rN81c1H2rp5T3Vl00al1Lk18B1qoyjtvojBKNn
         AIwNUdve229Uua8ERl9LLmtfTSEV0ud+DOu+8sjZYPUDL4fizeWm0DEur8ToXjkgehTE
         Z1/mJWLWkC2ZLy5Dxyg7XGLih5qK93mqgrkdMZjgRoKy+ZbQ9d8RmBWEsVkrU/UHOeBq
         ix0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bp7mEUVEt5QqG8xtFw9E/AxBIVfYeYYO56kVpuGbx0w=;
        b=AY8mqobtOfLIf6kwtwUYULCR6erN5iq4KgWIfEIIPDa2L+pWOjdKrx27dRb8Glg1ib
         fzdcNoTZYlythCvXJICokH3ThZqlIGSYERYbPMrVYwvj5md1Kk+0Wzy4myvarOC+J8z5
         n7OCA1okl2ek3OnWKb6LIJVGviv0VsDZjFEXs6kE67Y7sX5PFpX9GZ32aDvH4ArgMb5K
         3xpx/wsdJbWDDLwj8tn3WGgs1BvBaodWCTcZo1iM1Q2WpI3+/Cjw3pO76ykadKTwgaVi
         KmkNURRjOhtffqLdUFUKfaedmEAs6vIKqMlWNBDVEbHp+RI2RSojN+2Y+4vdGm7SuOFN
         TXOA==
X-Gm-Message-State: AOAM532x7P90pNQ9wN30MCUp9FBQe6PegO6nLjlLQwqr4g1TigV5NgWj
        NfX9Mtgo6eTf9sjSfy4D3Lm7lVSpSmvRxPC/HPysPg==
X-Google-Smtp-Source: ABdhPJwF++wWUq50mUMTn31nsRbQkp7Q/pEnYoXUvcdHVH5A7NkAMXK0YWkEElOmdUQGxHy+cfheXIlQKhKS83s//+Q=
X-Received: by 2002:a7b:c017:: with SMTP id c23mr3008380wmb.137.1637639168977;
 Mon, 22 Nov 2021 19:46:08 -0800 (PST)
MIME-Version: 1.0
References: <20211123015717.542631-1-guoren@kernel.org> <20211123015717.542631-4-guoren@kernel.org>
In-Reply-To: <20211123015717.542631-4-guoren@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 23 Nov 2021 09:15:57 +0530
Message-ID: <CAAhSdy3+hY1jwNAOrhE0kiCZPMRh4amY3+Mn-NR2TDFQ24orwQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] riscv: Add riscv.fwsz kernel parameter
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, atishp@rivosinc.com,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Anup Patel <anup.patel@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 7:27 AM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> The firmware of riscv (such as opensbi) occupy 2MB(64bit) /
> 4MB(32bit) in Linux. It's very wasteful to small memory footprint
> soc chip such as Allwinner D1s/F133. The kernel parameter gives a
> chance to users to set the proper size of the firmware and get
> more than 1.5MB of memory.

This kernel parameter is redundant see my comment on other patch.

regards,
Anup

>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Anup Patel <anup.patel@wdc.com>
> Cc: Atish Patra <atishp@rivosinc.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 9725c546a0d4..ee505743c8f4 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4964,6 +4964,9 @@
>                         [KNL] Disable ring 3 MONITOR/MWAIT feature on supported
>                         CPUs.
>
> +       riscv.fwsz=nn[KMG]
> +                       [RISC-V] Determine firmware size to save memory
> +
>         ro              [KNL] Mount root device read-only on boot
>
>         rodata=         [KNL]
> --
> 2.25.1
>
