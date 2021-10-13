Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B8B42C2B5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 16:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbhJMOTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 10:19:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:36522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229562AbhJMOTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 10:19:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB85D60F4A;
        Wed, 13 Oct 2021 14:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634134634;
        bh=xGaUNIV0JKCxDoZu8SaySJLNpamLkm5J0/iXLpj5oJ4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fV7TI00+eX44IfKk43MRiPWw5rHehObyw2gsMLdynvyHhM7Bx+TChWOLGcPqWQJG2
         /CXcQxGIR5ObaCM8iH9OyAJlr6L+hzpsclbrm8p2GCFJRSzBqNRAVmfWTOF53dGrf3
         lVHHk513wRQoOiQOgFxR+2Q2E0GIE0BMK/da3bwp2aETMan2SrnFHLdkW2/1kDBNdv
         Gxtmo23g8eQt+0OpBCbREiQ4yJVnKei/8jzLvYecRJja++ucvCX8MtK6lIxl8wfP3B
         c16idrtcnNcSpDpae/vbjCo4gIMQo9dXsskVfrPuHYF14ufeizfiscnRzaUSoqqm8d
         F1Wd7kCqB06uw==
Message-ID: <16840026-35ba-cce6-4e0b-3332b0902d2a@kernel.org>
Date:   Wed, 13 Oct 2021 22:17:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [f2fs-dev] [PATCH] f2fs: include non-compressed blocks in
 compr_written_block
Content-Language: en-US
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
References: <20211006174910.2964885-1-daeho43@gmail.com>
 <5743eeca-a6e8-87d4-5799-c622fbada429@kernel.org>
 <CACOAw_zfDZMB4pLEuHWU5YcKnAtfBBTSuXwXy+L2rNJxXC3ysg@mail.gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <CACOAw_zfDZMB4pLEuHWU5YcKnAtfBBTSuXwXy+L2rNJxXC3ysg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/10/12 0:02, Daeho Jeong wrote:
>>> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
>>> index c1bf9ad4c220..9b663eaf4805 100644
>>> --- a/fs/f2fs/compress.c
>>> +++ b/fs/f2fs/compress.c
>>> @@ -1530,6 +1530,7 @@ int f2fs_write_multi_pages(struct compress_ctx *cc,
>>>        if (cluster_may_compress(cc)) {
>>>                err = f2fs_compress_pages(cc);
>>>                if (err == -EAGAIN) {
>>> +                     add_compr_block_stat(cc->inode, cc->cluster_size);
>>
>> Shouldn't we relocate this after 'write' label?
>>
>> One more concern, it looks we've changed what compr_block stat indicated,
>> literally, the block we account should be compressed..., how about accounting
>> it by introducing .presist_blocks, used_blocks or occupied_blocks.... thoughts?
>>
> 
> What I wanted to add here is just one case in which compression was
> tried, but couldn't save any block, so gave up.
> If we put this below the "write" label, we will count blocks, even if
> the file is turned off for compression in "user-controlled
> compression" mode.
> Like the commit comment says, I want to estimate the overall compression rate.
> But, if we include every other compression disabled condition, it
> won't work like that.

Got it, thanks for the explanation.

Any thoughts about renaming compr_block? since some blocks accounted in
.compr_block weren't compressed blocks.

Thanks,

> 
> Thanks,
> 
