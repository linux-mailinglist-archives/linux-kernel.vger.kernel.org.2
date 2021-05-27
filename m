Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D1A392ED3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 15:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236010AbhE0NE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 09:04:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:36480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235177AbhE0NE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 09:04:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A0099610A2;
        Thu, 27 May 2021 13:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622120574;
        bh=eA7hFQjhjlkA6FGzsMI9qG2tJxSORQ8/zD5C/vVFOsw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IDA685ydk5IwY08vYougvVTSpbadl4AfWVhExFtxyasStnLxobzjttrsWWSXEvGPB
         BKHuGOGlowt+e8RA8eWWzkclXhCIz1cWHBKaiiIYrXuFVJEdF4zE6g0p32cmuxjnvx
         CcdVGDnpD+iAbK/snbwWc0MmKYL/M6Pyi3zgIQfA=
Date:   Thu, 27 May 2021 15:02:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Kyle Tso <kyletso@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: connector: Replace BIT macro with
 generic bit ops
Message-ID: <YK+Ye9fCq2Z02qjl@kroah.com>
References: <20210527121029.583611-1-kyletso@google.com>
 <YK+TZOAlc6zYRE0v@kroah.com>
 <CAL_JsqKGS--ZPUrhVkve3hK2EzWYeN2AATEpqB9PfNEzipfZzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKGS--ZPUrhVkve3hK2EzWYeN2AATEpqB9PfNEzipfZzA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 07:52:24AM -0500, Rob Herring wrote:
> On Thu, May 27, 2021 at 7:41 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, May 27, 2021 at 08:10:29PM +0800, Kyle Tso wrote:
> > > BIT macro is not defined. Replace it with generic bit operations.
> > >
> > > Fixes: 630dce2810b9 ("dt-bindings: connector: Add SVDM VDO properties")
> > > Signed-off-by: Kyle Tso <kyletso@google.com>
> > > ---
> > > Changes since v1:
> > > - re-word the commit message
> > >
> > >  include/dt-bindings/usb/pd.h | 20 ++++++++++----------
> > >  1 file changed, 10 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/include/dt-bindings/usb/pd.h b/include/dt-bindings/usb/pd.h
> > > index fef3ef65967f..cb70b4ceedde 100644
> > > --- a/include/dt-bindings/usb/pd.h
> > > +++ b/include/dt-bindings/usb/pd.h
> > > @@ -163,10 +163,10 @@
> > >  #define UFP_VDO_VER1_2               2
> > >
> > >  /* Device Capability */
> > > -#define DEV_USB2_CAPABLE     BIT(0)
> > > -#define DEV_USB2_BILLBOARD   BIT(1)
> > > -#define DEV_USB3_CAPABLE     BIT(2)
> > > -#define DEV_USB4_CAPABLE     BIT(3)
> > > +#define DEV_USB2_CAPABLE     (1 << 0)
> > > +#define DEV_USB2_BILLBOARD   (1 << 1)
> > > +#define DEV_USB3_CAPABLE     (1 << 2)
> > > +#define DEV_USB4_CAPABLE     (1 << 3)
> >
> > Why not just include the proper .h file instead?
> 
> Because the DT headers can't depend on kernel headers as they get used
> separately.

Lame.  :)
