Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1873DE3D5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 03:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbhHCBHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 21:07:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:60110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232891AbhHCBHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 21:07:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C5C460F9C;
        Tue,  3 Aug 2021 01:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627952843;
        bh=gqoUY+WypcTVS9T5fCC9B2LZOiAtQUuaP7ib+nH0mqo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=C+guK3wo3oQ8SdMdH5v1DypVz76yeAWsUm+LojLC9wD77dC6bdUdtXDmcSGeRBUng
         GT3fOO0LhUSIuyvnrgvQ+0IwI56D4Bb6Kc25LuN6rtOAux1xszIH3goURjP526+TKO
         lVmpGZANslmQdlbhyJJCNqNt7UnlYjliXkBAKXdnp5uUXYWxpt2fpzuLedQ/Q6Qpx9
         gJkIDDfDhtQOXWJlxDXwt1ZDcgLm1dyOebMVBEpI9yXx+kZk6qmdEcnMGNdz1lHpFK
         ESfZDAyHJLOYR7PCB3Id/FmQZ+6haq7JfK4Ptn4iRdYCPbRCuUSPTm2CeVQExga0zx
         AAT2fy1cx1kiQ==
Subject: Re: [RFC NO MERGE] f2fs: extent cache: support unaligned extent
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@linux.dev>
References: <20210707015815.1978-1-chao@kernel.org>
 <YQRQ4kHvdRTBnb10@google.com>
 <51565c85-a475-bcb8-bbb2-e3125c5223a3@kernel.org>
 <YQgziuikMr0fvlT7@google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <3256dc39-2a82-cb60-038b-69e262c32d18@kernel.org>
Date:   Tue, 3 Aug 2021 09:07:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQgziuikMr0fvlT7@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/3 2:03, Jaegeuk Kim wrote:
> On 08/01, Chao Yu wrote:
>> On 2021/7/31 3:20, Jaegeuk Kim wrote:
>>> On 07/07, Chao Yu wrote:
>>>> Currently, it only works in readonly format f2fs image.
>>
>> There wouldn't be any race condition because unaligned extent only works
>> for ro feature now?
> 
> Isn't your patch proposing on writable partition?

Please check description in patch message, now it was designed only for
compression case w/ ro feature, let's check and support rw partition later.

Thanks,

> 
>>
>>> Is there any race condition between the address in extent_cache and the one in
>>> dnode? I feel that we could synchronize it by locking its dnode block.
>>
>> Thanks,
