Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144893D9B09
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 03:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbhG2BYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 21:24:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:35696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233216AbhG2BYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 21:24:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D5F5A6103A;
        Thu, 29 Jul 2021 01:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627521875;
        bh=zsscGp2pw3XigcjWcGqfP+E4pheV41KtdZi8NPO57rI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kaSgNl7lu5P6hqO+euR6hUW6g9kk2GX5sOF8VTP4zHFcNsxZANC1hH2Oqk+dBzv5k
         Hjsm8a2jIajLPs0b80dJWz5laDhD/bodv2mPiT7iY8zv+uNKcjoADD0oEwZqH/Y6dW
         tE310XTb8iuPD88i3W3/EJTWWZqKiJK5u8+CKJWs2OWXerJ89Kfm57yVyXnGIcYbMZ
         YKYCV79Kys/dic9Ca4NtMwOkalgnIIqumYjTSeebtGEhKtS3HHFc4m3Tgy+cGgCT0f
         BPRSKeMpMPspPTG05Yavsz+7LbP2pIyJ2qhisN5vi94VrrbMqCdrffqjthvkN+arIy
         vqAWwyry3uuYw==
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: turn back remapped address in
 compressed page endio
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
References: <20210728193811.2519412-1-daeho43@gmail.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <56598a72-92d8-b571-550a-26830d7f5b2f@kernel.org>
Date:   Thu, 29 Jul 2021 09:24:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210728193811.2519412-1-daeho43@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/29 3:38, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Turned back the remmaped sector address to the address in the partition,
> when ending io, for compress cache to work properly.
> 
> Fixes: 6ce19aff0b8c ("f2fs: compress: add compress_inode to cache
> compressed blocks")
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Youngjin Gil <youngjin.gil@samsung.com>
> Signed-off-by: Hyeong Jun Kim <hj514.kim@samsung.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
