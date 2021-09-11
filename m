Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92C7F407557
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 08:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbhIKGrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 02:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhIKGrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 02:47:41 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E547C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 23:46:29 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id dw14so1922846pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 23:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Byf12TJ+ZzJytO+/aTSk+K6Nx6eB3hCnyGXMON4aO+E=;
        b=HOj18WdhhreeM5OVFqnWwOq80WlFI29IU61xJgFKFBL96bZNKS2b8jiA9S8QstauL2
         5dQ1eXlCkW0IVcXJoIIYByyeur4GLhtqOsEaZNqA8JsWaL9BB4D//ub6HGqbZAKuhIAD
         kg+9mbKglkbvJgfVMAmO0uu9XweoteLSOYU0ouEQOU+3ZCdWoCgz77ATstfaRyHZ/Mb/
         7eo20ZGbnjGqtNnDpWIX1R2f294yOZoJpcR2f07ujm5U7mejRpGzNTXOlmvRzDYihxWx
         hBixOoC1F89yXY516ruYy2XWE97GIRn0Je7Fg2+YdAI2/ZN35UBEwUFEThMdkPfUAWDz
         ukpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Byf12TJ+ZzJytO+/aTSk+K6Nx6eB3hCnyGXMON4aO+E=;
        b=LYzpNcOBFgSRq5OkIB8467bkvqiiqZ3SrZYSMSQDP0gT1lbFdup2zHrA53Hcw92xo3
         lsGDJK1b3Cd31IJreY5uW89oGSHs1SBTlGI1pWxg7OZHF3rcoU9eLi6ypUn7B936OeLD
         8tNqgcJjLoh7sENuyYSfvy0t8GaT+lv6ZdgOSUagJ2aw6dQqXJoTK5HAGBXg6VxF9VBo
         9OV0rzIp5SjIg1AAqXL8w2h3faAxyGsAJFxDDBwnq7dGlWm1YabB570LD+WaxiNnrMin
         5JZmlPaqtkz2Dd8Rmj1i939t5Jv2JzEjQsioQZvvSvbAvwWyajhX/G+onz49syUPjBzs
         /B1Q==
X-Gm-Message-State: AOAM532fhi/8loZfYS+4m6S6TMX8obxbXGpkjc9/9MMD1IXrJ66IHfLY
        FRse+QLGEYO5jzvLbwooWC8G7g==
X-Google-Smtp-Source: ABdhPJz5zMYwyFJ/x3cbzNJcSEbvbWYqx9piMU6jONkVOp5hpoIYweqMyb0v8DBz6UqjFyCW2uQCtw==
X-Received: by 2002:a17:90b:4c4f:: with SMTP id np15mr1634891pjb.30.1631342788956;
        Fri, 10 Sep 2021 23:46:28 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id a15sm858356pgn.25.2021.09.10.23.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 23:46:28 -0700 (PDT)
Date:   Fri, 10 Sep 2021 23:46:28 -0700 (PDT)
X-Google-Original-Date: Fri, 10 Sep 2021 23:20:41 PDT (-0700)
Subject:     Re: [PATCH] riscv: move the (z)install rules to arch/riscv/Makefile
In-Reply-To: <CAK7LNARVjdVf5QRFduKrxb-TJyiCdUPkpSSMtYiS7yN2yAZhEQ@mail.gmail.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, wangkefeng.wang@huawei.com,
        tklauser@distanz.ch, vitaly.wool@konsulko.com,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     masahiroy@kernel.org
Message-ID: <mhng-2e119b02-3df0-477b-ba4e-4fa5c3eba1ca@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Aug 2021 16:49:14 PDT (-0700), masahiroy@kernel.org wrote:
> On Sat, Aug 14, 2021 at 2:00 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>>
>> On Thu, 29 Jul 2021 07:21:47 PDT (-0700), masahiroy@kernel.org wrote:
>> > Currently, the (z)install targets in arch/riscv/Makefile descend into
>> > arch/riscv/boot/Makefile to invoke the shell script, but there is no
>> > good reason to do so.
>> >
>> > arch/riscv/Makefile can run the shell script directly.
>> >
>> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>> > ---
>> >
>> >  arch/riscv/Makefile      | 7 +++++--
>> >  arch/riscv/boot/Makefile | 8 --------
>> >  2 files changed, 5 insertions(+), 10 deletions(-)
>> >
>> > diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
>> > index bc74afdbf31e..3c437fb09a07 100644
>> > --- a/arch/riscv/Makefile
>> > +++ b/arch/riscv/Makefile
>> > @@ -126,8 +126,11 @@ $(BOOT_TARGETS): vmlinux
>> >  Image.%: Image
>> >       $(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
>> >
>> > -zinstall install:
>> > -     $(Q)$(MAKE) $(build)=$(boot) $@
>> > +install: install-image = Image
>> > +zinstall: install-image = Image.gz
>> > +install zinstall:
>> > +     $(CONFIG_SHELL) $(srctree)/$(boot)/install.sh $(KERNELRELEASE) \
>> > +     $(boot)/$(install-image) System.map "$(INSTALL_PATH)"
>> >
>> >  archclean:
>> >       $(Q)$(MAKE) $(clean)=$(boot)
>> > diff --git a/arch/riscv/boot/Makefile b/arch/riscv/boot/Makefile
>> > index 6bf299f70c27..becd0621071c 100644
>> > --- a/arch/riscv/boot/Makefile
>> > +++ b/arch/riscv/boot/Makefile
>> > @@ -58,11 +58,3 @@ $(obj)/Image.lzo: $(obj)/Image FORCE
>> >
>> >  $(obj)/loader.bin: $(obj)/loader FORCE
>> >       $(call if_changed,objcopy)
>> > -
>> > -install:
>> > -     $(CONFIG_SHELL) $(srctree)/$(src)/install.sh $(KERNELRELEASE) \
>> > -     $(obj)/Image System.map "$(INSTALL_PATH)"
>> > -
>> > -zinstall:
>> > -     $(CONFIG_SHELL) $(srctree)/$(src)/install.sh $(KERNELRELEASE) \
>> > -     $(obj)/Image.gz System.map "$(INSTALL_PATH)"
>>
>> Admittidly I don't see a reason to do it this way either, but it looks
>> like the other common ports (I checked arm64 and x86) are doing things
>> this way.  I don't really care that much about which way we do it, but
>> it'd be better to keep everyone aligned.
>>
>> Are you converting the other ports over as well?
>
> Yes.

Great, thanks.  This is on for-next.
