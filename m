Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7431C32DF97
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 03:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbhCECVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 21:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhCECVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 21:21:51 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1ADC061760
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 18:21:49 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id w1so503273ejf.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 18:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bZiurwwYnZLT/VRW1RwPIU3o79LWtOqbpFsXXHDZjhA=;
        b=0hVmylr1V561kRfTLKHz66ltkGePUnwKHV0pbgVb7Nvw5Xf+CtbpAcV7Q1Yj0we8BH
         ZAmp9aJ2qAOL61Yif4ZVRXx0oxNHUIZKzpcnAUiok1OjPnVK/GOLN3QPXBcy/6ETLvAQ
         nvedS8wRW7mnI3G0S5W/vWCM31i33+1lVLqwVuYVWta8A5R5N4HNtFOtrK1cFu4RUKfh
         0aS9a5P7r8ntFovNbCvO3qSPvpDWOJfTAxDda2ThJ32y1kRu0MP3Fd1E/Gm4Sp/h0zzm
         Q+wLDaqUS+SDcjAZh1iwVTHPLzTdh3+mHFqHkXmxdX54Jzeb84bc3YM9IzdcBfmchr5Y
         9mAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bZiurwwYnZLT/VRW1RwPIU3o79LWtOqbpFsXXHDZjhA=;
        b=BobYnYyveS4thd0aVKpLYhOxBYzgp8j2yPvmcOXauZAapj7LwM0+474nCxMMwZsEOU
         KsGtbmMm9dWlHgnj77IEpwWALyx5FqjMMbKZTUtICGCFVOdQpLRU29AOrIOcK6cS/ErF
         iVkk1RxRONRxPltEaSWMK/Dr8+mV09WWmJu99sXBDL1N5EMv9n1O+FYziPJSjciAwRoY
         OPr89+MTLk5tBtCxamsK+PKp7vaS4IqAY/OcszbXb/gn9QBW4vx9Y2rKOBJ83nARnm6t
         RzVRdJXU1TWik4/4XIcBjhKEnSGTZ0iDwtxnfed97OVGcK8OzuPCbGLy6MsgnLgG3mNB
         tJOg==
X-Gm-Message-State: AOAM530Q0mJE6mbVJ+sdKgRITeH8o9I6Mbu59yRk9KnYgcS16qNd6h4P
        LxMRT9I5MTWHpfNLGlh/RZno+a19dhTHF9v+ycTM
X-Google-Smtp-Source: ABdhPJyEddLl4eD/3yNcbwVkpXT3TfC4vxsZZtePuyU8RMKHXAPKcbjtxr3B9HNLlkXtR0rLroZcwHGHQWDMkyH0A54=
X-Received: by 2002:a17:906:2314:: with SMTP id l20mr398016eja.178.1614910908138;
 Thu, 04 Mar 2021 18:21:48 -0800 (PST)
MIME-Version: 1.0
References: <1613470672-3069-1-git-send-email-pnagar@codeaurora.org>
In-Reply-To: <1613470672-3069-1-git-send-email-pnagar@codeaurora.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 4 Mar 2021 21:21:37 -0500
Message-ID: <CAHC9VhTw_j5s9MQrruk1qSL+kHXPLmGeb9fH48-xZWkp=O8O9w@mail.gmail.com>
Subject: Re: [PATCH] RTIC: selinux: ARM64: Move selinux_state to a separate page
To:     Preeti Nagar <pnagar@codeaurora.org>
Cc:     arnd@arndb.de, James Morris <jmorris@namei.org>,
        Serge Hallyn <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-arch@vger.kernel.org, casey@schaufler-ca.com,
        ndesaulniers@google.com, dhowells@redhat.com, ojeda@kernel.org,
        psodagud@codeaurora.org, nmardana@codeaurora.org,
        rkavati@codeaurora.org, vsekhar@codeaurora.org,
        mreichar@codeaurora.org, johan@kernel.org, joe@perches.com,
        jeyu@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 5:19 AM Preeti Nagar <pnagar@codeaurora.org> wrote:
>
> The changes introduce a new security feature, RunTime Integrity Check
> (RTIC), designed to protect Linux Kernel at runtime. The motivation
> behind these changes is:
> 1. The system protection offered by Security Enhancements(SE) for
> Android relies on the assumption of kernel integrity. If the kernel
> itself is compromised (by a perhaps as yet unknown future vulnerability),
> SE for Android security mechanisms could potentially be disabled and
> rendered ineffective.
> 2. Qualcomm Snapdragon devices use Secure Boot, which adds cryptographic
> checks to each stage of the boot-up process, to assert the authenticity
> of all secure software images that the device executes.  However, due to
> various vulnerabilities in SW modules, the integrity of the system can be
> compromised at any time after device boot-up, leading to un-authorized
> SW executing.
>
> The feature's idea is to move some sensitive kernel structures to a
> separate page and monitor further any unauthorized changes to these,
> from higher Exception Levels using stage 2 MMU. Moving these to a
> different page will help avoid getting page faults from un-related data.
> The mechanism we have been working on removes the write permissions for
> HLOS in the stage 2 page tables for the regions to be monitored, such
> that any modification attempts to these will lead to faults being
> generated and handled by handlers. If the protected assets are moved to
> a separate page, faults will be generated corresponding to change attempts
> to these assets only. If not moved to a separate page, write attempts to
> un-related data present on the monitored pages will also be generated.
>
> Using this feature, some sensitive variables of the kernel which are
> initialized after init or are updated rarely can also be protected from
> simple overwrites and attacks trying to modify these.
>
> Currently, the change moves selinux_state structure to a separate page.
> The page is 2MB aligned not 4K to avoid TLB related performance impact as,
> for some CPU core designs, the TLB does not cache 4K stage 2 (IPA to PA)
> mappings if the IPA comes from a stage 1 mapping. In future, we plan to
> move more security-related kernel assets to this page to enhance
> protection.
>
> Signed-off-by: Preeti Nagar <pnagar@codeaurora.org>
> ---
> The RFC patch reviewed available at:
> https://lore.kernel.org/linux-security-module/1610099389-28329-1-git-send-email-pnagar@codeaurora.org/
> ---
>  include/asm-generic/vmlinux.lds.h | 10 ++++++++++
>  include/linux/init.h              |  6 ++++++
>  security/Kconfig                  | 11 +++++++++++
>  security/selinux/hooks.c          |  2 +-
>  4 files changed, 28 insertions(+), 1 deletion(-)

As long as we are only talking about moving the selinux_state struct
itself and none of the pointers inside I think we should be okay (the
access decision cache pointed to by selinux_state->avc could change
frequently).  Have you done any performance measurements of this
change?  Assuming they are not terrible, I have no objections to this
patch from a SELinux perspective.

-- 
paul moore
www.paul-moore.com
