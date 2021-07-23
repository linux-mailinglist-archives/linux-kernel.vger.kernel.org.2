Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 896E63D38FD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 13:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbhGWKVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 06:21:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:56168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230372AbhGWKVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 06:21:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B3C1660EB2;
        Fri, 23 Jul 2021 11:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627038112;
        bh=kzaEsoa7UY8A1naT/RVW8iZLVR/8UwfLgBZJB/INriw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JPqNPXtS2iHj9F3euqoq67XYGF8u57UxgaMeUcBYA/qryy0f25/7U3pYFtkkIIsTl
         fif/jdDRBfCe3nEFsunZGvtukF40s3Pw6Y+5uWjYBX9Bd85XoE9P0UhcZMSfYSUcY5
         oyIMT5/GIJJWC5AAFh+s8iLlzjculy06zUWG/Ybw=
Date:   Fri, 23 Jul 2021 13:01:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        fabioaiuto83@gmail.com
Subject: Re: [PATCH 0/7] staging: rtl8188eu: replace driver with better
 version
Message-ID: <YPqhmjYDj0rq7V7r@kroah.com>
References: <20210723004214.912295-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723004214.912295-1-phil@philpotter.co.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2021 at 01:42:07AM +0100, Phillip Potter wrote:
> I had to break this patchset up a bit to get around the file size limits
> on the mailing list, and also I removed the hostapd stuff which is
> userspace related and therefore not required.
> 
> The driver currently in staging is older and less functional than the
> version on Larry Finger's GitHub account, branch v5.2.2.4. This series
> of patches therefore:
> 
> (1) Removes the current driver from staging.
> (2) Imports the GitHub version mentioned above in its place.
> 
> There is plenty of work to do to this driver, including to its Makefile,
> but it is at least buildable/usable for now.

Looks like it failed to build :(

And does this replace the 0/2 series?  If so, is this a v2?

confused,

greg k-h
