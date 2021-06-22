Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32183AFECC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 10:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhFVIMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 04:12:24 -0400
Received: from mga17.intel.com ([192.55.52.151]:34208 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229677AbhFVIMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 04:12:22 -0400
IronPort-SDR: yLnl+IPdXaTIx0brnEEpE2SYkb9b72QQRcbYE+b0Yehk13GyMfkzG3tY+KdB5sJ+m/NcvID2hu
 eP2yz8iI0HLA==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="187389686"
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="187389686"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 01:09:58 -0700
IronPort-SDR: WRQWjSz6IY04U8on2iTPxmpcU3oevZrESTBlFpgmUtPBFK+YMTI37ILVe7Eo82IVljnXSI/D+h
 E80JfmEAPzUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="556537765"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 22 Jun 2021 01:09:55 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 22 Jun 2021 11:09:55 +0300
Date:   Tue, 22 Jun 2021 11:09:55 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: v5.13-rcX regression - NULL pointer dereference - MFD and
 software node API
Message-ID: <YNGa021IIj+C8H7h@kuha.fi.intel.com>
References: <YM77uq51jmDC/rHt@owl.dominikbrodowski.net>
 <CAHp75VfP2h_aLVR9cgfXWHmqNbUZg-KZj2UwMs6dAkbS5eSghg@mail.gmail.com>
 <YM8rY5hi+zuAekg+@owl.dominikbrodowski.net>
 <CAHp75VdSyM7JdGDhdo5t+FbmouEA7ZSOwGAtSwSRD8vTwTc+LA@mail.gmail.com>
 <CAHp75Ve=j+u-9TF0az3o82wOyzixCezkgOm=yUHh37JS_Awiig@mail.gmail.com>
 <YNBU3Jjme1lQ3MdV@owl.dominikbrodowski.net>
 <YNBjJnxrXaWmfUqo@smile.fi.intel.com>
 <YNBsB6zIo4A4vD4w@kuha.fi.intel.com>
 <YNCw5k9vwdQiS0u4@owl.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNCw5k9vwdQiS0u4@owl.dominikbrodowski.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 05:31:50PM +0200, Dominik Brodowski wrote:
> Am Mon, Jun 21, 2021 at 01:37:59PM +0300 schrieb Heikki Krogerus:
> > On Mon, Jun 21, 2021 at 01:00:06PM +0300, Andy Shevchenko wrote:
> > > Can you, please, attach this to the bug report?
> > > 
> > > Long story here is that the device creation fails but we already have added
> > > swnode to it. Meanwhile, device itself is not completely instantiated (yet)
> > > and dev_name(dev) is NULL. The software_node_notify() is called with such
> > > device and Oopses in the following line
> > > 
> > > 	sysfs_remove_link(&swnode->kobj, dev_name(dev));
> > > 
> > > My patch fixes another issue that might happen before this and in the code
> > > that retrieves swnode itself in the device_remove_software_node().
> > > 
> > > Of course my patch won't fix this issue.
> > > 
> > > I have heard that Heikki is looking how to fix the issue in your case and
> > > potentially in any other cases where device_add_software_node() is called
> > > against not formed object instance.
> > 
> > Dominik, can you test the attached patch to confirm if this really is
> > the case.
> 
> With this patch applied, the panic disappears.

Thanks Dominik. I'll clean it and send it out today.

cheers,

-- 
heikki
