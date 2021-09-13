Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B24E040877E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 10:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238573AbhIMIus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 04:50:48 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9421 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238487AbhIMIue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 04:50:34 -0400
Received: from dggeme712-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H7KmN4RC2z8yPs;
        Mon, 13 Sep 2021 16:44:52 +0800 (CST)
Received: from dggeme759-chm.china.huawei.com (10.3.19.105) by
 dggeme712-chm.china.huawei.com (10.1.199.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Mon, 13 Sep 2021 16:49:17 +0800
Received: from dggeme759-chm.china.huawei.com ([10.8.81.151]) by
 dggeme759-chm.china.huawei.com ([10.8.81.151]) with mapi id 15.01.2308.008;
 Mon, 13 Sep 2021 16:49:17 +0800
From:   weizhenliang <weizhenliang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "tangbin@cmss.chinamobile.com" <tangbin@cmss.chinamobile.com>,
        "zhangshengju@cmss.chinamobile.com" 
        <zhangshengju@cmss.chinamobile.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nixiaoming <nixiaoming@huawei.com>,
        "Xiaoqian (xiaoqian, RTOS FAE)" <xiaoqian9@huawei.com>
Subject: =?gb2312?B?s7e72DogW1BBVENIXSB0b29scy92bS9wYWdlX293bmVyX3NvcnQuYzogY291?=
 =?gb2312?Q?nt_and_sort_by_mem?=
Thread-Topic: [PATCH] tools/vm/page_owner_sort.c: count and sort by mem
Thread-Index: AQHXqHw8YLMXa0wOSGS/zRUUIILS7Q==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date:   Mon, 13 Sep 2021 08:49:17 +0000
Message-ID: <04952ec21aca446788d895b30fb81a49@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.101.97]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

d2VpemhlbmxpYW5nIL2rs7e72NPKvP6hsFtQQVRDSF0gdG9vbHMvdm0vcGFnZV9vd25lcl9zb3J0
LmM6IGNvdW50IGFuZCBzb3J0IGJ5IG1lbaGxoaM=
