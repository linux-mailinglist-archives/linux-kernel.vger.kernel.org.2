Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E331418E13
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 06:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbhI0EEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 00:04:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:48242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229445AbhI0EEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 00:04:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0CA9960F58;
        Mon, 27 Sep 2021 04:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632715390;
        bh=mRuC96Zj8HKwRVxgwL86lhq6ERtGrM3ClP5WU5GbLw4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N8sUpJWZoUGNwzTmbSXlpykWbXcz28yLbc061+LpUXZ8SmS888gckdIXkOGJW5d1+
         fDwNx0QG93WitEX+iR8dSVlv8Zl+wxVxzMQ9jFxpf4kw27AcWUjr2s62slwo2RdqOB
         GDFn/5rIsywz92My5EYlLENdVbKG6Qd1xV7gj2tc=
Date:   Mon, 27 Sep 2021 06:03:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     lee.jones@linaro.org, hdegoede@redhat.com, mgross@linux.intel.com,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 2/2] platform/x86: Add Intel Software Defined Silicon
 driver
Message-ID: <YVFCetbrNV+WkJ5Q@kroah.com>
References: <20210924213157.3584061-1-david.e.box@linux.intel.com>
 <20210924213157.3584061-2-david.e.box@linux.intel.com>
 <YU7BPIH123HUZKhw@kroah.com>
 <3392aea6b112926b063bbe46b1decaad4c9f9e6e.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3392aea6b112926b063bbe46b1decaad4c9f9e6e.camel@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 26, 2021 at 06:15:16PM -0700, David E. Box wrote:
> > > +static int sdsi_remove(struct platform_device *pdev)
> > > +{
> > > +       struct sdsi_priv *priv = platform_get_drvdata(pdev);
> > > +
> > > +       priv->dev_present = false;
> > > +       sysfs_remove_bin_file(&priv->pdev->dev.kobj, &priv->registers_bin_attr);
> > > +       misc_deregister(&priv->miscdev);
> > > +       kref_put(&priv->kref, sdsi_priv_release);
> > 
> > Why do you need a kref for a structure that already can be controlled by
> > a different lifetime rule?
> 
> Which rule am I missing? This kref allows the structure to remain in case the device is removed
> while the file is open.

This device is on a hardware bus that allows removal?

Anyway, you now are dealing with lifetime rules of 3 structures all at
once, and the interactions between them is not very obvious.  It would
probably be simpler just to stick with 2, right?  You really only care
about the misc structure here.

thanks,

greg k-h
