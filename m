Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD173FC3CB
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 10:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239944AbhHaHk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 03:40:58 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:52202 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239753AbhHaHk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 03:40:57 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UmjUpSh_1630395599;
Received: from B-D1K7ML85-0059.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0UmjUpSh_1630395599)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 31 Aug 2021 15:40:00 +0800
Subject: Re: [PATCH] ocfs2: avoid getting dlm lock of the target directory
 multiple times during reflink process
To:     Gang He <ghe@suse.com>, mark@fasheh.com, jlbec@evilplan.org
Cc:     linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        akpm@linux-foundation.org
References: <20210826075941.28480-1-ghe@suse.com>
 <744d756c-7640-d312-37ef-126755324e8a@suse.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <abe27a3a-efde-660c-4d9c-d659eba3eab1@linux.alibaba.com>
Date:   Tue, 31 Aug 2021 15:39:59 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <744d756c-7640-d312-37ef-126755324e8a@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/31/21 2:25 PM, Gang He wrote:
> Hello Joseph and Wengang,
> 
> When you have time, please help review this patch.
> About the deadlock problem which was caused by ocfs2_downconvert_lock failure, we have the fix patch, it is very key.
> But I feel this patch is still useful as a optimization patch, the user
> case is to reflink the files to the same directory concurrently, our users usually backup the files(via reflink) from the cluster nodes concurrently(via crontab) every day/hour.
> The current design, during the reflink process, the node will acquire/release dlm lock of the target directory multiple times,
> this is very inefficient in concurrently reflink.
> 

Sure, I'll spend some time this week.

Thanks,
Joseph
