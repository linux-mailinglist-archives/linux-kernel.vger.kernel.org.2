Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1ABE41067B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 14:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236333AbhIRMsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 08:48:46 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:48415 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235206AbhIRMsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 08:48:45 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Uon0NRt_1631969229;
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0Uon0NRt_1631969229)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 18 Sep 2021 20:47:10 +0800
Subject: Re: [PATCH v8 2/3] tty: hvc: pass DMA capable memory to put_chars()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Daniel Axtens <dja@axtens.net>, jirislaby@kernel.org,
        amit@kernel.org, arnd@arndb.de, osandov@fb.com,
        shile.zhang@linux.alibaba.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <20210818082122.166881-1-xianting.tian@linux.alibaba.com>
 <20210818082122.166881-3-xianting.tian@linux.alibaba.com>
 <87pmu8ehkk.fsf@linkitivity.dja.id.au>
 <6e36640d-b55f-ece4-4cab-437ecec0964a@linux.alibaba.com>
 <614b778b-8486-c20f-d5ed-37cc3b92ada1@linux.alibaba.com>
 <YUXeSUVQRDXzAqhf@kroah.com>
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
Message-ID: <9678a0e1-f80f-89af-e7a0-f52bd914384d@linux.alibaba.com>
Date:   Sat, 18 Sep 2021 20:47:09 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YUXeSUVQRDXzAqhf@kroah.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

thanks Greg, I will submit v9 patch for reviewing.

Before, I was waiting for a new reply:(

ÔÚ 2021/9/18 ÏÂÎç8:40, Greg KH Ð´µÀ:
> On Sat, Sep 18, 2021 at 08:32:01PM +0800, Xianting Tian wrote:
>> hi
>>
>> Will you consider to continue the disscussion of this patch? thanks
> I do not see a newer version of this series.
>
> thanks,
>
> greg k-h
