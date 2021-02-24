Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5403235F3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 04:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbhBXDNT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 23 Feb 2021 22:13:19 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:4635 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbhBXDNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 22:13:17 -0500
Received: from dggeml406-hub.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Dlgt24bcJzYCKm;
        Wed, 24 Feb 2021 11:11:06 +0800 (CST)
Received: from DGGEML509-MBX.china.huawei.com ([169.254.1.252]) by
 dggeml406-hub.china.huawei.com ([10.3.17.50]) with mapi id 14.03.0509.000;
 Wed, 24 Feb 2021 11:12:23 +0800
From:   "chenjun (AM)" <chenjun102@huawei.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregory.herrero@oracle.com" <gregory.herrero@oracle.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "Xiangrui (Euler)" <rui.xiang@huawei.com>
Subject: Re: Re: [PATCH] recordmcount: use w8 to read relp->r_info in
 arm64_is_fake_mcount
Thread-Topic: Re: [PATCH] recordmcount: use w8 to read relp->r_info in
 arm64_is_fake_mcount
Thread-Index: AQHXCSa61U/7Tvwg9UGsa9lKYMYb/g==
Date:   Wed, 24 Feb 2021 03:12:23 +0000
Message-ID: <CE1E7D7EFA066443B6454A6A5063B50220CC0D96@dggeml509-mbx.china.huawei.com>
References: <20210222135840.56250-1-chenjun102@huawei.com>
 <CE1E7D7EFA066443B6454A6A5063B50220C5B320@dggeml509-mbx.china.huawei.com>
 <20210223172617.1aeb8e2d@gandalf.local.home>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.178.53]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2021/2/24 6:26, Steven Rostedt 写道:
> On Mon, 22 Feb 2021 15:50:19 +0000
> "chenjun (AM)" <chenjun102@huawei.com> wrote:
> 
>> Hi
>>
>> There is no problem when I use aarch64_be(gcc v10.2). Because gcc v10.2 use __patchable_function_entries
>> instead of __mcount. I am not sure when the change happened.
> 
> But you are still saying that this patch needs to be applied, right?
> 
> -- Steve
> .
> 

Yes，this patch needs to be applied.

-- 
Regards
Chen Jun
