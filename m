Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 371EC35414E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 12:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbhDEKxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 06:53:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:54904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232355AbhDEKxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 06:53:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8889861284;
        Mon,  5 Apr 2021 10:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617619974;
        bh=E6mGmcFVUNZbpRQ/xRfQlUA6ryi9bhjbtTQUzzlkoYo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qw1KzdddFc8NORDeJtkDLMMDOlkYgcvPmNZ1sUKA2FtZhxq+ixJXbaFKhL8Po+0kP
         2A8d9uV2ZlJEfptO4bmk32RCEKYpvNJGxggDsZTR5eIMsEj6Vpb+JU0RTJzOcr7G/a
         iXUYDzprA+2GEucH/x8jLmREBsdi6iUcdj1GvWnk=
Date:   Mon, 5 Apr 2021 12:52:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luiz Sampaio <sampaio.ime@gmail.com>
Cc:     zbr@ioremap.net, corbet@lwn.net, rikard.falkeborn@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/9] w1: ds2438: fixed a coding style issue in iad_read
Message-ID: <YGrsA6V75B4ANJPi@kroah.com>
References: <20210403044821.390485-1-sampaio.ime@gmail.com>
 <20210405105009.420924-1-sampaio.ime@gmail.com>
 <20210405105009.420924-3-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210405105009.420924-3-sampaio.ime@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2021 at 07:50:02AM -0300, Luiz Sampaio wrote:
> Since there is only one statement inside the if clause, no brackets
> are required.
> 
> Signed-off-by: Luiz Sampaio <sampaio.ime@gmail.com>
> ---
>  drivers/w1/slaves/w1_ds2438.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

As this does the same type of fix as the next 3 patches, to the same
file, they should be all merged together into 1 patch.

thanks,

greg k-h
