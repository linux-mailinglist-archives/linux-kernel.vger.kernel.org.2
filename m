Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E12A23B8C63
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 04:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238627AbhGAClA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 22:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238056AbhGACk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 22:40:59 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6E5C061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 19:38:29 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id p4-20020a17090a9304b029016f3020d867so3007518pjo.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 19:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=DuvFY1gPxxozd7qXy5qfSaZHOIKcOMsMpJnnW/JJ+sI=;
        b=KZPgT5/AWPP1IKKRemRHaymL0E9XMI+s0sy4ZnF6fvxcQ3UNafR9ONvDi/27k/Afj9
         Uq2fpzi69JdTlF1Kh4y6Qy833grEW2xOo0MNt3wuu3/TtfsYBBQaVIoc+dBGelTcDY0b
         Jkgm4yD1ewl82bVW59EPJoCiQWFjTcuZJJ5043FvvaM3dJIMuGao0fxElA3XmShPNbK0
         OtwvhIFMTChxOhWbjR8a0zgCTWkPVE7OWaLkgCcvfxVw4Kw4wxPMyQmR9dtjvpw9tryQ
         kilHELsI6MrhJfNnyJjfHoOLvbzwi3vsJh41EOi8YhmLGoiMC7sV9TffN15P2Js1La79
         4ruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=DuvFY1gPxxozd7qXy5qfSaZHOIKcOMsMpJnnW/JJ+sI=;
        b=bEJrzBSP2OcdIMTbMeJG88drNPOKZwgsJ0FCk4IkxcaXxxn6CHeElTcRoaTqc0kNn/
         b7G3Q2h7XAi/OTwIvYT1w7KE1Mm39NnWCO9R+4xUieX4grml7eQSnt7fpu6uRdo1FRNv
         7QtbLLAdXe1LhjzBxYBUzy1ph/p5Gxzm+3iFZdhskLI2Fno8n/ar09pu927jdYBtYI/k
         liFcBxU4sETHFqliX/gjJh/ZSIV1gri08tWZbHAlYxQqGbEvgB5oYh5twWVZ/dIo3Uo/
         xf39B8qhY+STdjeRTUMrkmJM4D17bBwpw5Mz8+1Ipy9Ff1wjKaSDrurkUrYDJy8EdSCn
         32aQ==
X-Gm-Message-State: AOAM531gQ0MuT3bTNzIUwGkIfLMhuNWKrgyoYSOSjod6ows+9hwZz9+J
        agZW6O19A2IaKdmDz7SmHx+vGQ==
X-Google-Smtp-Source: ABdhPJxGRwxXtTva/zQTzn2UIFqbxvTX+jXNDe1uu/VCt2rAXg0/eU01kj2QcxTbgulC46mwzwgzaQ==
X-Received: by 2002:a17:90a:6605:: with SMTP id l5mr42070512pjj.168.1625107108942;
        Wed, 30 Jun 2021 19:38:28 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id g4sm23225456pfu.134.2021.06.30.19.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 19:38:28 -0700 (PDT)
Date:   Wed, 30 Jun 2021 19:38:28 -0700 (PDT)
X-Google-Original-Date: Wed, 30 Jun 2021 19:38:04 PDT (-0700)
Subject:     Re: [PATCH -next v2] riscv: Enable KFENCE for riscv64
In-Reply-To: <CANpmjNMh9ef30N6LfTrKaAVFR5iKPt_pkKr9p4Ly=-BD7GbTQQ@mail.gmail.com>
CC:     liushixin2@huawei.com, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, glider@google.com, dvyukov@google.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     elver@google.com
Message-ID: <mhng-d63a7488-73a5-451e-9bf8-52ded7f2e15c@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2021 02:11:53 PDT (-0700), elver@google.com wrote:
> On Tue, 15 Jun 2021 at 04:35, Liu Shixin <liushixin2@huawei.com> wrote:
>> Add architecture specific implementation details for KFENCE and enable
>> KFENCE for the riscv64 architecture. In particular, this implements the
>> required interface in <asm/kfence.h>.
>>
>> KFENCE requires that attributes for pages from its memory pool can
>> individually be set. Therefore, force the kfence pool to be mapped at
>> page granularity.
>>
>> Testing this patch using the testcases in kfence_test.c and all passed.
>>
>> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
>> Acked-by: Marco Elver <elver@google.com>
>> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>
> I can't see this in -next yet. It would be nice if riscv64 could get
> KFENCE support.

Thanks, this is on for-next.  I'm just doing a boot test with 
CONFIG_KFENCE=y (and whatever that turns on for defconfig), let me know 
if there's anything more interesting to test on the KFENCE side of 
things.
