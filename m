Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726E6359BE5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 12:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbhDIKWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 06:22:10 -0400
Received: from mailgate.ics.forth.gr ([139.91.1.2]:31973 "EHLO
        mailgate.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbhDIKWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 06:22:08 -0400
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 139ALrt0022221
        for <linux-kernel@vger.kernel.org>; Fri, 9 Apr 2021 13:21:53 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1617963708; x=1620555708;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4xoOfBoikcbpylZq0tpqCq2qp9BayyeejBfojMmM0AM=;
        b=XHpblb8NBLx3Snnj94rHJuQRPTYlgy+C6ombwMSnvOU/RhG+jqx+u2ywrcgk2tws
        GF5EbNR3JtS+E5774E2w4R+rI3t/mmM6xprc+Pgsve6A2eBuiuRVmzymrdt0zPq0
        66kdHGXqJb0i+WbAxAAcD1aI/rqcZ8+6eooHsm+ecKx8axo7O6sf7aHInMHzPs9b
        bk0QBgNX2GKJQBk+x72xC3rRd5klkPy1HpzANPggJGiOzmQdZDYvwIPsUkauPGa1
        3SEVblt4M4sWNuoqiETiLv8HuOjaG119S1CakU859lfU9b0gz+Rbxs6zyNVlxHHr
        UeVYhVE96m3j5ZYiXRQ4dA==;
X-AuditID: 8b5b014d-a70347000000209f-e5-60702abc8505
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id 4F.20.08351.CBA20706; Fri,  9 Apr 2021 13:21:48 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 09 Apr 2021 13:21:48 +0300
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     Alex Ghiti <alex@ghiti.fr>
Cc:     Nick Kossifidis <mick@ics.forth.gr>,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] RISC-V: Add kdump support
Organization: FORTH
In-Reply-To: <1385f2a4-53a9-535b-851a-3c470f1f3bc1@ghiti.fr>
References: <20210405085712.1953848-1-mick@ics.forth.gr>
 <20210405085712.1953848-5-mick@ics.forth.gr>
 <1385f2a4-53a9-535b-851a-3c470f1f3bc1@ghiti.fr>
Message-ID: <75abd98990bfaae51262b72cf7d59831@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.3.16
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsXSHT1dWXePVkGCwf2/GhbP7nxltbi8aw6b
        xbbPLWwWze/OsVu8vNzDbNE2i9+BzePNy5csHvdOTGP1eLjpEpPH5iX1Hpear7N7fN4kF8AW
        xWWTkpqTWZZapG+XwJWxrHMaa8FGtoppR06xNjA+Yeli5OSQEDCR2NV0mbmLkYtDSOAoo8Si
        jc/YIBKmErP3djKC2LwCghInZ0I0MAtYSEy9sp8RwpaXaN46mxnEZhFQlfj86DuYzSagKTH/
        0kGwehEBOYm27iOMIAuYBZYxSmw8vgKsSBhoQcOhqWA2v4CwxKe7F1lBbE4BG4k/3c/BmoUE
        ZjJKfOp172LkADrCRWLXKXeI21QkPvx+wA4SFgWyN89VmsAoOAvJpbOQXDoLyaULGJlXMQok
        lhnrZSYX66XlF5Vk6KUXbWIEBzuj7w7G25vf6h1iZOJgPMQowcGsJMLb3JyfIMSbklhZlVqU
        H19UmpNafIhRmoNFSZyXV29CvJBAemJJanZqakFqEUyWiYNTqoHJvmiDxhZngex50z9nTu+Q
        XRYS/HKv7HNpR6vlR0VONO1lCLmk6Kfe9C384h0Oy5slB9rfCyz++unlr9vf0ox01xT4Z2d8
        3pO0qfN61UHvnK8TZ1a1n73DYrJJlU9tkV78ht7zbWHPOU0NdHdFLnxy4dGLbBOxCfYtcQuF
        GFoOLVZ/bSvqt6bqakVm1q6rl3P272+YlH/txaMFPzmEhHYXK55TCBGt2B0Rer4xTlTk5IYm
        4a3sBc/FJ317+1pnM7fR0W0lGg9sXAvqhax2WzifP16z89sMZsdKRWsrQ2UJ31fW3rkz7zw4
        aXd4i9+GVeoW20PS21JPZ9+TP773ZMMcwQk882dfXDTvr2nc7d6dSizFGYmGWsxFxYkAnH5t
        XOUCAAA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Στις 2021-04-06 21:36, Alex Ghiti έγραψε:
> 
>> +	/* Switch to physical addressing */
>> +	la	s4, 1f
>> +	sub	s4, s4, s3
>> +	csrw	stvec, s4
>> +	csrw	sptbr, zero
> 
> satp is used everywhere instead of sptbr. And maybe you could CSR_****
> naming, like you did in riscv_crash_save_regs and like it's done in
> head.S too.
> 

ACK

>> +		crash_base = memblock_find_in_range(search_start, search_end,
>> +#ifdef CONFIG_64BIT
>> +						    crash_size, SZ_2M);
>> +#else
>> +						    crash_size, SZ_4M);
>> +#endif
> 
> You can use PMD_SIZE here and get rid of #ifdef.
> 
>> +
>> +#ifdef CONFIG_64BIT
>> +		if (!IS_ALIGNED(crash_base, SZ_2M)) {
>> +#else
>> +		if (!IS_ALIGNED(crash_base, SZ_4M)) {
>> +#endif
> 
> Ditto here.
> 

Will do.

Thanks a lot for your review !
