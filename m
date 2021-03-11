Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A956F3371C4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 12:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbhCKLuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 06:50:01 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:13146 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbhCKLti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 06:49:38 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Dx6cg50HWzmVyX;
        Thu, 11 Mar 2021 19:47:15 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 11 Mar
 2021 19:49:30 +0800
Subject: Re: [PATCH v2] f2fs: allow to change discard policy based on cached
 discard cmds
To:     Sahitya Tummala <stummala@codeaurora.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     <linux-kernel@vger.kernel.org>
References: <1615453148-30443-1-git-send-email-stummala@codeaurora.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <7d31f95b-d99f-b56a-8129-f65910f14cdf@huawei.com>
Date:   Thu, 11 Mar 2021 19:49:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1615453148-30443-1-git-send-email-stummala@codeaurora.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/11 16:59, Sahitya Tummala wrote:
> With the default DPOLICY_BG discard thread is ioaware, which prevents
> the discard thread from issuing the discard commands. On low RAM setups,
> it is observed that these discard commands in the cache are consuming
> high memory. This patch aims to relax the memory pressure on the system
> due to f2fs pending discard cmds by changing the policy to DPOLICY_FORCE
> based on the nm_i->ram_thresh configured.
> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> ---
> v2:
> - by mistake the last else condition was modified, fix it now.

Oh, yes,

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
