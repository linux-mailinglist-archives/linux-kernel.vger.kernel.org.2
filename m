Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD663BADBD
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 18:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhGDQE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 12:04:26 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:55399 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhGDQEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 12:04:25 -0400
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 164G1Lk7030014
        for <linux-kernel@vger.kernel.org>; Mon, 5 Jul 2021 01:01:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 164G1Lk7030014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1625414481;
        bh=6HNc8VG/tGcCTwbJDZ5Jks5Dx/j6qMD9eu7GWnNREkU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wNuqCnDJeszwlWMRwggixesyYC9GSSNb4BVoj9s+4KoPRsmpG40FiMfGS7lZWS0rw
         Vju7775hwvZ0Ymko7dqLJR5sVeNmtGOK+qL1X5IacienSYlEX1tr9E1efYOLypdLNy
         9XM6svOhwz4yrVXQuFw6T5DLQfxO7PQG6pOyYSRv+EpQ/6TZPI6939ltfX2jSpBpdm
         voMqztZ9YNLnVtHS83PtyZ8cu/H0PCQETT4oXVzld3bvmU8qn8Pw5cVEhNiI2g/pbq
         SCIyQ8Y8i3LbWY0oRAXpMSZrbw0YXjaRATImPIsBVtZyWD1SqH4BD0ZoM+jJR1tpTN
         kcIaT3nFg1CcQ==
X-Nifty-SrcIP: [209.85.214.181]
Received: by mail-pl1-f181.google.com with SMTP id f11so8762231plg.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jul 2021 09:01:21 -0700 (PDT)
X-Gm-Message-State: AOAM53080H7GNZjqKW/GkYj0wGQ9zmUTUWqSov5ctFXa3TNv98Ebveon
        eeNgK1QmJB5gL3O8RbY8efzAKS+RsCRp+57HFaM=
X-Google-Smtp-Source: ABdhPJyUd8hDodVvk57P9D5cJOVWm0aBMKZx0VXs4hWaZHPG8ewFlyHJhF+kHHx66S20ClMVU2HYLZO67xrF8yJMaY8=
X-Received: by 2002:a17:90a:c506:: with SMTP id k6mr10433843pjt.198.1625414480779;
 Sun, 04 Jul 2021 09:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200317071821.9916-1-yamada.masahiro@socionext.com> <20210630184741.GA1037365@maple.netwinder.org>
In-Reply-To: <20210630184741.GA1037365@maple.netwinder.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 5 Jul 2021 01:00:43 +0900
X-Gmail-Original-Message-ID: <CAK7LNASvYVyEQ4M_zEUdw9K9AB-RVErKoqFMQZ5OSKJF0AoBww@mail.gmail.com>
Message-ID: <CAK7LNASvYVyEQ4M_zEUdw9K9AB-RVErKoqFMQZ5OSKJF0AoBww@mail.gmail.com>
Subject: Re: [PATCH v2] mtd: rawnand: denali: add more delays before latching
 incoming data
To:     Ralph Siemsen <ralph.siemsen@linaro.org>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        Marek Vasut <marex@denx.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 1, 2021 at 3:47 AM Ralph Siemsen <ralph.siemsen@linaro.org> wrote:
>
> On Tue, Mar 17, 2020 at 04:18:21PM +0900, Masahiro Yamada wrote:
> >
> >Marek Vasut reported this driver in the latest kernel does not work
> >on his SOCFPGA board. (The on-board NAND chip is mode 5)
>
> In a bit of an ironic twist, this change seems to cause a regression for
> me. I'm also using a Cyclone V SoC system, similar but not the same as
> the SOCFPGA eval board. The NAND device in my case is S34ML04G2.
>
> It worked fine in 4.9, 4.19 and 5.4 kernels. However after upgrading to
> 5.10 the NAND driver fails with "timeout while waiting for irq 0x4",
> just as was reported back in 2018:
> https://lore.kernel.org/linux-mtd/737ejrj81y.fsf@pengutronix.de/
>
> Reverting commit 5756f2e8dad46eba6e2d3e530243b8eff4dd5a42 restores the
> behaviour in my case, but that would presumably break the SOCFPGA board.
>
> Any thoughts on how we could make it work for everybody?
>
> Ralph


I no longer have any hardware to test this driver.

If you increase data_setup_on_host (the current value is 10000),
will it solve your issue?





-- 
Best Regards
Masahiro Yamada
