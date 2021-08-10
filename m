Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46AF03E8686
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 01:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235542AbhHJXar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 19:30:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:53412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235414AbhHJXaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 19:30:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF6AE60551;
        Tue, 10 Aug 2021 23:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628638224;
        bh=qXqqVuYjXKpXw5v4+PCrqbY1ZfFdvKd0EthNnRwHiiU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=rDBruIydLEOrsMgZeC/KueX3urnTJSTmVoAI7jvjhjnCtJzCx8l8q9uyfKHeOlEUU
         QvL0vkLMUtULSjWKiHk3P5nzCYIZg8DfbuYetfU6U7UapaWD3RoPT0ZX5FqHOZY6IY
         dq+aH/+vl9dg9MaOHwtBXZz2xt2y7QBQBQJ8jtdzL2nasqjMHlUADDjDcYk44qDmio
         b6STbhE8wHmLtasZUzJHk0COCMu4Ueh+CLxZ+G9cSOiPxJZGCxBLBYiq/+6PksgMFL
         62yF2F2CRkBApYcSU3rHNUh/vs0LIAWdlc9upGxQdLWZ4XyjRUj2XF1QO/AQ4m7/sa
         r89XzH4PqHnGQ==
Subject: Re: [PATCH] erofs: remove the mapping parameter from
 erofs_try_to_free_cached_page()
To:     Yue Hu <zbestahu@gmail.com>, xiang@kernel.org,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, huyue2@yulong.com, zbestahu@163.com
References: <20210810072416.1392-1-zbestahu@gmail.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <1533fccf-f032-f390-3ec4-3f39612ab60d@kernel.org>
Date:   Wed, 11 Aug 2021 07:30:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210810072416.1392-1-zbestahu@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/10 15:24, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> The mapping is not used at all, remove it and update related code.
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

