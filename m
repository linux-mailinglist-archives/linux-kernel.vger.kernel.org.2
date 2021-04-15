Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCEA360249
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 08:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhDOGTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 02:19:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:60030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230297AbhDOGTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 02:19:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E10A6161E;
        Thu, 15 Apr 2021 06:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618467539;
        bh=yAwJdgvdGo1K4qqIU8Iah7hDuZCsGWgH2RBATLQes5k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t2WWrQ8l4666zQUTM5rMqNGnBw3n6ZmtJK/oE6OgYFnyUlMdliktavfoRiaZNnOCG
         rYA/P2rXmJstL3CsTT+s/MCKYYst7X0HGQEjTWaqZJJ3TekiI/raTg8t665IFPb/Hr
         iLuwJS0VlRshgBK2a+Otmzaz805XL1g1F8Ep7jWc=
Date:   Thu, 15 Apr 2021 08:18:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [Outreachy kernel] [PATCH v3 2/2] staging: rtl8723bs: Remove
 everything related with LedBlink
Message-ID: <YHfazks3NlaUE8tg@kroah.com>
References: <20210414192750.4974-1-fmdefrancesco@gmail.com>
 <20210414192750.4974-3-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414192750.4974-3-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 09:27:50PM +0200, Fabio M. De Francesco wrote:
> Removed struct LedBlink_param. Removed LedBlink entries in
> rtw_cmd_callback[] and in wlancmds[]. Everything related to LedBlink is
> not anymore needed. Removed extra blank lines in the two mentioned
> arrays and changend the numbers set in comments for having them in line
> with the shift.
> 
> Reported-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
> 
> Changes from v2: Added this patch as 2/2.
> Changes from v1: No changes.
> 
>  drivers/staging/rtl8723bs/core/rtw_cmd.c    | 27 ++++++---------------
>  drivers/staging/rtl8723bs/include/rtw_cmd.h | 14 +++--------
>  2 files changed, 11 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
> index f82dbd4f4c3d..a74e6846f2df 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
> @@ -22,7 +22,6 @@ static struct _cmd_callback rtw_cmd_callback[] = {
>  	{GEN_CMD_CODE(_Write_EEPROM), NULL},
>  	{GEN_CMD_CODE(_Read_EFUSE), NULL},
>  	{GEN_CMD_CODE(_Write_EFUSE), NULL},
> -
>  	{GEN_CMD_CODE(_Read_CAM),	NULL},	/*10*/
>  	{GEN_CMD_CODE(_Write_CAM),	 NULL},
>  	{GEN_CMD_CODE(_setBCNITV), NULL},

These blank lines are there for a reason, please do not remove them.

thanks,

gre gk-h
