Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1582535D234
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 22:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238196AbhDLUrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 16:47:18 -0400
Received: from smtprelay0133.hostedemail.com ([216.40.44.133]:36542 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236988AbhDLUrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 16:47:16 -0400
Received: from omf04.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 5314A181D3028;
        Mon, 12 Apr 2021 20:46:57 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id 451D2D1514;
        Mon, 12 Apr 2021 20:46:56 +0000 (UTC)
Message-ID: <d82c4f4be48b645983a7f922f1791ebf098b22c5.camel@perches.com>
Subject: Re: [PATCH v4 3/3] staging: rtl8192e: remove unnecessary parentheses
From:   Joe Perches <joe@perches.com>
To:     Mitali Borkar <mitaliborkar810@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Date:   Mon, 12 Apr 2021 13:46:54 -0700
In-Reply-To: <29464cba775f9529db30b7fb4168198975098b55.1618224838.git.mitaliborkar810@gmail.com>
References: <cover.1618224838.git.mitaliborkar810@gmail.com>
         <29464cba775f9529db30b7fb4168198975098b55.1618224838.git.mitaliborkar810@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 451D2D1514
X-Spam-Status: No, score=0.10
X-Stat-Signature: c8jpneo5wxn44uay84rgs8d99pt4mhjb
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+6cZm0BG9zoYa1nYYgSmPFXdugcr6N1eg=
X-HE-Tag: 1618260416-447498
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-04-12 at 16:52 +0530, Mitali Borkar wrote:
> Removed unnecessary parentheses because they must be used only when it
> is necessary or they improve readability.
> Reported by checkpatch.

I gave you feedback about the memset changes.
Please use it.
https://lore.kernel.org/lkml/f5fe04d62b22eb5e09c299e769d9b9d8917f119c.camel@perches.com/

> Changes from v3:- No changes.
> Changes from v2:- Rectified spelling mistake in subject description.
> Changes has been made in v3.
> Changes from v1:- No changes.
[]
> diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
[]
> @@ -646,13 +646,13 @@ void HTInitializeHTInfo(struct rtllib_device *ieee)
>  	pHTInfo->CurrentMPDUDensity = pHTInfo->MPDU_Density;
>  	pHTInfo->CurrentAMPDUFactor = pHTInfo->AMPDU_Factor;
>  
> 
> -	memset((void *)(&(pHTInfo->SelfHTCap)), 0,
> +	memset((void *)(&pHTInfo->SelfHTCap), 0,
>  	       sizeof(pHTInfo->SelfHTCap));

	memset(&pHTInfo->SelfHTCap, 0, sizeof(pHTInfo->SelfHTCap);

etc...

