Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4385442B877
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 09:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238289AbhJMHKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 03:10:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:48008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238294AbhJMHJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 03:09:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9987F61027;
        Wed, 13 Oct 2021 07:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634108874;
        bh=tJd6HdQjKdNfUh7OXPaE587O3EpP3jk9sV8NWmB0HLA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rKc8O8Z/eEXtKuZU60Y2MS2Ixh65eqtP1OrMsQNqHgP6aRaCrUM/fUXee8bq03iim
         7bzS9TWhc3BgLPQEz+joc87feXNm6t27Tbmp1mk7CzuidxDw2+xfuApchQWezk4oWi
         PqmTrXwZH6ja/gnC/twG7D8Le++csxaHYd9fqvRk=
Date:   Wed, 13 Oct 2021 09:07:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?utf-8?B?546L5pOO?= <wangqing@vivo.com>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQ0g=?= =?utf-8?Q?=5D?= usb: replace
 snprintf in show functions with sysfs_emit
Message-ID: <YWaFx3zMlsbWQQ6S@kroah.com>
References: <1634095668-4319-1-git-send-email-wangqing@vivo.com>
 <AA2A8gBxEnrQndzc*evdgarV.9.1634105950804.Hmail.wangqing@vivo.com>
 <SL2PR06MB3082C1AAF2A11871C10CDA53BDB79@SL2PR06MB3082.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SL2PR06MB3082C1AAF2A11871C10CDA53BDB79@SL2PR06MB3082.apcprd06.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 06:52:53AM +0000, 王擎 wrote:
>  
> >> On Tue, Oct 12, 2021 at 08:27:47PM -0700, Qing Wang wrote:
> >> coccicheck complains about the use of snprintf() in sysfs show functions.
> >> 
> >> Fix the following coccicheck warning:
> >> drivers/usb/core/sysfs.c:730:8-16: WARNING: use scnprintf or sprintf.
> >> drivers/usb/core/sysfs.c:921:8-16: WARNING: use scnprintf or sprintf.
> >> 
> >> Use sysfs_emit instead of scnprintf or sprintf makes more sense.
> >> 
> >> Signed-off-by: Qing Wang <wangqing@vivo.com>
> >> ---
> >>  drivers/usb/core/sysfs.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/drivers/usb/core/sysfs.c b/drivers/usb/core/sysfs.c
> >> index fa2e49d..6387c0d 100644
> >> --- a/drivers/usb/core/sysfs.c
> >> +++ b/drivers/usb/core/sysfs.c
> >> @@ -727,7 +727,7 @@ static ssize_t authorized_show(struct device *dev,
> >>                               struct device_attribute *attr, char *buf)
> >>  {
> >>        struct usb_device *usb_dev = to_usb_device(dev);
> >> -     return snprintf(buf, PAGE_SIZE, "%u\n", usb_dev->authorized);
> >> +     return sysfs_emit(buf, "%u\n", usb_dev->authorized);
> >>  }
> >>  
> >>  /*
> >> @@ -918,7 +918,7 @@ static ssize_t authorized_default_show(struct device *dev,
> >>        struct usb_hcd *hcd;
> >>  
> >>        hcd = bus_to_hcd(usb_bus);
> >> -     return snprintf(buf, PAGE_SIZE, "%u\n", hcd->dev_policy);
> >> +     return sysfs_emit(buf, "%u\n", hcd->dev_policy);
> >>  }
> >>  
> >>  static ssize_t authorized_default_store(struct device *dev,
> >> -- 
> >> 2.7.4
> >> 
> > 
> > If you are going to change this file, you should do this for all of the
> > sysfs show functions in this file, not just 2 of them, right?  Please
> > change this patch to do that.
> >
> > thanks,
> > 
> > greg k-h
> 
> Only these 2 snprintf need to be modified, other show functions
> used sprintf do not need to modify.

I do not think you understand the change you are trying to make here.

Either the whole file should use the same api, or just leave it as-is as
it obviously works properly today :)

thanks,

greg k-h
