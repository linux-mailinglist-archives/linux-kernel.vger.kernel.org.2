Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA7A42B90C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 09:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238439AbhJMHaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 03:30:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:58282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238405AbhJMHaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 03:30:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8988360E53;
        Wed, 13 Oct 2021 07:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634110083;
        bh=QcbkfNTF0iOrygpufmGcE3HxoY8PhoZf9QBoNP9L9fA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YRStEG4imf7S9GBdb73NeDCXloCCHPKRyKbWu9YnknIv5SIvhQH8A8crl3Kp+49Cl
         U5skNpY08PrqYXEE2v8OaA1Jn+Vuo3/mbIW6AHipKGUGJvfzzGNTE3PPBzLWUjGzsc
         DFbXh6Ud3SqsAfakTNFK+p4fne60FrJO+Na2Y8ZU=
Date:   Wed, 13 Oct 2021 09:28:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?utf-8?B?546L5pOO?= <wangqing@vivo.com>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRD?= =?utf-8?Q?H=5D?= usb:
 replace snprintf in show functions with sysfs_emit
Message-ID: <YWaKgF76P27KNiC6@kroah.com>
References: <1634095668-4319-1-git-send-email-wangqing@vivo.com>
 <AA2A8gBxEnrQndzc*evdgarV.9.1634105950804.Hmail.wangqing@vivo.com>
 <SL2PR06MB3082C1AAF2A11871C10CDA53BDB79@SL2PR06MB3082.apcprd06.prod.outlook.com>
 <AGUA7ADTEv9Q*f-TXCLIpKpn.9.1634108876473.Hmail.wangqing@vivo.com>
 <SL2PR06MB3082F89D5AE9436928A934F6BDB79@SL2PR06MB3082.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SL2PR06MB3082F89D5AE9436928A934F6BDB79@SL2PR06MB3082.apcprd06.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 07:20:25AM +0000, 王擎 wrote:
>  
> >> >> On Tue, Oct 12, 2021 at 08:27:47PM -0700, Qing Wang wrote:
> >> >> coccicheck complains about the use of snprintf() in sysfs show functions.
> >> >> 
> >> >> Fix the following coccicheck warning:
> >> >> drivers/usb/core/sysfs.c:730:8-16: WARNING: use scnprintf or sprintf.
> >> >> drivers/usb/core/sysfs.c:921:8-16: WARNING: use scnprintf or sprintf.
> >> >> 
> >> >> Use sysfs_emit instead of scnprintf or sprintf makes more sense.
> >> >> 
> >> >> Signed-off-by: Qing Wang <wangqing@vivo.com>
> >> >> ---
> >> >>  drivers/usb/core/sysfs.c | 4 ++--
> >> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >> >> 
> >> >> diff --git a/drivers/usb/core/sysfs.c b/drivers/usb/core/sysfs.c
> >> >> index fa2e49d..6387c0d 100644
> >> >> --- a/drivers/usb/core/sysfs.c
> >> >> +++ b/drivers/usb/core/sysfs.c
> >> >> @@ -727,7 +727,7 @@ static ssize_t authorized_show(struct device *dev,
> >> >>                               struct device_attribute *attr, char *buf)
> >> >>  {
> >> >>        struct usb_device *usb_dev = to_usb_device(dev);
> >> >> -     return snprintf(buf, PAGE_SIZE, "%u\n", usb_dev->authorized);
> >> >> +     return sysfs_emit(buf, "%u\n", usb_dev->authorized);
> >> >>  }
> >> >>  
> >> >>  /*
> >> >> @@ -918,7 +918,7 @@ static ssize_t authorized_default_show(struct device *dev,
> >> >>        struct usb_hcd *hcd;
> >> >>  
> >> >>        hcd = bus_to_hcd(usb_bus);
> >> >> -     return snprintf(buf, PAGE_SIZE, "%u\n", hcd->dev_policy);
> >> >> +     return sysfs_emit(buf, "%u\n", hcd->dev_policy);
> >> >>  }
> >> >>  
> >> >>  static ssize_t authorized_default_store(struct device *dev,
> >> >> -- 
> >> >> 2.7.4
> >> >> 
> >> > 
> >> > If you are going to change this file, you should do this for all of the
> >> > sysfs show functions in this file, not just 2 of them, right?  Please
> >> > change this patch to do that.
> >> >
> >> > thanks,
> >> > 
> >> > greg k-h
> >> 
> >> Only these 2 snprintf need to be modified, other show functions
> >> used sprintf do not need to modify.
> > 
> > I do not think you understand the change you are trying to make here.
> > 
> > Either the whole file should use the same api, or just leave it as-is as
> > it obviously works properly today :)
> > 
> > thanks,
> > 
> > greg k-h
> 
> snprintf() returns the length of the string, not the length actually written.
> Here only correct this issue, as to whether it overflows should be 
> guaranteed by the caller of sprintf().

But for all of these, there is no overflow possible, that's not the
issue here.

As-is, this code works just fine.  If you really want to change it, as
per the recommendation of some static checker, then do so for the whole
file, to be unified and make sense overall.  Do not just blindly follow
a static tool for no good reason :)

thanks,

greg k-h
