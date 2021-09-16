Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E01C40D1B6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 04:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbhIPCjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 22:39:09 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:16217 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbhIPCjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 22:39:08 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4H91SG1llfz1DGlJ;
        Thu, 16 Sep 2021 10:36:46 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 16 Sep 2021 10:37:47 +0800
Received: from [10.174.177.91] (10.174.177.91) by
 dggpemm500004.china.huawei.com (7.185.36.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 16 Sep 2021 10:37:47 +0800
Subject: Re: [PATCH -next] irqdomain: fix overflow error
To:     Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>
CC:     <maz@kernel.org>, <john.wanghui@huawei.com>
References: <20210908014623.61357-1-cuibixuan@huawei.com>
 <87o88vcqvh.ffs@tglx> <4f614b66-ad85-7fa3-6e6e-2a672e8148e3@huawei.com>
 <87pmtab7no.ffs@tglx>
From:   Bixuan Cui <cuibixuan@huawei.com>
Message-ID: <d77a76da-62fd-687f-cedb-198f393cff39@huawei.com>
Date:   Thu, 16 Sep 2021 10:37:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <87pmtab7no.ffs@tglx>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500004.china.huawei.com (7.185.36.219)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/9/15 15:49, Thomas Gleixner wrote:
> Appropriate is not really a technical reason. Making the code consistent
> is.
Agree, I'll change the message.

Thanks
Bixuan Cui
