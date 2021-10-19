Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEAC14336A1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 15:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235815AbhJSNG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 09:06:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:50174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230097AbhJSNG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 09:06:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DFD0C61372;
        Tue, 19 Oct 2021 13:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634648653;
        bh=y4bwIP99bgP7Ml+JufuaLWJMSFCpFb2IgDQsVZrKASk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bCpjhUh1VcXA9BupCXm2ZZIsAfA8v60rDCJCENAgyUd5lCl3+Xh1Qq5gGs02IAK4f
         HxvuxGpmjCgp6U260CCqlBEdvmMQu0PYJ71NGSLMwjx4ozStUNNQ9aTLCiFohPX8fc
         yLMbN8r33Bb2WrtgQgmkXvZJ1c7Aav2zZr+6JS/OdLRDgf8p+xnX0bFMOYuZrFXt+3
         G25b1BglnnHmAu/ZOGUXw2sWnUd0vpIJ7gYzyNpN/aUnLaZtRD9oU5FuVjGCAFhX6x
         Tre/X9bbk+IWoVgQo+i5milRvsGdiEYeyAqoW5Kg9cqhW6dEgvjFVMCQk5SqRX8AAO
         wPMvlSz9YaD1A==
Message-ID: <e920e58d-d003-32cb-2910-64eea15beb58@kernel.org>
Date:   Tue, 19 Oct 2021 21:04:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 7/7] erofs: lzma compression support
Content-Language: en-US
To:     Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Lasse Collin <lasse.collin@tukaani.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
References: <20211010213145.17462-1-xiang@kernel.org>
 <20211010213145.17462-8-xiang@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20211010213145.17462-8-xiang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/10/11 5:31, Gao Xiang wrote:
> From: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Add MicroLZMA support in order to maximize compression ratios for
> specific scenarios. For example, it's useful for low-end embedded
> boards and as a secondary algorithm in a file for specific access
> patterns.
> 
> MicroLZMA is a new container format for raw LZMA1, which was created
> by Lasse Collin aiming to minimize old LZMA headers and get rid of
> unnecessary EOPM (end of payload marker) as well as to enable
> fixed-sized output compression, especially for 4KiB pclusters.
> 
> Similar to LZ4, inplace I/O approach is used to minimize runtime
> memory footprint when dealing with I/O. Overlapped decompression is
> handled with 1) bounced buffer for data under processing or 2) extra
> short-lived pages from the on-stack pagepool which will be shared in
> the same read request (128KiB for example).
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Acked-by: Chao Yu <chao@kernel.org>

Thanks,
