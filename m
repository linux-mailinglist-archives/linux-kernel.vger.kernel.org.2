Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD7C372B0F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 15:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhEDNdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 09:33:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:58448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230519AbhEDNdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 09:33:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C567D610FC;
        Tue,  4 May 2021 13:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620135125;
        bh=dOWj9KpD6YYv1QfoTJTLmqbkodKnlVInixOTiaxzaDk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HrKeShIRzVWeWIlX5XlGbsfFUzFwzWIoIUTY3WM6l7grGpMLe7H+JCQscqGttBAe5
         RsOxkPfjfMAurlRPuQ4tAYGFbYpLTHScwdXgCW1KDOKcVkhWPa5LWi0f2nu6jCmvAd
         mcFTymLjDpJWlCzXPFIQkhAXtoQNBMBfCxU8+5OA=
Date:   Tue, 4 May 2021 15:32:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] staging: rtl8723bs: use in-kernel aes encryption in
 OMAC1 routines
Message-ID: <YJFM0igHeonjMra5@kroah.com>
References: <cover.1620133620.git.fabioaiuto83@gmail.com>
 <8c1c680a6498045746ca579e4caa3c87d13b3b49.1620133620.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c1c680a6498045746ca579e4caa3c87d13b3b49.1620133620.git.fabioaiuto83@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2021 at 03:12:56PM +0200, Fabio Aiuto wrote:
> --- a/drivers/staging/rtl8723bs/include/rtw_security.h
> +++ b/drivers/staging/rtl8723bs/include/rtw_security.h
> @@ -7,6 +7,7 @@
>  #ifndef __RTW_SECURITY_H_
>  #define __RTW_SECURITY_H_
>  
> +#include <crypto/aes.h>

Why put this .h in a .h file?  Why not just put it in the .c file(s)
that need it?

You will note that this .h file does not have any other #include lines
in it...

thanks,

greg k-h
