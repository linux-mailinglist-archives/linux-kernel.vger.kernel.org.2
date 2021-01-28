Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8FC5306BBF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 04:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbhA1D62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 22:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbhA1DjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 22:39:02 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE91C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 19:38:21 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id u17so4209821iow.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 19:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jr6oZPut6R5xADAqmuwrtlULXRHD5ex1ji/nfSHLdjI=;
        b=VwegR629zsG5eWgMolbdrVoWKF5kPCL2ZDQZ81vzE4H7W4ea+7lL1d1NEA5CTFJy2e
         lhByZQy/GPod8TIk7DU2hSBCD74OchArhHoaxO4pIXI04rWcfGDHuQy4aMgXC3IRHtiy
         S/AbetCzzXy/XMJg5uHlir5dxTgjxFoSsi8C6eMDBFfEPPkjQ5VTR3eU5END04lAgcXy
         SUNWO/yDDhOcByiHH2T3FTjkXqZRypiab+XbQ5yORXTO7kBeDQqlYkjd4uVH0aNbl40z
         a3CoCweDW/7S3EgVjIgQLDySV6uufuzaATnOdTgXQvoRmKvXIJGpunFKOgaamYwPb/7U
         Llmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jr6oZPut6R5xADAqmuwrtlULXRHD5ex1ji/nfSHLdjI=;
        b=ohmGWlPWAM9U+CApo9Zj1vPXzWSPXeoKeInnPs+KDtMFgtHX0hG3L1skzjLnBoqo4g
         tj0Hp7pgwnLRXDhzp01laTzwvmwLCX3wAivDePQQ7pttpCwjwQlWTaOfMFy8lJMnhgXF
         Z17iQPAHzLcRONP/I//RHKvYm/BnRp0iyymuEy6bBNTHI8skAbPH6iPn7GRwmNhAf6aD
         eABBN4cBdQpIr3LorVo4LAW1mln9xhNuga/nNzrt5GMt5lQ9l8LQn39dLZe6KlOKJjno
         k1y0JOka7dU6VJgfYs+Sf/bQjgKJw9x7+67RY2ivVsONMqi9dw3AcEgzavu/ugbpq514
         eQqw==
X-Gm-Message-State: AOAM532jajt75Bj2H7llksKjT2YcFs8PdSp3LfYNiuV/3HCvcV4U4Y/K
        DHCGMMYPWvOXFMTbKDxA2MWeKRYZRPUOQr7IOwXO8g==
X-Google-Smtp-Source: ABdhPJw7IsVFdtYI2WAojkBUPfX6pfS0VhA6v3+fiPYaEPumQIbqvS7kGPBha0bAGSmg93kPegsmbxZc9a845c2LZLU=
X-Received: by 2002:a02:6a50:: with SMTP id m16mr11376167jaf.129.1611805100433;
 Wed, 27 Jan 2021 19:38:20 -0800 (PST)
MIME-Version: 1.0
References: <20210119101044.1637023-1-howardyen@google.com>
 <af91bbf1-6731-3e87-4086-de0dbba22c22@intel.com> <CAJDAHvbTY3Z_bRg+++uLefWSvCWo_nGq+3OOQX3QHJ2w3X1SQw@mail.gmail.com>
 <ca442ca7-a434-2527-9945-861dafa685cc@linux.intel.com> <YBAk795ccXBPgJWp@kroah.com>
In-Reply-To: <YBAk795ccXBPgJWp@kroah.com>
From:   Howard Yen <howardyen@google.com>
Date:   Thu, 28 Jan 2021 11:38:09 +0800
Message-ID: <CAJDAHvZ2CCm9tT+C=hNc_U1CaYJg3ZjifsYLik3UqfXwUm++Lg@mail.gmail.com>
Subject: Re: [PATCH 0/4] add xhci hooks for USB offload
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Mathias Nyman <mathias.nyman@intel.com>, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 10:19 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Jan 22, 2021 at 05:32:58PM +0200, Mathias Nyman wrote:
> > On 20.1.2021 12.04, Howard Yen wrote:
> > > On Tue, Jan 19, 2021 at 8:47 PM Mathias Nyman <mathias.nyman@intel.com> wrote:
> > >>
> > >> On 19.1.2021 12.10, Howard Yen wrote:
> > >>> To let the xhci driver support USB offload, add hooks for vendor to have
> > >>> customized behavior for the initialization, memory allocation, irq work, and
> > >>> device context synchronization. Detail is in each patch commit message.
> > >>
> > >> Is this related to the usb audio sideband capability that was added to the xHCI specification?
> > >> If yes, then we should probably implement the generic parts first, and then add
> > >> the vendor specific hooks.
> > >>
> > >> -Mathias
> > >>
> > >>
> > >
> > > This is for offloading, no matter what type of offloading.
> > > I made the hooks generically and can be used for usb audio on the xhci
> > > which is not including the usb audio sideband capability.
> > >
> >
> > Ok, before adding hooks like this I think we need to see how they are used.
> > Do you have the rest of the patches that go on top of this series?
> >
> > Maybe it could make sense to use overrides for the functions in struct hc_driver
> > instead in some cases? There is support for that already.
>
> What overrides could be done for these changes?  At first glance that
> would seem to require a lot of duplicated code in whatever override
> happens to be needed.
>
> thanks,
>
> greg k-h

This patch series is all the changes for the offload hooks currently.

I thought about this, but if I tried to override the functions in
struct hc_driver, that'll need to
copy many code to the override function, and it won't follow the
latest change in the core
xhci driver.


- Howard
