Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 373F0422396
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 12:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbhJEKb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 06:31:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:60126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234579AbhJEKb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 06:31:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D43D0611AE;
        Tue,  5 Oct 2021 10:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633429779;
        bh=E0WwExfLjdxHIUiA5gdbo/w28j/Ic5yr/TkBTwl0/oc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZBEPshrw8bYoxNsaxCH3VMKSU/o3XclKZ1IG/aqTj561YDEAf7Y2i4mIPnbZ3oLww
         XeJgCdNNGAvViy2PxQdw8zzihA66qUvIquC6mrJ4PBNKY0IUCispsd+W+wB8CPSZ25
         wqM5YJb9ysHx/kNTSlv7iq86ktylzRzrmhxmOYmg=
Date:   Tue, 5 Oct 2021 12:29:37 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     hallblazzar <hallblazzar@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: r8188eu: Fix misspelling in comment
Message-ID: <YVwpEa5T4HnOX5/g@kroah.com>
References: <7bc392d5-11e4-7ad0-dab6-295ccadf63b9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7bc392d5-11e4-7ad0-dab6-295ccadf63b9@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 12:29:01PM +0100, hallblazzar wrote:
> As format check raised by scripts/checkpatch.pl, comment in the rtw_ap.c
> looks misspelled by accident. Help fix it.
> 
> The original error is as below shows:
> 
> CHECK: 'followign' may be misspelled - perhaps 'following'?
> +Set to 0 (HT pure) under the followign conditions
> 
> Signed-off-by: Siou-Jhih, Guo <hallblazzar@gmail.com>

This does not match with your "From" line in your email header :(

> ---
>  drivers/staging/r8188eu/core/rtw_ap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

What changed from v1?  That always has to go below the --- line as per
the documentation, right?

Please fix up and send a v3.

thanks,

greg k-h
