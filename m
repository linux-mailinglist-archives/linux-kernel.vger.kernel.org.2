Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A45843F74A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 08:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbhJ2GiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 02:38:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232123AbhJ2GiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 02:38:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ACD37610D2;
        Fri, 29 Oct 2021 06:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635489329;
        bh=6L9d1Ezd7kwg1IfsoMHgf5b33hOvvWq/PQqAlZkeHGQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QwfsIJwdYqVryW06h3c2Cl2KR/HVsN9j2EldZP6281F0uToZh5uk6lc+bcpKBdg4q
         W21CAt06HgStIj1Xm/xdTNy5lmVF3rcFKL6QtezOKJT8uSLWrt6ccTjeP+uf0+zf2D
         TpMLWOVsDeJiJya8ecwnITd7ZksWTXZvY4jgY4f96+VYNxejUKMu/GkS272g1hfSP8
         yfKquY1PkIrOkVyfzv7BkNWvDZSOLqV0hXfHz2UqUWKzSr4KAQF0JqGALs5ybUimpi
         PROFyblGoPfChL6TWRp9O+uhs4TGTGMv8qC9J3iqx65LnMtqZB3cICYQDelyr/aB5G
         9Z5vB7q0l2LAQ==
Message-ID: <b169d1ba-54c9-7195-6190-9d10ffb44530@kernel.org>
Date:   Fri, 29 Oct 2021 14:35:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH] erofs: don't trigger WARN() when decompression fails
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzbot+d8aaffc3719597e8cfb4@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>
References: <20211025074311.130395-1-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20211025074311.130395-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/10/25 15:43, Gao Xiang wrote:
> syzbot reported a WARNING [1] due to corrupted compressed data.
> 
> As Dmitry said, "If this is not a kernel bug, then the code should
> not use WARN. WARN if for kernel bugs and is recognized as such by
> all testing systems and humans."
> 
> [1] https://lore.kernel.org/r/000000000000b3586105cf0ff45e@google.com
> Reported-by: syzbot+d8aaffc3719597e8cfb4@syzkaller.appspotmail.com
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Chao Yu <chao@kernel.org>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
