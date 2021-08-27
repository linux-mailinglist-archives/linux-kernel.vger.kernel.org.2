Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E24183F9AEF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 16:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238436AbhH0OhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 10:37:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:54434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233282AbhH0Og6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 10:36:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D99B66056C;
        Fri, 27 Aug 2021 14:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630074969;
        bh=z3xfp8u4+uJOQSeXp4ZKSEbEw8WZb1aXyFXJc6oIpG4=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=dYmTbIIQ3V/GB/pyfrw44fA+njyeg9YIDkkhKtbZOwMwmEyvY5i9gmTVNAnYzfp53
         o1scZZUjlKKZgDNGTlV96Kk5JRMqkWZEqsQI4zDYrLHsCOTgKRmCqzikmYYk1ngMQT
         2ObUaRu/jY8MqzTs9XCu6cOZ+GnP5UouxVjy7+RXW3cpuAPFsu0lYbgAWfLgZ1BI6P
         YzEnPV7ifnUUqFcPjeu57khSMpyqGYyiw4Qy1LH8p08XEOOUoINfMwW7cjuVSS/eoO
         6dYj0IGPQ4jflCvy8FikX45XEnISMUHI1HcVCnKtE3CueNq7TsKEJbFVPIjAQTAQU4
         4rGwtPj0o8CiQ==
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: don't ignore writing pages on fsync
 during checkpoint=disable
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20210823170151.1434772-1-jaegeuk@kernel.org>
 <YSa3DPBIFZ5P17vt@google.com> <YSfGwKtGhutsTJ8x@google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <e0869c6f-e261-01d0-92d2-abb1cc2957ee@kernel.org>
Date:   Fri, 27 Aug 2021 22:36:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YSfGwKtGhutsTJ8x@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/27 0:52, Jaegeuk Kim wrote:
>  From 64fe93a7f9c35c2b5a34cfa3cf84158852c201be Mon Sep 17 00:00:00 2001
> From: Jaegeuk Kim <jaegeuk@kernel.org>
> Date: Thu, 19 Aug 2021 14:00:57 -0700
> Subject: [PATCH] f2fs: guarantee to write dirty data when enabling checkpoint
>   back
> 
> We must flush all the dirty data when enabling checkpoint back. Let's guarantee
> that first by adding a retry logic on sync_inodes_sb(). In addition to that,
> this patch adds to flush data in fsync when checkpoint is disabled, which can
> mitigate the sync_inodes_sb() failures in advance.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
