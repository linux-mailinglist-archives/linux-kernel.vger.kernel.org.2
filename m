Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66B63B8C6F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 04:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238670AbhGACzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 22:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238056AbhGACzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 22:55:23 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D8BC0617A8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 19:52:53 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id b1so2830076pls.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 19:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=hvxDF3nom/N8rPm+Ppo7zGPA/qzGtO9RuOCfsxZTu98=;
        b=SpjFL08PBqV7tkh6qKJFbHlv80PlDkGq07wcYsvXaYnweI2EpYhmpM/u8RV0DX7eud
         lszQ4GyMHGCeoLbl8uNh/YKcZWbdc+fRt/XgL1QGeyrevEt5RgdJ6m0PW/BND3i+5Mvt
         Tf1Ptudl3du2nRf77SJ/JTGH4r2jVQ6ewpyf6qFhyG5k2cA8/+YIheA6dKXE0TLYOJ4N
         TiemKl2puGeIDcT/OFNCWGTGKsgDz4DYMn/wxKrrGcVMn9+0e2BzC1Ov8ExreTRiJpb8
         //MHSLFw+Mp/ugzIgYixQV3a4jfQgyIOYoHYuZkvH1D9IaVUWIAkkKC4GniP/WYVuQpc
         HoJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=hvxDF3nom/N8rPm+Ppo7zGPA/qzGtO9RuOCfsxZTu98=;
        b=BCFauAcvtedNJgvYyeGGMxjWmzX5GAN2wvOv89M0w4PQbeiXYZcqTjNFDT0D7sGoWs
         AxPxo8QTWQu8y9cMMqEAzlYOBBowlZ/MCejLRAu67YqnnNa4SPlTa/GB+4nkCaX3rgCO
         3PIbRCogWgBKvL9qM2E5WXVkqJIp3F7t/C+ARsp9fY5PyKA6XfxH3D6upHnDnChznp50
         0KHsD3532llDKOhZLCjlaDBq0eDJj2omWzvYQFFvvA8OCTwjzj9xyJ/Bv3V8Olz6vHGv
         JayezAZ062qSNtJ527PK8c45yfSeZqa9xrlJXURPZocv3sBHh+dHo7zGnfBjOTe7RiRF
         B/mA==
X-Gm-Message-State: AOAM530BZoXiJbZlDXkfzOZttpsJlQV+X84dyWkjCSqRWphaExH22ndm
        KEDIEHMXeUURhh2usFx+ceo02g==
X-Google-Smtp-Source: ABdhPJwTB1Hi0X5cFeHOElli+j39Ed7Ljy/aE1Qg7eTojjCof97X9FW3uTdfNXuJxXddlvtQXZecVA==
X-Received: by 2002:a17:903:2341:b029:129:1282:fd37 with SMTP id c1-20020a1709032341b02901291282fd37mr6223940plh.6.1625107972559;
        Wed, 30 Jun 2021 19:52:52 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 206sm23381385pfv.108.2021.06.30.19.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 19:52:51 -0700 (PDT)
Date:   Wed, 30 Jun 2021 19:52:51 -0700 (PDT)
X-Google-Original-Date: Wed, 30 Jun 2021 19:52:49 PDT (-0700)
Subject:     Re: [PATCH 2/3] riscv: Remove non-standard linux,elfcorehdr handling
In-Reply-To: <CAL_JsqKJgz=ixNAJProoVFmQXGEOsTYX=bXTdtf7RLQErL1VRg@mail.gmail.com>
CC:     mick@ics.forth.gr, geert@linux-m68k.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, frowand.list@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     robh+dt@kernel.org
Message-ID: <mhng-6db38728-4f82-45bd-9b17-c41da55c41e9@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2021 07:47:46 PDT (-0700), robh+dt@kernel.org wrote:
> On Wed, Jun 16, 2021 at 4:43 AM Nick Kossifidis <mick@ics.forth.gr> wrote:
>>
>> Στις 2021-06-16 10:56, Geert Uytterhoeven έγραψε:
>> >
>> > I can't comment on the duplication on arm64, but to me, /chosen
>> > sounds like the natural place for both "linux,elfcorehdr" and
>> > "linux,usable-memory-range".  First rule of DT is "DT describes
>> > hardware, not software policy", with /chosen describing some software
>> > configuration.
>> >
>>
>> We already have "linux,usable-memory" on /memory node:
>> https://elixir.bootlin.com/linux/v5.13-rc6/source/drivers/of/fdt.c#L1011
>> and it makes perfect sense to be there since it overrides /memory's reg
>> property.
>>
>> Why define another binding for the same thing on /chosen ?
>
> Go look at the thread adding "linux,usable-memory-range". There were
> only 35 versions of it[1]. I wasn't happy with a 2nd way either, but
> as I've mentioned before we don't always have /memory node.

I don't really understand what's going on here, but IIUC what I merged 
in 5.13 doesn't match the behavior that other architectures have.  In 
that case I'm happy moving RISC-V over to the more standard way of doing 
things and just calling what we have in 5.13 a screwup.

Sorry for the confusion.
