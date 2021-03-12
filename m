Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B97703385F9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 07:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbhCLGe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 01:34:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:42810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231806AbhCLGep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 01:34:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F8CF64F7E;
        Fri, 12 Mar 2021 06:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615530885;
        bh=z9VRAvxwpItsHfsW21eQ/ghaBvAxsgifK2mUSWcSD0Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XUHe3a+YuBgLRbxM15JPYTMYlv9yGORQRo9I44uunNJ9SGxm3dG37oAEuNpXJJuh9
         /mwuVQJ0YTKKTv6fbQFD8OQdGeg1TBH6hoohrCrAaKFYK7Jfh754bVl0zh05DfcdZK
         CUz31HstnHIxjL4GAa098YFZ1KdcEAvu+f6JzcHM=
Date:   Fri, 12 Mar 2021 07:34:42 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyle Tso <kyletso@google.com>
Subject: Re: [PATCH v2 1/2] usb: typec: tcpci: Add tcpc chip level callbacks
Message-ID: <YEsLgogC66Fzx7Vk@kroah.com>
References: <20210312052443.3797674-1-badhri@google.com>
 <YEsLSevhzYja0fwk@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEsLSevhzYja0fwk@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 07:33:45AM +0100, Greg Kroah-Hartman wrote:
> On Thu, Mar 11, 2021 at 09:24:42PM -0800, Badhri Jagan Sridharan wrote:
> > This change adds chip callbacks for the following operations:
> > 1. Notifying port role
> > 2. Notifying orientation
> 
> This should be 2 different patches, one per callback, right?
> 
> And where is the code using these callbacks?  We can't add any hooks
> without in-tree users, as you know.

Ah, your second patch added that, sorry, missed it.

This should be a 4 patch series, remember, only do one thing per patch.

thanks,

greg k-h
