Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 062803566F8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 10:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348590AbhDGIia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 04:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348534AbhDGIiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 04:38:25 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BBEC06174A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 01:38:15 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id r20so19701052ljk.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 01:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AuFjkA3Te0yYWflgJfKxzh4S0jAnT6+PkWv6Iu0MWs0=;
        b=LFBuJUeg1Jml0D8sr6mXbhoYwJrV9La5vY9YIOdtk1QHn1VxCrm3R79qeO2S7/V8K3
         oGwlpk/zgnt8mPc1OYznR4jxUkYrkLqaHcn3+9VD6tFS5BH0zMC1EDBRoVoNRT9qpSty
         Odpw+Ebo/Gh0YXEPE58CYA9+oyvJwwM+nOo2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AuFjkA3Te0yYWflgJfKxzh4S0jAnT6+PkWv6Iu0MWs0=;
        b=RfiMV0P1+0WQvg5KAmNZqGChWVVzFN7YkNkGbC/x/gEUDSkNK0c+TMYb4IfJz7moth
         6fMo9lYpf3opda1BUcLHVwBWhlmbkt31apjMyD0xToS9Tfv4ZjKrv9kNa69vEkbwxRg8
         HoV51bGdRMKgecbMoye95NZk0Ym/2wlkPaA8uXJDUPXL8+YSNRkF8ly+Odq9pJ37ZkCX
         tOGtjyjLGFcOSEgBxoSgGoLZi75ONsF7lrJPzRdbfbkEqasVoDokX1K1Qhd9IFVaOnu1
         DRWAZe2l30imMUa11auiTViUGT95J3gV6DzNeOXUXLr8xhckykcZ5p7/ehQpJWC8VmPD
         TFAw==
X-Gm-Message-State: AOAM531u/xmBxtGVWcxutPNuD0zJG8mWswlkyZpzod97GGNiTCxP2hm5
        QYm/MM9UdF0fPQ1tfaUCR7Y8sivKwYJKVVeXQROyjw==
X-Google-Smtp-Source: ABdhPJyVLN3dn/GmaH9hhtE4TjLlahmNOWaMUoB6H3PcFErj/DDYE9Jhz3XRT4oPDAAfjRr41PabX1ZzBi/rJMDpc+c=
X-Received: by 2002:a2e:924f:: with SMTP id v15mr1542585ljg.172.1617784694327;
 Wed, 07 Apr 2021 01:38:14 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-add8fe77-f966-42ee-97b7-3d78f48fb103@palmerdabbelt-glaptop>
 <ac54f74d-adab-e844-ad46-733b1560ece1@ghiti.fr> <324299b7-eef4-0961-239c-ee72100f2e85@ghiti.fr>
 <CAM4kBBL8pDrZT0aGygsjVLTKfRf8y2-YQeyGPDEBcujmaOZCyg@mail.gmail.com>
 <32a6ac11-f274-71ee-e5d0-dc60ba841495@ghiti.fr> <b9fe823e-5e7e-9f0d-3540-784dbf9480e1@ghiti.fr>
 <CAM4kBBJcb0fBnAGFJQTVoT2HDMks3mzg0_-DWrHVPhMk8Mf8dQ@mail.gmail.com>
 <CAM4kBBL0U25xyGbdxtQXu+O+E8KEghyr8iT1sH2JuGiG=udiFg@mail.gmail.com>
 <27b0ae72-bc84-a2f3-bae9-da6995d38058@ghiti.fr> <CAM4kBBJQ9g2Fbpcjp+--vCMZggBM3WOGqM1N0jJwwfHKjDM_KA@mail.gmail.com>
 <dd303c4c-713f-c68c-879d-f4212cc305ee@ghiti.fr>
In-Reply-To: <dd303c4c-713f-c68c-879d-f4212cc305ee@ghiti.fr>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Wed, 7 Apr 2021 10:38:05 +0200
Message-ID: <CAM4kBBLsWPVfL20Py=QVSUCT4QW6pDbJR_TVR=LtTVgMLqL1QQ@mail.gmail.com>
Subject: Re: [PATCH v6] RISC-V: enable XIP
To:     Alex Ghiti <alex@ghiti.fr>
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bin Meng <bin.meng@windriver.com>,
        Anup Patel <anup@brainfault.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Nicolas Pitre <nico@fluxnic.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

<snip>
> > All in all, I am quite sure now that your take on XIP is working fine.
> > The issue with single-core boot under QEmu seems to be  less
> > reproducible on slower machines running QEmu and more reproducible on
> > higher performance ones. It's not clear to me if that is a QEmu
> > problem or an in-kernel race, but it's hardly a XIP problem: I was
> > able to reproduce it once on a non-XIP kernel too, by copying it to
> > RAM in u-boot and giving it a 'go'.
>
> Ok then I'll post a v7 of your patch soon hoping it will go to for-next.
> I'll add my SoB to yours as I modified quite a few things and I thin
> people need to know who to yell at, if you don't mind of course.

No, absolutely not. :) Thanks for digging into this!

Best regards,
   Vitaly
