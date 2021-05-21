Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D2638CDA8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 20:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236437AbhEUSmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 14:42:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:46068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229554AbhEUSmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 14:42:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0833761163;
        Fri, 21 May 2021 18:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621622490;
        bh=nXFKjp9iGtwjkRW0R7cZgoSZErIoiQjCkATagLSNS3k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h7cWA/3j1e0WsSCDRMI029WQEqM0g5y/rWbg2xuiHyPw2ooZx3vTd9ga0vmpv1dz7
         uqCwklA9DQ00yolZlvVLQtmL7JnSdeUYriyVNtxpHybOiXtqyeuxEQJfQpAZ6Whb8I
         ehkAkV6N/5+pavmXi4jzBJH03XnPYZrw4Gz3zimI=
Date:   Fri, 21 May 2021 20:41:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] sysfs: Add helper BIN_ATTRIBUTE_GROUPS
Message-ID: <YKf+2KY9ssWc999p@kroah.com>
References: <66e9f6e5-fdee-6963-6131-228c69705350@gmail.com>
 <e20db248-ed30-cf5d-a37c-b538dceaa5b2@gmail.com>
 <YKVFO4bmW/hkoUnx@kroah.com>
 <1facebe2-1368-9b52-e0a1-f7a6eafc91ea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1facebe2-1368-9b52-e0a1-f7a6eafc91ea@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 09:02:47PM +0200, Heiner Kallweit wrote:
> On 19.05.2021 19:04, Greg Kroah-Hartman wrote:
> > On Wed, May 19, 2021 at 06:33:14PM +0200, Heiner Kallweit wrote:
> >> New helper BIN_ATTRIBUTE_GROUPS() does the same as ATTRIBUTE_GROUPS(),
> >> just for binary attributes.
> >>
> >> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> >> ---
> >>  include/linux/sysfs.h | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
> >> index d76a1ddf8..a12556a4b 100644
> >> --- a/include/linux/sysfs.h
> >> +++ b/include/linux/sysfs.h
> >> @@ -162,6 +162,12 @@ static const struct attribute_group _name##_group = {		\
> >>  };								\
> >>  __ATTRIBUTE_GROUPS(_name)
> >>  
> >> +#define BIN_ATTRIBUTE_GROUPS(_name)				\
> >> +static const struct attribute_group _name##_group = {		\
> >> +	.bin_attrs = _name##_attrs,				\
> >> +};								\
> >> +__ATTRIBUTE_GROUPS(_name)
> > 
> > Is this really needed by more than just 1 driver?
> > 
> Few more use case I saw:
> devcd_dev_groups in drivers/base/devcoredump.c
> w1_f3a_group in drivers/w1/slaves/w1_ds2413.c
> w1_slave_default_groups in drivers/w1/w1.c

Ok, might as well, can't hurt to add this :)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
