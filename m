Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55FD737F923
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 15:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234223AbhEMNvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 09:51:03 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2479 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbhEMNu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 09:50:59 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FgtHv15tSzBthk;
        Thu, 13 May 2021 21:47:07 +0800 (CST)
Received: from [10.67.108.157] (10.67.108.157) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Thu, 13 May 2021 21:49:40 +0800
Subject: Re: [PATCH -next] drivers/base/node.c: make CACHE_ATTR define static
 DEVICE_ATTR_RO
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Wang Weiyang <wangweiyang2@huawei.com>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <20210513110716.25791-1-gongruiqi1@huawei.com>
 <YJ0M5HcXIQQFOTEq@kroah.com>
From:   Gong Ruiqi <gongruiqi1@huawei.com>
Message-ID: <b2065aab-b9d0-41dc-023c-e5e73d6989f3@huawei.com>
Date:   Thu, 13 May 2021 21:49:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YJ0M5HcXIQQFOTEq@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.108.157]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Resend for the correct format. Apology from a TB amateur.)


On 2021/05/13 19:26, Greg Kroah-Hartman wrote:
> On Thu, May 13, 2021 at 07:07:16PM +0800, Ruiqi Gong wrote:
>> The Sparse tool reports as follows:
>>
>> drivers/base/node.c:239:1: warning:
>>  symbol 'dev_attr_line_size' was not declared. Should it be static?
>> drivers/base/node.c:240:1: warning:
>>  symbol 'dev_attr_indexing' was not declared. Should it be static?
>>
>> These symbols (and several others) are defined by DEVICE_ATTR_RO(name) in
>> CACHE_ATTR(name, fmt), and all of them are not used outside of node.c. So let's
>> mark DEVICE_ATTR_RO(name) static to solve these complains from Sparse.
> 
> Why not fix them all at once?  Why only one here?

Sorry for not making it clear enough. Actually the patch does fix them
all. Those symbols reported by Sparse are generated when two of the
following macros are expanded:

    CACHE_ATTR(size, "%llu")
    CACHE_ATTR(line_size, "%u")
    CACHE_ATTR(indexing, "%u")
    CACHE_ATTR(write_policy, "%u")

So one fix of the CACHE_ATTR's definition fixs them all.

> 
> thanks,
> 
> greg k-h
> .
> 

.
