Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D74D39D89D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 11:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhFGJZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 05:25:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:42596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230127AbhFGJZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 05:25:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6705860232;
        Mon,  7 Jun 2021 09:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623057805;
        bh=A4zAYvAyANbFqhltJKq2zyoNqrB3rlfLtGKwOWMjzTs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bpt7xkkvmewiElQQWNxsRbWGWMDyRcMFFSBuUq7jYs9pNInxR1c8kEUT6qBYhOB5b
         iEkhfZbmpWeJgyPPhVfFHkqG51sWeQdv17qm5qesWti+UnV29W55AeiV2sA9fM5F0g
         MYaya5iNBq8fBy4KzX12+khVuzgl6OXwhWa9tLbs=
Date:   Mon, 7 Jun 2021 11:23:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Wenli Looi <wlooi@ucalgary.ca>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Fix uninitialized variable
Message-ID: <YL3lih8OqGOLjVBf@kroah.com>
References: <20210606070021.116284-1-wlooi@ucalgary.ca>
 <20210607083316.GO1955@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607083316.GO1955@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 11:33:17AM +0300, Dan Carpenter wrote:
> Greg asked about struct holes and the answer is "= {}" will zero out
> struct holes but it's not important in this case.  The "= {}" is a GCC
> extension for zeroing structs and it's not part of the C standard.
> The struct has a kernel pointer in it so we had better not be shairing
> it to user space.

I thought we proved that "= {}" will _NOT_ zero out holes in structures.
Or did we really prove that?  I can't remember now, do you?

thanks,

greg k-h
