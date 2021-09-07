Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1D94027B7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 13:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343772AbhIGLYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 07:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245597AbhIGLX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 07:23:56 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA43C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 04:22:50 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id x27so18818168lfu.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 04:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=djnVuYfWJom7QWowXSw0crySrBfFYVvwoRUeTsmFcIE=;
        b=hEVQgdId01KH8Tlx1h7u9xnzriYqAALPaRO3hGOP7pFyB7vIrRUsMTyLpMXd/iIF+T
         K0lckbSo/qpprs83+YbjRi1Dnltu0oX+q73QCrIqC65BPBEbmtEuikaCUxbGahoCKhyp
         ZT20haEi3pppIIqpQeO3vDp6bWpXaww1RCcmtATjHN8Dql2TijR19t9dZKOPCMKScQ4a
         RZ1FSAED8Z2GomVZA4W44mpeED2+DPLTAHtKNIQhThKIba7sbMH3zY/AYVKbhkfsNeOA
         gAV7mK77VSwUjaEmY3zho21begUbXPj32KiT/WaP1ziWhIkBzbS7Q94Vq1lcQeHiFr16
         tA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=djnVuYfWJom7QWowXSw0crySrBfFYVvwoRUeTsmFcIE=;
        b=SiDGnlsclSMUuBseckoOLUG3yKEN41CEBHI3T9f4S+50Tz7w3UhU6Xi/gO74/NwJs2
         LvFIte/wk3zyVe9/K5BsmyHIdsyMbBvvlYymWQKLy4/ReEk8bPX6A1bKHO4NtWXElRZd
         StORhaYIeDHGxrgrFUI2feg0GSxwG1zMIHKHja2KAw3toHjXKfILlDB5tgwnkUwoRqHX
         FFMiDvsFYUjrhFYI+fWg7sHgS7PU9KMjUIOtIVzFUZXtqtAjAA/gIDrfsIjceuwrRi80
         QP+Ls4KA6ODuu+bwLH8KQM/0iWmavwj3+vghcmElB1kCDA4gN4wHgh/83HgaIOfGK7QN
         OfIw==
X-Gm-Message-State: AOAM533B98/rrNKM2gEV4TjIZyK4huaoRu1VelPlL/t7mBnh3zn4SGQF
        n6SkltENQ0mWGvr5rrxZyhNEEBYpTuqfSxGU/NDnCQ==
X-Google-Smtp-Source: ABdhPJy5mZTkiKyoEGvbCEqyl7lCtCNoepF5L3gwu2HJpX8x8gd7jmueVQJp1dEE60xhk1QRUtZ0aRu1aoAHg8A1YLE=
X-Received: by 2002:a05:6512:3096:: with SMTP id z22mr12186266lfd.584.1631013768369;
 Tue, 07 Sep 2021 04:22:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210818114743.kksb7tydqjkww67h@pali>
In-Reply-To: <20210818114743.kksb7tydqjkww67h@pali>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Sep 2021 13:22:37 +0200
Message-ID: <CACRpkdYe-Y-1YstovrJd7b8iNCDeX312mB4gLGcG1y6dE6di=A@mail.gmail.com>
Subject: Re: pci-ftpci100: race condition in masking/unmasking interrupts
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 1:47 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:

> I do not see any entry in MAINTAINERS file for pci-ftpci100.c driver, so
> I'm not sure to whom should I address this issue...

It's me.

> During pci-aardvark review, Marc pointed one issue which is currently
> available also in pci-ftpci100.c driver.
>
> When masking or unmasking interrupts there is read-modify-write sequence
> for FARADAY_PCI_CTRL2 register without any locking and is not atomic:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/pci/controller/pci-ftpci100.c?h=3Dv5.13#n270
>
> So there is race condition when masking/unmasking more interrupts at the
> same time.

I thought those operations were called in atomic context.
How did you fix it?

Yours,
Linus Walleij
