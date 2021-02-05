Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2E7310297
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 03:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhBECJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 21:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhBECJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 21:09:10 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6920C0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 18:08:29 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id j84so5290165ybg.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 18:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8/DUuuLnOc3dW/Ew2hfkg+fVyjRRdajneZRBMkAFYOQ=;
        b=PbuOE30AyXprky6/QR6czkFZx5uz17LkJwwN/l7f1dG57sQ7EjetrbkJPVtSaWBvWE
         1MABWdpp0QcG1W3UvP4VyHMQ+KGHcWc6GEZzOA20F45P43A3TOMFTG7Gs/LeVB8CBvyM
         LE9/ZWPsB+PgfTuWezS6JdVf6YTnKCuixndXTbwSDwXlUkEQ2YYbjGxT0Sx1Gq6bJmLQ
         Ph8Gi+aqbEcWolobecwmtusaOk6FrDZzhIohA2gKDr8cO6ekedgyd1KyXWh78DscPoBN
         lC/l73RCkWkvPfU5YrajCfBIaXC9A4tR+Lu7Umf5bb/5DhBnyV7zHBJMT2rxzowBYsWy
         3zvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8/DUuuLnOc3dW/Ew2hfkg+fVyjRRdajneZRBMkAFYOQ=;
        b=s2Dw1CKga04XdtKuL+wjdeb68cg1CufhFqgoGyck9tfZSf9c1bLX4mhoHDntWc57ba
         vrXbU2nNuVHjUNFTm2iB4ClGG1oGTiXbd56WQVc7B+q/ecPYrE9wI6B+EjCgBzRYpedk
         FAWtUWdNWcdCwOoUx260pCYCdVuiz3SIkuEaJYcRhW3mAwX7NBhQzGiDG9ZBoJVTeD/H
         OEenQV0hr4Nl2BU5p8pkXEtffA5UMZ+47t7ADlTueo+XCESaSLjNT6B5Kx7bWcoZXNIa
         Lg6y0+VgSmp8yBXxN6J1jY7IBhumBslJUlBpMFFC2moRYWeJVKm0E0lwXJpP1ebSoeIB
         QCng==
X-Gm-Message-State: AOAM532c1mbkpCoQ9obiyKNpUu2focpXk5X02G3uDpy9ptCEX40sEAek
        8mv548GU0Xk64dzn3ZoQ3WljdobMlOX2Z+U/CCmviw==
X-Google-Smtp-Source: ABdhPJx+J5x04XVJbmCzZQFFCEeL6xlp5guKIWQwS5n8MuL3YcoG9mvY9lyIlpsOZ2HSMR15MNevEl/+YHoiA762ok8=
X-Received: by 2002:a05:6902:1025:: with SMTP id x5mr3141079ybt.96.1612490909017;
 Thu, 04 Feb 2021 18:08:29 -0800 (PST)
MIME-Version: 1.0
References: <20210205013847.1736929-1-saravanak@google.com> <CAOMZO5DRjT4d8gzSZZX4itcOXO_pye-1aq658EX2vQJ5xhEi8A@mail.gmail.com>
In-Reply-To: <CAOMZO5DRjT4d8gzSZZX4itcOXO_pye-1aq658EX2vQJ5xhEi8A@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 4 Feb 2021 18:07:53 -0800
Message-ID: <CAGETcx9E+dw3HS+DHMhzbrQGcrT6z4kDH=ziS=1=i-7=0rLwgw@mail.gmail.com>
Subject: Re: [PATCH v3] ARM: imx: avic: Convert to using IRQCHIP_DECLARE
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Kaiser <martin@kaiser.cx>,
        Android Kernel Team <kernel-team@android.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 4, 2021 at 5:54 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Saravana,
>
> On Thu, Feb 4, 2021 at 10:39 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > Using IRQCHIP_DECLARE lets fw_devlink know that it should not wait for
> > these interrupt controllers to be populated as struct devices. Without
> > this change, fw_devlink=on will make the consumers of these interrupt
> > controllers wait for the struct device to be added and thereby block the
> > consumers' probes forever. Converting to IRQCHIP_DECLARE addresses boot
> > issues on imx25 with fw_devlink=on that were reported by Martin.
> >
> > This also removes a lot of boilerplate code.
> >
> > Fixes: e590474768f1 ("driver core: Set fw_devlink=on by default")
> > Reported-by: Martin Kaiser <martin@kaiser.cx>
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > Tested-by: Martin Kaiser <martin@kaiser.cx>
>
> Thanks for the respin:
>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Thanks for the quick review.

-Saravana
