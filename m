Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2797039A156
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 14:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbhFCMp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 08:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbhFCMp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 08:45:59 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41846C06175F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 05:44:01 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id s6so6921494edu.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 05:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cY9zsFfpkOdR2m3AOTwm913YpwUGVvMqfshNZL/oNro=;
        b=ehJK2oqClwfwtPNWL3C/udY8/MUItvfUJBoviT3cYLfq6G2mtv9TEVs3HemnjwAwI/
         fIFvncpFhm6mYn2Vr9bPwhM8bRpd/KNOuRG2xT+V+w1x60i4kzHyTqlrPQbto0JGDlX2
         yyHfFYdq0M4W0wyfIH/YSknyjESbejfEB1rTFKrzIwZ5cDntwoHY9heKaq3DJynSmhZO
         Cx0ZvetdLYPJvt+rIbmT+Hxn38TUrYkm82c26FzgaLLiqtsF3TzFTB6lQr7ZCsLR6G0u
         0/s7nVJH5ljgzpB2z5ge8EWWcIZZh1Yd2uMYiicTonE95MQb0e3qrDTtZNzAkvRCGtii
         BpuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=cY9zsFfpkOdR2m3AOTwm913YpwUGVvMqfshNZL/oNro=;
        b=SaMEJXNxa9RpgItJGVtSqvmkKuh679HH2EA61KG+RRKiY9we7nUjy2VjhH675kM9CJ
         M4EV39tKpuTgJj9azav3IfILj79gjiMZtR6s6XH1NsDm/gaz8ewztzCCra4UaVvUg0T+
         v//3H85Q3Hvdril94TSZKD3hR0ObGEJcwnr+1WGpKuj47d0RX4fOixeAItIDQTfMKFea
         BdhvTnflzx/88ltXerQI/LprKkT/imH6DC4Y9lXWZxzgf/C062qdEuQsqYXNrC2zmlyM
         SgUYFPzpxEZiSQE0d9DNUrTQdBLg2PQWUUOToeA80hEfgYgjrpPVRggdlZ2/98ikqnbm
         6x/Q==
X-Gm-Message-State: AOAM5312kyIUYyuLOaNiEXZxMC7gi7wBM6LQDr8fUweau9BKPAGK6eML
        1m4tc/lzKv05pwzQ6TRe0qI=
X-Google-Smtp-Source: ABdhPJwyw283p6k0/iEi/b4DUjUwM2Ookyr34sYBt8ImWPf8DrNwCKl+dPuAhXTE8JGc04dUfXIZvg==
X-Received: by 2002:a50:ee18:: with SMTP id g24mr14705617eds.11.1622724239786;
        Thu, 03 Jun 2021 05:43:59 -0700 (PDT)
Received: from gmail.com (563BAF3B.dsl.pool.telekom.hu. [86.59.175.59])
        by smtp.gmail.com with ESMTPSA id f18sm1476331ejz.119.2021.06.03.05.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 05:43:59 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 3 Jun 2021 14:43:57 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kbuild: Ctrl-C of parallel kernel build sometimes corrupts
 .o.cmd files permanently
Message-ID: <YLjOjZVetM4UbUPn@gmail.com>
References: <YLeot94yAaM4xbMY@gmail.com>
 <CAK7LNAR54mOqEcUTUmEUfVAwA6XrGLr2J_3+v6fdys9tBLe28w@mail.gmail.com>
 <YLjNa7vaYOfVhBFm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLjNa7vaYOfVhBFm@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> >   CC      security/keys/keyctl_pkey.o
> >   CC      kernel/sys.o
> >   CC      arch/x86/power/hibernate_64.o
> > ^Cmake[5]: *** Deleting file 'drivers/video/fbdev/core/fbcmap.o'  <---- Deleting
> > make[5]: *** [scripts/Makefile.build:272:
> > drivers/video/fbdev/core/fbmon.o] Interrupt
> > make[3]: *** [scripts/Makefile.build:272: security/selinux/nlmsgtab.o] Interrupt
> > make[2]: *** [scripts/Makefile.build:272: arch/x86/power/cpu.o] Interrupt
> > make[2]: *** [scripts/Makefile.build:272:
> 
> Interestingly I don't get *any* interruption messages at all:
> 
>   CC      drivers/dma/dw/acpi.o
>   CC      sound/pci/ice1712/ice1712.o
>   CC      drivers/char/ipmi/ipmi_watchdog.o
>   CC      fs/overlayfs/export.o
>   CC      fs/nls/nls_cp936.o
>   CC      drivers/char/ipmi/ipmi_poweroff.o
>  ^Ckepler:~/tip> 
> 
> The '^C' there - it just stops, make never prints anything for me.

Found something - seems to be related whether the build is going into a 
pipe or not.


I usually build this way (directly or via a script):

   make -j96 bzImage ARCH=x86 2>&1 | tee e

Ctrl-C interruption is not handled by kbuild in this case:

  CC      fs/jffs2/xattr_trusted.o
  CC      sound/firewire/motu/motu-transaction.o
  CC      sound/usb/clock.o
  ^Ckepler:~/tip> 

Immediate prompt - no cleanup sequence.

But if I do it without 'tee', I get the expected cleanup sequence by make:

  kepler:~/tip> make -j96 bzImage ARCH=x86 2>&1

  CC      fs/jffs2/acl.o
  CC      sound/pci/echoaudio/mona.o
  CC      fs/nls/nls_iso8859-9.o
  ^Cmake[2]: *** Deleting file 'drivers/reset/core.o'
    make[3]: *** Deleting file 'sound/pci/mixart/mixart.o'
    make[3]: *** Deleting file 'sound/pci/emu10k1/voice.o'
    make[2]: *** Deleting file 'fs/gfs2/aops.o'

Thanks,

	Ingo
