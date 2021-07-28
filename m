Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711643D8740
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 07:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbhG1Foi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 01:44:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:47008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229814AbhG1Fog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 01:44:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF5F360F91;
        Wed, 28 Jul 2021 05:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627451074;
        bh=CYjhDYPNMH+Hg9kMhEDMaCiOh0Q61z7lbz39STzyZmg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HDpl0uUCU6bga5BodqjpnEYl0kd6HLLgTZMtAPfIgeBwnHH5uiF76teYESxc/N4P7
         k/ovqM79T9eyqn6SgP7x6USscrXpWQGUwkqmkTAeIwXiTkI3zRy+yNsdBXldz1UQUJ
         Hvi6qaBybDCmvB47KKVGK/LzMBZxd/Qe4TYGhA0A=
Date:   Wed, 28 Jul 2021 07:44:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: core: Fix incorrect type in
 assignment
Message-ID: <YQDuv2fIKtga0Blz@kroah.com>
References: <20210728004223.15102-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728004223.15102-1-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 02:42:23AM +0200, Fabio M. De Francesco wrote:
> Fix sparse warning: incorrect type in assignment (different base types).
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_security.c | 31 +++++++++++--------
>  1 file changed, 18 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
> index a99f439328f1..527f710c7658 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_security.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_security.c
> @@ -35,8 +35,10 @@ const char *security_type_str(u8 value)
>  */
>  void rtw_wep_encrypt(struct adapter *padapter, u8 *pxmitframe)
>  {																	/*  exclude ICV */
> -
> -	unsigned char crc[4];
> +	union {
> +	__le32 f0;
> +	unsigned char f1[4];
> +	} crc;

Odd indentation, are you sure this is right?

Please indent the fields by one more tab.

thanks,

greg k-h
