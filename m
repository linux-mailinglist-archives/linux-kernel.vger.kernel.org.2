Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2929454A77
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 17:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238897AbhKQQHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 11:07:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:50512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230315AbhKQQHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 11:07:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6327561269;
        Wed, 17 Nov 2021 16:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637165051;
        bh=nmB2DsfemEqpIbhBbDCmIdQB3zuDPzsQ7EPJXzBUb6o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LrrI5vFta6nJumYjJyxWUS2f+fNshkVK/oaB+WTfEqJZ9z7rXy7yLgjiqsvbbqZVl
         69lvj6g8Xd9kXwROKMJ0+Y5OrcORJagFiJqhygVJPpX3De8IDVrzMLQV043A5PEfK6
         4U8C3iMxV+WN5GtAK2Vjk76gM/trViMmKn2844nE=
Date:   Wed, 17 Nov 2021 17:04:09 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sven Peter <sven@svenpeter.dev>,
        Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] usb: typec: tipd: Fix initialization sequence for
 cd321x
Message-ID: <YZUn+Svh+RwuI8a8@kroah.com>
References: <20211117151450.207168-1-marcan@marcan.st>
 <20211117151450.207168-3-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117151450.207168-3-marcan@marcan.st>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 12:14:50AM +0900, Hector Martin wrote:
> The power state switch needs to happen first, as that
> kickstarts the firmware into normal mode.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  drivers/usb/typec/tipd/core.c | 33 ++++++++++++++++-----------------
>  1 file changed, 16 insertions(+), 17 deletions(-)

Same question here, what commit id does this fix?

thanks,

greg k-h
