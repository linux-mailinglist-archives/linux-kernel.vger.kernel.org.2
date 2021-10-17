Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 375074309EC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 17:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343952AbhJQPCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 11:02:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:41676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241731AbhJQPCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 11:02:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D5E2860C4D;
        Sun, 17 Oct 2021 15:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634482829;
        bh=CZmDICCzhkLK1KqmUZwDtCRFPPI+j7qhJXvlQjcBucg=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=joOfFlaWsD0EXuPnkTu8K4hBQDmSPKsg+zGvTOIf1Rvk7cBGUZx4wstFzG1b0JlA/
         VR6TzH8mqygi009HKbyo2GYrL9Fl9R/7PK0WYdpDHaXSp0gwWdLqJ+HA30qdq91FKS
         FBtfoe69HJM1UvEF/0fH4WwB4vmDAigRmy8X4TqDP312q1t24dWsJZxONuwWABGNCR
         yhjGCu8QRMiEmimPsf3FYspEluZge4iQfslvvc8DZGr/WEaTPkYtOKlBYVCzG9pvKV
         oGqDf/fJG/tY/JmvhJZY3aZv0awmlAgxoKeO1Ru2WpwjhpAfrzH7CWXcJb7P9+2gYI
         Iguqp442JncKg==
Message-ID: <ab239c64-2d3b-f41b-aac4-d1825a75c594@kernel.org>
Date:   Sun, 17 Oct 2021 23:00:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v6 2/2] erofs: add multiple device support
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org, Liu Bo <bo.liu@linux.alibaba.com>,
        Yan Song <imeoer@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peng Tao <tao.peng@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Changwei Ge <chge@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>
References: <20211010063345.28183-1-xiang@kernel.org>
 <20211014081010.43485-1-hsiangkao@linux.alibaba.com>
 <b5f8c41f-d781-a9d2-6ee1-77f2692f9461@kernel.org>
 <20211017041523.GA15116@hsiangkao-HP-ZHAN-66-Pro-G1>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20211017041523.GA15116@hsiangkao-HP-ZHAN-66-Pro-G1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/10/17 12:15, Gao Xiang wrote:
> Hi Chao,
> 
> On Sun, Oct 17, 2021 at 10:10:15AM +0800, Chao Yu wrote:
>> File won't locate in multidevices, right? otherwise it needs to shrink mapped length
>> as well.
> 
> Thanks for your review.
> 
> File can be located in multi-devices. But it's intended as I mentioned in the commit
> message, each extent won't cross devices, which is guaranteed by mkfs seriously.
> Otherwise, it's more complicated to handle (especially for the compression side) and
> has no more benefits.

Thanks for the explanation.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

> 
> Thanks,
> Gao Xiang
> 
>>
>> Thanks,
