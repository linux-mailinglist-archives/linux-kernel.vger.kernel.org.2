Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4951344CF74
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 03:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbhKKCHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 21:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233156AbhKKCHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 21:07:38 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9481AC061766;
        Wed, 10 Nov 2021 18:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=0Nt0HEE9X5wOjLHK/2KYgOYAmFu/jqQA+XTNP+rxn0c=; b=LI/lgat9mSPLl11pGP8oR1Dzkr
        YctlCHlPLfJ36I08z8F//KgzzWOmRL1wKQuOwPXfDGWkmuQDroVf9BjN+opYYk6WAlTqpvO4jjCHz
        Y0DWqkJ9cMuMrViAULF6EURm1vZsdfo2bCOKcDufwipVCPCqzSRoEx8mvw9aeUXxPg3/UsrweOHl0
        goceDKe2lbk9v34JDd+3jgiK150CvRnJAOixcGBugSva2jyq0aWUpxuh0u5iTdPqiYTHUSBEXZWkr
        ffFP478ZRT5aa2vWrpkfzTE1eEtOcemtn7lg1NWhr2UnWqpRcISaV42XFvsmCUYx1xrI/AwYVelhw
        X3WRH/mg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkzSL-006kGt-9H; Thu, 11 Nov 2021 02:04:49 +0000
Subject: Re: [PATCH] m68k: Enable memtest kernel parameter
To:     Finn Thain <fthain@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Mike Rapoport <rppt@kernel.org>, Sam Creasey <sammy@sammy.net>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <a57524fe38123ea17a6741cdc282f6c84c30a009.1636593047.git.fthain@linux-m68k.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <725c0578-d816-f0c9-175a-7400c4a01887@infradead.org>
Date:   Wed, 10 Nov 2021 18:04:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <a57524fe38123ea17a6741cdc282f6c84c30a009.1636593047.git.fthain@linux-m68k.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/21 5:10 PM, Finn Thain wrote:
> Enable the memtest feature and rearrange some code to prevent it from
> clobbering the initrd.
> 
> The CONFIG_BLK_DEV_INITRD symbol was conditional on !defined(CONFIG_SUN3).
> For simplicity, remove that test on the basis that m68k_ramdisk.size == 0
> on Sun 3.
> 
> The SLIME source code athttp://sammy.net/  shows that no BI_RAMDISK entry
> is ever passed to the kernel due to #ifdef 0 around the relevant code.
> 
> Cc: Mike Rapoport<rppt@kernel.org>
> Cc: Sam Creasey<sammy@sammy.net>
> Signed-off-by: Finn Thain<fthain@linux-m68k.org>
> ---
> Are there any other Linux bootloaders on Sun 3?
> ---
>   arch/m68k/Kconfig           |  1 +
>   arch/m68k/kernel/setup_mm.c | 15 ++++++---------
>   arch/m68k/mm/motorola.c     |  2 ++
>   3 files changed, 9 insertions(+), 9 deletions(-)

Hi Finn,

Please also update Documentation/admin-guide/kernel-parameters.txt:

	memtest=	[KNL,X86,ARM,PPC,RISCV] Enable memtest

to include "M68K".

thanks.
-- 
~Randy
