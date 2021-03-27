Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8613534B765
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 14:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhC0NgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 09:36:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:37858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229582AbhC0Nfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 09:35:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3BF4E619B4;
        Sat, 27 Mar 2021 13:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616852130;
        bh=Nupl1h4L3SrvV6jeooPg4igwqzoBR9zVxBIfDnVt+Ws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ITLqQbDcNg1pWJF9wcg8RmMX/7LtRW/YIho350gj34w4jlAhVkVBf2JdhrKrW+cw0
         vg6RY0hxOogsN3GUC1pWxVCWE9uukKh7tvcNE2o4MYKpGgsKdMjmAnHocvACG/CuP9
         r771hR11e5tzq4Ua/7p75ofXEgFdv7GswvPp0bxQ=
Date:   Sat, 27 Mar 2021 14:35:27 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ray Chi <raychi@google.com>
Cc:     balbi@kernel.org, Thinh.Nguyen@synopsys.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        albertccwang@google.com
Subject: Re: [Patch v3] usb: dwc3: add cancelled reasons for dwc3 requests
Message-ID: <YF80n+iN9zYYooOB@kroah.com>
References: <20210327132202.1759953-1-raychi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210327132202.1759953-1-raychi@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 27, 2021 at 09:22:02PM +0800, Ray Chi wrote:
> Currently, when dwc3 handles request cancelled, dwc3 just returns
> -ECONNRESET for all requests. It will cause USB function drivers
> can't know if the requests are cancelled by other reasons.
> 
> This patch will replace DWC3_REQUEST_STATUS_CANCELLED with the
> reasons below.
>   - DWC3_REQUEST_STATUS_DISCONNECTED
>   - DWC3_REQUEST_STATUS_DEQUEUED
>   - DWC3_REQUEST_STATUS_STALLED
> 
> Signed-off-by: Ray Chi <raychi@google.com>
> ---
>  drivers/usb/dwc3/core.h   | 12 +++++++-----
>  drivers/usb/dwc3/gadget.c | 24 ++++++++++++++++++++----
>  drivers/usb/dwc3/gadget.h |  6 ++++--
>  3 files changed, 31 insertions(+), 11 deletions(-)

What changed from the previous versions?  that should always go below
the --- line as documented.

Please fix up and submit a v4 with that information.

thanks,

greg k-h
