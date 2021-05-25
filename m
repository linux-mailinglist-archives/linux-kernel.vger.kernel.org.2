Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 788E238FD9B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 11:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbhEYJUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 05:20:54 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6704 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbhEYJUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 05:20:51 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fq7jC3XPNzlYVQ;
        Tue, 25 May 2021 17:15:43 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 25 May 2021 17:19:19 +0800
Received: from [10.174.177.91] (10.174.177.91) by
 dggpemm500004.china.huawei.com (7.185.36.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 25 May 2021 17:19:18 +0800
Subject: Re: [PATCH -next] module: fix build error when CONFIG_SYSFS is
 disabled
To:     Stephen Boyd <swboyd@chromium.org>, <jeyu@kernel.org>
CC:     <sfr@canb.auug.org.au>, <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
References: <20210525085400.15854-1-cuibixuan@huawei.com>
 <CAE-0n522LiGxorhBXtqE2yj8ZKtnmVCikCPFV_iQp8MJzNA+Zg@mail.gmail.com>
From:   Bixuan Cui <cuibixuan@huawei.com>
Message-ID: <369cfa5a-87f6-b55a-dc32-f98751b4a780@huawei.com>
Date:   Tue, 25 May 2021 17:19:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAE-0n522LiGxorhBXtqE2yj8ZKtnmVCikCPFV_iQp8MJzNA+Zg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500004.china.huawei.com (7.185.36.219)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I will send a new, thanks.
