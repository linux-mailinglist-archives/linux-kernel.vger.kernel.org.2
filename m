Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA4A3F16FD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 12:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238255AbhHSKDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 06:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238230AbhHSKDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 06:03:11 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FF3C061760
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 03:02:35 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id q11-20020a7bce8b0000b02902e6880d0accso6433878wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 03:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=8C/FxciNOLeL1YfMCKDaW7YDEOrFtXO1Tv3d7+X9b5Q=;
        b=sCQDEwzWer75yqZXmOtrzAzg6NgXGULsDSXiY8GCI3s+RbiNwutZCdoi7X6ZJvTEJK
         B1tpOSMASvQZLPLkbrDQM+LIVOL2Ju4X8qBOq2Q9T8kYHZTUHTHK1hVQZIRZzmnicYJZ
         jjm1j7s1ch0I5NvK75wdAwTdx/frxfzuUyxgqVCCuBKY+Jg/vEr9hMeX1Xjy3iYhA9SI
         9x9jcyBeQQUrUsNAj/9dyFGjDV7YgdGLyu3eS7Jk7wyNbCZto3AA4wxqByYg4w2THgSg
         DMo0ERQWFk4aXjzeaI5/cyLnTLSVGjZvU+HsJujMV95eAp0EM3ip0vjRqe3j1hIbsvQt
         Lphg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=8C/FxciNOLeL1YfMCKDaW7YDEOrFtXO1Tv3d7+X9b5Q=;
        b=jqbJx0p96ZNaWUqWALLRyOLoDJFRUw/68cMqnEmRMSabRQdACCx8tZzwoDU8b05gto
         lLunGbIHPPwpOTPdqVA6DxWLZRNiIuiLqZ+ZJTEECnrIY5l9Xj+JHbXgiwC2SK3TNBCl
         1mXK8/V58Otrhao26yPp3JsHVs8in2WrWP0LHZvkI2ND4FZDbjNel4RuHR1+OqATdfZV
         vkBf3mPwhY4lnlr2v0oCxZ9ddNyTamBJom5HOS1RXx9viecudAry4C9bBMMnfBeCtDv6
         sd35ZU18DrcN9fWgQtQ6diw3Qn/AufCc6UX/YOOBkH7KpkXHepSG5YEI1nyfLOsK5u5o
         rPLA==
X-Gm-Message-State: AOAM530uf/LKqVKJVXfB43R5qMsrrzcUEbVKVfn7qkmwWGEovs9WLjJx
        WRjudbDqc+/4U4xlFl+tZuw=
X-Google-Smtp-Source: ABdhPJx0VP9SdGq1FNgZVkvJhZgTs06RkeR3kiZXfTlfuV18gH1Ye+jPJbML2qgsCaRlsUc6k819ew==
X-Received: by 2002:a1c:80c9:: with SMTP id b192mr12740087wmd.73.1629367354210;
        Thu, 19 Aug 2021 03:02:34 -0700 (PDT)
Received: from agape.jhs ([5.171.80.222])
        by smtp.gmail.com with ESMTPSA id e10sm2358727wrt.82.2021.08.19.03.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 03:02:33 -0700 (PDT)
Date:   Thu, 19 Aug 2021 12:02:31 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: x86/boot/compressed/64: Lenovo Ideapad Miix300 bug report
Message-ID: <20210819100230.GA28768@agape.jhs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Joerg and other x86 developers,

I work on a Lenovo Ideapad Miix 300-10IBY (intel baytrail based)
for hardware tests.
I have fedora 34 installed on, and since I updated to the 5.13.x
versions, the tablet very often freezes at Lenovo startup logo.

I did a bisect and found that the commit that introduced
the bug is:

commit 79419e13e8082cc15d174df979a363528e31f2e7
Author: Joerg Roedel <jroedel@suse.de>
Date:   Wed Mar 10 09:43:21 2021 +0100

    x86/boot/compressed/64: Setup IDT in startup_32 boot path
    
    This boot path needs exception handling when it is used with SEV-ES.
    Setup an IDT and provide a helper function to write IDT entries for
    use in 32-bit protected mode.
    
    Signed-off-by: Joerg Roedel <jroedel@suse.de>
    Signed-off-by: Borislav Petkov <bp@suse.de>
    Link: https://lkml.kernel.org/r/20210312123824.306-5-joro@8bytes.org

I tried also to checkout a v5.13 and revert this commit
together with the following:

fef81c86262879d4b1176ef51a834c15b805ebb9
"x86/boot/compressed/64: Check SEV encryption in the 32-bit boot-path"

e927e62d8e370ebfc0d702fec22bc752249ebcef
"x86/boot/compressed/64: Add CPUID sanity check to 32-bit boot-path"

1ccdbf748d862bc2ea106fa9f2300983c77860fe
"x86/boot/compressed/64: Add 32-bit boot #VC handler"

to ensure an errorless build. The kernel works fine on tablet
without those changes.

My efibootmgr -v output is:

BootCurrent: 0000
Timeout: 2 seconds
BootOrder: 0000,0001,2001,2002,2003
Boot0000* Fedora	HD(1,GPT,1bb602be-6ed0-4ef5-aee4-b26891963c4a,0x800,0xaf000)/File(\EFI\fedora\shimia32.efi)
Boot0001* Fedora	HD(1,GPT,1bb602be-6ed0-4ef5-aee4-b26891963c4a,0x800,0xaf000)/File(\EFI\fedora\shim.efi)RC
Boot2001* EFI USB Device	RC
Boot2002* EFI DVD/CDROM	RC
Boot2003* EFI Network	RC

This means that on startup is followed the 32-bit boot-path.

CONFIG_AMD_MEM_ENCRYPT=y

Tell me if can help, I started contributing to linux kernel
five months ago in staging subsystem. I'd be glad to contribute
to such a core area of the kernel.

thank you in advance,

fabio
