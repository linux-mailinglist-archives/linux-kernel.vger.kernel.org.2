Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFF9446E5A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 15:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234394AbhKFOog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Nov 2021 10:44:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:53496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231939AbhKFOof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Nov 2021 10:44:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2649561074;
        Sat,  6 Nov 2021 14:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636209714;
        bh=EFQSWC2A+sX79AmgQ55mM3lCqICyKef/vVuUVtOUPQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B5IpqBXMdalPSmjvlnYyi3YP7VMHGKHlDz/6TjOOZeIrivWSz086HWVdeXGyLo2S8
         e3KTbd32XN9GYgi+d2+MIIK/AsFtMFwYMv1Mr/Cv0jUL+3NPZ40255JEXNDmW3F7Xs
         KJ1hZrmTTuNExDUxBlwaWuTytkEnyxVZYN11FEXE=
Date:   Sat, 6 Nov 2021 15:41:47 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     stern@rowland.harvard.edu, mr.yming81@gmail.com,
        chunfeng.yun@mediatek.com, matthias.bgg@gmail.com,
        nishadkamdar@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, eddie.hung@mediatek.com
Subject: Re: [PATCH] xhci: Fix USB 3.1 enumeration issues by increasing
 roothub power-on-good delay
Message-ID: <YYaUK/rjuAOucOpI@kroah.com>
References: <20211105133050.GA1590803@rowland.harvard.edu>
 <20211105160036.549516-1-mathias.nyman@linux.intel.com>
 <YYVYrksU5/aCB3Fd@kroah.com>
 <b5b59fb7-40ce-929e-479a-d0605994cb53@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5b59fb7-40ce-929e-479a-d0605994cb53@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 09:56:59PM +0200, Mathias Nyman wrote:
> On 5.11.2021 18.15, Greg KH wrote:
> > On Fri, Nov 05, 2021 at 06:00:36PM +0200, Mathias Nyman wrote:
> >> Some USB 3.1 enumeration issues were reported after the hub driver removed
> >> the minimum 100ms limit for the power-on-good delay.
> >>
> >> Since commit 90d28fb53d4a ("usb: core: reduce power-on-good delay time of
> >> root hub") the hub driver sets the power-on-delay based on the
> >> bPwrOn2PwrGood value in the hub descriptor.
> >>
> >> xhci driver has a 20ms bPwrOn2PwrGood value for both roothubs based
> >> on xhci spec section 5.4.8, but it's clearly not enough for the
> >> USB 3.1 devices, causing enumeration issues.
> >>
> >> Tests indicate full 100ms delay is needed.
> >>
> >> Reported-by: Walt Jr. Brake <mr.yming81@gmail.com>
> >> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> > 
> > So this needs:
> > 	Fixes: 90d28fb53d4a ("usb: core: reduce power-on-good delay time of root hub")
> > right?
> 
> I guess so, not sure on "Fixes" policy here.
> 
> This patch fixes an xhci issue revealed by ("usb: core: reduce power-on-good delay time of root hub")
> That original patch itself looks correct, but these two patches should really go together to
> avoid any enumeration issues.  

Great, I'll use that tag for now so that it will get backported
properly.

greg k-h
