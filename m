Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCF23580A0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 12:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhDHKal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 06:30:41 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:63652 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhDHKad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 06:30:33 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20210408103018euoutp01a984dae75132eb7085cecd0d86068109~z203mru251230512305euoutp01k
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 10:30:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20210408103018euoutp01a984dae75132eb7085cecd0d86068109~z203mru251230512305euoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1617877818;
        bh=Wawn+jC2hksX05vj35MLNFZB6CXJZrElC2FBihBKOn8=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=fyrUi767TI4Mowsd+xLtllYPf2aUy/qeNm84o7xfa05Qt4kGv8jCidXv2ovVWo4ap
         6/kL63gBi40DcZjKzmjMVynFBNn9VGCmiJkjDnRWqXlRa4lDolsn1BJL9Z+H6n5Rnw
         x9WQpCKa5J5m7Ja2HCcgXlDUTV97+iHK9FXgygSY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210408103018eucas1p18da90f664d02ec502f772b58be72301d~z203V62j82828328283eucas1p1f;
        Thu,  8 Apr 2021 10:30:18 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 54.21.09452.A3BDE606; Thu,  8
        Apr 2021 11:30:18 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210408103018eucas1p2a390b6a21fb277c4657878967566df4a~z2027OUvj1880618806eucas1p2O;
        Thu,  8 Apr 2021 10:30:18 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210408103018eusmtrp1968fb8fa4294c2f9691810c512417f03~z2026lXIX2517025170eusmtrp1F;
        Thu,  8 Apr 2021 10:30:18 +0000 (GMT)
X-AuditID: cbfec7f2-a9fff700000024ec-6a-606edb3aa99f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 47.80.08696.93BDE606; Thu,  8
        Apr 2021 11:30:17 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210408103017eusmtip25d2c6e428d220e29e75ea26af5b9f138~z202yd2tR0680506805eusmtip2b;
        Thu,  8 Apr 2021 10:30:17 +0000 (GMT)
Received: from localhost (106.210.248.142) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 8 Apr 2021 11:30:17 +0100
Date:   Thu, 8 Apr 2021 12:30:16 +0200
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Keith Busch <kbusch@kernel.org>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>,
        <linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH 1/1] nvme-pci: add the DISABLE_WRITE_ZEROES quirk for a
 Samsung PM1725a
