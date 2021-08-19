Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76CFA3F1EEE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 19:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhHSRVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 13:21:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:43186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229465AbhHSRVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 13:21:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 84DED61028;
        Thu, 19 Aug 2021 17:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629393648;
        bh=YzY24lQYMbKKLQwXLzaMuzKanF4AoGWlTRj+qxi045g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gBsMQvvkdugXnBKZSFFFq76XTlNfUJGGDEkWRjIb3walnRzi5sG4gglFT7vjgg3L1
         6/w9jVyD7+7uL91l0jmJ9UUGyFeSiSdHal2o+bpag5i8cP88fV06PxKooseZ5s93xF
         T+Qq8L8XQo/BuFC6Fd1aN4beA1XpYwNnlhIncpyQ=
Date:   Thu, 19 Aug 2021 19:20:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Aakash Hemadri <aakashhemadri123@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] staging: r8188eu: restricted __be16 degrades to
 int
Message-ID: <YR6S7MfxpXpQFl9d@kroah.com>
References: <cover.1629360917.git.aakashhemadri123@gmail.com>
 <bd63137c645ecc20dc446a6cfa7f7d3461a642d7.1629360917.git.aakashhemadri123@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd63137c645ecc20dc446a6cfa7f7d3461a642d7.1629360917.git.aakashhemadri123@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 01:47:56PM +0530, Aakash Hemadri wrote:
> Fix sparse warning:
> > rtw_br_ext.c:839:70: warning: restricted __be16 degrades to integer
> > rtw_br_ext.c:845:70: warning: invalid assignment: |=
> > rtw_br_ext.c:845:70:    left side has type unsigned short
> > rtw_br_ext.c:845:70:    right side has type restricted __be16
> 
> dhcp->flag is u16, remove htons() as __be16 degrades.

Um, are you sure?

> 
> Signed-off-by: Aakash Hemadri <aakashhemadri123@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_br_ext.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
> index d4acf02ca64f..14b2935cab98 100644
> --- a/drivers/staging/r8188eu/core/rtw_br_ext.c
> +++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
> @@ -674,13 +674,13 @@ void dhcp_flag_bcast(struct adapter *priv, struct sk_buff *skb)
>  					u32 cookie = dhcph->cookie;
>  
>  					if (cookie == DHCP_MAGIC) { /*  match magic word */
> -						if (!(dhcph->flags & htons(BROADCAST_FLAG))) {
> +						if (!(dhcph->flags & BROADCAST_FLAG)) {

So you now just ignore the fact that the code used to properly check
BROADCAST_FLAG being in big endian mode, and now you assume it is native
endian?

Why is this ok?  Did you test this?

thanks,

greg k-h
