Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4022F43D73C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 01:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhJ0XLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 19:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbhJ0XLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 19:11:33 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C6CC061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 16:09:07 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id s24so3131738plp.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 16:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=z53gTOEVxYIb2lgRgD1L0JMW+iobeAI2vEOAm7ftuvk=;
        b=lV/g05Uypl1OzKYE1QMWJyYIU8xBPn8A0CXWkz0mdqne0nY/AhG62U7txhv33/8DBJ
         L8QMapRM1yzfc2+j9bzuWXoyXiXhAbLXYxCt3WAjfpBecHdHe6WwRzd1zri9JzCqhiaW
         pZkpAUtcH+ZPBVClrhm5qjb6xz1xV+yfzRODN62gaVcYIi7sCPobs0xde5NJ42Ox0xDu
         Vm9O+wT3VUTdonNpQP2UTPs3G3ya+XOMxAZoqAT86EVmCLMpHKdDUxwUt3v8X0kZvmwu
         8F8ObOpydb6ih8EwhOpDBxicaZ5mhVmwPgQqDO25HgcULLaWmkyG/l53yLZsNfrjWZBq
         8cEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=z53gTOEVxYIb2lgRgD1L0JMW+iobeAI2vEOAm7ftuvk=;
        b=JmnZGdTbloE7Fe90DXytdKPLCYEm5kx3S9VYnyD6L+0z/IcJS6sg4sqgWpoYP6IWqP
         fU65GLvZ1/dCM2UA2TvB9qbUmHNMQ4UhgAU8laJTxWL2YYtZGMYeI9Dye8JK8ID6cZRH
         V9JEjHWtfafkbdBjybr/vW92+HylUnGnPW3kNrKUTXBNUi1MLIMB5HV4J725pMohKVNm
         4YNtfZ52ztgMGNQ8W/qgnv1wUlYfVvEh2XeS+NDJ4tkb8UscNHiphDTh1dV0eK6FyUAM
         k1rB6WPAA1yWJe16j5/iLE+dLVdW3CtSErpLHkKTkba+SrtBKjZW77xUZruA5tgh3G5s
         ljaA==
X-Gm-Message-State: AOAM530ecm4Dw08bbB7VIwQgi5LcEi9lGHmUEMJcvu+47jH5SEGexTEf
        uGkfQxzWTybQ6XCSFhIOHGS8qA==
X-Google-Smtp-Source: ABdhPJwzxaxiDrbf0kl3QEpL66IJ+PcLfivFj41ahyeu/Lr51qQFioruTUwYw2IXhembXFga6qL70Q==
X-Received: by 2002:a17:902:e808:b0:140:55fe:1b4e with SMTP id u8-20020a170902e80800b0014055fe1b4emr413929plg.87.1635376146401;
        Wed, 27 Oct 2021 16:09:06 -0700 (PDT)
Received: from localhost ([2620:0:1000:5e10:60fc:a50:6d27:9fd3])
        by smtp.gmail.com with ESMTPSA id d21sm1000958pfl.59.2021.10.27.16.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 16:09:05 -0700 (PDT)
Date:   Wed, 27 Oct 2021 16:09:05 -0700 (PDT)
X-Google-Original-Date: Wed, 27 Oct 2021 16:07:37 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: Make CONFIG_RELOCATABLE user selectable
In-Reply-To: <87ee86ajig.fsf@igel.home>
CC:     alexandre.ghiti@canonical.com, alex@ghiti.fr,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     schwab@linux-m68k.org
Message-ID: <mhng-95082d33-c7f4-4d3e-9794-7e0534324218@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2021 02:45:27 PDT (-0700), schwab@linux-m68k.org wrote:
> On Okt 27 2021, Alexandre Ghiti wrote:
>
>> On Wed, Oct 27, 2021 at 10:03 AM Andreas Schwab <schwab@linux-m68k.org> wrote:
>>>
>>> On Okt 26 2021, Palmer Dabbelt wrote:
>>>
>>> > +config RELOCATABLE
>>> > +     bool "Build a relocatable kernel"
>>> > +     depends on MMU && 64BIT && !XIP_KERNEL
>>> > +     help
>>> > +          This builds a kernel as a Position Independent Executable (PIE),
>>> > +          which retains all relocation metadata required to relocate the
>>> > +          kernel binary at runtime to a different virtual address than the
>>> > +          address it was linked at.
>>> > +          Since RISCV uses the RELA relocation format, this requires a
>>> > +          relocation pass at runtime even if the kernel is loaded at the
>>> > +          same address it was linked at.
>>>
>>> When in doubt, do what?
>>
>> Then do not enable.
>
> Please add that to the help string.

Thanks, I forgot about that.  I've added it, but this is still a bit in 
flux so I'm not going to send a v2 right now (it's on top of Alex's 
other patches and should probably be squashed in, anyway).
