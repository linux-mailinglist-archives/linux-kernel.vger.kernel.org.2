Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98DC4420325
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 19:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhJCRrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 13:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbhJCRrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 13:47:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CEFC0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 10:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=e+pm47rydWsOuvn1OCU3zNcVNz4N3LmfGQSpFTy2J1s=; b=eIMSBLXG91rw0/dj6eW+7MZMtJ
        2xcBaKbfU7BmN5dG4+mSS9iDjONZkHIKvE38pOvcRnQ227OgYt3q4HSNOMFumv6+RkztscsddF0pL
        iBLV9Szjcq7WJAUNiLSiwg9A8NGFK9iZonEufKNGj85HyMVZPuNmYTr1thJBZlk+7/YphyQcKfe4c
        NnRmCqL6Wpih5YwlsnwDPxpI/uyPV5L08VfMv0q3eJUrkEjKNknN8T83V9KiozNs5W6mUKXFblNXu
        LVFAf9LSclEiFv4nDAVQDnlCPvDQanevisujIvjM5WTwqBURliQF4Ul42cPV4A9hhIz01O74ya5fu
        ITwr2yug==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mX5Xx-004CQG-3X; Sun, 03 Oct 2021 17:45:09 +0000
Subject: Re: [PATCH] riscv: add rv32 and rv64 randconfig build targets
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-kernel@vger.kernel.org, mpe@ellerman.id.au,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org
References: <mhng-a1bcb222-57a9-4ef5-82bc-bed70d1a7e38@palmerdabbelt-glaptop>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <08028a91-0150-a6ee-67ac-73ca53c4d7d7@infradead.org>
Date:   Sun, 3 Oct 2021 10:45:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <mhng-a1bcb222-57a9-4ef5-82bc-bed70d1a7e38@palmerdabbelt-glaptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/21 11:06 PM, Palmer Dabbelt wrote:
> On Thu, 12 Aug 2021 07:29:30 PDT (-0700), rdunlap@infradead.org wrote:
>> Hi,
>> Any comments on this patch?
> 
> Sorry, I must have missed this one.  It looks great, it's just that I don't see your Signed-off-by on the original patch.
> 
>> thanks.

Hi Palmer,

I sent a v2 with the missing S-o-b:

https://lore.kernel.org/all/20210912034538.19404-1-rdunlap@infradead.org/


-- 
~Randy
