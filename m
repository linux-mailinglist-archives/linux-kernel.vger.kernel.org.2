Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF32A30F554
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 15:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236899AbhBDOrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 09:47:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:42072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236692AbhBDOn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:43:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 000B564E8C;
        Thu,  4 Feb 2021 14:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612449765;
        bh=/rVF1ewWAynnHeHR43wEdEtX3Z4so9ujSh9AmbUppjA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hQWi83KhX4a0EmunXvgyU/YvCoap+oikLv5OWLk7u47/3PhZ3ZVwq+gpBb9fEnwzS
         DqicfFAMSV2j8z8l0aeWTdpe03VB7aKOW2qx08/IQHh3KrHGV7VExZGn/nCPaynOrg
         VHUr6dNGE9/P5ztgom0pgjK6fvIOFTQplv33FZRM=
Date:   Thu, 4 Feb 2021 15:42:42 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 3/6] usb: dwc3: haps: Constify the software node
Message-ID: <YBwH4mMWM9ydO2B6@kroah.com>
References: <20210204141711.53775-1-heikki.krogerus@linux.intel.com>
 <20210204141711.53775-4-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204141711.53775-4-heikki.krogerus@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 05:17:08PM +0300, Heikki Krogerus wrote:
> What platform_device_add_properties() does is it allocates
> dynamically a software node that will contain the device
> properties supplied to it, and then couples that node with
> the device. Since that node is always created, it might as
> well be constant.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/usb/dwc3/dwc3-haps.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

I've also now applied this, and patch 4/6 of the series as they have
nothing to do with your real work here :)

thanks,

greg k-h
