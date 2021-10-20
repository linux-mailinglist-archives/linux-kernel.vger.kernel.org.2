Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE6C9434C50
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 15:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhJTNqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 09:46:37 -0400
Received: from smtprelay0163.hostedemail.com ([216.40.44.163]:49844 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229985AbhJTNqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 09:46:36 -0400
Received: from omf12.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 6E03D181D3058;
        Wed, 20 Oct 2021 13:44:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf12.hostedemail.com (Postfix) with ESMTPA id 56A8A240234;
        Wed, 20 Oct 2021 13:44:20 +0000 (UTC)
Message-ID: <16db455b46f130300b5c346160aa434616e4f6b4.camel@perches.com>
Subject: Re: [PATCH] staging: vt6655: Rename `dwAL2230InitTable` array
From:   Joe Perches <joe@perches.com>
To:     Karolina Drobnik <karolinadrobnik@gmail.com>,
        outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Wed, 20 Oct 2021 06:44:19 -0700
In-Reply-To: <20211020132811.417341-1-karolinadrobnik@gmail.com>
References: <20211020132811.417341-1-karolinadrobnik@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 56A8A240234
X-Spam-Status: No, score=0.09
X-Stat-Signature: oo3h5kbqswjdmb7acbiqk8tbkpj89guo
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/eiOfcbBMvL+7NHov4EFM1SyAS5JwxoKw=
X-HE-Tag: 1634737460-597000
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-10-20 at 14:28 +0100, Karolina Drobnik wrote:
> Drop Hungarian notation prefix in `dwAL2230InitTable` array.
> Change it to use snake case.
> 
> Fix issue detected by checkpatch.pl:
>   CHECK: Avoid CamelCase: <dwAL2230InitTable>

Seems fine.

trivial suggestion:

> diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
[]
> @@ -33,7 +33,7 @@
>  #define SWITCH_CHANNEL_DELAY_AL7230 200 /* us */
>  #define AL7230_PWR_IDX_LEN    64
>  
> -static const unsigned long dwAL2230InitTable[CB_AL2230_INIT_SEQ] = {
> +static const unsigned long al2230_init_table[CB_AL2230_INIT_SEQ] = {
>  	0x03F79000 + (BY_AL2230_REG_LEN << 3) + IFREGCTL_REGW,
>  	0x03333100 + (BY_AL2230_REG_LEN << 3) + IFREGCTL_REGW,
>  	0x01A00200 + (BY_AL2230_REG_LEN << 3) + IFREGCTL_REGW,

In this file there are more than 100 uses of

	(BY_AL2230_REG_LEN << 3) + IFREGCTL_REGW

Maybe add a define for it and substitute the uses for the define.


