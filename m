Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 812BB30A6DA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 12:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhBALuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 06:50:06 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:11966 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhBALuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 06:50:02 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DTmRN0QCpzjG4Z;
        Mon,  1 Feb 2021 19:48:16 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.220) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.498.0; Mon, 1 Feb 2021
 19:49:09 +0800
Subject: Re: [PATCH v6 2/4] ARM: hisi: add support for Kunpeng50x SoC
To:     Arnd Bergmann <arnd@kernel.org>
CC:     Russell King <rmk+kernel@arm.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        "Haojian Zhuang" <haojian.zhuang@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210201033601.1642-1-thunder.leizhen@huawei.com>
 <20210201033601.1642-3-thunder.leizhen@huawei.com>
 <CAK8P3a142CkJ0kOD6mK+H-E2NrKZ6Ec-aYasddAUmAhTWhrjcA@mail.gmail.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <69103fcc-902a-29f3-1d0e-0d124d778c01@huawei.com>
Date:   Mon, 1 Feb 2021 19:49:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a142CkJ0kOD6mK+H-E2NrKZ6Ec-aYasddAUmAhTWhrjcA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/2/1 16:35, Arnd Bergmann wrote:
> On Mon, Feb 1, 2021 at 4:35 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:
>>
>> Enable support for the Hisilicon Kunpeng506 and Kunpeng509 SoC.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
> Russell, do you have a preference for how to get this series merged
> after the last comments are resolved?
> 
> I think there is no technical problem in having patch two merged through
> the soc tree, while merging the other three through your tree, but it
> seems more logical to keep all four together in either location.

Wait, wait. I've coordinated resources urgently. I can run test cases for new changes tonight.

> 
>        Arnd
> 
> .
> 

