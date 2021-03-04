Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1B432CA17
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 02:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbhCDBgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 20:36:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:59634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231683AbhCDBgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 20:36:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 717F56523D;
        Thu,  4 Mar 2021 01:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614821753;
        bh=Qe7zGUitWIYRrO9+yOOXaqCaFvUR2e3wtBb+ql0NqIA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y7w5u5sgdSYnaZk7ektFug+FNzuWFx+BfLgvydnYyBsjboq9UDNoTmaHGrnrXDXS0
         VxmQtz5yAf5FXliFzO5wCmNq8zsi1LYLr0VZRLB1whaigliLnrdoj0kHJOOLK6WX+K
         52gbShNnbjmASVJYsXrSUhyGm8wWlhzXyCTHIcNtS4mk18lqIbvi4OWhoSL0q+xup2
         1yO6hBOwA7u7lMz3Er3MamRdtIs0l9IUJBASRYX5ZpuavDYv5E7posggNyYfgbibaa
         sD9sBXSlnA9W5OJt7JFFpSnQFS3BNpXeBpNuP1txZsKOWGshA0N/NceUjL4E3997Uu
         nHekpx+ft246Q==
Date:   Thu, 4 Mar 2021 09:35:49 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     liulongfang <liulongfang@huawei.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, mathias.nyman@intel.com,
        linux-usb@vger.kernel.org, yisen.zhuang@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] USB:XHCI:Modify XHCI driver for USB2.0 controller
Message-ID: <20210304013548.GA16596@nchen>
References: <1614327697-1021-1-git-send-email-liulongfang@huawei.com>
 <YDizmDmu6Kh264Pv@kroah.com>
 <87cc8b54-f530-cce0-3ea2-f879436ff5f7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cc8b54-f530-cce0-3ea2-f879436ff5f7@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-02-27 11:31:00, liulongfang wrote:
> On 2021/2/26 16:38, Greg KH wrote:
> > On Fri, Feb 26, 2021 at 04:21:37PM +0800, Longfang Liu wrote:
> >> Our current XHCI hardware controller has been customized to only
> >> support USB 2.0 ports.
> > 
> > That sounds like a spec violation, right?  Why do you want to do this?
> > 
> > greg k-h
> > .
> > 
> I hope to support a USB2.0-only mode on the XHCI controller
> through software configuration.
> Thanks.

If your hardware has disabled USB3 logic, when the USB3 device is plugged,
since there are no RX signal on the bus, the device will not enable USB3
logic, and only USB2 signals will be on the bus, there are only USB devices on
USB2 roothub later. So, any issues you have met?

-- 

Thanks,
Peter Chen

