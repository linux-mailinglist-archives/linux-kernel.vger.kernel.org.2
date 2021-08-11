Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089603E888B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 05:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbhHKDDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 23:03:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:41734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231967AbhHKDDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 23:03:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 88BAB60E78;
        Wed, 11 Aug 2021 03:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628650992;
        bh=ettOy+VFNs6f4ibXirUSZ/2TBEWAHyC8CfuGfsHZ0JE=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=kVIb7Q/+GLt6j+D+RdrReT22ZqppIsA6cr3kUYRR6ze5swSQ4yTitdTEu+yALrzHM
         Jr70+QKMTFvI/ZbOGh30Wam9boPndW0x2L20+l8fb04D7xXz0zMezNKFyafLAGcK/r
         8DTfqNR/DyLVAlGh7KrKhueKuxNkmEwxEbEfOk6aG8Ht3Axdh6McBDQN9MPpCtQKQJ
         8RDrcss6f7cCo0LvjpaNubeJDdsmry1yp/mw2k7qNR1amRLz/V2x2IHNau8sqwXot+
         56f3hPgeQJ/4oyHlKZTobhgqe/HGK5XWwNu7kSm0YsBxEHxJJ5NP7Hy5HMKmhMDRPF
         SyuaHIMk6LmmQ==
Subject: Re: [f2fs-dev] f2fs do DIO write make file corruption
To:     Wu Bo <bo.wu@vivo.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <5b68208b-fd94-bf4e-fc4b-d79d13abf1c6@vivo.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <6519b8b7-1eb0-f286-7593-5c5ebbfb5554@kernel.org>
Date:   Wed, 11 Aug 2021 11:03:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <5b68208b-fd94-bf4e-fc4b-d79d13abf1c6@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/11 10:48, Wu Bo wrote:
> I use the following command to create a file, the file may got corruption:
> 	f2fs_io write 2 0 512 inc_num dio $path
> 
> And when I use bio or to set the chunk size to 1 block, the file is
> normal. The commands as following:
> 	f2fs_io write 2 0 512 inc_num buffered $path
> 	f2fs_io write 1 0 512 inc_num dio $path
> 
> I find this bug on old kernel version 4.14.117, and not find on version
> 4.19.152. So this bug is fixed. Can anyone can tell me which patch fixed
> this bug?

Not sure,

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-4.19.y&id=7bae8b6b73e46c307fa355ce086800b7ad6610f8

Thanks,

> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
