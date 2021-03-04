Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819B532D50D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 15:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238578AbhCDONI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 09:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbhCDOMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 09:12:52 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB03C061756
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 06:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=z5ESyTLcVoMZVnpQ4B7zTQW9XP8OhZQssC3ZYya5zNs=; b=xjubPFfku1IhQ4d8SRrTTH2sv
        3UBvliaomkgJC1Sx4MhDKvQNfKJgvPlXHfRlvywWpH3vxnp3fPiabhwz1ZoBJTrype0z543DHYGMc
        8M2K1V7Wkl1J/gRs1UNASf10TAXSq6B9DjXN0O0nnS8B5DX2b86UMzylbydIsRQgBXP8LbytiuadP
        Ex5tq97JARUFCwxkoal/NqzH3mllf2hE1W1/ykUzt0p6tRGyCKL48Ha3C28WPnk4pcBaANOyo7kWG
        cgT02SilIKXby8lSJn6CqzFJapF5o92KUSuh6eVSaaDSyWNiLgfh+r12y6jLhSUUkKlTaoLI9/lHf
        0UbviCTww==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48942)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lHohy-0007I5-RZ; Thu, 04 Mar 2021 14:12:06 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lHohx-0003Py-48; Thu, 04 Mar 2021 14:12:05 +0000
Date:   Thu, 4 Mar 2021 14:12:05 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] amba: Remove deferred device addition
Message-ID: <20210304141205.GC1463@shell.armlinux.org.uk>
References: <20210304035958.3657121-1-saravanak@google.com>
 <CAGETcx8KQ7cm7irv-vsBzqYfZqSMz4c3_hD_V55gxjVM1vd=PA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx8KQ7cm7irv-vsBzqYfZqSMz4c3_hD_V55gxjVM1vd=PA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 08:08:44PM -0800, Saravana Kannan wrote:
> Marek,
> 
> I tested it and saw the device get added before the resources were
> available and the uevent file looked okay. Would you mind testing it
> further?

To put it bluntly, if you have tested this, the testing was not very
effective. Deleting the lines that are removed by the patch so we can
see what the new code looks like below:

> > +int amba_device_add(struct amba_device *dev, struct resource *parent)
> >  {
> > +       int ret;
> >
> >         WARN_ON(dev->irq[0] == (unsigned int)-1);
> >         WARN_ON(dev->irq[1] == (unsigned int)-1);
> >
> >         ret = request_resource(parent, &dev->res);
> >         if (ret)
> > +               return ret;
> >
> > +       /* If primecell ID isn't hard-coded, figure it out */
> > +       if (dev->periphid) {
> > +               ret = amba_read_periphid(dev);

So, if the peripheral ID has _already_ been set, we attempt to read the
peripheral ID from the device. Isn't that just wrong?

> > +               if (ret && ret != -EPROBE_DEFER)
> > +                       goto err_release;
> >                 /*
> > +                * AMBA device uevents require reading its pid and cid
> > +                * registers.  To do this, the device must be on, clocked and
> > +                * out of reset.  However in some cases those resources might
> > +                * not yet be available.  If that's the case, we suppress the
> > +                * generation of uevents until we can read the pid and cid
> > +                * registers.  See also amba_match().
> >                  */
> > +               if (ret)
> > +                       dev_set_uevent_suppress(&dev->dev, true);
> >         }

If the peripheral ID has not been set, we don't attempt to read it, and
we generate an add event when the amba device is added with a zero
peripheral ID.

I guess that if() statement should be negated - and with such an error,
I fail to see how this code could have been properly tested.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
