Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D622D43B51F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 17:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235818AbhJZPK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 11:10:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:35426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231545AbhJZPK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 11:10:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D60D760200;
        Tue, 26 Oct 2021 15:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1635260883;
        bh=0XC+Ubh1QkWoRD6gJg2T3EnMFPxdPJ1VDdiOnTzCcT4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LzjRGliV/g/PF5CswOAGe1WCK7HafenLr5+7zV3gP4PZ1kvxGpnXlPCsWqiJnSUY7
         2HBi2KSB1g9Fn6TLAo20n7SgTr/HO9qFEtTbvB0Gw49abqqyjqYPRSp0X/cisf6u1t
         OYya2vaOB9JB4liNCVFpn4Cn5Wp3huyLuiIx4d5Q=
Date:   Tue, 26 Oct 2021 17:08:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@google.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        "Gopal, Saranya" <saranya.gopal@intel.com>,
        "Regupathy, Rajaram" <rajaram.regupathy@intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/4] usb: typec: Character device for USB Power
 Delivery devices
Message-ID: <YXgZ0N/eWmmXeoP2@kroah.com>
References: <20211026143352.78387-1-heikki.krogerus@linux.intel.com>
 <20211026143352.78387-3-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026143352.78387-3-heikki.krogerus@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 05:33:50PM +0300, Heikki Krogerus wrote:
> Interim.
> 
> TODO/ideas:
> - Figure out a proper magic value for the ioctl and check if
>   the ioctl range is OK.
> - Register separate PD device for the cdev, and register it
>   only if the device (port, plug or partner) actually
>   supports USB PD (or come up with some other solution?).
> - Introduce something like
> 
> 	struct pd_request {
> 		struct pd_message request;
> 		struct pd_message __user *response;
> 	};
> 
>   and use it instead of only single struct pd_messages everywhere.
> 
> - Add compat support.

Ick, no, new ioctls should never need compat support if you create them
properly.  That is only for "old" ones.

Also, why not use the miscdev api instead?  That should remove some code
of yours and make things simpler, if you really want to stick with a
char device node...

thanks,

greg k-h
