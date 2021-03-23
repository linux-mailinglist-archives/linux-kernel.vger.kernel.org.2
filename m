Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A749F345E68
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 13:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbhCWMnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 08:43:50 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:62420 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbhCWMn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 08:43:26 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20210323124324euoutp01880c7322da504b4ee49d979b8f7ebb55~u_Ug8AXa52257022570euoutp01x
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 12:43:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20210323124324euoutp01880c7322da504b4ee49d979b8f7ebb55~u_Ug8AXa52257022570euoutp01x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1616503404;
        bh=F9YbOt2z/GtVDoNDHvqo1d0D7rtuPi/FENivTe2yq7I=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=i8zgQ84PpqmMFvUjV6LX12JWdVr1wUbUhTWdKuRB3MOT0PCI6n2569Qsmaf9ZtGE0
         ipqLJ2UZCchqMi/oTZM9rTdOZnHr11R+LZck2CmuyujdmrcSbJqFOctBfbYg7BR2RK
         tUQvl/K40EENW5erIsTVV1mYoGxjbGJV+o02iubY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210323124324eucas1p23464d80e834a0702735d1e473b58c08d~u_UgzpKGS2660126601eucas1p2B;
        Tue, 23 Mar 2021 12:43:24 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 68.17.09452.C62E9506; Tue, 23
        Mar 2021 12:43:24 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210323124324eucas1p1b36ca121137d41e9c20cf8e9a684256d~u_UgemILe1361913619eucas1p1S;
        Tue, 23 Mar 2021 12:43:24 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210323124324eusmtrp168be8b4e8b7cd6c057ee36b9fb4e2250~u_Ugd6_je1369713697eusmtrp1T;
        Tue, 23 Mar 2021 12:43:24 +0000 (GMT)
X-AuditID: cbfec7f2-a9fff700000024ec-9f-6059e26c3269
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id CA.11.08696.C62E9506; Tue, 23
        Mar 2021 12:43:24 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210323124324eusmtip132a8513fcbd6ed470cb4a3fd9a1448ec~u_UgU6BZR1267512675eusmtip1t;
        Tue, 23 Mar 2021 12:43:24 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
        Server (TLS) id 15.0.1497.2; Tue, 23 Mar 2021 12:43:23 +0000
Received: from localhost (106.110.32.47) by CAMSVWEXC01.scsc.local
        (106.1.227.71) with Microsoft SMTP Server (TLS) id 15.0.1497.2 via Frontend
        Transport; Tue, 23 Mar 2021 12:43:23 +0000
Date:   Tue, 23 Mar 2021 13:43:22 +0100
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Keith Busch <kbusch@kernel.org>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>,
        <linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH 1/1] nvme-pci: add the DISABLE_WRITE_ZEROES quirk for a
 Samsung PM1725a
