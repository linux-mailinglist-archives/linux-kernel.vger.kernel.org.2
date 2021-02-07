Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA57F3124DD
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 15:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhBGOzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 09:55:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:53926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229522AbhBGOzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 09:55:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B15FE64E42;
        Sun,  7 Feb 2021 14:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612709707;
        bh=Wt9cjdwSLRzxXcychd1Z79SJy+jAFVnftbg1gVSar24=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eCM83IFX2LU1xrujsZe/0UxiWeKrZFGJO39/E/FowxMbokxCGvRoEsp48HVLkQ59B
         oY59k2lTJHBVkWhoaFXpher3PEhkasmDar6RqHuJVp7FmKprsqhdxCte8sYTHIo15y
         xYNl+3o4JG8JROMXqYZDQ88EkcrDBKthiMKgFdTc=
Date:   Sun, 7 Feb 2021 15:55:04 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     alexander.sverdlin@nokia.com, andrew@lunn.ch, davem@davemloft.net,
        chris.packham@alliedtelesis.co.nz, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: octeon: convert all uses of strlcpy to strscpy
 in ethernet-mdio.c
Message-ID: <YB//SDQJEsHwewFb@kroah.com>
References: <20210207144804.88330-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210207144804.88330-1-phil@philpotter.co.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 07, 2021 at 02:48:04PM +0000, Phillip Potter wrote:
> Convert three calls to strlcpy inside the cvm_oct_get_drvinfo function
> to strscpy calls. Fixes a style warning.

Is it really safe to do this type of conversion here?  If so, you need
to provide evidence of it in the changelog, otherwise we could just do a
search/replace across the whole kernel and be done with it :)

thanks,

greg k-h
