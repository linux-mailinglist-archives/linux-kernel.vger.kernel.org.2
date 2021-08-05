Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA85C3E1072
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 10:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239547AbhHEIie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 04:38:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:57670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237891AbhHEIid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 04:38:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C301610A8;
        Thu,  5 Aug 2021 08:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628152699;
        bh=LuDDhiurEknBQTcWpVTvvZaAFwzvJtxw/M1UF5YJNbc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BqDsRlADw62BzjyGcsDDjoaZ2UKjsTdZRoYZssSMjKM9oyMMMEuGwiR3Ej9sl/vLK
         8Ph+YsozxHS0eHzou8FC0iW8y1YhKyWaqEn6VjRkDXCSuB2P3R2nVfnOflEZKJfB3Z
         KEP2zE4UFfjr8M4AK9l9vVwnWg+/MePT8sddzOhc=
Date:   Thu, 5 Aug 2021 10:38:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com,
        laurent.pinchart@ideasonboard.com
Subject: Re: [PATCH v2 2/2] Revert "media: device property: Call
 fwnode_graph_get_endpoint_by_id() for fwnode->secondary"
Message-ID: <YQujbIj0ynE43vw9@kroah.com>
References: <20210804230313.78238-1-djrscally@gmail.com>
 <20210804230313.78238-3-djrscally@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804230313.78238-3-djrscally@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2021 at 12:03:13AM +0100, Daniel Scally wrote:
> This reverts commit acd418bfcfc415cf5e6414b6d1c6acfec850f290. Checking for
> endpoints against fwnode->secondary in fwnode_graph_get_next_endpoint() is
> a better way to do this since that function is also used in a bunch of
> other places, for instance sensor drivers checking that they do have an
> endpoint connected during probe.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Daniel Scally <djrscally@gmail.com>
> ---
>  drivers/base/property.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)

This can only be reverted due to your 1/2 change, right?  If so, you
might want to make that explicit here...

thanks,

greg k-h
