Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2525F37A9C3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 16:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhEKOnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 10:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbhEKOnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 10:43:46 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531D8C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 07:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VpdWWPVwCDuLCQx48KbKcWauncgjWTUPNT/nkVmSq+A=; b=SY5mhMbtH/IaXs+wEFCoh9Q0X
        ZO+jjAzbV+jlgKtzJuoZZo4GheG7V8l45AD1VbRUJqjpjOCYgny5YoGeu0kE8U4+LQ+hgKqQePbrY
        sjfUDxWO/whyJLJAnJOmyl/6SNY6649Q9L4PeWoMAZ5DePOAssq0DZz1w45ZBHJmbohyNzZZt+RoG
        FePwHQQmmNwoLeniH4L60tglhKGP0W/bx5qe/485ze5uQpHyIU0wy/VM52nLQAJMqJ4oz2wlsjdmD
        xLsXIfraewgVZNVNRMbSXRODnM49GoPQOLv3uh1nmPz9vNMewplbOiFxZDdoGEUnjEgVujSb+0l9V
        xWBg6znvg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43862)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lgTan-0002k7-NT; Tue, 11 May 2021 15:42:37 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lgTan-0001AK-3C; Tue, 11 May 2021 15:42:37 +0100
Date:   Tue, 11 May 2021 15:42:37 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] component: Move host device to end of device lists on
 binding
Message-ID: <20210511144236.GL1336@shell.armlinux.org.uk>
References: <20210508074118.1621729-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210508074118.1621729-1-swboyd@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 08, 2021 at 12:41:18AM -0700, Stephen Boyd wrote:
> Within the component device framework this usually isn't that bad
> because the real driver work is done at bind time via
> component{,master}_ops::bind(). It becomes a problem when the driver
> core, or host driver, wants to operate on the component device outside
> of the bind/unbind functions, e.g. via 'remove' or 'shutdown'. The
> driver core doesn't understand the relationship between the host device
> and the component devices and could possibly try to operate on component
> devices when they're already removed from the system or shut down.

You really are not supposed to be doing anything with component devices
once they have been unbound. You can do stuff with them only between the
bind() and the unbind() callbacks for the host device.

Access to the host devices outside of that is totally undefined and
should not be done.

The shutdown callback should be fine as long as the other devices are
still bound, but there will be implications if the shutdown order
matters.

However, randomly pulling devices around in the DPM list sounds to me
like a very bad idea. What happens if such re-orderings result in a
child device being shutdown after a parent device has been shut down?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
