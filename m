Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE206346124
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 15:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbhCWONI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 10:13:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:59016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232210AbhCWONA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 10:13:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 09AE7619A9;
        Tue, 23 Mar 2021 14:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616508780;
        bh=jKQf4rc43XmSfVAPjyFxLr/Xr4+DIDxPH4T8RixyZ14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tI3hL+dLKo90oYgd6XTZ1bxfZN5PHzY6zQsrcCyZSZ7xLt0cdmYrfvkQXyY4eERW8
         NtbHxulop8Z1GjMLnmRqmnlHH34JNRV2ogEd0JXR+AFhaXBYA6CglV7OQ4CwihYhQD
         INcNfScIqi6yPPfZqPwTRvqafSvhPxqIMDeCNMT8=
Date:   Tue, 23 Mar 2021 15:12:58 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Don Bollinger <don@thebollingers.org>
Cc:     arndb@arndb.de, linux-kernel@vger.kernel.org,
        brandon_chuang@edge-core.com, wally_wang@accton.com,
        aken_liu@edge-core.com, gulv@microsoft.com, jolevequ@microsoft.com,
        xinxliu@microsoft.com
Subject: Re: [PATCH v2] eeprom/optoe: driver to read/write SFP/QSFP/CMIS
 EEPROMS
Message-ID: <YFn3ahkF4w/IClaw@kroah.com>
References: <20210215193821.3345-1-don@thebollingers.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210215193821.3345-1-don@thebollingers.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 11:38:21AM -0800, Don Bollinger wrote:
> optoe is an i2c based driver that supports read/write access to all
> the pages (tables) of MSA standard SFP and similar devices (conforming
> to the SFF-8472 spec), MSA standard QSFP and similar devices (conforming
> to the SFF-8636 spec) and CMIS and similar devices (conforming to the
> Common Management Interface Specfication).

Given this thread, I think that using the SFP interface/api in the
kernel already seems like the best idea forward.

That being said, your api here is whack, and I couldn't accept it
anyway.

Not for the least being it's not even documented in Documentation/ABI/
like all sysfs files have to be :)

And it feels like you are abusing sysfs for things it was not ment for,
you might want to look into configfs?

But really, these are networking devices, so they should be controllable
using the standard networking apis, not one-off sysfs files.  Moving to
the Linux-standard tools is a good thing, and will work out better in
the end instead of having to encode lots of device-specific state in
userspace like this "raw" api seems to require.

thanks,

greg k-h
