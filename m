Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7AC83DCA77
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 09:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbhHAHEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 03:04:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:54078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229491AbhHAHEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 03:04:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 248A1601FC;
        Sun,  1 Aug 2021 07:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627801439;
        bh=GC5kyfNHf0uebyQTOXFEbg26ZhVQQXtbrK2nbuuOZyc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lXWT+EDRqJ17uyfPuxC4HACMEsAKTP+Vce6lFEWAnpOJ3n8oba0vKI65E2hW+f6yU
         SdhhN5aisKocX+zvBBQF3gXes4KLsyeaB78z5sY2jQMujl8+WHTq3kuA4LZ+62Lbq3
         OG37nJmtfh2ieYuhRnEfzAfM0doOQEaaG1eP5VTzAJ5WVdZg5sSBXWH38nPJviBgGQ
         xfa0W3huyceFHPNiQem5jLLYt8NFb4DBZfTI4ODyEB3rFU2NMtpiZntLYQTZlsI+Aw
         UPUeDIROqFdbVJIJEE4kYuhe9LELGwtxeBBIfR8ZHj/nnVR/tHlIdDKykFMANbF86S
         Wrbn1os3+0AkQ==
Subject: Re: [RFC NO MERGE] f2fs: extent cache: support unaligned extent
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@linux.dev>
References: <20210707015815.1978-1-chao@kernel.org>
 <YQRQ4kHvdRTBnb10@google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <51565c85-a475-bcb8-bbb2-e3125c5223a3@kernel.org>
Date:   Sun, 1 Aug 2021 15:03:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQRQ4kHvdRTBnb10@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/31 3:20, Jaegeuk Kim wrote:
> On 07/07, Chao Yu wrote:
>> Currently, it only works in readonly format f2fs image.

There wouldn't be any race condition because unaligned extent only works
for ro feature now?

> Is there any race condition between the address in extent_cache and the one in
> dnode? I feel that we could synchronize it by locking its dnode block.

Thanks,
