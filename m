Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE98141B867
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 22:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242752AbhI1Uf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 16:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242016AbhI1Uf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 16:35:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64476C06161C;
        Tue, 28 Sep 2021 13:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=8Ggu/0OLgkwhv1XAK+iyNiUVWyqmgJl+lsAM3cYVagw=; b=dv2PA1MswNXBuvgB1DYG5SjjZx
        95DjB255H8mpvboBlPZqGjvEpqUdZkW5Oob6IlyxrW+4jh+16blJ4sNSsp3zmfDrvRwM4/8Gk3Cxf
        eU4VzCR7/xwBokCboPb+NEHwX27WQi0V/Ne5kDKQRGm1QrIr1VqeJWaVyHRp8iKPab6yT1lj80E3o
        tquglhxYKbC6b93YCn8v9IRWzMdwio7pXEN07VxpBRt/AkF/y5EXteTXFzgjHZ6QFXWP942DbNGN6
        ki65w90xR+sopLDpQveoftH6JTTie+rHdLNrXWLhLQ4quzoUAGEEzGtGON1cODpAD8mDpvIpPOg7O
        Z6YCFp0Q==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mVJnP-008m1d-W7; Tue, 28 Sep 2021 20:33:48 +0000
Subject: Re: [PATCH] of: remove duplicate declaration of of_iomap()
To:     trix@redhat.com, robh+dt@kernel.org, frowand.list@gmail.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210928201214.294737-1-trix@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e706d330-87ab-75e6-7118-e9b280039409@infradead.org>
Date:   Tue, 28 Sep 2021 13:33:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210928201214.294737-1-trix@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/21 1:12 PM, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> A ranconfig produces this linker error

randconfig .. on what arch, please?

> irq-al-fic.c:252: undefined reference to `of_iomap'
> 
> The declaration of of_iomap() is dependent on OF
> The definition of of_iomap() is dependent on OF_ADDRESS
> These should match.  There are duplicate declarations
> of of_iomap(), remove of_iomap() and the
> of_address_to_resource() duplicate.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>   include/linux/of_address.h | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)
> 


thanks.
-- 
~Randy
