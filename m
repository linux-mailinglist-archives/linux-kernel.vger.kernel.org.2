Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5FAB3DFC39
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 09:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235932AbhHDHld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 03:41:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:42866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235912AbhHDHlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 03:41:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D80B860BD3;
        Wed,  4 Aug 2021 07:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628062879;
        bh=Pm6fYyTmBfc6cqn8GdKXA+qPcfd/g6gN0afm3nZoctg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JL7zGSXgQcWrdXFmQXVBEIe74njilMYnBBrxniUqQurLN/tNbmRd6Zfg9zZ7h+gjy
         v4jDPZhEIZnY8OzhV6p4GW7Key2mXWJgFXxEv/ExTi0SIaw0ORRc5Zl+5ynfEaJdrY
         856n5kfKoTHqS6rh12U18VVa9nmBoBNLTQqJOyLoBLf4KOHXMCjiRqwjKX4hmRpSge
         KfugJAzjTAydSrtYgS04hn1kc81d26/FgQi/2FWqleVGF2VRqUTUIQ/unDOCIrYX3N
         i1xKfK8diXXcOQojmOKvvoOAsvJpGYTNiW7ZyOoeG5c3CM8NTcBZ14eQlWUnnluI4f
         W//MzhI8+G8cQ==
Subject: Re: [RFC v2] f2fs: extent cache: support unaligned extent
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@linux.dev>
References: <20210803023912.26667-1-chao@kernel.org>
 <YQnzJojWyVrNf9op@google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <2cd44682-4e50-24c0-0f56-5f6aaf827e48@kernel.org>
Date:   Wed, 4 Aug 2021 15:41:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQnzJojWyVrNf9op@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/4 9:53, Jaegeuk Kim wrote:
>> +#ifdef CONFIG_F2FS_FS_COMPRESSION
> 
> Can remove this by if (unaligned)?
> 
>> +	if (unaligned)
>> +		en->plen = ((struct extent_info_unaligned *)ei)->plen;

struct extent_info_unaligned should be covered by CONFIG_F2FS_FS_COMPRESSION.

>>   static inline bool __is_extent_mergeable(struct extent_info *back,
>> -						struct extent_info *front)
>> +				struct extent_info *front, bool unaligned)
>>   {
>> +#ifdef CONFIG_F2FS_FS_COMPRESSION
> 
> This can be controlled by "bool unaligned"?

Ditto,

> 
>> +	struct extent_info_unaligned *be = (struct extent_info_unaligned *)back;
>> +	struct extent_info_unaligned *fe = (struct extent_info_unaligned *)front;
>> +
>> +	if (unaligned && (be->ei.len != be->plen || fe->ei.len != fe->plen))
>> +		return false;
>> +#endif

Thanks,
