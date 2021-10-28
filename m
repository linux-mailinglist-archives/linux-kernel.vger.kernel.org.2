Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4858A43DBD1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 09:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhJ1HT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 03:19:59 -0400
Received: from mga01.intel.com ([192.55.52.88]:50581 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229768AbhJ1HT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 03:19:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10150"; a="253900828"
X-IronPort-AV: E=Sophos;i="5.87,189,1631602800"; 
   d="scan'208";a="253900828"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2021 00:17:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,189,1631602800"; 
   d="scan'208";a="636111472"
Received: from kuha.fi.intel.com ([10.237.72.166])
  by fmsmga001.fm.intel.com with SMTP; 28 Oct 2021 00:17:12 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 28 Oct 2021 10:17:11 +0300
Date:   Thu, 28 Oct 2021 10:17:11 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
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
Message-ID: <YXpOd9AZ/mGZC97g@kuha.fi.intel.com>
References: <20211026143352.78387-1-heikki.krogerus@linux.intel.com>
 <YXgZdFV2yTXAKxE9@kroah.com>
 <YXkx0uG3Z539XJWo@kuha.fi.intel.com>
 <YXlL5WG6M7fNNtuo@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXlL5WG6M7fNNtuo@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 02:53:57PM +0200, Greg KH wrote:
> On Wed, Oct 27, 2021 at 02:02:42PM +0300, Heikki Krogerus wrote:
> > Hi Greg,
> > 
> > On Tue, Oct 26, 2021 at 05:06:28PM +0200, Greg KH wrote:
> > > So, why not sysfs?  :)
> > 
> > This is about allowing the user space to take over the USB Power
> > Delivery communication and policy decisions in some cases. The user
> > space needs to be able to send and receive raw USB Power Delivery
> > messages one way or the other. I don't care about what's the interface
> > that we use.
> > 
> > Here we are talking about the PDOs, so basically the power contract.
> > Even if we figured out a way how to expose all the information from
> > the Capability, Status, Alert and what ever messages you need to the
> > user space via sysfs, and then allow the user to separately send the
> > Request Message, we would have only covered the power contract. That
> > does not cover everything, but it would also be unnecessarily
> > complicated to handle with separate sysfs files IMO.
> > 
> > Even with the power contract it would make more sense to me to just
> > allow the user space to simply read and write the raw messages, but
> > when we go the other things like Vendor Specific Messages, I don't
> > think there is any other way.
> > 
> > So we really do need to be able to tap into the USB Power Delivery
> > protocol layer directly from user space. I don't care about how we do
> > that - character device is just a suggestion, although, it does still
> > feel correct to me. Is there some other way we could do this?
> 
> Ok, a char device sounds fine, but _what_ userspace code is going to be
> using this interface?  We need to have a working version of that as well
> before we could take this new interface, otherwise it wouldn't make much
> sense.
> 
> And why does userspace have to do this, what is wrong with the kernel
> doing it as it does today?  I.e. what is broken that adding a new api to
> the kernel is going to fix?
> 
> That needs to be documented really really well.

Sure.

thanks,

-- 
heikki
