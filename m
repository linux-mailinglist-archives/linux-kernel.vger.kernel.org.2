Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F2338C6AE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 14:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbhEUMmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 08:42:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:58750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231447AbhEUMmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 08:42:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C71A7613CA;
        Fri, 21 May 2021 12:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621600850;
        bh=Zd2uZ/NzI4g1Qu2S7+9Pwydv4FGMJZRaQ3BjjojC22A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TnzNHnR52qPTlxZGk9GFxvPYwJj7G028iLbIN+VM4lyKuxUbqvUbMkcT77k/4cXsv
         +ZA9s2QYebMeEDDVOOWjpA/Vp2ljLeoGnBSBYoREUWrTCNbELE114C0oJWeXYec5zn
         2G1q4VfyB+8jplIcisu9aCCWyXR1iq+WY4axjopo=
Date:   Fri, 21 May 2021 14:40:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] ttyprintk: remove redundant initialization of
 variable i
Message-ID: <YKeqUBZ+Zy/mvZNQ@kroah.com>
References: <20210518182126.140978-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518182126.140978-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 07:21:26PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable i is being initialized with a value that is never read,
> it is being updated later on.  The assignment is redundant and can be
> removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/char/ttyprintk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/ttyprintk.c b/drivers/char/ttyprintk.c
> index 219fa1382396..230b2c9b3e3c 100644
> --- a/drivers/char/ttyprintk.c
> +++ b/drivers/char/ttyprintk.c
> @@ -52,7 +52,7 @@ static void tpk_flush(void)
>  
>  static int tpk_printk(const unsigned char *buf, int count)
>  {
> -	int i = tpk_curr;
> +	int i;
>  
>  	for (i = 0; i < count; i++) {
>  		if (tpk_curr >= TPK_STR_SIZE) {
> -- 
> 2.31.1
> 

This is not ok for what is currently in linux-next :(

greg k-h