Message-ID: <20210323124322.qchyk7boyzklwv3v@mpHalley.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210323123121.GA31105@lst.de>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsWy7djP87o5jyITDFat0LKYdfs1i8XdN+9Z
        LFauPspkMenQNUaLy7vmsFnMX/aU3YHNY9OqTjaPzUvqPXbfbGDz+LxJzqP9QDeTx6uL69kD
        2KK4bFJSczLLUov07RK4Mk5Om85S0MxS8W3zFNYGxgXMXYycHBICJhI/Pn9jB7GFBFYwSlw/
        Ld/FyAVkf2GUeHfyESuE85lRYnrbPrYuRg6wjofNfhDx5YwSh48sY4MrOtXYxQzhnGGUaL+3
        lwnC2cso8XbVIlaQJSwCqhILHq1mArHZBOwlLi27BXaIiICSxNNXZxlBGpgFtjFKPDnwFuwq
        YYFYiR9TT4A18wrYSPRemMMMYQtKnJz5hAXEZhawkuj80MQKch+zgLTE8n8cEGF5ieats8HK
        OQV0JDoWnwC7TkLgA4fE/yszmCH+cZGY/DcBEhjCEq+Ob2GHsGUkTk/uYYGob2aUOLPmClRz
        D6PEn0krGCGarSX6zuRANDhKbD0zDxpGfBI33gpC3MAnMWnbdKhVvBIdbUIQ1WoSO5q2Mk5g
        VJ6F5JlZSJ6ZhfDMLCTPLGBkWcUonlpanJueWmyYl1quV5yYW1yal66XnJ+7iRGYgk7/O/5p
        B+PcVx/1DjEycTAeYpTgYFYS4W0Jj0gQ4k1JrKxKLcqPLyrNSS0+xCjNwaIkzrtq9pp4IYH0
        xJLU7NTUgtQimCwTB6dUA1OWQgW3ulBT1GTVG70btCsr1+61eFsgeGSGUOdpLt3or/+7ZGdf
        m31e6qP72lOfLpZq/TCvSLx70S568Y3roZrxzE/zdZsNNgtw8t4L//inLeLg3oWGhpurtz/q
        O9YRZ95sb5kx7YdtS9OsI+fM+e6G7ij2sIz+E2X85/Ztt5SDXTZZkgfsdk+8e+K72tuAD13+
        OgIxi8KSTjCvfZdTNklxaunUut0JHLufK9q5vbpTvf5prMoS9XT1qGezzWZZLQmf3PX8lsrn
        0vDSorYf4sujW31NHc0ffzy+Wl1wV8Mkyw5ZhjlSU/8Jek57s2kq34WKK4Et7y7uy8v5u62E
        bQe7t+Czh1tSbbbwnLexdVBiKc5INNRiLipOBAAawunZsAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsVy+t/xu7o5jyITDJafFrGYdfs1i8XdN+9Z
        LFauPspkMenQNUaLy7vmsFnMX/aU3YHNY9OqTjaPzUvqPXbfbGDz+LxJzqP9QDeTx6uL69kD
        2KL0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0Mk5O
        m85S0MxS8W3zFNYGxgXMXYwcHBICJhIPm/26GLk4hASWMkr8vrSeqYuREyguI/Hpykd2CFtY
        4s+1LjaIoo+MEmuW7mYDSQgJnGGUOLvQGiKxl1Fizpo5jCAJFgFViQWPVoNNYhOwl7i07BYz
        iC0ioCTx9NVZRpAGZoFtjBJPDrwFWyEsECvxY+oJVhCbV8BGovfCHGaIqROYJe5tPcgMkRCU
        ODnzCQuIzSxgITFz/nlGkB+YBaQllv/jgAjLSzRvnQ1WzimgI9Gx+ATzBEbhWUi6ZyHpnoXQ
        PQtJ9wJGllWMIqmlxbnpucVGesWJucWleel6yfm5mxiBsbjt2M8tOxhXvvqod4iRiYPxEKME
        B7OSCG9LeESCEG9KYmVValF+fFFpTmrxIUZTYFhMZJYSTc4HJoO8knhDMwNTQxMzSwNTSzNj
        JXFekyNr4oUE0hNLUrNTUwtSi2D6mDg4pRqYmuesCrqmsWsZz+fMF/PvbmwqPzhr+Txfi+cf
        J5joefTXi5x+EFJ9TENvyp8ljZp8SRM+vLm030Pnw9Kec3KfcqYvvrljUZaZM6O8crbt+uh0
        3i67XWaT/3zdyL6EP7j77qYXp56ouyaHuute2GnlXuQSupVTaPOdzTOlVj5tDpwyWcwtbe+0
        B3/Pf7jvfvoyy8LNSonX1AUNdAqjPDebeFj5Xki7enDz/e4Te5/OzNJWZ7Wy7z1upNWloGdu
        tYgvWW91bbNJfpjN6a9uJ2Lmze3ZXlNr7ZW5bdaheToxj1xOan6Ys0hxslr+25MWiZzO38Md
        ElyNn25x3lb16ruo1VfLqhvblHbe2T5DRMS1Q4mlOCPRUIu5qDgRAGZDw+pOAwAA
X-CMS-MailID: 20210323124324eucas1p1b36ca121137d41e9c20cf8e9a684256d
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.03.2021 13:31, Christoph Hellwig wrote:
>On Tue, Mar 23, 2021 at 09:37:49AM +0100, Javier González wrote:
>> Quick question. It seems like the current quirk simply disables
>> write-zeroes. Would you be open for a quirk that aligns with MDTS for
>> models that implemented it this way before TP4040?
>
>Aligning to MDTS is our current behavior, although all kernels up to
>5.11 had a bug in the calculation.

I see. Let me check internally and see what's going on with
write-zeroes on this model.
