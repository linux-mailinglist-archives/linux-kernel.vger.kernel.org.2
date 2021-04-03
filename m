Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F26353485
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 17:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236824AbhDCPYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 11:24:19 -0400
Received: from smtprelay0127.hostedemail.com ([216.40.44.127]:60986 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236621AbhDCPYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 11:24:18 -0400
Received: from omf13.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 2D0F118026B23;
        Sat,  3 Apr 2021 15:24:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf13.hostedemail.com (Postfix) with ESMTPA id 341331124F5;
        Sat,  3 Apr 2021 15:24:14 +0000 (UTC)
Message-ID: <eb2db42b7e721e6fbeaf8324d33801b5a9bfc03a.camel@perches.com>
Subject: Re: [PATCH v3 23/30] staging: rtl8723bs: fix comparison in if
 condition in core/rtw_recv.c
From:   Joe Perches <joe@perches.com>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>, gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Date:   Sat, 03 Apr 2021 08:24:12 -0700
In-Reply-To: <5acf0d9573f2d9cd5d249f928fbfeee010f5f3fc.1617440834.git.fabioaiuto83@gmail.com>
References: <cover.1617440833.git.fabioaiuto83@gmail.com>
         <5acf0d9573f2d9cd5d249f928fbfeee010f5f3fc.1617440834.git.fabioaiuto83@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.10
X-Rspamd-Server: rspamout02
X-Stat-Signature: zt1nspw3kad7tm9qeokqwpacs364i44y
X-Rspamd-Queue-Id: 341331124F5
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+w7r9xgpov50X4YYjx3W+YPKMYulw10ZA=
X-HE-Tag: 1617463454-954665
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-04-03 at 11:13 +0200, Fabio Aiuto wrote:
> fix post-commit checkpatch issue:
> 
> CHECK: Using comparison to false is error prone
> 27: FILE: drivers/staging/rtl8723bs/core/rtw_recv.c:381:
> +				if (psecuritypriv->
> 			bcheck_grpkey == false &&
> 
> Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_recv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
> index cd4324a93275..21949925ec77 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_recv.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
> @@ -378,7 +378,7 @@ static signed int recvframe_chkmic(struct adapter *adapter,  union recv_frame *p
>  
> 
>  			} else {
>  				/* mic checked ok */
> -				if (psecuritypriv->bcheck_grpkey == false &&
> +				if (!psecuritypriv->bcheck_grpkey &&
>  				    (IS_MCAST(prxattrib->ra) == true))
>  					psecuritypriv->bcheck_grpkey = true;
>  			}


