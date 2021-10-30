Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C29F5440A49
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 18:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhJ3QzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 12:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbhJ3QzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 12:55:02 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF37C061570
        for <linux-kernel@vger.kernel.org>; Sat, 30 Oct 2021 09:52:32 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id b10so4553898ilj.10
        for <linux-kernel@vger.kernel.org>; Sat, 30 Oct 2021 09:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uKmeXVvNm8StHsQLA79AzT8JNuEz/eDwn91O5B3XSkE=;
        b=ar9OTyzBuJxbi6PIxQQodk9zcx/k4xqxnHogwSHSRBkYiYx1hLWOGGnQwGilXK+Zwq
         OH5EYRhOGSFz+SspDZvuvpdTgYW/7mU15trdTQgMZsLEdqc+7jNpxA2qG4CjVfwSmH8T
         tqD09/VgsD8ws2cIiRHlQnZVkusXipKluZVi5Q4FNg/xMsx4XYZRky/pk1OJFGm9WBNf
         swy56HJp6UdHnY+CbFELByaYUehCkpNxrIyggmZC4Yyhp2XcaIZEl6zWoTImE+mTyL6A
         uMrgvobZXuGrYACsesZbz341IW4/6fgvBZjvAqRrsakXfaUy9m+GJ1jVAodP9WtP/j3k
         bBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uKmeXVvNm8StHsQLA79AzT8JNuEz/eDwn91O5B3XSkE=;
        b=YTz75EzisCY42YQjs4PTOY9dcpT50oTDZCTJooQiNgoLQcdN5lMwEXnjQ14j5EB38S
         UHDi/RSkVC5zusJO085JX24fDrLpm7jMWdXSzWtgm84ajUy48uLY2Bi3XJRfREf4cK9E
         T1XcdtwGijgaLUmY/3UZWvY4LE6PU3ZWP2F22fjYGF/09VsHn5XOdFphiy/9k2OopqGZ
         nOm8jtVr3KQLvP5rc6pVvElpqLypN/aHG3xp8DfeC2hqJR5jhlDWHk1Y7OxvDfS5xpV6
         ENzGje9A6SrpcZ5X7dY3jBr67T6zQHwuKBlUunG9pnSJkpVMziKkx69b5AZ4umYDZk6H
         3YDg==
X-Gm-Message-State: AOAM533IP2P3PyOHiFL65fG/V8iWOWthPDyVtST9nRZnAKBbSY8A83JU
        JTr7sd2tOAEq32vworQYaWbJEisihXDDlg==
X-Google-Smtp-Source: ABdhPJx0mHeS1DRVQRoNhgzmgPhExhE6GgEzggjZwNXln1JAj+wIhqwoVbf253ExoRhI/3/JPzW6bw==
X-Received: by 2002:a92:ca0e:: with SMTP id j14mr13052965ils.131.1635612751153;
        Sat, 30 Oct 2021 09:52:31 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id y6sm1671428ilu.38.2021.10.30.09.52.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Oct 2021 09:52:30 -0700 (PDT)
Subject: Re: [axboe-block:for-5.16/passthrough-flag 136/159]
 fs/fs-writeback.c:1896:15: error: 'struct task_struct' has no member named
 'plug'
To:     kernel test robot <lkp@intel.com>, Christoph Hellwig <hch@lst.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202110310058.oh2LK0CJ-lkp@intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c22aff75-63c7-9fee-44b4-4333dce589ab@kernel.dk>
Date:   Sat, 30 Oct 2021 10:52:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202110310058.oh2LK0CJ-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/21 10:24 AM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-5.16/passthrough-flag
> head:   0bf6d96cb8294094ce1e44cbe8cf65b0899d0a3a
> commit: 008f75a20e7072d0840ec323c39b42206f3fa8a0 [136/159] block: cleanup the flush plug helpers
> config: x86_64-randconfig-s022-20211028 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.4-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?id=008f75a20e7072d0840ec323c39b42206f3fa8a0
>         git remote add axboe-block https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
>         git fetch --no-tags axboe-block for-5.16/passthrough-flag
>         git checkout 008f75a20e7072d0840ec323c39b42206f3fa8a0
>         # save the attached .config to linux build tree
>         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):

This got fixed by:

commit 599593a82fc57f5e9453c8ef7420df3206934a0c
Author: Jens Axboe <axboe@kernel.dk>
Date:   Fri Oct 22 19:35:45 2021 -0600

    sched: make task_struct->plug always defined

it's just that for-5.16/passthrough-flag was forked off before that commit
ended up in for-5.16/block. This report can be ignored.

-- 
Jens Axboe

