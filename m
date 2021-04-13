Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A02235D953
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 09:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238190AbhDMHwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 03:52:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:39624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229821AbhDMHwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 03:52:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A9230613B1;
        Tue, 13 Apr 2021 07:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618300317;
        bh=kH6tzlgbDeOX411elnJ/YrqiObxFCB2d+i2jEGP6EVM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EfyifVtZP+00T6KM/wUeCHuGZbvos4c60CfXdKSe1HM5C/MJOypnszg+TY/YTfQ3F
         G3MJKorJ8mYVYR51as0PxCb+sAk2sWrfhTCDjd5PZeAmRJYLTnGJq/OmlI7NWvToT7
         50flA6rU2+1jtClNXN3Bt8gbHqrnQfW5IRvA4Uv8=
Date:   Tue, 13 Apr 2021 09:51:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH 0/2] Remove spaces and blank lines
Message-ID: <YHVNmqagCRLbicR/@kroah.com>
References: <20210412175903.17819-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412175903.17819-1-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 07:59:01PM +0200, Fabio M. De Francesco wrote:
> Removed spaces before tabs and multiple blank lines from Hal8723BReg.h
> for readability improvement. Issues detected by checkpatch.pl.
> 
> Fabio M. De Francesco (2):
>   staging: rtl8723bs: hal Remove spaces before tabs
>   staging: rtl8723bs: hal: Remove multiple blank lines
> 
>  drivers/staging/rtl8723bs/hal/Hal8723BReg.h | 43 +++++++++------------
>  1 file changed, 18 insertions(+), 25 deletions(-)

This series does not apply to my tree, please rebase and resend.

thanks,

greg k-h
