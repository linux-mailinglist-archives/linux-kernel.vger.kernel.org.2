Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1C640BE4F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 05:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbhIODhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 23:37:12 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:16256 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbhIODhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 23:37:11 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4H8QpC1yLYz8t39;
        Wed, 15 Sep 2021 11:35:15 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 15 Sep 2021 11:35:52 +0800
Received: from [10.174.177.91] (10.174.177.91) by
 dggpemm500004.china.huawei.com (7.185.36.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 15 Sep 2021 11:35:51 +0800
Subject: Re: [PATCH -next] ASoC: mediatek: mt8195: Add missing of_node_put()
To:     Trevor Wu <trevor.wu@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <matthias.bgg@gmail.com>,
        <alsa-devel@alsa-project.org>
References: <20210911081246.33867-1-cuibixuan@huawei.com>
 <7a1af556bf3b7dda9f1be848d2631448a1155ec6.camel@mediatek.com>
From:   Bixuan Cui <cuibixuan@huawei.com>
Message-ID: <2b8a26ef-945a-e142-3f4d-039599198d9a@huawei.com>
Date:   Wed, 15 Sep 2021 11:35:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <7a1af556bf3b7dda9f1be848d2631448a1155ec6.camel@mediatek.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500004.china.huawei.com (7.185.36.219)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/9/15 11:07, Trevor Wu wrote:
> Thanks for catching that.
> I found there are other usages of of_parse_phandle() in the file.
> Will you handle them together?
> If not, I will prepare a patch to fix them after this patch is merged.
Hi,
You can send a v2 patch with your fixes base on my patch. The sign-off-by plus the two of us.

Thanks,
Bixuan Cui

> 
> Thanks,
> Trevor
