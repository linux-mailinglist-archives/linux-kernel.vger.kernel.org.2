Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8597930CCDB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 21:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240425AbhBBULZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 15:11:25 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:60903 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238623AbhBBUKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 15:10:39 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 939075C034D;
        Tue,  2 Feb 2021 15:09:49 -0500 (EST)
Received: from imap4 ([10.202.2.54])
  by compute1.internal (MEProxy); Tue, 02 Feb 2021 15:09:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com.au;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm2; bh=sA+AU/n4/I/xsAJBbgiEJO8oMY76
        mKXx9sM4Uq7UJao=; b=hvj88uq8ZOXU6NVHVxZr6lcTussLMmrD/h2HQ2kQwrBn
        cCTsjUyyVlc1uy7WdtAlk3xrHZk6wXVbWl7fWU8VUFQuxJ8025494lzcCsA8Hojw
        KjXaUfQ/QRJx62eCM5jnNC2HQMXhJjQtpc2JE664M07m7t9pxnxhhiP9q/slmx/7
        DRT8fVRIKsI8SjwkBFUwbi8jIPpcFW0Qyl76svn7wK6Ke3MeZCWwXpLMcLudBvjT
        vchRWbs5dcr6YaOskTUq/SIgTjvuv//5ljuA/aMb8x13LPyOApYHjt4sIWU/UTEC
        j1Tl/yH/wSSnfc4ZGKR8bSn+fsppKTCjT+rkp9jQzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=sA+AU/
        n4/I/xsAJBbgiEJO8oMY76mKXx9sM4Uq7UJao=; b=iWvsa85Q0cHzrxUmXXaNkx
        O8aLhxi9X6EphpmeeMq4Yx3WVre5Oh/t/VXt+ml2PqL7YDDYBYqHYfgR0H1QFYXo
        VnI6WC8AqGKiHuAhBtvEsgWb6+/j3z6egVMUlV1RNsQkEZPrk9T216rOtiJqt4iB
        OPxZQDQt+iRy/6bVLlnZnZ9jQo/OWc0qsoOdl5ECsA7iFds6p4O2sL3IomFGYLTP
        rxecZYqpXtJJId5/2ZPpRspns6tn0EeUr+teUn9hU+HpxWGTio9Q/bGAJtUyt7QM
        pBs+7wt2scVOtrtr8BDeqVia7wJar+dMOe1H/mRLPfxtI4HyxFFYniWKxYcSt8iQ
        ==
X-ME-Sender: <xms:jLEZYBktTP4LPOMxIxrRrAv97WWg-_-bL_2O3NbblZvpbCItnlP0rQ>
    <xme:jLEZYM3F9T-brSm7q_Xzr1BxgYK4bMVsO7sVPlRDYcrS6GLBLdIFyscQgR_FLj_wN
    YfLVxA1S4DjZV1_nA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrgedtgddufeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdflohhh
    nhcuvfhhohhmshhonhdfuceoghhithesjhhohhhnthhhohhmshhonhdrfhgrshhtmhgrih
    hlrdgtohhmrdgruheqnecuggftrfgrthhtvghrnhepveehjedvhfeghefhtdehhfevheef
    vedugeeiveffkeeuiefgudffffeujedvgffhnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepghhithesjhhohhhnthhhohhmshhonhdrfhgrshht
    mhgrihhlrdgtohhmrdgruh
X-ME-Proxy: <xmx:jLEZYHq-tyGbFULG6zRHb1n1zf2Ee9VJlnordVqfOTN4zGod7TGvkQ>
    <xmx:jLEZYBkiuRk-Ey9hMB0vYyEU5rFVdOaVsbrRFo9xVTw0S40bKk47dA>
    <xmx:jLEZYP2-xaG4MNM9tUDWmrTZlOkxOQmRic_uiUfkUPfJztkPzeyAnQ>
    <xmx:jbEZYAz4_QHCbr2WclkSKVk2-nfqCDQUwe38ez9YU28O_6X7KMToHg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0AE3016064E; Tue,  2 Feb 2021 15:09:48 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-93-gef6c4048e6-fm-20210128.002-gef6c4048
Mime-Version: 1.0
Message-Id: <b21034dc-f511-448f-9c1d-68013c640608@www.fastmail.com>
In-Reply-To: <20210104122853.18428-1-git@johnthomson.fastmail.com.au>
References: <20210104122853.18428-1-git@johnthomson.fastmail.com.au>
Date:   Tue, 02 Feb 2021 20:08:43 +0000
From:   "John Thomson" <git@johnthomson.fastmail.com.au>
To:     "Miquel Raynal" <miquel.raynal@bootlin.com>,
        "Richard Weinberger" <richard@nod.at>,
        "Vignesh Raghavendra" <vigneshr@ti.com>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: =?UTF-8?Q?Re:_[RFC_PATCH]_mtd:_spi-nor:_write_support_for_minor_aligned_?=
 =?UTF-8?Q?partitions?=
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Jan 2021, at 12:28, John Thomson wrote:
> --- a/drivers/mtd/mtdpart.c
> +++ b/drivers/mtd/mtdpart.c
> @@ -38,10 +38,11 @@ static struct mtd_info *allocate_partition(struct 
> mtd_info *parent,
>  	struct mtd_info *master = mtd_get_master(parent);
>  	int wr_alignment = (parent->flags & MTD_NO_ERASE) ?
>  			   master->writesize : master->erasesize;
> +	int wr_alignment_minor;

int wr_alignment_minor = 0;

> +	if (!(child->flags & MTD_NO_ERASE)) {
> 	wr_alignment = child->erasesize;
> +	if (child->erasesize_minor)

if (child->erasesize_minor && IS_ENABLED(CONFIG_MTD_SPI_NOR_USE_VARIABLE_ERASE)) {
Config test wrap wr_alignment_minor being set,
so that a partition on a minor boundary is only set writeable if the non-uniform erase path can be used.

> +		wr_alignment_minor = child->erasesize_minor;
> +	}

> +		if (wr_alignment_minor) {

smatch picked up a tested uninitialized symbol 'wr_alignment_minor' here,
initialise as 0.
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

> +		if ((!wr_alignment_minor) || (wr_alignment_minor && remainder_minor != 0)) {

If it is safe to boolean test the ints and u32, I should use this consistently?
if ((!wr_alignment_minor) || (wr_alignment_minor && remainder_minor)) {
Or is it clearer to use the math tests?
if ((wr_alignment_minor == 0) || (wr_alignment_minor > 0 && remainder_minor > 0)) {

> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -1225,7 +1225,11 @@ static u8 spi_nor_convert_3to4_erase(u8 opcode)
>  
>  static bool spi_nor_has_uniform_erase(const struct spi_nor *nor)
>  {
> +#ifdef CONFIG_MTD_SPI_NOR_USE_VARIABLE_ERASE

if (IS_ENABLED(CONFIG_MTD_SPI_NOR_USE_VARIABLE_ERASE)) {
and the closing brace better than the #ifdef here?

> +	return false;
> +#else
>  	return !!nor->params->erase_map.uniform_erase_type;
> +#endif
>  }
>  
>  static void spi_nor_set_4byte_opcodes(struct spi_nor *nor)


Otherwise, is this approach valid, or is there a better method I can use?

Cheers,
-- 
  John Thomson
