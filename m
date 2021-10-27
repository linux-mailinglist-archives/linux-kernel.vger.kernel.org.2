Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6138E43CA25
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 14:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242021AbhJ0M40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 08:56:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:47442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231407AbhJ0M4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 08:56:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D53CF60F56;
        Wed, 27 Oct 2021 12:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1635339239;
        bh=kT5wF0QcJsM63TXyH9HZCOLNY7CrfeWre62eaoLrvCE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yBnpX7YIUEC7D5Eejk7AP89qTeypRr5RSpeKODTACONPYeMGc0IyRUG9VDA4C2kyZ
         brMaHSu2QWRyt2boeSSFwTZtU39nLkMW2CYDPA8APLpDwXxYwKFW3fzVQeOlMK6/pr
         BFR7IZtdqzGktmflqhZMK3OeQh0hm1y67qsVwCYs=
Date:   Wed, 27 Oct 2021 14:53:57 +0200
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
Subject: Re: [RFC PATCH 0/4] USB Power Delivery character device interface
Message-ID: <YXlL5WG6M7fNNtuo@kroah.com>
References: <20211026143352.78387-1-heikki.krogerus@linux.intel.com>
 <YXgZdFV2yTXAKxE9@kroah.com>
 <YXkx0uG3Z539XJWo@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXkx0uG3Z539XJWo@kuha.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 02:02:42PM +0300, Heikki Krogerus wrote:
> Hi Greg,
> 
> On Tue, Oct 26, 2021 at 05:06:28PM +0200, Greg KH wrote:
> > So, why not sysfs?  :)
> 
> This is about allowing the user space to take over the USB Power
> Delivery communication and policy decisions in some cases. The user
> space needs to be able to send and receive raw USB Power Delivery
> messages one way or the other. I don't care about what's the interface
> that we use.
> 
> Here we are talking about the PDOs, so basically the power contract.
> Even if we figured out a way how to expose all the information from
> the Capability, Status, Alert and what ever messages you need to the
> user space via sysfs, and then allow the user to separately send the
> Request Message, we would have only covered the power contract. That
> does not cover everything, but it would also be unnecessarily
> complicated to handle with separate sysfs files IMO.
> 
> Even with the power contract it would make more sense to me to just
> allow the user space to simply read and write the raw messages, but
> when we go the other things like Vendor Specific Messages, I don't
> think there is any other way.
> 
> So we really do need to be able to tap into the USB Power Delivery
> protocol layer directly from user space. I don't care about how we do
> that - character device is just a suggestion, although, it does still
> feel correct to me. Is there some other way we could do this?

Ok, a char device sounds fine, but _what_ userspace code is going to be
using this interface?  We need to have a working version of that as well
before we could take this new interface, otherwise it wouldn't make much
sense.

And why does userspace have to do this, what is wrong with the kernel
doing it as it does today?  I.e. what is broken that adding a new api to
the kernel is going to fix?

That needs to be documented really really well.

thanks,

greg k-h
