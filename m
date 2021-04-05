Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6331354118
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 12:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241037AbhDEKKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 06:10:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:50016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232456AbhDEKKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 06:10:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91E1E61278;
        Mon,  5 Apr 2021 10:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617617405;
        bh=Je/iwEPKGmWwfpx6j9nU8e8Cx0cbV02FGR+9cImDvtU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F9FTALqjBFbtV7oQpMRcYa2WpyX4RL+k+DoVQsoXjFO+qSHpnXlFc1YIro5ohuikj
         0EgGr4bYUBdrCigV1+t4BXBLDRKiBrY75DTptvrBqSlGKT6w8ShM4LqfsDUeKwbW7k
         mhk/Kbnxf4/G29RZajcgxDFBdqZnDRpJOA8alYWo=
Date:   Mon, 5 Apr 2021 12:10:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     David Villasana =?iso-8859-1?Q?Jim=E9nez?= 
        <davidvillasana14@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: Re: [PATCH] kpc2000: kpc2000: Removed extra blank line
Message-ID: <YGrh+jxGDczfqoeB@kroah.com>
References: <YGpCij8SVkJwO9AN@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YGpCij8SVkJwO9AN@fedora>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 04, 2021 at 05:49:46PM -0500, David Villasana Jiménez wrote:
> Fix checkpatch warning:
> CHECK: Please don't use multiple blank lines
> 
> Signed-off-by: David Villasana Jiménez <davidvillasana14@gmail.com>
> ---
>  drivers/staging/kpc2000/kpc2000/pcie.h | 1 -
>  1 file changed, 1 deletion(-)

Shouldn't the subject line something like:
	[PATCH] staging: kpc2000: pcie.h: Remove extra blank line

?

Please fix up and try again.

thanks,

greg k-h
