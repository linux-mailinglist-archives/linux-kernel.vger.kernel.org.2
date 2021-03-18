Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C687833FEFF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 06:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbhCRFml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 01:42:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55364 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbhCRFmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 01:42:18 -0400
Received: from mail-lf1-f69.google.com ([209.85.167.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1lMlQH-0004v9-CE
        for linux-kernel@vger.kernel.org; Thu, 18 Mar 2021 05:42:17 +0000
Received: by mail-lf1-f69.google.com with SMTP id z12so821329lfs.15
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 22:42:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VxkRvo8Av52OSk++GohaaBtIAYaVN6TGBHHeWI4XHuU=;
        b=JOcvUqA/aN+nJbQ/Njw/g4zOY4buioS4TS7ZomJ8YnOytILljV4W5urHys44JakAa7
         YpjFiymHcjcJcMT3Y5hPE1+41oc+RdQqJjcmWHd5un31eHnR+mmUJLvRcX9175tyRHcM
         MiVIug4DWjNSKta/e+T+gNG1GIYrcRXfAF4thz6ymci3xwfrN/9A1uMMCVBBt8xDexcz
         209DM9Rc9hcv4DdWwOmkJR1XlsFuomDZoKLSHah8/3dbZDGBhYmvf9ydARt24sxUMzLq
         t2SKdO2sk66OzDPFO8poS82Oh0MPTMrTtG3vCCQMWynzPb6QNr9mIA9vF5bcwgB8xkbU
         D52w==
X-Gm-Message-State: AOAM533Pj3CKCh7tAQd+S/R97tN1JbX0ztMfJqXWy2g6Ecqv6lIvR8WX
        RDJRFEYcG7eJWr0yd4bBbjElWIrRAzQF8kBhmr3E6VRhOwxz4Z4Vy26ktgOWBQWTY1tjjTdi8Vh
        ppbMy6gcQKZ6vfXb1IK7YWPaSNs9WAmQG0LHAz+J0sq3CFQSV5R0FWwUF6w==
X-Received: by 2002:ac2:4acf:: with SMTP id m15mr4532072lfp.290.1616046136857;
        Wed, 17 Mar 2021 22:42:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgQo9UEdE+NM66rLQK/xasWGY3OP+m4oeg0m1l4VIeYKmu5ZW68DX09IM7OpKcH9HfWAmMzBxEBvCEYTIrMV4=
X-Received: by 2002:ac2:4acf:: with SMTP id m15mr4532064lfp.290.1616046136611;
 Wed, 17 Mar 2021 22:42:16 -0700 (PDT)
MIME-Version: 1.0
References: <b8db79e6857c41dab4ef08bdf826ea7c47e3bafc.1615947283.git.josef@toxicpanda.com>
 <CAAd53p5Vh_+tUeEQx3xf_aLiCiKP1u5Y3VgYCUzZ82Kgtr-iYw@mail.gmail.com>
 <bebcaffc-d485-912d-0c42-c0781f9c7603@toxicpanda.com> <CAAd53p7eJk9EtMTLjB5i7RdoKA3WS1W4TRjQs08adi7iAux_jQ@mail.gmail.com>
 <78dfcd55-442d-dcc0-c37f-5576f65f91b5@toxicpanda.com>
In-Reply-To: <78dfcd55-442d-dcc0-c37f-5576f65f91b5@toxicpanda.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 18 Mar 2021 13:42:04 +0800
Message-ID: <CAAd53p6Lp8+S0yjWi=MikQJ_zywiWamUS5p19oKoqB6uYW8jzg@mail.gmail.com>
Subject: Re: [PATCH][RESEND] Revert "PM: ACPI: reboot: Use S5 for reboot"
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 1:25 AM Josef Bacik <josef@toxicpanda.com> wrote:
[snipped]
> "shutdown now" works fine with and without your patch.  Thanks,

Rafael,
Please revert the patch while we are working on it.

Josef,
Can you please test the following patch:

diff --git a/kernel/reboot.c b/kernel/reboot.c
index eb1b15850761..263444a3fb38 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -233,6 +233,15 @@ void migrate_to_reboot_cpu(void)
        set_cpus_allowed_ptr(current, cpumask_of(cpu));
 }

+static void kernel_shutdown_prepare(enum system_states state)
+{
+       blocking_notifier_call_chain(&reboot_notifier_list,
+               (state == SYSTEM_HALT) ? SYS_HALT : SYS_POWER_OFF, NULL);
+       system_state = state;
+       usermodehelper_disable();
+       device_shutdown();
+}
+
 /**
  *     kernel_restart - reboot the system
  *     @cmd: pointer to buffer containing command to execute for restart
@@ -243,7 +252,7 @@ void migrate_to_reboot_cpu(void)
  */
 void kernel_restart(char *cmd)
 {
-       kernel_restart_prepare(cmd);
+       kernel_shutdown_prepare(SYSTEM_POWER_OFF);
        if (pm_power_off_prepare)
                pm_power_off_prepare();
        migrate_to_reboot_cpu();
@@ -257,14 +266,6 @@ void kernel_restart(char *cmd)
 }
 EXPORT_SYMBOL_GPL(kernel_restart);

-static void kernel_shutdown_prepare(enum system_states state)
-{
-       blocking_notifier_call_chain(&reboot_notifier_list,
-               (state == SYSTEM_HALT) ? SYS_HALT : SYS_POWER_OFF, NULL);
-       system_state = state;
-       usermodehelper_disable();
-       device_shutdown();
-}
 /**
  *     kernel_halt - halt the system
  *

>
> Josef
