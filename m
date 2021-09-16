Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F94C40DBC0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 15:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236670AbhIPNxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 09:53:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:42910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236364AbhIPNx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 09:53:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 80E6561056;
        Thu, 16 Sep 2021 13:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631800327;
        bh=PVPBKtiUBKzN5oWP2AP+VB1YQFhqbU8dENfIk9m5jDw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xxROAd1nkGdHWzHKoyJwnTqY0MeGVMlvq/Q7+B6h6Gz/6SphXi7RquCXBRAmVvc5B
         c3XVv+PHVjUw4xNv1q82qzv934ZXOgAxLhSauwqc9NVIjUuksBgp9fUfIr3D+n9hbD
         lwYvfIR+3gZejW4c/zCOm13jMSn5MNWLPAwKDG8Q=
Date:   Thu, 16 Sep 2021 15:52:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v6 14/19] staging: remove struct _io_ops
Message-ID: <YUNMBOcolb+5S4I5@kroah.com>
References: <20210915211103.18001-1-fmdefrancesco@gmail.com>
 <20210915211103.18001-15-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915211103.18001-15-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 11:10:58PM +0200, Fabio M. De Francesco wrote:
> From: Pavel Skripkin <paskripkin@gmail.com>
> 
> Finally struct _io_ops is unused, so remove it.
> 
> Co-developed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> ---
>  drivers/staging/r8188eu/hal/usb_ops_linux.c |  6 -----
>  drivers/staging/r8188eu/include/rtw_io.h    | 25 ---------------------
>  drivers/staging/r8188eu/include/usb_ops.h   |  2 --
>  3 files changed, 33 deletions(-)

Subject line is missing the driver name :(
