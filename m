Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C5E41BECA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 07:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244289AbhI2FlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 01:41:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244147AbhI2FlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 01:41:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 98394613C8;
        Wed, 29 Sep 2021 05:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632893966;
        bh=IGnWJOyuv2q27b9eXT2nQLtV7eTJr66xH+o8rgdvwMg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tEyHVAPC6Bpkoyc3EE10uMwg0WPjRcT6XICSSMu39ikuzmDkFinERPqS0qcBBBrW8
         I9clDCFowfwE3OYa8xp2NsfwJuxPqex4uyfsuw0rZQmHCpdGBXiQacVV1QEUsLP435
         ZgZqKW0/hOMnMY/XvGqUfoUO/QWW8xqxCUPDeX3g=
Date:   Wed, 29 Sep 2021 07:39:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     hallblazzar <hallblazzar@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: Subject: [PATCH] staging: r8188eu: Fix misspelling in comment
Message-ID: <YVP8CYJ6MpWCjRB0@kroah.com>
References: <5174112d-d0a5-e908-aee8-7d494914e89b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5174112d-d0a5-e908-aee8-7d494914e89b@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 06:49:48PM +0100, hallblazzar wrote:
> As format check raised by scripts/checkpatch.pl, comment in the rtw_ap.c
> looks misspelled by accident. Help fix it.
> 
> The original error is as below shows:
> 
> CHECK: 'followign' may be misspelled - perhaps 'following'?
> +Set to 0 (HT pure) under the followign conditions
> 
> Signed-off-by: Siou-Jhih, Guo <hallblazzar@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_ap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Your subject line has "Subject:" in it twice for some reason :(

Please fix up and send a v2.

thanks,

greg k-h
