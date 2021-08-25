Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 692CA3F74E3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 14:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240227AbhHYMRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 08:17:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:59558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239788AbhHYMRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 08:17:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A4557610FD;
        Wed, 25 Aug 2021 12:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629893794;
        bh=8txebq8fSyFq9pJPKAVpvF0kEw0g630jQsSaz3xAq3o=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=h5qKEgXnotyvqKxZ5Y+Ly3/g6TTwGv7Jfu2XfFir0LNdgR9n1M5+spTMZPoUMvqh0
         VYsBpbGo5wYkD6ueWPHRg1EExHJ/7VRV7WjhGtxO8OYt71YXBR+GzZMBWvJMJfz/HK
         DhRhu2jIA+gQo1i7xEVzl9PzRPPQl55R8B6QnX9nr1+ZtoZLOxnig7ufqm/ElYHYx9
         g9YkUHeEo7VfwH0K1eRkIn+RtbjswXK9GL5h2LWiwjYN1gPzxA4edy9GU0pciSC0y2
         xVaaABRKN/U0ij876m7ZXHAQ2jaGKaGgVKQVJjilLueL0rhKFb5zel+ddhuevUW+rz
         jC0wN+V18BUHg==
Subject: Re: [PATCH] erofs: fix double free of 'copied'
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org, Liu Bo <bo.liu@linux.alibaba.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20210825120757.11034-1-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <7b9600f5-c968-3d97-af36-382fa6f0df32@kernel.org>
Date:   Wed, 25 Aug 2021 20:16:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210825120757.11034-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/25 20:07, Gao Xiang wrote:
> Dan reported a new smatch warning [1]
> "fs/erofs/inode.c:210 erofs_read_inode() error: double free of 'copied'"
> 
> Due to new chunk-based format handling logic, the error path can be
> called after kfree(copied).
> 
> Set "copied = NULL" after kfree(copied) to fix this.
> 
> [1] https://lore.kernel.org/r/202108251030.bELQozR7-lkp@intel.com
> Fixes: c5aa903a59db ("erofs: support reading chunk-based uncompressed files")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
