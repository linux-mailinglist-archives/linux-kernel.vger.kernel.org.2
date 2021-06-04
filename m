Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDBA39C353
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 00:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbhFDWMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 18:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbhFDWM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 18:12:28 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA68BC061768
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 15:10:26 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 27so8952122pgy.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 15:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Kl/E6sm1Hy5waa1ESIZ6GAoJ0uFLqC7+4leUJX1UReE=;
        b=e1C3eBAJo533STH89elp7a4H+e6DnBllnlpNPkSJ37AUtSa9D2fSu0R9qPHRWFpoUB
         dyKBlwyR2c9ha5qH37lC+zWEtaBtf/3ujqhuCkHBVKkpFXmVRfB052qGmbX6QEROyzD5
         3piThQCpvPoTNvTgpwAYjppQ7qiFBb3tZhJuG3A4soIr6mSQh9a2WrqXG2sMAvkf4lAr
         VShOLXtWlvCnxX+kxgqH+shj8nPlrteBjpNkyAbKPqD3c8r53ZkiFSt9/f1WtmOKJCE+
         lnqhimh/cKxstXt7srO9gYkWhdjTgZ6M61MALsrXBsMcUtD9cVabUQh9b9yd6ovsvTxK
         9GbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Kl/E6sm1Hy5waa1ESIZ6GAoJ0uFLqC7+4leUJX1UReE=;
        b=IVK1E+6VVsmwoSVxEAJltlPVQNIYoXD48CWUkeky3vKXydqJlbXMnlGiikDk1tkpeD
         WXq/VRW6BUwZyBnB/pLCPbEsIDLNP5QZ2U6SSwnk9tmz2OXX8A64MSUgX3/hdCyes9X4
         hkmoxEKW3dBNmUBAKECPJ+KKz4ao3Rp1aZw5Lfj8Avyz6swh8bsVR6U3cDPfeOm8St2b
         U/xTL8P5AfVLOMMrnWgOjQuUNJ5nx4OfOx13BPcxROFxp6M6bPhUUWR8jRs4LGG04RXq
         FeZWO/TY5oxhehUy/1LIq9ngplN4ejz1G7yd2mHN/qWOFyjUgOLwzK8IUSv2ZF/7FTSc
         lG6g==
X-Gm-Message-State: AOAM532z7gOfJzHAqyr2GjWYnq5flDy1ATfzUfkDcUAfID7kyQt0Jzgz
        LWTwzEfVoRljRDnTBb9ho8tbVw==
X-Google-Smtp-Source: ABdhPJx6gnUDtLRP5p/Mj/1tsX2DdzihHec2VB3/gPJAOwx7MOtdoF07gdAgTqrtYn6zBIaIbuTF9w==
X-Received: by 2002:a05:6a00:139a:b029:2e3:db98:9ae3 with SMTP id t26-20020a056a00139ab02902e3db989ae3mr6785904pfg.81.1622844626154;
        Fri, 04 Jun 2021 15:10:26 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 35sm2768481pgq.91.2021.06.04.15.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 15:10:25 -0700 (PDT)
Date:   Fri, 04 Jun 2021 15:10:25 -0700 (PDT)
X-Google-Original-Date: Fri, 04 Jun 2021 15:10:24 PDT (-0700)
Subject:     Re: [PATCH RFC 0/3] riscv: Add DMA_COHERENT support
In-Reply-To: <CAK8P3a04C8HObpSHNYqQpe4V96MoSLs7sEpiPvp4OpvyAU1_fQ@mail.gmail.com>
CC:     guoren@kernel.org, Anup Patel <Anup.Patel@wdc.com>,
        anup@brainfault.org, drew@beagleboard.org,
        Christoph Hellwig <hch@lst.de>, wefu@redhat.com,
        lazyparser@gmail.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-sunxi@lists.linux.dev, guoren@linux.alibaba.com,
        Paul Walmsley <paul.walmsley@sifive.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Arnd Bergmann <arnd@arndb.de>
Message-ID: <mhng-82cca177-11c3-44d0-a0c3-37df6a40bb6b@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Jun 2021 14:26:11 PDT (-0700), Arnd Bergmann wrote:
> On Fri, Jun 4, 2021 at 6:14 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>> >> To give some common examples that make it break down:
>> >>
>> >> - 32-bit vs 64-bit already violates that rule on risc-v (as it does on
>> >>   most other architectures)
>>
>> Yes, and there's no way around that on RISC-V.  They're different base
>> ISAs therefor re-define the same instructions, so we're essentially at
>> two kernel binaries by that point.  The platform spec says rv64gc, so we
>> can kind of punt on this one for now.  If rv32 hardware shows up
>> we'll probably want a standard system there too, which is why we've
>> avoided coupling kernel portability to XLEN.
>
> I would actually put 32-bit into the same category as NOMMU, XIP
> and the built-in DTB:
> Since it seems unrealistic to expect an rv32 Debian or Fedora build,
> there is very little to gain by enforcing compatibility between machines.
> This is different from 32-bit Arm, which is widely used across multiple
> distros and many SoCs.

OK, well, that's what the spec says already.  Maybe the right answer is 
to just add that "be compatible with the platform spec" Kconfig and have 
it also enforce rv64gc like the spec says.

>
>> >> - architectures that support both big-endian and little-endian kernels
>> >>   tend to have platforms that require one or the other (e.g. mips,
>> >>   though not arm). Not an issue for you.
>>
>> It is now!  We've added big-endian to RISC-V.  There's no hardware yet
>> and very little software support.  IMO the right answer is to ban that
>> from the platform spec, but again it'll depnd on what vendors want to
>> build (though anyone is listening, please don't make my life miserable
>> ;)).
>
> I don't see any big-endian support in linux-next. This one does seem
> worth enforcing to be kept out, as it would double the number of user
> space ABIs, not just kernel configurations. On arm64, I think the general
> feeling is now that we would have been better off not merging big-endian
> support into the kernel as an option, but it still seemed important at the
> time. Not that there is anything really wrong with big-endian by itself,
> just that there is no use case that is worth the added complexity of
> supporting both.
>
> Let me know if there are patches you want me to Nak in the future ;-)

Sorry, by "added big-endian to RISC-V" I meant to the ISA, not to Linux.  
We haven't had any interesting in adding it to Linux.  The interest has 
all been in the embedded space.
