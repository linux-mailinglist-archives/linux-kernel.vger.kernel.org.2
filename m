Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3427C3459EB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 09:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhCWIi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 04:38:26 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:37621 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhCWIhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 04:37:53 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20210323083751euoutp02d4de61b5fee9100be6654e3692bf68b1~u6_HNimtY1416514165euoutp02E
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 08:37:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20210323083751euoutp02d4de61b5fee9100be6654e3692bf68b1~u6_HNimtY1416514165euoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1616488671;
        bh=RAJW6KXGMCgfP+KxJg+mnX3RSzCjtZMNvC5Qa4T70Iw=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=qg1dprvamhRUbo3/AcgKd5LrBampkc+ntGEJRbbx2vAn52YSRxaZ73+CwQloQ2XD+
         0FeGRBH/AhrlZcNrj3rYNrMTdB2IOMMH6pwQ+/6GJtAyphStjytwyE8GR4GBGlydkI
         /Gzxo6HEh+UWeenvW515+bs1MU85C1b/uazGpWnQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210323083751eucas1p1bfc19447901aa1737df2b8fee83a7e5f~u6_HDsipM1368513685eucas1p1e;
        Tue, 23 Mar 2021 08:37:51 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id C5.DB.09439.FD8A9506; Tue, 23
        Mar 2021 08:37:51 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210323083750eucas1p14d21230ac758194d854ca336caf7f3f2~u6_GyfjrA2514925149eucas1p1P;
        Tue, 23 Mar 2021 08:37:50 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210323083750eusmtrp15c88d878c40a90e53b03a356af76352c~u6_Gxh9_T0377003770eusmtrp15;
        Tue, 23 Mar 2021 08:37:50 +0000 (GMT)
X-AuditID: cbfec7f5-c03ff700000024df-ed-6059a8df690a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id DF.B3.08696.ED8A9506; Tue, 23
        Mar 2021 08:37:50 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210323083750eusmtip27e021e64b28aa1631915825ba88f0a01~u6_GpMQNb0860508605eusmtip2e;
        Tue, 23 Mar 2021 08:37:50 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
        Server (TLS) id 15.0.1497.2; Tue, 23 Mar 2021 08:37:50 +0000
Received: from localhost (106.110.32.47) by CAMSVWEXC01.scsc.local
        (106.1.227.71) with Microsoft SMTP Server (TLS) id 15.0.1497.2 via Frontend
        Transport; Tue, 23 Mar 2021 08:37:49 +0000
Date:   Tue, 23 Mar 2021 09:37:49 +0100
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Keith Busch <kbusch@kernel.org>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>,
        <linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH 1/1] nvme-pci: add the DISABLE_WRITE_ZEROES quirk for a
 Samsung PM1725a
