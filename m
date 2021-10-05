Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA544227CF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 15:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235025AbhJENbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 09:31:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:51178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234170AbhJENbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 09:31:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 70DCA61989;
        Tue,  5 Oct 2021 13:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633440558;
        bh=LF/tBVlDQO6RuZf99DRYv1cbQeLhdXuXABeqOo0O3fg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GX98xAI9+1xPRS57QOe/fJ/xyF39b5nmOnVrWSvURobnEmIhSsskyyyPaScjWolxb
         0WvF6RnLxXc5ZcLt9R7b11MHBOERjmtLHG7yEdWHEUFJL7I4NasfxdEQScuQ9GtDj6
         ObLiOhpCxJFW7uQZi81ab1TvMJlRa4uejgLuftL7AxIzGNkQN+Ns55ZFbFKcPC7IDo
         I8G4GpTJSMMyDCYkcFVJMUP5lfitnnQCBK1utcHgPL6qpKxVg75+KlgLTZsSXhuTuU
         1GbDQPAW6qpoQoBo0/Penh28TdIMKrqUnmehsiTfp8VV/RjPCGpPd+nbDcK/PJx6r5
         2yN8Nii9CLCPQ==
Received: by mail-qv1-f52.google.com with SMTP id a9so12003186qvf.0;
        Tue, 05 Oct 2021 06:29:18 -0700 (PDT)
X-Gm-Message-State: AOAM531MiKFiVPIWxeUiEJaPmM3vDyapPhuyHvNWNRNZmkzjas102fjx
        0taLhoD8H74w62spjTn6LDR/xqM0Mro74A0AHg==
X-Google-Smtp-Source: ABdhPJxMdpq3J7fB00AXs7CoA89pdFWl0mrM2JhB4zgxF0Cc87pLhhCVtwW5TsMMLA1sELraQx1/aydztdtEIskS/PI=
X-Received: by 2002:a0c:80e4:: with SMTP id 91mr28966424qvb.57.1633440557667;
 Tue, 05 Oct 2021 06:29:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210926145931.14603-1-sergio.paracuellos@gmail.com>
 <20210926145931.14603-2-sergio.paracuellos@gmail.com> <YVtBsrmCDk/sLsRJ@robh.at.kernel.org>
 <CAMhs-H_qBkQhzwvcVyFbegf412ecvweOBOYq8NW2hBNYUUCE-w@mail.gmail.com>
In-Reply-To: <CAMhs-H_qBkQhzwvcVyFbegf412ecvweOBOYq8NW2hBNYUUCE-w@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 5 Oct 2021 08:29:04 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+Nj_=kmGNEbmN4DxJquVdd1BRJnuK43ROvNp-hQM4POw@mail.gmail.com>
Message-ID: <CAL_Jsq+Nj_=kmGNEbmN4DxJquVdd1BRJnuK43ROvNp-hQM4POw@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: reset: add dt binding header for ralink
 RT2880 resets
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-staging@lists.linux.dev, John Crispin <john@phrozen.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
        NeilBrown <neil@brown.name>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 4, 2021 at 1:26 PM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
>
> On Mon, Oct 4, 2021 at 8:02 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Sun, Sep 26, 2021 at 04:59:29PM +0200, Sergio Paracuellos wrote:
> > > Adds dt binding header for 'ralink,rt2880-reset' resets.
> > >
> > > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > > ---
> > >  include/dt-bindings/reset/ralink-rt2880.h | 40 +++++++++++++++++++++++
> > >  1 file changed, 40 insertions(+)
> > >  create mode 100644 include/dt-bindings/reset/ralink-rt2880.h
> > >
> > > diff --git a/include/dt-bindings/reset/ralink-rt2880.h b/include/dt-bindings/reset/ralink-rt2880.h
> > > new file mode 100644
> > > index 000000000000..266ef521a584
> > > --- /dev/null
> > > +++ b/include/dt-bindings/reset/ralink-rt2880.h
> > > @@ -0,0 +1,40 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> >
> > Dual license please.
>
> Ah, ok. I thought the dual license was only for binding yaml files but
> not for headers since there are a lot of already mainlined files with
> only GPL-2.0. I will take into account from now that binding headers
> also need dual license.

If you want your dts files used by other projects such as *BSD, then
they and their include files need to be licensed for that.

Rob
