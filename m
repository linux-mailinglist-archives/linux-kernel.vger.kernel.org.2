Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B61841A6CA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 06:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbhI1Etp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 00:49:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:50962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232038AbhI1Eto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 00:49:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 03F3A61157;
        Tue, 28 Sep 2021 04:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632804485;
        bh=rIPpR3k4tQd1NuIq7TpHR6yPadssaAAh/Dq8CqelThY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xofd4et8t4QVcH/QX/qGqEVZ78SGvQs2KXYS9+zd/TT+V2Ah3Zu4rPNYc07a6q/H/
         r4Gyo2Qcm1QmtFMFjRYyav2BuPWJaptA5JMY8oKTtZeCrYSbxmfX4/g4TBapekyQmI
         SZRp9MhkFAggJkHzFjLIg59I0lQo2oRgUUzXWi8E=
Date:   Tue, 28 Sep 2021 06:48:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     lee.jones@linaro.org, hdegoede@redhat.com, mgross@linux.intel.com,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 2/2] platform/x86: Add Intel Software Defined Silicon
 driver
Message-ID: <YVKeglYilJvqp1jk@kroah.com>
References: <20210924213157.3584061-1-david.e.box@linux.intel.com>
 <20210924213157.3584061-2-david.e.box@linux.intel.com>
 <YU7BPIH123HUZKhw@kroah.com>
 <3392aea6b112926b063bbe46b1decaad4c9f9e6e.camel@linux.intel.com>
 <YVFCetbrNV+WkJ5Q@kroah.com>
 <10bee4a609c48b8e10458c25755f17222c43c33c.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10bee4a609c48b8e10458c25755f17222c43c33c.camel@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 10:53:09AM -0700, David E. Box wrote:
> On Mon, 2021-09-27 at 06:03 +0200, Greg KH wrote:
> > On Sun, Sep 26, 2021 at 06:15:16PM -0700, David E. Box wrote:
> > > > > +static int sdsi_remove(struct platform_device *pdev)
> > > > > +{
> > > > > +       struct sdsi_priv *priv = platform_get_drvdata(pdev);
> > > > > +
> > > > > +       priv->dev_present = false;
> > > > > +       sysfs_remove_bin_file(&priv->pdev->dev.kobj, &priv->registers_bin_attr);
> > > > > +       misc_deregister(&priv->miscdev);
> > > > > +       kref_put(&priv->kref, sdsi_priv_release);
> > > > 
> > > > Why do you need a kref for a structure that already can be controlled by
> > > > a different lifetime rule?
> > > 
> > > Which rule am I missing? This kref allows the structure to remain in case the device is removed
> > > while the file is open.
> > 
> > This device is on a hardware bus that allows removal?
> 
> Well the device can be unbound. A test case covers this.

Great, where are these tests?  Why not add them to the kernel tree
itself in the proper location?

And in the real-world, who would ever unbind this?

> > Anyway, you now are dealing with lifetime rules of 3 structures all at
> > once, and the interactions between them is not very obvious.  It would
> > probably be simpler just to stick with 2, right?  You really only care
> > about the misc structure here.
> 
> In the case that the device is unbound, both the pdev and miscdev go away. Something has to outlive
> them in order to handle any open files still trying to use the ioctl.

I do not think that the miscdev goes away if the file handle is still
open, right?

thanks,

greg k-h
