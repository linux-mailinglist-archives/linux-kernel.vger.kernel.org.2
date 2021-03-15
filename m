Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D98233B127
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 12:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbhCOLaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 07:30:01 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13537 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbhCOL3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 07:29:42 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DzYzn4CgBzNnCN;
        Mon, 15 Mar 2021 19:27:17 +0800 (CST)
Received: from [127.0.0.1] (10.40.192.131) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.498.0; Mon, 15 Mar 2021
 19:29:31 +0800
Subject: Re: [PATCH v1] ata: ahci: Disable SXS for Hisilicon Kunpeng920
To:     Jens Axboe <axboe@kernel.dk>
CC:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>, <john.garry@huawei.com>,
        <yangxingui@huawei.com>
References: <1615544676-61926-1-git-send-email-luojiaxing@huawei.com>
 <c1ef5207-96a4-e7f1-68ac-f95ab0b0f5d2@kernel.dk>
From:   luojiaxing <luojiaxing@huawei.com>
Message-ID: <06094d83-2083-09ad-5948-718cfbe4579b@huawei.com>
Date:   Mon, 15 Mar 2021 19:29:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <c1ef5207-96a4-e7f1-68ac-f95ab0b0f5d2@kernel.dk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.40.192.131]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/3/12 22:27, Jens Axboe wrote:
> Is this controller arm exclusive?


Yes, our SoC is base on ARM64 only.


Thanks

Jiaxing


