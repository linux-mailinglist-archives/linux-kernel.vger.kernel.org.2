Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE1A40EED7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 03:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242400AbhIQBiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 21:38:12 -0400
Received: from mail.loongson.cn ([114.242.206.163]:52010 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236351AbhIQBiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 21:38:11 -0400
Received: from [10.20.42.25] (unknown [10.20.42.25])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9CxJOYl8UNhUr4IAA--.24933S3;
        Fri, 17 Sep 2021 09:36:38 +0800 (CST)
Subject: Re: [PATCH 2/2] drm/qxl: Add qxl dma fence release function
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Dave Airlie <airlied@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20210914062352.6102-1-maobibo@loongson.cn>
 <20210914062352.6102-2-maobibo@loongson.cn>
 <20210915063835.36bhpadzbzuj7shw@sirius.home.kraxel.org>
From:   maobibo <maobibo@loongson.cn>
Message-ID: <42a70a29-3ecb-7f41-f4e2-378cf3f6939c@loongson.cn>
Date:   Fri, 17 Sep 2021 09:36:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210915063835.36bhpadzbzuj7shw@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9CxJOYl8UNhUr4IAA--.24933S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZry8Xr1rKw47WFyDAry5Arb_yoW3JFgEkF
        W2grW8Cwn0g3s5Aa13Cw15XrWxKa95Zry8XFyDZasxtF98Ar4kGr40krsxW3sxAa40kFsx
        Arn7Xryaqw1SgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbIxYjsxI4VWkKwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
        vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
        Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
        W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG
        8wCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r12
        6r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU5PpnJUUUUU==
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/15/2021 02:38 PM, Gerd Hoffmann wrote:
> On Tue, Sep 14, 2021 at 02:23:52AM -0400, bibo mao wrote:
>> Add qxl dma fence release function, previously default dma fence
>> release function is used, and fence pointer is used to free 
>> the memory. With this patch, actual qxl release pointer is used
>> to free memory, so that dma fence can put at any place of 
>> struct qxl_release.
> 
> Why?  Is there a problem with struct dma_fence being the first
> element of struct qxl_release?
Yes, there is no problem put it in the first element of struct qxl_release. This patch has no actual use,it is only more flexible. And you can discard this patch if other graphics drivers do the same thing like this.

regards
bibo,mao
> 
> take care,
>   Gerd
> 

