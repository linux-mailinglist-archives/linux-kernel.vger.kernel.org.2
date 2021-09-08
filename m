Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED2194031F5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 02:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343520AbhIHAnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 20:43:03 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:19303 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243944AbhIHAnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 20:43:00 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210908004151epoutp03d6c470468135cc9f65d788d637c2b8ec~isfwvOpHh1904119041epoutp03D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 00:41:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210908004151epoutp03d6c470468135cc9f65d788d637c2b8ec~isfwvOpHh1904119041epoutp03D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1631061711;
        bh=66dYrz8JD/SY7DjN7xPVA1MXtFk/YlHrXJQ1noZe4kA=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=k/OzdsLAQeiq6y4E4TbXADMRXtYm0VBemDX+HV9Oygf8jXsTTJyIVXlwsM9VzlUE8
         CoeuCgchRwYlbi2kZMXYE2eWGLvx3WNRKFzzw7bPbUFlksv50Cn4xGwSdT18dkrmFQ
         +Mi8B8p4AWbiJ5ug+wNcmrRf/cztdEnrKuNCfkDE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210908004150epcas1p2a1e486611478577c69c312853d0b58eb~isfv1Xjxf2750527505epcas1p2z;
        Wed,  8 Sep 2021 00:41:50 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.38.241]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4H43HJ00g5z4x9Qh; Wed,  8 Sep
        2021 00:41:48 +0000 (GMT)
X-AuditID: b6c32a36-1f0ada8000002663-c7-613806cab010
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A5.38.09827.AC608316; Wed,  8 Sep 2021 09:41:46 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(3) [PATCH] zram_drv: allow reclaim on bio_alloc
Reply-To: jaewon31.kim@samsung.com
Sender: Jaewon Kim <jaewon31.kim@samsung.com>
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     Minchan Kim <minchan@kernel.org>,
        Jaewon Kim <jaewon31.kim@samsung.com>
CC:     Christoph Hellwig <hch@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        YongTaek Lee <ytk.lee@samsung.com>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <YTeas6sPrvQKmUHG@google.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20210908004146epcms1p295287978b225bbf1c85b1abcf29f8289@epcms1p2>
Date:   Wed, 08 Sep 2021 09:41:46 +0900
X-CMS-MailID: 20210908004146epcms1p295287978b225bbf1c85b1abcf29f8289
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOJsWRmVeSWpSXmKPExsWy7bCmge4pNotEg817LS3mrF/DZvHykKbF
        6QmLmCy6N89ktOh9/4rJ4vKuOWwW99b8Z7VY9vU9u8Xj9dwOnB47Z91l99i8Qstj06pONo9N
        nyaxe5yY8ZvFo2/LKkaPz5vkAtijsm0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3M
        lRTyEnNTbZVcfAJ03TJzgO5SUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYFegV
        J+YWl+al6+WlllgZGhgYmQIVJmRndM88w1xwlq9iwd2DbA2MV7m7GDk5JARMJHbMesncxcjF
        ISSwg1Fi/r3ZjF2MHBy8AoISf3cIg5jCAjYSO7dEg5QLCShJnP1xhR3EFhbQlWjqXs0CYrMJ
        aEu8XzCJFcQWEfCWmNhwAmwks8BKJokTV9ewQOzilZjR/hTKlpbYvnwrI4jNKaAlseXJA0aI
        uKjEzdVv2WHs98fmQ8VFJFrvnWWGsAUlHvzcDRWXkjjXfZwJ5E4JgXqJpa1SIHslBBoYJeb9
        WMsGUWMu8WxDC9hMXgFfiU3ztoLNYRFQlehovcQKUeMi8XXqKSYQm1lAXmL72znMIDOZBTQl
        1u/ShyhRlNj5ey4jzCsNG3+zo7OZBfgk3n3tYYWJ75j3hAnCVpNoefYVKi4j8fffM9YJjEqz
        EAE9C8niWQiLFzAyr2IUSy0ozk1PLTYsMILHbXJ+7iZGcArVMtvBOOntB71DjEwcjIcYJTiY
        lUR4/5qbJQrxpiRWVqUW5ccXleakFh9iNAV6eSKzlGhyPjCJ55XEG5pYGpiYGZlYGFsamymJ
        8zK+kkkUEkhPLEnNTk0tSC2C6WPi4JRqYDLK+fJz8blP6jvNr1/VK7+zZGuQxsErxomzM94Z
        psWfvnZ10/WrIv/3/vePe36xPGHJou62rux7x1jO3g9PXRdfdnn/TFO2Ffd4j7iGLLt8Sf7T
        tfTlMyW0Jk+dqHonh101PdbH5Wp50750Nh/9juxAnadeOnuns95zXXTNK0P7r07K57+9nyoX
        r4zZ0XRNx/K/sudnlqtPzOT0j+6u2d7hlDGlSobr5uT2JQtl0mxdlgj75Lml+7n2te8zVaxb
        1LX/R2Wh+P0zPwVlmlOrD69wL1wqHHy4v2tvo9NZDrfAm/52cdb7JO6zaK1X42YNKfz6tTDf
        8FP49R1yV8wyoy/qFbxglPjI8cgwqvTaFSWW4oxEQy3mouJEALyKyDQqBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210906052847epcas1p1f53f1ad04ad785d53f64eef150969c34
