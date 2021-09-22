Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4336D414CEF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 17:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236420AbhIVPZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 11:25:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:46792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236304AbhIVPZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 11:25:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 51A62611EE;
        Wed, 22 Sep 2021 15:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632324222;
        bh=iQtZW7bI/BbYz50FbzeKEjP01m1V9pZsyCJK85pCxCk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Nq+UGdpuHjxkrO38TRVQ70c83KK9my+Fru9cYgbKriisyN2+PIHg1QjqDjs3BEmqk
         xOWIBexO75Wtav7mMxavaKWhDofU3umydS4ArZVNQXsRGdQp48XaboFV87U9X5uQSZ
         vPspefhIAEyirojJ/78FVJTGhIfBdRooGSoN+itn+ebpe4wgmK4/a0CfWz2QHVy1s5
         lYxyQ501Vp8AVBeDG3WcMuLAxqfRoPLEiG8l2Fwb+UM5776TG8Hqq38lEnakAfcI2B
         4SwmIM8SPJeYAG5/kGXzFkHjkuuE4NGojvrg8NQ8zQckQlgEOgOt67eJD7Nllcatny
         Ndof6jlzjntsw==
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: introduce fragment allocation mode
 mount option
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Daeho Jeong <daeho43@gmail.com>,
        Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20210902172404.3517626-1-daeho43@gmail.com>
 <YTvmhVhLlBPeASHT@google.com>
 <9f4a2954-e8c9-abc5-5df4-a7cec53433a3@kernel.org>
 <YUkR84sklj0SgosC@google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <6c592379-104d-8975-4385-9778f23cda56@kernel.org>
Date:   Wed, 22 Sep 2021 23:23:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YUkR84sklj0SgosC@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/9/21 6:57, Jaegeuk Kim wrote:
> On 09/12, Chao Yu wrote:
>> On 2021/9/11 7:13, Jaegeuk Kim wrote:
>>> Wait. Why do we need to add so many options here? I was expecting to see
>>> performance difference when getting random segments or random blocks as
>>> an extreme case. I don't get the point why we need the middle of those cases.
>>
>> I guess we can simply the aging test procedure of filesystem by changing a bit
>> based on this patch.
> 
> My question was on "fragment:fixed_block".

This mode can be used for below filesystem aging scenario.

Fragmenting filesystem with specified pattern:
1M chunk | 1M hole | 1M chunk | 1M hole | ...

e.g.

Before
1. create/write 10 1M files: file0 file1 file2 ... file9
2. remove file1 file3 file5 ... file9

After
mode=fragment:fixed_block
fragment_chunk_size=1M
fragment_hole_size=1M
1. create/write one 10M file

Thanks,

> 
>>
>> See comments in below thread.
>>
>> https://lore.kernel.org/lkml/425daf77-8020-26ce-dc9f-019d9a881b78@kernel.org/
>>
>> Thanks,
