Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 596383E31D3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 00:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242443AbhHFWgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 18:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbhHFWgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 18:36:08 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A1EC0613CF;
        Fri,  6 Aug 2021 15:35:51 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id o11so347871wms.0;
        Fri, 06 Aug 2021 15:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gVuKbVXZPtoRifrL8/ErqID3f4/WzrsOET4lmsi9jdM=;
        b=cXdU8wHDYBlcJ3IzjjewATWeMWDgR/r5xlHegYBEWwsiz4MJbs8C3cbisSeUGZtj+V
         50PfYzziLCmPJwMkTaxjlKQ3cNgX+owhC2eu2npT3j5jOvxVtrmiDGKYRRZGKG/sOfiZ
         kvoyE7TbbT4HHtrvIvKEqybKY+/Ee+uUhdxvIup+NtnluzF+w09abz+MIUTVOHsiNLLn
         H93WHO/OdJ3ar8HnQn5XNEX3g07cDKPtU+G94ROk/R4JDxLViKeG6nqd7G3XeGD/X812
         KGqIj6VeTKyQRxIbRp4MA6HnUFPu44d66+C5aRNwkizqnP6Ssa5VTPTDuxaGLGyW8x12
         GJQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gVuKbVXZPtoRifrL8/ErqID3f4/WzrsOET4lmsi9jdM=;
        b=YD0BtOGfg0KoHn0v4dvinlx+SvsPnvc3IJaIAP3FWJ+aIYxawaa2UUoVP5iaorTyj0
         gq6voK/0oflylz5atlerhS8mtXIURq0zcnKVRoLKFwRRtjnMo1gPZdzB86E/aBgTePuR
         /cYJojoIZLM9/VUUzjOflTqQyH5Fu1X6cQslihswKO+NrSkr6WJpM7tEr4mjjW6tPoqO
         bSTAsFn0P3VbR96cALnvdXbXjcjuyjIWXoZ/LxwZH1waMcYd5ALUu5sC+M3XoXtG/MhB
         VFYOUt0Fx0e7gO8shnXqnkqovx3IlkId9inD4YcO1HI3MdxLm5T+YiuRRkVS5I8xzlg3
         VH7A==
X-Gm-Message-State: AOAM531qLWOTy8nAeWvkNm491D4/mtALTFAv/gzVi6fpHN/PV6vVknyk
        3FxC7DI9tRmBGPo+imM0Lxxm8c4hNUmpzwJIPog=
X-Google-Smtp-Source: ABdhPJy4exHJo7eECucP6QTzRqjbBgev399KS4p1yQCB6h9gvKKlZJlxKha5VxsptfltcWQe2jefoPHtsBOx1XBlKKQ=
X-Received: by 2002:a1c:208e:: with SMTP id g136mr22386947wmg.142.1628289349581;
 Fri, 06 Aug 2021 15:35:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210728224140.3672294-1-bjwyman@gmail.com> <2517b3a8-6549-3ee6-76d3-6545a38cf6ea@roeck-us.net>
In-Reply-To: <2517b3a8-6549-3ee6-76d3-6545a38cf6ea@roeck-us.net>
From:   Brandon Wyman <bjwyman@gmail.com>
Date:   Fri, 6 Aug 2021 17:35:15 -0500
Message-ID: <CAK_vbW2fU+i6H5bV79eQAnFUzfuO-czyxbT9cbJmv34Sei5Log@mail.gmail.com>
Subject: Re: [PATCH] hwmon: (pmbus/ibm-cffps) Fix write bits for LED control
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Joel Stanley <joel@jms.id.au>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eddie James <eajames@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 6:14 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 7/28/21 3:41 PM, Brandon Wyman wrote:
> > From: "B. J. Wyman" <bjwyman@gmail.com>
> >
> > When doing a PMBus write for the LED control on the IBM Common Form
> > Factor Power Supplies (ibm-cffps), the DAh command requires that bit 7
> > be low and bit 6 be high in order to indicate that you are truly
> > attempting to do a write.
> >
> > Signed-off-by: B. J. Wyman <bjwyman@gmail.com>
>
> Please be consistent and use "Brandon Wyman".

Ack. Curiously, that is the first time someone has pointed out that
inconsistency.

>
> Guenter
>
> > ---
> >   drivers/hwmon/pmbus/ibm-cffps.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/hwmon/pmbus/ibm-cffps.c b/drivers/hwmon/pmbus/ibm-cffps.c
> > index 5668d8305b78..df712ce4b164 100644
> > --- a/drivers/hwmon/pmbus/ibm-cffps.c
> > +++ b/drivers/hwmon/pmbus/ibm-cffps.c
> > @@ -50,9 +50,9 @@
> >   #define CFFPS_MFR_VAUX_FAULT                        BIT(6)
> >   #define CFFPS_MFR_CURRENT_SHARE_WARNING             BIT(7)
> >
> > -#define CFFPS_LED_BLINK                              BIT(0)
> > -#define CFFPS_LED_ON                         BIT(1)
> > -#define CFFPS_LED_OFF                                BIT(2)
> > +#define CFFPS_LED_BLINK                              (BIT(0) | BIT(6))
> > +#define CFFPS_LED_ON                         (BIT(1) | BIT(6))
> > +#define CFFPS_LED_OFF                                (BIT(2) | BIT(6))
> >   #define CFFPS_BLINK_RATE_MS                 250
> >
> >   enum {
> >
>