Message-ID: <20210408103016.5girhv5ctkucovmd@mpHalley.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210323124322.qchyk7boyzklwv3v@mpHalley.local>
X-Originating-IP: [106.210.248.142]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsWy7djPc7pWt/MSDN7Pl7aYdfs1i8XdN+9Z
        LFauPspkMenQNUaLy7vmsFnMX/aU3YHNY9OqTjaPzUvqPXbfbGDz+LxJzqP9QDeTx6uL69kD
        2KK4bFJSczLLUov07RK4Mm5emcZe8Jy94l/LN6YGxpVsXYwcHBICJhLrHtd2MXJyCAmsYJRY
        ddegi5ELyP7CKNHdcJIRwvnMKDH33GU2kCqQhvNz/zJDJJYzSsx6d4wJrurw2q9QzhZGiWfX
        LjKBtLAIqEi0XjrFCGKzCdhLXFp2ixnEFhFQknj66izYDmaBbYwSTw68ZQdJCAvESvyYeoIV
        xOYVsJE4+msiM4QtKHFy5hMWEJtZwEqi80MTK8gTzALSEsv/cUCE5SWat85mBglzCthK3P9S
        AfGmssTy6b4QD9RKrD12hh1kq4TADw6Jll/tLBAJF4m1B46xQtjCEq+Ob2GHsGUkTk/uYYFo
        aGaUOLPmCjOE08Mo8WfSCkaIDdYSfWdyIBocJbaemQcNXz6JG28FIU7jk5i0bTozRJhXoqNN
        aAKjyiwkf81C8tcshL9mIflrASPLKkbx1NLi3PTUYsO81HK94sTc4tK8dL3k/NxNjMD0c/rf
        8U87GOe++qh3iJGJg/EQowQHs5II747e7AQh3pTEyqrUovz4otKc1OJDjNIcLErivKtmr4kX
        EkhPLEnNTk0tSC2CyTJxcEo1MHUrZB3gnbBGt/zmgd8bZwizXz3FJPyKoSdI/Y3/8iidTzdX
        n2apSshfPvvK5jP+n/f/5p639kfr+ffW3/IVHSwCrHboBzDMmHKp27X4vPHsKS6femZrlBZZ
        mmsckTq5SCyHOfDwHMvF2d9Win1UXLpq/sYzKt6GnZU+Ie8frjwVKMQXJlNTKtD38riEY8dZ
        e836p8/ffDtm9OCpYf7xgFffBesiexy4Ns89v1FCKuBDzpL/U5fWvpRTu/HnprBQfXiiUznf
        cuEd1zfOvrVu6e9Z7+8H6+d8LP6sdp2769xsBSnHFgOGTpU/li7mL04EMXya7d0+N+fk16de
        MadD2pS6pj543OnbzH1R/s4ajbNKLMUZiYZazEXFiQCc4vSxrgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsVy+t/xe7qWt/MSDI7vsbGYdfs1i8XdN+9Z
        LFauPspkMenQNUaLy7vmsFnMX/aU3YHNY9OqTjaPzUvqPXbfbGDz+LxJzqP9QDeTx6uL69kD
        2KL0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0Mm5e
        mcZe8Jy94l/LN6YGxpVsXYycHBICJhLn5/5l7mLk4hASWMoo8WDyWlaIhIzEpysf2SFsYYk/
        17rAGoQEPjJK3F6VAWFvYZSYPzEGxGYRUJFovXSKEcRmE7CXuLTsFjOILSKgJPH01VlGkAXM
        AtsYJZ4ceAs2VFggVuLH1BNgy3gFbCSO/poIdcVRZom7Kw8wQSQEJU7OfMICYjMLWEjMnH8e
        aBIHkC0tsfwfB0RYXqJ562xmkDCngK3E/S8VIKaEgLLE8um+EOfXSry6v5txAqPILCQzZyGZ
        OQth5iwkMxcwsqxiFEktLc5Nzy020itOzC0uzUvXS87P3cQIjM5tx35u2cG48tVHvUOMTByM
        hxglOJiVRHh39GYnCPGmJFZWpRblxxeV5qQWH2I0BYbQRGYp0eR8YHrIK4k3NDMwNTQxszQw
        tTQzVhLnNTmyJl5IID2xJDU7NbUgtQimj4mDU6qBqeXZpYW6qht2VUlkv6hmvzJVTCq96EDu
        n77IF6cemP+WaDEX2umeHvbU5q+HhuEngSntW+9cypXcXnT1Z+rL3N4O8YrIF6IzhY+1enQw
        KeQcfCt0QEMiOGKuzBLVP7sVzm91P+nnVdtp/v+AdfP8r+/VLK79vvCxX19PRf2gZ6+xXtac
        vqYt39xTNE5tLuk3kNpQHbhSNPV3efVk/5cHt9pP+2m06Gf+kmk3A6bveDb5mOV7/jZZ5jWd
        tz4HuWZE3b3z/Z3UyeWbd7KpCrJ3//LeqLHkUapD9n4ulfNyFycfn764I+ipt2XtmZUfL1w9
        mrzolMSyCVPaV5uqrDja4La9qDrqCfPuGTe5/jzLd1NiKc5INNRiLipOBABtl10FVwMAAA==
X-CMS-MailID: 20210408103018eucas1p2a390b6a21fb277c4657878967566df4a
X-Msg-Generator: CA
X-RootMTR: 20210323083750eucas1p14d21230ac758194d854ca336caf7f3f2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210323083750eucas1p14d21230ac758194d854ca336caf7f3f2
References: <1615377076-3251-1-git-send-email-dmtrmonakhov@yandex-team.ru>
        <20210310132156.GA12145@lst.de> <20210310134110.GA13063@lst.de>
        <20210310200030.GA3377333@dhcp-10-100-145-180.wdc.com>
        <20210311104712.GA16218@lst.de>
        <CGME20210323083750eucas1p14d21230ac758194d854ca336caf7f3f2@eucas1p1.samsung.com>
        <20210323083749.r272grolxozf3w2f@mpHalley.local>
        <20210323123121.GA31105@lst.de>
        <20210323124322.qchyk7boyzklwv3v@mpHalley.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.03.2021 13:43, Javier González wrote:
>On 23.03.2021 13:31, Christoph Hellwig wrote:
>>On Tue, Mar 23, 2021 at 09:37:49AM +0100, Javier González wrote:
>>>Quick question. It seems like the current quirk simply disables
>>>write-zeroes. Would you be open for a quirk that aligns with MDTS for
>>>models that implemented it this way before TP4040?
>>
>>Aligning to MDTS is our current behavior, although all kernels up to
>>5.11 had a bug in the calculation.
>
>I see. Let me check internally and see what's going on with
>write-zeroes on this model.

We still need to confirm, but it seems like MDTS for write-zeroes is
reported wrong in the FW that Dmitry is using. We can at least reproduce
it.

Would it be a possibility to add quirk infrastructure to hardcode MDTS
for FW versions prior TP4040?

Another possibility is to add quirks to the TP4040 support patches to
enable this - it might also help reduce the list of models currently
blacklisted for write-zeroes.
