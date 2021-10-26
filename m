Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9781A43BBFD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 23:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239385AbhJZVGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 17:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235827AbhJZVGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 17:06:01 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1CEC061570;
        Tue, 26 Oct 2021 14:03:35 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id d6so400956qvb.3;
        Tue, 26 Oct 2021 14:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XG5lbTjVQqOyn0s7cG0no6APYPSE1g9UuIJyOQ6ldbQ=;
        b=L0Q6Q39KF4ld5D0VLg4Foh6S7OmTuL4NUJHDlWVu8adgjXhgE4sPJgxkeNiiYrl8H5
         KprWsqQ8R8PY9IgEbm6QTvlQwatPzn6ZFHRV2claSzj4DnHUp5pIjWH8guAKZqsTVv9d
         UtXb4AQ8yTRsTAkMdaq0hFNvQubso2XBdKzvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XG5lbTjVQqOyn0s7cG0no6APYPSE1g9UuIJyOQ6ldbQ=;
        b=jKJpWjlJ3A1yrf6PJyVGcEnXA1xBwomZWwqiuusTbjWk9HtVya8f8m6X1AvcvCWNGe
         Swor5dQPM9CS+URdinONp2uSvcaiRUxqYohQ5Vn14fCCXKKI8UoM0cwNH/TCYgp3in38
         2KtbKGrZ1S31Rj7kQGnZGZnmqDVQLBSdnmnhwe4oHgny5x++noiXl+aY5xBLbMd/l27k
         pStcOeglqi8wakU3RGwX9FGG9ju8e4jsy6+zYUW1HCVJR5lYajQ5OGf52LrUllo69IUX
         Cbd3vlYK360nDV4O8LSLLJDArCJiFvDnkIOmXvH7vUahN8BTHYqH0nup5zBZe47jdHXi
         1pqA==
X-Gm-Message-State: AOAM531IFtdX6fkPRBGb4MwD9KEq0EsmePx/wGkDb/Byrq6B3A2ASM9G
        ATFXrL1ytMovLooAedCIiLYGQ3zTDtKT29NOSGwXM/G8F2E=
X-Google-Smtp-Source: ABdhPJyS+raPQ3RHzlakqcRijKe8IBgxi3FsZs0B+JL2VJIAV2O/RysAVQOh6SdhYJC6+oczNxVjX85+/VudRV6YotQ=
X-Received: by 2002:a0c:cdcd:: with SMTP id a13mr19072201qvn.27.1635282214282;
 Tue, 26 Oct 2021 14:03:34 -0700 (PDT)
MIME-Version: 1.0
References: <20211026200058.2183-1-aladyshev22@gmail.com>
In-Reply-To: <20211026200058.2183-1-aladyshev22@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 26 Oct 2021 21:03:22 +0000
Message-ID: <CACPK8Xd5eYpsFNw1jEjv3NaShgzE3zC_Ct29pJM34TfrqRTNtQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: aspeed: Add AMD DaytonaX BMC
To:     Konstantin Aladyshev <aladyshev22@gmail.com>
Cc:     Supreeth Venkatesh <supreeth.venkatesh@amd.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        SoC Team <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Konstantin,

On Tue, 26 Oct 2021 at 20:01, Konstantin Aladyshev
<aladyshev22@gmail.com> wrote:
>
> Add initial version of device tree for the BMC in the AMD DaytonaX
> platform.
>
> AMD DaytonaX platform is a customer reference board (CRB) with an
> Aspeed ast2500 BMC manufactured by AMD.
>
> Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>

This looks good. I have one comment about the GPIOs below.

> +&gpio {
> +       status = "okay";
> +       gpio-line-names =
> +       /*A0-A7*/       "","","FAULT_LED","","","","","",
> +       /*B0-B7*/       "","","","","","","","",
> +       /*C0-C7*/       "CHASSIS_ID_BTN","","","","","","","",
> +       /*D0-D7*/       "","","ASSERT_BMC_READY","","","","","",
> +       /*E0-E7*/       "MON_P0_RST_BTN","ASSERT_RST_BTN","MON_P0_PWR_BTN","ASSERT_PWR_BTN","",
> +                       "MON_P0_PWR_GOOD","MON_PWROK","",

For systems that will run openbmc, we try to use naming conventions
from this document:

https://github.com/openbmc/docs/blob/master/designs/device-tree-gpio-naming.md

If a GPIO is missing from that doc I encourage you to add it.
