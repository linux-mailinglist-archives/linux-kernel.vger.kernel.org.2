Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B9E3F5EB7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 15:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237409AbhHXNJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 09:09:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:50726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233952AbhHXNJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 09:09:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9AA45611F0;
        Tue, 24 Aug 2021 13:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629810536;
        bh=ABj4LR5k72Rshmnhw64r4qHL4fTwkh8FdL4jKsoQMsw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BfkojAvbtqXour9qM7rVfkGA/ATycyd3f/08Zqvf5EAvAynDrD8SLzfGU3QXDOJGZ
         L0bJB57VkRJLNpcFwKYvTcFbMyOiGSucvFEjRX/riQtuOs71qe3326A8MUhbw4fKcm
         rwuGvK9NkGRHCaMIfYrEV/kWSutztfeUbOxDGtVI=
Date:   Tue, 24 Aug 2021 15:08:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        chris.chiu@canonical.com
Subject: Re: [RFC PATCH 2/5] usb: core: hcd: Let usb_add_hcd() indicate if
 roothub has to be registered
Message-ID: <YSTvY36KMOCL6sEv@kroah.com>
References: <20210824105302.25382-1-kishon@ti.com>
 <20210824105302.25382-3-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824105302.25382-3-kishon@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 04:22:59PM +0530, Kishon Vijay Abraham I wrote:
> No functional change. Add __usb_add_hcd() which takes "register_hub"
> flag that indicates if roothub has to be registered or not. This is in

"flags" like this are horrid, never do that, except at a local static
function level that might make code easier.

For this, make a usb_hcd_add_and_register() function, so that you know
instantly when seeing it be called, as to what it does.  Otherwise you
have to go look up a random boolean value and that's impossible to
remember over time.

thanks,

greg k-h
