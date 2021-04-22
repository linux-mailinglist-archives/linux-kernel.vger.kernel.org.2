Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36580368489
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 18:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238006AbhDVQOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 12:14:16 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2909 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbhDVQOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 12:14:12 -0400
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FR2Mt41dYz6slNQ;
        Fri, 23 Apr 2021 00:06:02 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 22 Apr 2021 18:13:36 +0200
Received: from [10.47.95.78] (10.47.95.78) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 22 Apr
 2021 17:13:35 +0100
To:     Thomas Gleixner <tglx@linutronix.de>
From:   John Garry <john.garry@huawei.com>
Subject: Question on threaded handlers for managed interrupts
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <b8c4be8c-1d67-c16c-570e-d3c883c77ea2@huawei.com>
Date:   Thu, 22 Apr 2021 17:10:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.95.78]
X-ClientProxiedBy: lhreml748-chm.china.huawei.com (10.201.108.198) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

I am finding that I can pretty easily trigger a system hang for certain 
scenarios with my storage controller.

So I'm getting something like this when running moderately heavy data 
throughput:

Starting 6 processes
[70.656622] sched: RT throttling activatedB/s][r=356k,w=0 IOPS][eta
01h:14m:43s]
[  207.632161] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:ta
01h:12m:26s]
[  207.638261] rcu:  0-...!: (1 GPs behind)
idle=312/1/0x4000000000000000 softirq=508/512 fqs=0
[  207.646777] rcu:  1-...!: (1 GPs behind) idle=694/0/0x0

It ends pretty badly - see [0].

The multi-queue storage controller (see [1] for memory refresh, but note 
that I can also trigger on PCI device host controller as well) is using 
managed interrupts and threaded handlers. Since the threaded handler 
uses SCHED_FIFO, aren't we always vulnerable to this situation with the 
managed interrupt and threaded handler combo? Would the advice be to 
just use irq polling here?

I unsuccessfully tried to trigger the same on NVMe PCI - however I have 
only 1x card, so hardly overloading the system.

Thanks,
John

[0] 
https://lore.kernel.org/rcu/412926e8-d3e1-3071-8cb9-098a7f49b64c@huawei.com/T/#mbd60463c543e04f87090d89301e1a5f10de958dd

[1] 
https://lore.kernel.org/linux-scsi/1606905417-183214-1-git-send-email-john.garry@huawei.com/#t
