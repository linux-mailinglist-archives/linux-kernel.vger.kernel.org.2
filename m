Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0E3B4018AC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 11:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241107AbhIFJQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 05:16:00 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:14553 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhIFJP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 05:15:58 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210906091452epoutp0215d397b06060db0dac904b0b4e36907f~iMNHGlCdy3112131121epoutp02E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 09:14:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210906091452epoutp0215d397b06060db0dac904b0b4e36907f~iMNHGlCdy3112131121epoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1630919692;
        bh=q10GZulpYYuR+PRYvpMnmQv1Y9NPjiTNR8ZkJ2udFWM=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=WVz+lYq68ktU68YJAB+PmF6r5fUseaAi3uSce0LNQGSm8RquUu3BFsyqZivmhu5ts
         oK36NoxCirjQlbYIw5eqwwnnSeOk3K3qHzU/SV7vRNb3AZZZfb49gGSHq9KwaZM118
         106awKCB5w0h6XZub8hovOgEyP7ezRRFthGp0tWM=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210906091452epcas1p3969963421b0c8418461bcc5577243a92~iMNGkxeHR1330313303epcas1p3q;
        Mon,  6 Sep 2021 09:14:52 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.240]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4H32m943jyz4x9Q0; Mon,  6 Sep
        2021 09:14:49 +0000 (GMT)
X-AuditID: b6c32a35-c2fff700000026b6-95-6135dc08763e
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        FF.B9.09910.80CD5316; Mon,  6 Sep 2021 18:14:48 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(2) [PATCH] zram_drv: allow reclaim on bio_alloc
Reply-To: jaewon31.kim@samsung.com
Sender: Jaewon Kim <jaewon31.kim@samsung.com>
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Jaewon Kim <jaewon31.kim@samsung.com>
CC:     "minchan@kernel.org" <minchan@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        YongTaek Lee <ytk.lee@samsung.com>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <YTXTe3U8RrvSAynl@infradead.org>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20210906091448epcms1p6bcc1f11b0da18e215219e6868ed07914@epcms1p6>
Date:   Mon, 06 Sep 2021 18:14:48 +0900
X-CMS-MailID: 20210906091448epcms1p6bcc1f11b0da18e215219e6868ed07914
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBJsWRmVeSWpSXmKPExsWy7bCmri7HHdNEg+YNEhZz1q9hs3h5SNPi
        9IRFTBbdm2cyWvS+f8VkcXnXHDaLe2v+s1os+/qe3eLxem4HTo+ds+6ye2xeoeWxaVUnm8em
        T5PYPU7M+M3i0bdlFaPH501yAexR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbm
        Sgp5ibmptkouPgG6bpk5QHcpKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgrMCvSK
        E3OLS/PS9fJSS6wMDQyMTIEKE7IzWn98YSro5ap41DiBpYFxAUcXIyeHhICJxL/HzSxdjFwc
        QgI7GCXOb9zN2MXIwcErICjxd4cwSI2wgI3EuR1/2EBsIQElibM/rrBDxHUlmrpXs4DYbALa
        Eu8XTGIFsUUEgiRaNyxnBpnJLLCWSeLch4WMEMt4JWa0P2WBsKUlti/fChbnBBo0d2UPO0Rc
        VOLm6rdw9vtj86F6RSRa751lhrAFJR783A0Vl5I4132cCeRmCYF6iaWtUiB7JQQaGCXm/VjL
        BlFjLvFsQwvYTF4BX4mTG5aA2SwCqhKT795lgqhxkTi3bDNYPbOAvMT2t3OYQWYyC2hKrN+l
        D1GiKLHz91y4Vxo2/mZHZzML8Em8+9rDChPfMe8J1Hg1iZZnX6HiMhJ//z1jncCoNAsR0rOQ
        LJ6FsHgBI/MqRrHUguLc9NRiwwJDeOQm5+duYgQnUS3THYwT337QO8TIxMF4iFGCg1lJhDfa
        2ShRiDclsbIqtSg/vqg0J7X4EKMp0MsTmaVEk/OBaTyvJN7QxNLAxMzIxMLY0thMSZyX8ZVM
        opBAemJJanZqakFqEUwfEwenVANT6o64Jo4DkxZnCnWdWj2Hd/5v+80Hs688Sp624YCJQffu
        5u1VryTui+rl6jTHrjR9IOTmev+7pNqVP68Ob+guvtBoovh+07SfgjvEraffqMy5MFe8ZueV
        mlmLVavNA+U2s8x/t5Qz8JbQp/w1IXc5hL5I7N1oN9nvR/kmgcraG6fs5BYr2zKsqi+z6JnQ
        zVvIsrdz3aEF9m+jL/7ddfnf1MS40NPlHX/OXn8o8Sv9WAt7eP61b86Nvybc3n5MYNv1u/HW
        bmpr5/g97u8vPznbuWXWSTPDjuPbY6f+7bhpm2X4ct+1uCOR9t4737X9iPtmprNppfMuz08l
        LS3aq+yDEvf8E45ZWBC31GOVxWO5H0osxRmJhlrMRcWJACckOmQrBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210906052847epcas1p1f53f1ad04ad785d53f64eef150969c34
References: <YTXTe3U8RrvSAynl@infradead.org>
        <20210906052926.6007-1-jaewon31.kim@samsung.com>
        <CGME20210906052847epcas1p1f53f1ad04ad785d53f64eef150969c34@epcms1p6>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 
>--------- Original Message ---------
>Sender : Christoph Hellwig <hch@infradead.org>
>Date : 2021-09-06 17:39 (GMT+9)
>Title : Re: [PATCH] zram_drv: allow reclaim on bio_alloc
> 
>On Mon, Sep 06, 2021 at 02:29:26PM +0900, Jaewon Kim wrote:
>> The read_from_bdev_async is not called on atomic context. So GFP_NOIO is
>> available rather than GFP_ATOMIC. If there were reclaimable pages with
>> GFP_NOIO, we can avoid allocation failure and page fault failure.
>> 
>> Reported-by: Yong-Taek Lee <ytk.lee@samsung.com>
>> Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
>> ---
>>  drivers/block/zram/zram_drv.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
>> index fcaf2750f68f..53be528a39a2 100644
>> --- a/drivers/block/zram/zram_drv.c
>> +++ b/drivers/block/zram/zram_drv.c
>> @@ -587,7 +587,7 @@ static int read_from_bdev_async(struct zram *zram, struct bio_vec *bvec,
>>  {
>>          struct bio *bio;
>>  
>> -        bio = bio_alloc(GFP_ATOMIC, 1);
>> +        bio = bio_alloc(GFP_NOIO|__GFP_HIGHMEM, 1);
> 
>Passing __GFP_HIGHMEM to bio_alloc does not make any sense whatsoever.
> 
Correct, let me remove __GFP_HIGHMEM if I send v2 patch.
Thank you
