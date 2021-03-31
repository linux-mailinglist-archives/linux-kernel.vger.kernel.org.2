Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB623500C7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 14:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235537AbhCaM7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 08:59:08 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:15837 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235521AbhCaM6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 08:58:47 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F9RCX0nqrz9tR4;
        Wed, 31 Mar 2021 20:56:40 +0800 (CST)
Received: from [10.174.179.96] (10.174.179.96) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Wed, 31 Mar 2021 20:58:43 +0800
Subject: Re: [PATCH -next] powerpc/eeh: Remove unused inline function
 eeh_dev_phb_init_dynamic()
To:     Daniel Axtens <dja@axtens.net>, <ruscur@russell.cc>,
        <oohall@gmail.com>, <mpe@ellerman.id.au>,
        <benh@kernel.crashing.org>, <paulus@samba.org>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
References: <20210324140714.19612-1-yuehaibing@huawei.com>
 <874kgy8ptt.fsf@linkitivity.dja.id.au>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <238925b8-c2be-8282-1ce6-e1d92b7b527e@huawei.com>
Date:   Wed, 31 Mar 2021 20:58:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <874kgy8ptt.fsf@linkitivity.dja.id.au>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.96]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/26 13:08, Daniel Axtens wrote:
> Hi,
> 
>> commit 475028efc708 ("powerpc/eeh: Remove eeh_dev_phb_init_dynamic()")
>> left behind this, so can remove it.
> 
> I had a look: the inline that you are removing here is for the
> !CONFIG_EEH case, which explains why it was missed the first time.
> 
> This looks like a good change. Out of interest, what tool are you using
> to find these unused inlines? If there are many more, it might make
> sense to combine future patches removing them into a single patch, but
> I'm not sure.

Just use some grep skill, will do that if any.

> 
> checkpatch likes this patch, so that's also good :)
> 
> Reviewed-by: Daniel Axtens <dja@axtens.net>
> 
> Kind regards,
> Daniel
> .
> 
