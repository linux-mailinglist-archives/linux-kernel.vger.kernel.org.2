Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 977A432458B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 22:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbhBXVCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 16:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbhBXVCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 16:02:05 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6CBC061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 13:01:24 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id p186so3253652ybg.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 13:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oNOJCv96V2W2oiF3R22dF2MhqbWN/9wIBc5R81MAbG8=;
        b=Oj66rqmFCj1oZG5mcctMLdE8WopD4kxLQzOMCysvpcWagEg/435Upf00UDNpJpepTz
         TKxck5a6VqwGKlDBLhND1QrqqxHD8RHFF8Gzw3SrmKThy/yBtNSowzjAQTDpYGl4XEv1
         ohV/Gt+75AoO7McrARs4e4Foe8DoRodOysovwG23+HRqM/w1UamueJX4gsPdORMeNzDu
         Nw0vCHVdUttZ2u0L3mY/Vze+ZohwTykVT64Fq+J2CFgFI6izKiogt2asRmJFnKzZF2VR
         LQ+cTS+UOCLVxA/QFFTp3Aeg/GySGciOZRwxFvB2TZQJ7mn/tbzCzXUbXU+7UtVR0P3j
         yVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oNOJCv96V2W2oiF3R22dF2MhqbWN/9wIBc5R81MAbG8=;
        b=bH0t7woqbcxiDyLBTFQ2+kXTGGafpbNjkmvMe24/YSVflEKuCq6A7J8WKNXatRKGMU
         o0RZ6akqBmS835UpIwfBZljk1hqiTxlHvb7QTbNSQKOJrYzySP/M5gqPZyYyIjE29wog
         thslodPaywAhiZeWSqU8XyAchlddJ3/Fpo1yxYdzgAlwBqqOoaRxdHE7+SuuWcqvvQqx
         PIdMJy5lRV6giJ0NPlMI6uIcuyzrzBAzi7TwSTtaP13W7RYWU14bRGjxkOeeeqzxGC5X
         CNYdbmErvKahHyIC0GZ3R67EXqZQfGKELlGiJBpgOeHRwh7NHvzE483VVfxGBlWn5T8L
         WJcw==
X-Gm-Message-State: AOAM530tUC8KnQVLtzS+5f2DVA/JaPtECxh4p5ylff6mJcjOmcooiIAL
        xcWB8JOhHFOYXzhPhcPfE/fqFkzEpkihIgLdV+0=
X-Google-Smtp-Source: ABdhPJykxKsUxsj58MI1Rbl2fvDXH6b809ZrxV1OH6WJSgCBEfcMBAHGNDV8YUTJBoGOX3RnsxoCjOfPLntOJ95q3Kg=
X-Received: by 2002:a25:d94b:: with SMTP id q72mr47291810ybg.135.1614200484280;
 Wed, 24 Feb 2021 13:01:24 -0800 (PST)
MIME-Version: 1.0
References: <20210222201655.32361-1-noltari@gmail.com> <20210224080210.23686-1-noltari@gmail.com>
In-Reply-To: <20210224080210.23686-1-noltari@gmail.com>
From:   Brian Norris <computersforpeace@gmail.com>
Date:   Wed, 24 Feb 2021 13:01:13 -0800
Message-ID: <CAN8TOE_Eg6zYqy8wLtrNcTiCQdcihM7wGM5JHw=bh4=b1CL-_A@mail.gmail.com>
Subject: Re: [PATCH v2] nand: brcmnand: fix OOB R/W with Hamming ECC
To:     =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 12:02 AM =C3=81lvaro Fern=C3=A1ndez Rojas
<noltari@gmail.com> wrote:
> Fixes: 27c5b17cd1b1 ("mtd: nand: add NAND driver "library" for Broadcom S=
TB NAND controller")

FWIW, I could believe this was broken. We weren't testing Hamming ECC
(nor JFFS2) at the time, so it could easily have obvious bugs like
this.

And since I got this far, and I'm still in MAINTAINERS, I guess:

Acked-by: Brian Norris <computersforpeace@gmail.com>
