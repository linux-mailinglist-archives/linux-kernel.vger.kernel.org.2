Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3561E3446D7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbhCVONz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:13:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:49426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230064AbhCVON2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:13:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 643706196C;
        Mon, 22 Mar 2021 14:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616422405;
        bh=JXTDkyZwuXA+9XPeNaO0HsrZDnTdmpJxzyY5eEeJo/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u1j+BZ+sDmeYanObBds8Zt27/g3/OC6qyyM8GWQZAd6neYEHdFO1Q/i3SbolGLmJV
         8p4iymM9mYQPH7t/AuPVQyEGg2WJwsmHVQEOmRg5/PzuPOTPpYKyHjxEzhiW244IAv
         AGQDDSXcLdbkPLXGDgAb8Vg9FAlI4qJAC1vOyEnhs9tfL15ubYtBAmuOnt8/gSIZ01
         8+MZbV/+ZKdW6/Ks8LDif0Jg5YRWcTGCmN/fpaV/HVQSRoX+WYnF65tiEgaGdwEFnl
         ogO6lVkWshmGV0NFhZFbnlxRTGToyl7ytbxxM3Bvvwz1EPsBPpesdFfsUfiNF7tKzD
         ME0Gj7rvPeI6Q==
Received: from johan by xi with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lOLJO-00006M-PG; Mon, 22 Mar 2021 15:13:42 +0100
Date:   Mon, 22 Mar 2021 15:13:42 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] USB: cdc-acm: always claim data interface
Message-ID: <YFimFgUnc2VVQbNx@hovoldconsulting.com>
References: <20210318155202.22230-1-johan@kernel.org>
 <20210318155202.22230-8-johan@kernel.org>
 <9a802d1120a03e34d0e40e1d4e1e558c5359e92b.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a802d1120a03e34d0e40e1d4e1e558c5359e92b.camel@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 11:46:47AM +0100, Oliver Neukum wrote:
> Am Donnerstag, den 18.03.2021, 16:52 +0100 schrieb Johan Hovold:
> > Make sure to always claim the data interface and bail out if it's
> > already bound to another driver or isn't authorised.
> 
> Hi,
> 
> Thanks for the fixes. All previous ones are good work.
> this one is problematic I am afraid.
> 
> 
> acm_probe() has a test for the availability of the interface:
> 
> 	if (!combined_interfaces && usb_interface_claimed(data_interface)) {
> 		/* valid in this context */
> 		dev_dbg(&intf->dev, "The data interface isn't available\n");
> 		return -EBUSY;
> 	}
> 
> That check is ancient. BKL still existed. If you want to remove it
> and do proper error handling, that would be good. But if you do
> error handling, the check has to go, too.

Thanks, this bit can go indeed. But note that it's simply because it's
now redundant.

I'll send a v2.

Johan
