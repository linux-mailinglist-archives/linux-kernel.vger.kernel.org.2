Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA4A421663
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 20:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238402AbhJDS2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 14:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238541AbhJDS2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 14:28:12 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605BFC061746;
        Mon,  4 Oct 2021 11:26:23 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id y14so6777780vsm.9;
        Mon, 04 Oct 2021 11:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6n/vts0PyHmoxi8oEBeOuVoVdH7tRF+8eeP06Mq4yWA=;
        b=NuDtgVLsxGgAxPAHdWpFc8G6LW+l550GL9Nh06oO17X1ulv4GnhPCUdBjx+zU4LSyH
         Lse4QOm89izzccTGHht3YRE4BXD12YPzgpcUFqqUG/Vu0p2LIJQKubFN4zmlqKNwdyG7
         qNmTA1rh02vDf6WggG/IYDve1KWSYW+jM9Vc1U/CIfj7okQO7UbHnsgBNeoFw0WPom/k
         /VwHya7SSczwtL1tixVNZaILyrKuFNAlS3P1BhwgqLhEANIuDYfTMZtKO62LU2jeXiK8
         kWZdMMqClpOq1da2IhvLtAPlP8DAPFbIm7Hpu9fpeB7ubx5iLHYfkzBIBeS0lEkxVH5m
         04ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6n/vts0PyHmoxi8oEBeOuVoVdH7tRF+8eeP06Mq4yWA=;
        b=pJez7O6ZNiNhVG3XkKCx+YFkQnaNs0+uddMuRrna3VE1dsSK8X57STZ/SixdzKaQ62
         lL3m+qaSE2qvQ+pTIAm5fmpz47MS5j7mmjnBcp/Va5EYbZEUekgbrWeeSbudOOZ90pxX
         ccur+mtGJb7J8xJDiXPRrSANLv5jZxPHZ0F2zxBOoZTfBeewK4Su2uz0U1LYaXejZhWe
         qqKTerpwGpr3C37grnfw2jg1GR9pS204fL00hTzMUfdMnIaOBpECHbvxF4/VTdocElTS
         vxdgiTcNGVMbsR1LmkdT6/CuBhJNR/xpVrRm/hRnl3dlVemlB4cpSWn55L1G6TaFQPYA
         0g1g==
X-Gm-Message-State: AOAM532LBuQtTQANaqrsGj1bcYkILSdzmp71DBf2rLBVUK8TwTU3J+8e
        mbWV+L8SX0DWasx0a5N3CMTmCqaxnEyXkvIYZNI=
X-Google-Smtp-Source: ABdhPJyWkVxkzj24O9IbQ07+XhO2ovB+390tYNmw0/qcOFn04pnzmeGJsny1QYwPGB1Z3BUS7aR0Sa6NBsE2uQoC/w4=
X-Received: by 2002:a67:d189:: with SMTP id w9mr14525515vsi.55.1633371982514;
 Mon, 04 Oct 2021 11:26:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210926145931.14603-1-sergio.paracuellos@gmail.com>
 <20210926145931.14603-2-sergio.paracuellos@gmail.com> <YVtBsrmCDk/sLsRJ@robh.at.kernel.org>
In-Reply-To: <YVtBsrmCDk/sLsRJ@robh.at.kernel.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Mon, 4 Oct 2021 20:26:11 +0200
Message-ID: <CAMhs-H_qBkQhzwvcVyFbegf412ecvweOBOYq8NW2hBNYUUCE-w@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: reset: add dt binding header for ralink
 RT2880 resets
To:     Rob Herring <robh@kernel.org>
Cc:     linux-staging@lists.linux.dev, John Crispin <john@phrozen.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
        NeilBrown <neil@brown.name>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 4, 2021 at 8:02 PM Rob Herring <robh@kernel.org> wrote:
>
> On Sun, Sep 26, 2021 at 04:59:29PM +0200, Sergio Paracuellos wrote:
> > Adds dt binding header for 'ralink,rt2880-reset' resets.
> >
> > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > ---
> >  include/dt-bindings/reset/ralink-rt2880.h | 40 +++++++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> >  create mode 100644 include/dt-bindings/reset/ralink-rt2880.h
> >
> > diff --git a/include/dt-bindings/reset/ralink-rt2880.h b/include/dt-bindings/reset/ralink-rt2880.h
> > new file mode 100644
> > index 000000000000..266ef521a584
> > --- /dev/null
> > +++ b/include/dt-bindings/reset/ralink-rt2880.h
> > @@ -0,0 +1,40 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
>
> Dual license please.

Ah, ok. I thought the dual license was only for binding yaml files but
not for headers since there are a lot of already mainlined files with
only GPL-2.0. I will take into account from now that binding headers
also need dual license.

Thanks for the review and clarification.

Best regards,
    Sergio Paracuellos
