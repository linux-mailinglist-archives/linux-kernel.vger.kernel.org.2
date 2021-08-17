Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6233EE0FA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 02:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235287AbhHQAfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 20:35:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:34262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232911AbhHQAfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 20:35:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 680E160F39;
        Tue, 17 Aug 2021 00:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629160469;
        bh=E0NfnEyiTSyWDge60fnhZNw6CHy7zGw8qtpGLglIxc0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Yn/zSxFl5u93MbNSH3rfMndlBIiIsqXQn6RgnRyNVWPvbj7WycdsB4UDE3+zgjJZe
         qG1aMjWShRPQT2+F3K1t2xsksGrVMg0u/MmhoSr6/l3jayu09+HS+Gep5n0dArY5iL
         MeWcuNRcJBd84wG679xJ9fS/UGiJK0m3dlUkdnY83z35LbAnIlLN+fq2cuZ0AjdkVm
         e+FeI8NFAMQSzcEEkcxQRABTMTj9jVqq56LLX03pMoBQHZ7Imbb4cHk7TD/1wbAcCE
         0t9GfGtDTgJY0OmZtuxE6p1rFxWHl3wlhNMicXPMXQvj61lWwDJhx+hCImEgmwIuYN
         2y4DEi21A3RGw==
Subject: Re: [PATCH] f2fs: Add missing inline to f2fs_sanity_check_cluster()
 stub
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20210816234247.139528-1-nathan@kernel.org>
 <YRsD6P4x9v38oDWl@google.com>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <1f2eff07-f003-03c8-b3c8-0e06f9bf9684@kernel.org>
Date:   Mon, 16 Aug 2021 17:34:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YRsD6P4x9v38oDWl@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/2021 5:33 PM, Jaegeuk Kim wrote:
> Hi Nathan,
> 
> On 08/16, Nathan Chancellor wrote:
>> Without this, there is a warning in nearly every fs/f2fs/ file when
>> F2FS_FS_COMPRESSION is not set:
>>
>> In file included from fs/f2fs/super.c:31:
>> fs/f2fs/f2fs.h:4251:13: warning: unused function 'f2fs_sanity_check_cluster' [-Wunused-function]
>> static bool f2fs_sanity_check_cluster(struct dnode_of_data *dn) { return false; }
>>              ^
>> 1 warning generated.
>>
>> Fixes: 1495870233e7 ("f2fs: compress: do sanity check on cluster")
> 
> This has not been merged yet, so if you don't mind, can I integrate your fix in
> the original patch?

Sure thing!

Cheers,
Nathan
