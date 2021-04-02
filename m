Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB90352506
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 03:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbhDBBRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 21:17:50 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:16322 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbhDBBRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 21:17:48 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FBMYm0V77z9vLq;
        Fri,  2 Apr 2021 09:15:40 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.498.0; Fri, 2 Apr 2021
 09:17:41 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: set checkpoint_merge by default
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
References: <20210402004225.1677382-1-jaegeuk@kernel.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <99fb34f8-3e89-dcb3-f7d9-17a37a57f0ca@huawei.com>
Date:   Fri, 2 Apr 2021 09:17:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210402004225.1677382-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/2 8:42, Jaegeuk Kim wrote:
> Once we introduced checkpoint_merge, we've seen some contention w/o the option.
> In order to avoid it, let's set it by default.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
