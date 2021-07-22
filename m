Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D953D2AB3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 19:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234450AbhGVQTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 12:19:21 -0400
Received: from smtprelay0163.hostedemail.com ([216.40.44.163]:52632 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235053AbhGVQS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 12:18:57 -0400
Received: from omf16.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 435B01801EC49;
        Thu, 22 Jul 2021 16:59:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf16.hostedemail.com (Postfix) with ESMTPA id AF19F25510C;
        Thu, 22 Jul 2021 16:59:24 +0000 (UTC)
Message-ID: <ff955d0fa6c50954d52ca93f0bee2e79627fe861.camel@perches.com>
Subject: Re: [PATCH] staging: rtl8188eu: Line over 100 characters
From:   Joe Perches <joe@perches.com>
To:     Jignesh Patel <jigs0101@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Martin Kaiser <martin@kaiser.cx>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Safonov <insafonov@gmail.com>,
        Paul McQuade <paulmcquad@gmail.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Thu, 22 Jul 2021 09:59:23 -0700
In-Reply-To: <20210722164144.377781-1-jigs0101@gmail.com>
References: <20210722164144.377781-1-jigs0101@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.20
X-Stat-Signature: 9euwhj4p6rexifjirezs86fbna9cr3cj
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: AF19F25510C
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18K4fqFUH4ZUuHs1GOeAukvXKaS/Q2YgsU=
X-HE-Tag: 1626973164-729998
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-07-22 at 22:11 +0530, Jignesh Patel wrote:
> Break various lines into multiple lines to respect 100 character width limit.
[]
> diff --git a/drivers/staging/rtl8188eu/core/rtw_ap.c b/drivers/staging/rtl8188eu/core/rtw_ap.c
[]
> @@ -254,9 +254,12 @@ void expire_timeout_chk(struct adapter *padapter)
>  			updated = ap_free_sta(padapter, psta, true,
>  					      WLAN_REASON_DEAUTH_LEAVING);
>  		} else {
> -			/* TODO: Aging mechanism to digest frames in sleep_q to avoid running out of xmitframe */
> +			/** TODO: Aging mechanism to digest frames in

Please do not use double asterisks to start a comment.


