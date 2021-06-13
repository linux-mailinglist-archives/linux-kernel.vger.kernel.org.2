Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 370C33A55F0
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 03:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbhFMBMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 21:12:49 -0400
Received: from smtprelay0164.hostedemail.com ([216.40.44.164]:33398 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229753AbhFMBMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 21:12:48 -0400
Received: from omf08.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 416CD100E7B40;
        Sun, 13 Jun 2021 01:10:47 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf08.hostedemail.com (Postfix) with ESMTPA id E21571A29F6;
        Sun, 13 Jun 2021 01:10:45 +0000 (UTC)
Message-ID: <2580565feae3e407d297b9eaa1ac6c4988c77076.camel@perches.com>
Subject: Re: [PATCH] staging: rtl8188eu: convert DBG_88E calls in
 core/rtw_sta_mgt.c
From:   Joe Perches <joe@perches.com>
To:     Phillip Potter <phil@philpotter.co.uk>, gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux@roeck-us.net,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20210612232831.1325-1-phil@philpotter.co.uk>
References: <20210612232831.1325-1-phil@philpotter.co.uk>
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
Date:   Sat, 12 Jun 2021 17:22:33 -0700
User-Agent: Evolution 3.40.0-1 
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.80
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: E21571A29F6
X-Stat-Signature: t3yk7mc8irqnbpx1cwpan5ydurhodh7b
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18VV3YH/jbrx/asX0C2z+T4c4WI5W7Xbuw=
X-HE-Tag: 1623546645-739408
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2021-06-13 at 00:28 +0100, Phillip Potter wrote:
> Convert both calls to the DBG_88E macro in core/rtw_sta_mgt.c into
> netdev_dbg calls. The DBG_88E macro is unnecessary, as visibility of
> debug messages can be controlled more precisely by just using debugfs.
> It is important to keep these messages still, as they are displayable
> via a kernel module parameter when using DBG_88E.
[]
> diff --git a/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c b/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
[]
> @@ -113,17 +113,20 @@ u32 _rtw_init_sta_priv(struct sta_priv *pstapriv)
>  inline int rtw_stainfo_offset(struct sta_priv *stapriv, struct sta_info *sta)
>  {
>  	int offset = (((u8 *)sta) - stapriv->pstainfo_buf) / sizeof(struct sta_info);
> +	struct net_device *pnetdev = stapriv->padapter->pnetdev;
>  
> 
>  	if (!stainfo_offset_valid(offset))
> -		DBG_88E("%s invalid offset(%d), out of range!!!", __func__, offset);
> +		netdev_dbg(pnetdev, "invalid offset(%d), out of range!!!", offset);

better to add terminating newlines to the formats.


