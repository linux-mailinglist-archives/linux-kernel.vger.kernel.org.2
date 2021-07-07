Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 537D33BE181
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 05:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbhGGDVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 23:21:55 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:14028 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbhGGDVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 23:21:53 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GKPhK3JbnzZmd2;
        Wed,  7 Jul 2021 11:16:01 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (7.185.36.74) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 7 Jul 2021 11:18:57 +0800
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Wed, 7 Jul 2021
 11:18:56 +0800
Subject: Re: [PATCH 0/2] tools/virtio: fix compilation
To:     =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>,
        <mst@redhat.com>, <linux-kernel@vger.kernel.org>
CC:     Matthew Wilcox <willy@infradead.org>,
        Jason Wang <jasowang@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
References: <20210706142632.670483-1-eperezma@redhat.com>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <38e101ff-c4aa-2a53-436e-f9710e575de1@huawei.com>
Date:   Wed, 7 Jul 2021 11:18:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20210706142632.670483-1-eperezma@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggeme710-chm.china.huawei.com (10.1.199.106) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/6 22:26, Eugenio Pérez wrote:
> Virtio testing tools cannot build. Fixing.
> 
> 
> 
> Comments are welcome, specially in case I missed use of stub lockdep.h.
> 
> 
> 
> I couldn't try some of the tools, that already did not compile on 5.13:
> 
> gpio, liblockdep, selftests, bpf, tracing.

This patchset fixes the compilation error explicitly.
My previous refactor patchset seems to fixes the compilation error
accidentally too.

Anyway it seems better to fix the compilation error explicitly.

> 
> 
> 
> Eugenio Pérez (2):
> 
>   tools: Remove lockdep.h and its include from spinlock.h
> 
>   vringh: Include spinlock.h
> 
> 
> 
>  include/linux/vringh.h                   |  1 +
> 
>  tools/include/linux/spinlock.h           |  2 --
> 
>  tools/testing/radix-tree/linux/lockdep.h | 11 -----------
> 
>  3 files changed, 1 insertion(+), 13 deletions(-)
> 
>  delete mode 100644 tools/testing/radix-tree/linux/lockdep.h
> 
> 
> 
