Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 197E933E722
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 03:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhCQCuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 22:50:52 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38375 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhCQCuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 22:50:40 -0400
Received: from mail-lf1-f72.google.com ([209.85.167.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1lMMGd-0000Se-CZ
        for linux-kernel@vger.kernel.org; Wed, 17 Mar 2021 02:50:39 +0000
Received: by mail-lf1-f72.google.com with SMTP id x10so12158474lfu.22
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 19:50:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0qNw+09sx4P5n2rDayk0okTg2tM+VITy3e6500kIc/0=;
        b=KwmslHMuxL0YK5DqHOYB+muHaeat++UhQkRmdYYXuNBIT9swuEuHVEZ2EPblb7va0O
         NAiP0/eZ4k+tXCu30xtCSu9BS82d9ai01oJO36S0eQ3KNM7GM1wl7AbZpeSPmUkZeV4w
         tQDGOZVdKsaLFSsNbmFwsRqShNzSvURVJzvdchu71cx0clS9x+fCEUV52D+PnhAZZ2yu
         c8qjQDWM5pIjX/bH9fZ4r2keZ1W3zBIbDjvgrJp4/6VmQ99bntMdE+lPb0sWCn1JyaRZ
         YkUnpTMLR/eT/4nv6fN/6+cAVCpuEfuaofAf/YdOn8KHBTxJrkatjLEkdMeekfw2fPKf
         fMkA==
X-Gm-Message-State: AOAM5339BBiEzMkOy3AdXnLxzP0KFGgfNp2luEFc7AbfPmb1C9uYp3Ao
        V7fi1bTaXi3ZH36FJyj3OG6zF+mxaA/Q8LUWojLl6Hz7uxea9FQEfCNt8NfaFNShSXtyP5jlATI
        MUIC9fTmnO+/gOBwE86zIfPboU+WWBVii9U8HiJuzV5o2eCaDcEPzg7bXLg==
X-Received: by 2002:a05:651c:50b:: with SMTP id o11mr1062591ljp.97.1615949438856;
        Tue, 16 Mar 2021 19:50:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFmsBahF05pTMsFRAQBKaYjmqQ/jHu71L6DnaaG4ZSK01RxtWX8W1zFCsUVHsbmEU6Qu3fgzHyvp+yrTH5ZvQ=
X-Received: by 2002:a05:651c:50b:: with SMTP id o11mr1062583ljp.97.1615949438603;
 Tue, 16 Mar 2021 19:50:38 -0700 (PDT)
MIME-Version: 1.0
References: <b8db79e6857c41dab4ef08bdf826ea7c47e3bafc.1615947283.git.josef@toxicpanda.com>
In-Reply-To: <b8db79e6857c41dab4ef08bdf826ea7c47e3bafc.1615947283.git.josef@toxicpanda.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 17 Mar 2021 10:50:27 +0800
Message-ID: <CAAd53p5Vh_+tUeEQx3xf_aLiCiKP1u5Y3VgYCUzZ82Kgtr-iYw@mail.gmail.com>
Subject: Re: [PATCH][RESEND] Revert "PM: ACPI: reboot: Use S5 for reboot"
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 17, 2021 at 10:17 AM Josef Bacik <josef@toxicpanda.com> wrote:
>
> This reverts commit d60cd06331a3566d3305b3c7b566e79edf4e2095.
>
> This patch causes a panic when rebooting my Dell Poweredge r440.  I do
> not have the full panic log as it's lost at that stage of the reboot and
> I do not have a serial console.  Reverting this patch makes my system
> able to reboot again.

But this patch also helps many HP laptops, so maybe we should figure
out what's going on on Poweredge r440.
Does it also panic on shutdown?

Kai-Heng

>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
> - apologies, I mistyped the lkml list email.
>
>  kernel/reboot.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index eb1b15850761..a6ad5eb2fa73 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -244,8 +244,6 @@ void migrate_to_reboot_cpu(void)
>  void kernel_restart(char *cmd)
>  {
>         kernel_restart_prepare(cmd);
> -       if (pm_power_off_prepare)
> -               pm_power_off_prepare();
>         migrate_to_reboot_cpu();
>         syscore_shutdown();
>         if (!cmd)
> --
> 2.26.2
>
