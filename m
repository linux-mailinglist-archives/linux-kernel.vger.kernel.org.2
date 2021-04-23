Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D22D369627
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 17:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242791AbhDWP2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:28:38 -0400
Received: from smtprelay0212.hostedemail.com ([216.40.44.212]:33146 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230330AbhDWP2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 11:28:37 -0400
Received: from omf07.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 00EC7180721D4;
        Fri, 23 Apr 2021 15:28:01 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id 2C359315D79;
        Fri, 23 Apr 2021 15:28:00 +0000 (UTC)
Message-ID: <0a68fbfffba4cc801814e3af1e3a7571928c1921.camel@perches.com>
Subject: Re: [PATCH 02/49] staging: rtl8723bs: replace DBG_871X_SEL log
 macro with netdev_dbg()
From:   Joe Perches <joe@perches.com>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Fri, 23 Apr 2021 08:27:58 -0700
In-Reply-To: <9e6a1e4dc8962bfd58375be98619c76e8e28febe.1619189489.git.fabioaiuto83@gmail.com>
References: <cover.1619189489.git.fabioaiuto83@gmail.com>
         <9e6a1e4dc8962bfd58375be98619c76e8e28febe.1619189489.git.fabioaiuto83@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.10
X-Stat-Signature: hpfqnibtk36znrqgjib1ysj7y39gayqw
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 2C359315D79
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19+yg7nfYjZqGqlfNqDoe3QbcEYNILX4Fg=
X-HE-Tag: 1619191680-416089
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-04-23 at 16:57 +0200, Fabio Aiuto wrote:
> replace DBG_871X_SEL log macro with the net device driver
> recommended netdev_dbg().
> 
> This macro by default does a raw printk, and the alternative
> behaviour, never triggered is a seq_print() call.
[]
> diff --git a/drivers/staging/rtl8723bs/core/rtw_debug.c b/drivers/staging/rtl8723bs/core/rtw_debug.c
[]
> @@ -23,9 +23,10 @@ void mac_reg_dump(void *sel, struct adapter *adapter)
>  	for (i = 0x0; i < 0x800; i += 4) {
>  		if (j%4 == 1)
>  			netdev_dbg(adapter->pnetdev, "0x%03x", i);
> -		DBG_871X_SEL(sel, " 0x%08x ", rtw_read32(adapter, i));
> +		netdev_dbg(adapter->pnetdev, " 0x%08x ",
> +			   rtw_read32(adapter, i));
>  		if ((j++)%4 == 0)
> -			DBG_871X_SEL(sel, "\n");
> +			netdev_dbg(adapter->pnetdev, "\n");
>  	}

This makes a mess of the output as each netdev_dbg call
is a separate line.

Dumping 1000 register lines into output logs seems impolite
at best, even for debugging.

This _might_ be rewritten to something like:

void dump_4_regs(struct adapter *adapter, int offset)
{
	u32 reg[4];
	int i;

	for (i = 0; i < 4; i++)
		reg[i] = rtw_read32(adapter, offset + i);

	netdev_dbg(adapter->pnetdev, "0x%03x 0x%08x 0x%08x 0x%08x 0x%08x\n",
		   i, reg[0], reg[1], reg[2], reg[3]);
}

void mac_reg_dump(...)
{
	...

	for (i = 0; i < 0x800; i += 4)
		dump_4_regs(adapter, i);