Message-ID: <20210323083749.r272grolxozf3w2f@mpHalley.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline
In-Reply-To: <20210311104712.GA16218@lst.de>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsWy7djPc7r3V0QmGHxex2ox6/ZrFou7b96z
        WKxcfZTJYtKha4wWl3fNYbOYv+wpuwObx6ZVnWwem5fUe+y+2cDm8XmTnEf7gW4mj1cX17MH
        sEVx2aSk5mSWpRbp2yVwZXw4tISxYC9HxYHe9SwNjN/Zuhg5OSQETCQedyxn72Lk4hASWMEo
        sXRDKxOE84VRYseB2awgVUICnxklbkxghek4cPM9C0TRckaJj18WQ3UAFR2+DFIF4pxhlHg8
        cTNU2V6gWX9b2EH6WQRUJdpaLzCC2GwC9hKXlt1iBrFFBJQknr46ywjSwCywjVHiyYG3YA3C
        ArESP6aeAFvOK2AjcXPTHRYIW1Di5MwnYDazgJVE54cmoBoOIFtaYvk/DpAwp4COxMGdT5lB
        ZkoI3OCQ6N55hQniCReJ+Yv6WSBsYYlXx7ewQ9gyEqcn97BANDQzSpxZcwWqu4dR4s+kFYwg
        GyQErCX6zuRANDhKbD0zjw0izCdx460gxD18EpO2TWeGCPNKdLQJQVSrSexo2go1REbi6RqF
        CYxKs5A8MwvJM7MQnlnAyLyKUTy1tDg3PbXYOC+1XK84Mbe4NC9dLzk/dxMjMNmc/nf86w7G
        Fa8+6h1iZOJgPMQowcGsJMLbEh6RIMSbklhZlVqUH19UmpNafIhRmoNFSZx319Y18UIC6Ykl
        qdmpqQWpRTBZJg5OqQYmnxr/Mrbey7XrDXIj59z259PJvyS0l8XYqm+by1zHpdvVDbNz5byE
        neY3VLbukqvr1Lv7YPrF5IPLQiKdH19K07rwKIh1s8HUl1q9+bqiyhoSMrnLShgT5lluqN3U
        IVb5e0v4tfbtBdP+2pz6pWMmxZu1K1/q7I5d1du9moXveXkpKtUeTQx/+tTnknLQN4vef1bP
        7//b0bmnYc+rIDP/ROvbzy+UK73z27tbs5y571RUrod2doPwInYrg66tv6u/nbiqymr8XbBH
        sWf65qDI7ndz7vS86d4+adlC9c8F95n+qIjKhPVny5xkiZ36b0nRbAOv3arbbv94/OJs/reZ
        GbVHv9qs+bLp8Tv9gPlKLMUZiYZazEXFiQAVSPHApQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsVy+t/xe7r3VkQmGLy8a2Ax6/ZrFou7b96z
        WKxcfZTJYtKha4wWl3fNYbOYv+wpuwObx6ZVnWwem5fUe+y+2cDm8XmTnEf7gW4mj1cX17MH
        sEXp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZXw4
        tISxYC9HxYHe9SwNjN/Zuhg5OSQETCQO3HzP0sXIxSEksJRRYuqHbqiEjMSnKx/ZIWxhiT/X
        utggij4ySty5u5ARwjnDKLFoZTszhLOXUWLJ/SPMIC0sAqoSba0XGEFsNgF7iUvLboHFRQSU
        JJ6+OgvWzSywjVHiyYG3YDuEBWIlfkw9wQpi8wrYSNzcdAfqqOeMEjvu3GWCSAhKnJz5hAXE
        ZhawkJg5/zzQJA4gW1pi+T8OkDCngI7EwZ1PmScwCs1C0jELSccshI4FjMyrGEVSS4tz03OL
        jfSKE3OLS/PS9ZLzczcxAuNr27GfW3Ywrnz1Ue8QIxMH4yFGCQ5mJRHelvCIBCHelMTKqtSi
        /Pii0pzU4kOMpkA/T2SWEk3OB0Z4Xkm8oZmBqaGJmaWBqaWZsZI4r8mRNfFCAumJJanZqakF
        qUUwfUwcnFINTPoOr5d1pS7j84sSlY1sPywTeu3KzglbLQ9NbedM5X6j08nM807S6NPDDTHv
        JmYWmDe67g4/UXEseDV/14QmfxPDORKzj31yaSjTeT0zpGLC83NuqpW1AmFGRZwX8412y8l1
        PY6Na7qc/Ynz9BmJHfuYyhRbZ2jLnhP4bMld+snEwHXh5VUrrLaqzJ/h3OlRkCquzqo4U8rk
        8qTk7Mb3l66UmBgcOnLzSqyVGmPao4YnUgFz5jx/knjfdf4f4eX6p/6cuJ1gdapZqe/j2Q23
        zTKS6nos/4vbMTJsun5jTfjsCNnYN1/mX0k3mPphkvEhg/Qnna/XHJD0jLmx9cGSWU87v6jn
        /8x+zLXsZ+2ZIiWW4oxEQy3mouJEACMwrck4AwAA
X-CMS-MailID: 20210323083750eucas1p14d21230ac758194d854ca336caf7f3f2
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.03.2021 11:47, Christoph Hellwig wrote:
>On Wed, Mar 10, 2021 at 12:00:30PM -0800, Keith Busch wrote:
>> On Wed, Mar 10, 2021 at 02:41:10PM +0100, Christoph Hellwig wrote:
>> > On Wed, Mar 10, 2021 at 02:21:56PM +0100, Christoph Hellwig wrote:
>> > > Can you try this patch instead?
>> > >
>> > > http://lists.infradead.org/pipermail/linux-nvme/2021-February/023183.html
>> >
>> > Actually, please try the patch below instead, it looks like our existing
>> > logic messes up the units:
>>
>> This seems like a good opportunity to incorporate TP4040 for non-MDTS
>> command limits. I sent a proposal here
>>
>>   http://lists.infradead.org/pipermail/linux-nvme/2021-March/023522.html
>>
>> And it defaults to your suggestion if the controller doesn't implement
>> the capability.
>
>I think TP4040 is good and useful, but I defintively want the pure
>fix get in first.

Quick question. It seems like the current quirk simply disables
write-zeroes. Would you be open for a quirk that aligns with MDTS for
models that implemented it this way before TP4040?
