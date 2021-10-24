Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCEA438B5C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 20:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbhJXSVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 14:21:19 -0400
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:57142 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhJXSVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 14:21:16 -0400
Received: from [192.168.1.18] ([92.140.161.106])
        by smtp.orange.fr with ESMTPA
        id ei57mb2SudmYbei57mLejJ; Sun, 24 Oct 2021 20:18:54 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 24 Oct 2021 20:18:54 +0200
X-ME-IP: 92.140.161.106
Subject: Re: [PATCH] dma-mapping: Use 'bitmap_zalloc()' when applicable
To:     Joe Perches <joe@perches.com>, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20976d6fd4af266dec589b40929b53dfddd64b75.1635097161.git.christophe.jaillet@wanadoo.fr>
 <c8cd95bc81173fdbdff4f2b504db3ce89119fa0d.camel@perches.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <994b268f-ea33-bf82-96ab-c20057ba4930@wanadoo.fr>
Date:   Sun, 24 Oct 2021 20:18:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <c8cd95bc81173fdbdff4f2b504db3ce89119fa0d.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 24/10/2021 à 19:54, Joe Perches a écrit :
> On Sun, 2021-10-24 at 19:40 +0200, Christophe JAILLET wrote:
>> 'dma_mem->bitmap' is a bitmap. So use 'bitmap_zalloc()' to simplify code,
>> improve the semantic and avoid some open-coded arithmetic in allocator
>> arguments.
> 
> There is a cocci script for some of these.
> 
> https://lore.kernel.org/all/08b89608cfb1280624d1a89ead6547069f9a4c31.camel@perches.com/
> 

Hi Joe,

yes I know.
As it is public, I guess that new comers may have seen it and want to 
propose patches based on your cocci script.

So, for now, I'm more focused on things that are not spotted by your 
script. I look for places where the size computation is not done within 
the kmalloc() or eq. function.

CJ
