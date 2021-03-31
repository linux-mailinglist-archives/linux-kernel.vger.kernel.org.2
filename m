Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31523350A77
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 00:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbhCaWth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 18:49:37 -0400
Received: from smtprelay0034.hostedemail.com ([216.40.44.34]:43564 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229624AbhCaWtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 18:49:22 -0400
Received: from omf17.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id C6BE8837F24C;
        Wed, 31 Mar 2021 22:49:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id 041DA27DD18;
        Wed, 31 Mar 2021 22:49:20 +0000 (UTC)
Message-ID: <391203d8794c2fc5343f2bf991a5497d3d5b7fcd.camel@perches.com>
Subject: Re: [PATCH v1 1/7] Add Driver for SUNIX PCI(e) I/O expansion board
From:   Joe Perches <joe@perches.com>
To:     Moriis Ku <saumah@gmail.com>, lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org
Date:   Wed, 31 Mar 2021 15:49:19 -0700
In-Reply-To: <20210330082350.6890-1-saumah@gmail.com>
References: <20210330082350.6890-1-saumah@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.10
X-Rspamd-Server: rspamout02
X-Stat-Signature: qqo8xj84t45bkhbdybjsp7m1b1em4stc
X-Rspamd-Queue-Id: 041DA27DD18
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+QArIPAEnPqZrr3WXrYHQav7xxq5L2Ixs=
X-HE-Tag: 1617230960-288004
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-03-30 at 16:23 +0800, Moriis Ku wrote:
> From: Morris <saumah@gmail.com>
> 
> Signed-off-by: Morris <saumah@gmail.com>
> ---
>  spi_pack.c | 1506 ++++++++++++++++++++++++++++++++++++++++++++++++++++

You might try to use scripts/checkpatch.pl on this and see
if there is anything you want to change to have the code look
more like the rest of the kernel.

Using
	./scripts/checkpatch.pl --strict --fix <patch>
from the top of the kernel tree should help quite a bit with
making the code layout look more like typical kernel style.

> diff --git a/spi_pack.c b/spi_pack.c
[]
> +static void get_info(struct sunix_sdc_spi_channel *spi_chl, unsigned int incomeLength, unsigned int * translateLength)
> +{
[]
> +	do
> +	{
> +		Address = spi_chl->info.phy2_base_start + spi_chl->info.memoffset;
> +
> +	} while (false);

That's an odd and unnecessary use of a do while.

> +	memset(TrBuff, 0, SUNIX_SDC_SPI_BUFF);
> +	TrLength = 0;
> +
> +	pTrHeader->Version = 0x01;
> +	pTrHeader->CmdResponseEventData = pRxHeader->CmdResponseEventData | 0x8000;
> +	pTrHeader->ResponseStatus = nStatus;
> +	pTrHeader->Length = (nStatus == SDCSPI_STATUS_SUCCESS)?(31 + (cib_info->spi_number_of_device * 12)):0;
> +	TrLength = sizeof(SPI_HEADER);

Perhaps reorder the patch submission to define the structs first.

This can't compile as SPI_HEADER isn't defined
SPI_HEADER and PSPI_HEADER should use not use typedefs and use the typical
	struct spi_header
and
	struct spi_header *

> +	if (pTrHeader->ResponseStatus == SDCSPI_STATUS_SUCCESS)

Hungarian isn't generally used in the kernel.
CamelCase isn't generally used either.

> +	{
> +		memcpy(&TrBuff[TrLength], spi_chl->info.model_name, 16);
> +		TrLength += 16;
> +		TrBuff[TrLength++] = spi_chl->info.bus_number;
> +		TrBuff[TrLength++] = spi_chl->info.dev_number;
> +		TrBuff[TrLength++] = spi_chl->info.line;
> +		TrBuff[TrLength++] = (unsigned char)((Address & 0xff000000) >> 24);
> +		TrBuff[TrLength++] = (unsigned char)((Address & 0x00ff0000) >> 16);
> +		TrBuff[TrLength++] = (unsigned char)((Address & 0x0000ff00) >> 8);
> +		TrBuff[TrLength++] = (unsigned char)((Address & 0x000000ff));
> +		TrBuff[TrLength++] = (unsigned char)(spi_chl->info.irq);

You might consider using a single char * and increment that and not use
TrLength at all and use p - TrBuff when necessary.

		*p++ = spi_chl->info.bus_number;
		*p++ = spi_chl->info.dev_number;
		...

> +		TrBuff[TrLength++] = (unsigned char)((cib_info->spi_significand_of_clock & 0xff000000) >> 24);
> +		TrBuff[TrLength++] = (unsigned char)((cib_info->spi_significand_of_clock & 0x00ff0000) >> 16);
> +		TrBuff[TrLength++] = (unsigned char)((cib_info->spi_significand_of_clock & 0x0000ff00) >> 8);
> +		TrBuff[TrLength++] = (unsigned char)((cib_info->spi_significand_of_clock & 0x000000ff));

Perhaps

		put_unaligned_le32(cib_info->spi_significant_of_clock, p);
		p += 4;

etc...


