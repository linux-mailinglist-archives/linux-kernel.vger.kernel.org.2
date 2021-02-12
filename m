Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5CA3319B63
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 09:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhBLIle convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 12 Feb 2021 03:41:34 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:4627 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbhBLIlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 03:41:03 -0500
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4DcRjm3md3zY7bG;
        Fri, 12 Feb 2021 16:38:52 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 12 Feb 2021 16:40:09 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi761-chm.china.huawei.com (10.1.198.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Fri, 12 Feb 2021 16:40:09 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.006;
 Fri, 12 Feb 2021 16:40:09 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
CC:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        "sjenning@linux.vnet.ibm.com" <sjenning@linux.vnet.ibm.com>,
        "Linux List Kernel Mailing" <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: RE: kernel BUG at mm/zswap.c:1275! (rc6 - git 61556703b610)
Thread-Topic: kernel BUG at mm/zswap.c:1275! (rc6 - git 61556703b610)
Thread-Index: AQHXAFP/pTUK4Kj84UiROgFUcTG6DapSwoOggADb+QCAAJRVcA==
Date:   Fri, 12 Feb 2021 08:40:09 +0000
Message-ID: <1ad147ed4e71406698f5df9305acfe38@hisilicon.com>
References: <CABXGCsNEUpv9x93UeCa-wOjE0LgUdTCY2FTABJeFL=gGq4SX_g@mail.gmail.com>
 <2538f4c21dd2405aac2abb776047a0fa@hisilicon.com>
 <20210212074234.vumx4odistyhbu4m@spock.localdomain>
In-Reply-To: <20210212074234.vumx4odistyhbu4m@spock.localdomain>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.202.192]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Oleksandr Natalenko [mailto:oleksandr@natalenko.name]
> Sent: Friday, February 12, 2021 8:43 PM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>;
> sjenning@linux.vnet.ibm.com; Linux List Kernel Mailing
> <linux-kernel@vger.kernel.org>; Linux Memory Management List
> <linux-mm@kvack.org>
> Subject: Re: kernel BUG at mm/zswap.c:1275! (rc6 - git 61556703b610)
> 
> Hello.
> 
> On Thu, Feb 11, 2021 at 10:43:18AM +0000, Song Bao Hua (Barry Song) wrote:
> > Are you using zsmalloc? There is a known bug on the combination
> > of zsmalloc and zswap, fixed by patches of tiantao:
> >
> > mm: set the sleep_mapped to true for zbud and z3fold
> > mm/zswap: fix variable 'entry' is uninitialized when used
> > mm/zswap: fix potential memory leak
> > mm/zswap: add the flag can_sleep_mapped
> >
> > at Linux-next:
> >
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/?q
> t=author&q=tiantao6%40hisilicon.com
> 
> Is this a future stable-5.11 material (and/or, potentially, older stable
> branches
> as well)?

I would believe this should be put into 5.11. I will ask Andrew.

> 
> --
>   Oleksandr Natalenko (post-factum)

Thanks
Barry

