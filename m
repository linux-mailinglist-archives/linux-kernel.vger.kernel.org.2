Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B7D354FE5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 11:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbhDFJ35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 05:29:57 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:16347 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhDFJ34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 05:29:56 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FF2HY0s17z9wsQ;
        Tue,  6 Apr 2021 17:27:37 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 6 Apr 2021
 17:29:46 +0800
Subject: Re: [PATCH v2] f2fs: fix the periodic wakeups of discard thread
To:     Sahitya Tummala <stummala@codeaurora.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     <linux-kernel@vger.kernel.org>
References: <20210316093406.GC8562@codeaurora.org>
 <1617700156-19719-1-git-send-email-stummala@codeaurora.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <f2197598-510b-dded-ffef-42203a101b1b@huawei.com>
Date:   Tue, 6 Apr 2021 17:29:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1617700156-19719-1-git-send-email-stummala@codeaurora.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/6 17:09, Sahitya Tummala wrote:
> Fix the unnecessary periodic wakeups of discard thread that happens under
> below two conditions -
> 
> 1. When f2fs is heavily utilized over 80%, the current discard policy
> sets the max sleep timeout of discard thread as 50ms
> (DEF_MIN_DISCARD_ISSUE_TIME). But this is set even when there are
> no pending discard commands to be issued.
> 
> 2. In the issue_discard_thread() path when there are no pending discard
> commands, it fails to reset the wait_ms to max timeout value.
> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