References: <YTeas6sPrvQKmUHG@google.com> <YTXTe3U8RrvSAynl@infradead.org>
        <20210906052926.6007-1-jaewon31.kim@samsung.com>
        <20210906091448epcms1p6bcc1f11b0da18e215219e6868ed07914@epcms1p6>
        <CGME20210906052847epcas1p1f53f1ad04ad785d53f64eef150969c34@epcms1p2>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 
>--------- Original Message ---------
>Sender : Minchan Kim <minchan@kernel.org>
>Date : 2021-09-08 02:00 (GMT+9)
>Title : Re: (2) [PATCH] zram_drv: allow reclaim on bio_alloc
> 
>Hi Jaewon,
> 
>On Mon, Sep 06, 2021 at 06:14:48PM +0900, Jaewon Kim wrote:
>> > 
>> > 
>> >--------- Original Message ---------
>> >Sender : Christoph Hellwig <hch@infradead.org>
>> >Date : 2021-09-06 17:39 (GMT+9)
>> >Title : Re: [PATCH] zram_drv: allow reclaim on bio_alloc
>> > 
>> >On Mon, Sep 06, 2021 at 02:29:26PM +0900, Jaewon Kim wrote:
>> >> The read_from_bdev_async is not called on atomic context. So GFP_NOIO is
>> >> available rather than GFP_ATOMIC. If there were reclaimable pages with
>> >> GFP_NOIO, we can avoid allocation failure and page fault failure.
>> >> 
>> >> Reported-by: Yong-Taek Lee <ytk.lee@samsung.com>
>> >> Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
> 
>Looks reasonable to me.
>Feel free to add after dealing with Christoph's comment.
> 
>Acked-by: Minchan Kim <minchan@kernel.org>
> 
>Thank you.

Thank you, I will send v2 patch soon.

> 
>> >> ---
>> >>  drivers/block/zram/zram_drv.c | 2 +-
>> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >> 
>> >> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
>> >> index fcaf2750f68f..53be528a39a2 100644
>> >> --- a/drivers/block/zram/zram_drv.c
>> >> +++ b/drivers/block/zram/zram_drv.c
>> >> @@ -587,7 +587,7 @@ static int read_from_bdev_async(struct zram *zram, struct bio_vec *bvec,
>> >>  {
>> >>          struct bio *bio;
>> >>  
>> >> -        bio = bio_alloc(GFP_ATOMIC, 1);
>> >> +        bio = bio_alloc(GFP_NOIO|__GFP_HIGHMEM, 1);
>> > 
>> >Passing __GFP_HIGHMEM to bio_alloc does not make any sense whatsoever.
>> > 
>> Correct, let me remove __GFP_HIGHMEM if I send v2 patch.
>> Thank you
> 
