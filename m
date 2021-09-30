Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C41E641D2BA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 07:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348098AbhI3Fdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 01:33:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:60056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348096AbhI3Fdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 01:33:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A87776135D;
        Thu, 30 Sep 2021 05:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632979914;
        bh=qgF3mXPiviYN07VlLPuhXZ5G1voewEGfUYirB3xXEdY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mUWZmSsSN9ChHM1UQxmmJpclnue/Q+lXBO3mBJN35tunWT+kSoAZMwswzGdFAfQP+
         T7G/LFmrthA+QiTHXe1ydVF5aMWOc9mPapddaXMGoOZgo/yQ0aDCzMTKS9p/auFXDk
         IaUs1Wf6L0k0VvG7ju27gAji8qwraRPHSJSM561g=
Date:   Thu, 30 Sep 2021 07:31:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        levinale@google.com, bleung@google.com, rajatxjain@gmail.com,
        jsbarnes@google.com, pmalani@google.com
Subject: Re: [PATCH 2/2] usb: hub: Mark devices downstream a removable hub,
 as removable
Message-ID: <YVVLxi/on9x6nfCZ@kroah.com>
References: <20210929224823.556943-1-rajatja@google.com>
 <20210929224823.556943-2-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929224823.556943-2-rajatja@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 03:48:23PM -0700, Rajat Jain wrote:
> If a usb device sits below a removable hub, mark the device also as
> removable. This helps with devices inserted on a standard removable hub or
> also thunderbold docks, to be shown as removable.
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
>  drivers/usb/core/hub.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Combined with the previous patch, you are now marking all devices that
happen to be attached to a root hub that is on a thunderbolt controller
as removable.  So all USB devices inside of a docking station are now
removable?

What type of devices did you test this series out with?  And again, what
problem are you trying to solve?

thanks,

greg k-h
