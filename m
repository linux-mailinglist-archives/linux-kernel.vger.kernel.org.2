Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F001839A141
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 14:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhFCMmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 08:42:10 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:36602 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhFCMmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 08:42:09 -0400
Received: by mail-ed1-f44.google.com with SMTP id w21so6826547edv.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 05:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R9qc4cw/vA/RJi1p9reVL3moSscoSk2hpgnjWqOep64=;
        b=k0QWB9K1LPy0C/MuA/+9K1RMjG3expfVsxPdA5xwkZ2Zl18ZEYbSYRdd8HwBPS7eW7
         YrkwQY+tCIEuF3E0/V1sXJGyGVwSDPYY5Je7hoHe69uNTkdBz0IxUWCKYRn6+SUU/pWB
         MzcjdGv0UefGFWn4NlBb55Oz3KRXPxDsch8jA0o4+8ApU+LFvn5Eq08Ox73rjoBeQEo3
         7rHbWF/4jWOdJFkxfQbI5gJJg4F7dAwmYHX1kVmPgfrE/b2fo7ET6gXsyTzaWy+87s+Y
         sZJAMAlsNNdWOm2A9znSbIpGOPnExqwT9DWYNWfOmSFzVwpIqOFWtsnFA2D0OyS0oH6N
         1d9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=R9qc4cw/vA/RJi1p9reVL3moSscoSk2hpgnjWqOep64=;
        b=phHH5QdYHbTHCZwTLVAY7Nr5K8AyeKaecdrvaoqlpTkfPiNnMwVyqXFu/q0ShMqRwM
         9wWSD3zaUhFKnJysq6hrFR4qtQPD886vQUrVP4cgylkETpJyufoiujc0lR1qQ5kPuEjR
         CuOXGICz6n6vLzxuriATIa6s08k1CKtjbrT6qJDPe1CE9VvivcR/ksCYYLisIkWnLY/m
         OevN5URfmYKaFWEWUOSoClFKE9zn7VDNXs79BM9cKUvdYp4xBnDORekC8Iey30rQEy20
         g9K/b0DugP+Nk16MiszMDk70t7hQy152OvjT7tQbqSXcEc0d8xVSyOzBQDER4ha5Bbxp
         JQ0Q==
X-Gm-Message-State: AOAM532Z10RGCHDN9wEIJlAbd7v1maK2Pz/IUGEes81YiyB6+WArvxax
        QH5pfa9WbBKz97B7Q7gFLpg=
X-Google-Smtp-Source: ABdhPJzoQjSA4JScdmmmaaKDPiNYEmw74XTqxWhQK5Tho7T3J13wG/I90j/onQ53swFyRM6sOV4HHQ==
X-Received: by 2002:a05:6402:548:: with SMTP id i8mr7149486edx.344.1622723949892;
        Thu, 03 Jun 2021 05:39:09 -0700 (PDT)
Received: from gmail.com (563BAF3B.dsl.pool.telekom.hu. [86.59.175.59])
        by smtp.gmail.com with ESMTPSA id t2sm1447009ejx.72.2021.06.03.05.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 05:39:09 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 3 Jun 2021 14:39:07 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kbuild: Ctrl-C of parallel kernel build sometimes corrupts
 .o.cmd files permanently
Message-ID: <YLjNa7vaYOfVhBFm@gmail.com>
References: <YLeot94yAaM4xbMY@gmail.com>
 <CAK7LNAR54mOqEcUTUmEUfVAwA6XrGLr2J_3+v6fdys9tBLe28w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAR54mOqEcUTUmEUfVAwA6XrGLr2J_3+v6fdys9tBLe28w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Masahiro Yamada <masahiroy@kernel.org> wrote:

> Hmm, I have not observed this.
> 
> My expectation is, it should work like this:
> 
> When scripts/basic/fixdep is interrupted (or fail due to any reason),
> partially written *.o.cmd is left over. So, having incomplete *.o.cmd
> files is expectation.
> 
> When .DELETE_ON_ERROR is specified, GNU Make is supposed to
> automatically delete the target on any error.
> (If it is interrupted, it should exit with code 130)
> 
> On the next invocation of Make, Kbuild will not include .*.o.cmd files
> whose corresponding *.o files do not exist.
> 
> 
> 
> 
> 
> When you got the corrupted drivers/gpu/drm/.drm_blend.o.cmd,
> didn't you see the log
> Deleting file 'drivers/gpu/drm/drm_blend.o' ?
> 
> 
> 
> If it works as I expect, the log should look like follows:
> (I marked  the lines with '<---- Deleting')
> 
> 
> 
>   CC      security/keys/keyctl_pkey.o
>   CC      kernel/sys.o
>   CC      arch/x86/power/hibernate_64.o
> ^Cmake[5]: *** Deleting file 'drivers/video/fbdev/core/fbcmap.o'  <---- Deleting
> make[5]: *** [scripts/Makefile.build:272:
> drivers/video/fbdev/core/fbmon.o] Interrupt
> make[3]: *** [scripts/Makefile.build:272: security/selinux/nlmsgtab.o] Interrupt
> make[2]: *** [scripts/Makefile.build:272: arch/x86/power/cpu.o] Interrupt
> make[2]: *** [scripts/Makefile.build:272:

Interestingly I don't get *any* interruption messages at all:

  CC      drivers/dma/dw/acpi.o
  CC      sound/pci/ice1712/ice1712.o
  CC      drivers/char/ipmi/ipmi_watchdog.o
  CC      fs/overlayfs/export.o
  CC      fs/nls/nls_cp936.o
  CC      drivers/char/ipmi/ipmi_poweroff.o
 ^Ckepler:~/tip> 

The '^C' there - it just stops, make never prints anything for me.

Weird ...

Thanks,

	Ingo
