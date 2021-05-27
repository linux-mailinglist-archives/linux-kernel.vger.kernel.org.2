Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C636392E60
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 14:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236007AbhE0MyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 08:54:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:33526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235734AbhE0MyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 08:54:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F193B613E3;
        Thu, 27 May 2021 12:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622119961;
        bh=KGKc5qTJru05K3irLK2cGRBe4SX+5pRyHRDPOJWvDGc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bfaVJXjELEf7LLxaXkgdVJHahVBB+ju++zovmbaa0+chX90t79PPMqqz3n6f4kmL8
         S0bBw1BolgUc05EHIJEjjj5hD5ORLlqPGq+1UnxN05FAL5rRi7YDKfpgsyqH/c71ch
         UaOtWPYzinuNcOC6J82vpAHsTad9pIffAnEV82Zo0Kp8QRD76ogQzaavy88ajyNcYI
         PZW9egfAiKsmOKkxs11hjbUnklHxvyDVx8jPRrqCMO5cSmOC1GBfnu1QyeP9GnPJ6L
         Ia6ljoNDZnZQDyHETvm+NEAdoXN1zkfEW2vwk0HDruwdm4RYgyrq0OdA2y9a4R6931
         FwGlYVnkEZSyQ==
Received: by mail-ej1-f46.google.com with SMTP id l1so7857223ejb.6;
        Thu, 27 May 2021 05:52:40 -0700 (PDT)
X-Gm-Message-State: AOAM532uuWcVZkQweZCDr+Chkb9BWvRjHlwNKjnYG07XhXVjb8/6Y/TJ
        Pi+3XJhrM99ytM3lfXm4SgS7xOER9WBAtdAEWA==
X-Google-Smtp-Source: ABdhPJxM9eAon4T+vscvp97uksDQ/yJYoFEbWoPuaJhe1RTrL2fLQKbAHlmkb+5lsjgn3fQ8A9nGVGaYIexET+dYCe8=
X-Received: by 2002:a17:906:1d0a:: with SMTP id n10mr3605862ejh.341.1622119959571;
 Thu, 27 May 2021 05:52:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210527121029.583611-1-kyletso@google.com> <YK+TZOAlc6zYRE0v@kroah.com>
In-Reply-To: <YK+TZOAlc6zYRE0v@kroah.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 27 May 2021 07:52:24 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKGS--ZPUrhVkve3hK2EzWYeN2AATEpqB9PfNEzipfZzA@mail.gmail.com>
Message-ID: <CAL_JsqKGS--ZPUrhVkve3hK2EzWYeN2AATEpqB9PfNEzipfZzA@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: connector: Replace BIT macro with generic
 bit ops
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Kyle Tso <kyletso@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 7:41 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, May 27, 2021 at 08:10:29PM +0800, Kyle Tso wrote:
> > BIT macro is not defined. Replace it with generic bit operations.
> >
> > Fixes: 630dce2810b9 ("dt-bindings: connector: Add SVDM VDO properties")
> > Signed-off-by: Kyle Tso <kyletso@google.com>
> > ---
> > Changes since v1:
> > - re-word the commit message
> >
> >  include/dt-bindings/usb/pd.h | 20 ++++++++++----------
> >  1 file changed, 10 insertions(+), 10 deletions(-)
> >
> > diff --git a/include/dt-bindings/usb/pd.h b/include/dt-bindings/usb/pd.h
> > index fef3ef65967f..cb70b4ceedde 100644
> > --- a/include/dt-bindings/usb/pd.h
> > +++ b/include/dt-bindings/usb/pd.h
> > @@ -163,10 +163,10 @@
> >  #define UFP_VDO_VER1_2               2
> >
> >  /* Device Capability */
> > -#define DEV_USB2_CAPABLE     BIT(0)
> > -#define DEV_USB2_BILLBOARD   BIT(1)
> > -#define DEV_USB3_CAPABLE     BIT(2)
> > -#define DEV_USB4_CAPABLE     BIT(3)
> > +#define DEV_USB2_CAPABLE     (1 << 0)
> > +#define DEV_USB2_BILLBOARD   (1 << 1)
> > +#define DEV_USB3_CAPABLE     (1 << 2)
> > +#define DEV_USB4_CAPABLE     (1 << 3)
>
> Why not just include the proper .h file instead?

Because the DT headers can't depend on kernel headers as they get used
separately.

Rob
