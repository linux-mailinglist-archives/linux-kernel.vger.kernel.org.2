Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD53B401A68
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 13:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238840AbhIFLPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 07:15:35 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:46211 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232819AbhIFLPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 07:15:33 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UnRwFtM_1630926866;
Received: from B-D1K7ML85-0059.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0UnRwFtM_1630926866)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 06 Sep 2021 19:14:27 +0800
Subject: Re: [PATCH] ocfs2: avoid getting dlm lock of the target directory
 multiple times during reflink process
To:     Gang He <ghe@suse.com>, mark@fasheh.com, jlbec@evilplan.org
Cc:     linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        akpm@linux-foundation.org
References: <20210826075941.28480-1-ghe@suse.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <41bc413d-0926-0eae-6772-076314bbae53@linux.alibaba.com>
Date:   Mon, 6 Sep 2021 19:14:26 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210826075941.28480-1-ghe@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gang,


On 8/26/21 3:59 PM, Gang He wrote:
> During the reflink process, we should acquire the target directory
> inode dlm lock at the beginning, and hold this dlm lock until end
> of the function.
> With this patch, we avoid dlm lock ping-pong effect when clone
> files to the same directory simultaneously from multiple nodes.
> There is a typical user scenario, users regularly back up files
> to a specified directory through the reflink feature from the
> multiple nodes.
> 
Since now it take dir inode lock across the whole reflink, it may impact
other concurrent operations under the same directory.
Have you evaluated such cases?

Thanks,
Joseph


