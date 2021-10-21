Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 947A2435D72
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 10:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbhJUI66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 04:58:58 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:4159 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231461AbhJUI64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 04:58:56 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Ut7VcNC_1634806588;
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0Ut7VcNC_1634806588)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 21 Oct 2021 16:56:29 +0800
Subject: Re: [PATCH v11 0/3] make hvc pass dma capable memory to its backend
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jirislaby@kernel.org, amit@kernel.org, arnd@arndb.de,
        osandov@fb.com, shile.zhang@linux.alibaba.com,
        linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20211015024658.1353987-1-xianting.tian@linux.alibaba.com>
 <YXEmW071C+GlmXqw@kroah.com>
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
Message-ID: <16ffdf1c-7ea9-7466-fcc5-7e6b09ca5a28@linux.alibaba.com>
Date:   Thu, 21 Oct 2021 16:56:28 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YXEmW071C+GlmXqw@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am very glad to get this reply:)

Thank you and other experts' kindly help and guide, which improved me a lot.

在 2021/10/21 下午4:35, Greg KH 写道:
> On Fri, Oct 15, 2021 at 10:46:55AM +0800, Xianting Tian wrote:
>> Dear all,
>>
>> This patch series make hvc framework pass DMA capable memory to
>> put_chars() of hvc backend(eg, virtio-console), and revert commit
>> c4baad5029 ("virtio-console: avoid DMA from stack”)
> Thanks for sticking with this, looks much better now, all now queued up.
>
> greg k-h
