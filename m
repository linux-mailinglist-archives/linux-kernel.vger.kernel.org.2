Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC073FC083
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 03:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239293AbhHaBhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 21:37:09 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:15274 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235217AbhHaBhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 21:37:08 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Gz8sG4FB1z89mF;
        Tue, 31 Aug 2021 09:35:46 +0800 (CST)
Received: from dggema764-chm.china.huawei.com (10.1.198.206) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 31 Aug 2021 09:36:07 +0800
Received: from [10.174.185.179] (10.174.185.179) by
 dggema764-chm.china.huawei.com (10.1.198.206) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Tue, 31 Aug 2021 09:36:05 +0800
Subject: Re: [PATCH] drm: remove zxdrm driver
To:     Rob Herring <robh@kernel.org>, Daniel Vetter <daniel@ffwll.ch>
CC:     Thomas Zimmermann <tzimmermann@suse.de>,
        Arnd Bergmann <arnd@arndb.de>, <wanghaibin.wang@huawei.com>,
        Jun Nie <jun.nie@linaro.org>, David Airlie <airlied@linux.ie>,
        Shawn Guo <shawnguo@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        <devicetree@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
References: <20210821031357.289-1-yuzenghui@huawei.com>
 <YSPuMqd1QgnRIVCB@robh.at.kernel.org> <YSddYSKvGneVKNjW@phenom.ffwll.local>
 <CAL_Jsq+gapHO79i1BY8AhCJX6H67FgLmZV7xXcjBn9yY4q=6iQ@mail.gmail.com>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <c1f2cf72-d0df-578b-ec33-925147c75059@huawei.com>
Date:   Tue, 31 Aug 2021 09:36:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+gapHO79i1BY8AhCJX6H67FgLmZV7xXcjBn9yY4q=6iQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.185.179]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema764-chm.china.huawei.com (10.1.198.206)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/31 0:12, Rob Herring wrote:
> On Thu, Aug 26, 2021 at 4:22 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>>
>> I just merged another patch to delete the zte driver.
> 
> Unfortunately, that one missed the binding doc, so please send me a
> patch removing the binding doc.

Okay I'll send it out today.

I've searched the patch [*] on dri-devel list to make sure we're
talking about the same thing.

[*] 
https://lore.kernel.org/r/20210819112253.16484-5-lukas.bulwahn@gmail.com/

Zenghui
