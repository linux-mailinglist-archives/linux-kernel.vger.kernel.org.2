Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81FE5379CCD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 04:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhEKCRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 22:17:55 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:46707 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230398AbhEKCRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 22:17:54 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UYUn5Xl_1620699407;
Received: from B-D1K7ML85-0059.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0UYUn5Xl_1620699407)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 11 May 2021 10:16:48 +0800
Subject: Re: [Ocfs2-devel] [PATCH v2] ocfs2: Reomve err less than zero check
To:     Wengang Wang <wen.gang.wang@oracle.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        akpm <akpm@linux-foundation.org>
References: <1620643062-124920-1-git-send-email-jiapeng.chong@linux.alibaba.com>
 <1EED85DE-EFE1-4FBA-9AA5-648D8E586DD9@oracle.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <2c9b7d34-01b9-d7de-2334-5d684d29d4eb@linux.alibaba.com>
Date:   Tue, 11 May 2021 10:16:47 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <1EED85DE-EFE1-4FBA-9AA5-648D8E586DD9@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




On 5/10/21 11:50 PM, Wengang Wang wrote:
> Hi Jiapeng,
> 
> Though the type of enum dlm_status has a value range starting from zero,  It can be assigned with negative values without warnings.
> I am wondering why you are sure it can’t be negative?  You went over all the calling path and so you are sure it can’t be negative?
> If you did that, I’d think/guess you should also be able to say it can’t be DLM_MAXSTATS or bigger, right? If not, which calling path are returning >= DLM_MAXSTATS value?
> we should fix that too.
> 
> I’d think we should treat the two conditions of (err >= DLM_MAXSTATS) and the (err < 0) the same way.  If keep, keep both. if remove, remove both.
> I’m suspecting the coccicheck warning is based on the type of enum (starting with 0), but if that’s the only theory to remove (err < 0), It’s NAK from me
DLM_MAXSTATS is a valid value for dlm_status.
Take a look again, I agree with Wengang that we'd better keep the check
here for those misused return code.

Thanks,
Joseph 
