Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919A44370F5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 06:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbhJVEfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 00:35:38 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:33159 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbhJVEff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 00:35:35 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20211022043317epoutp033ae44260094b28982cda2604f996c93a~wQCYlwpJb2504325043epoutp03W
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 04:33:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20211022043317epoutp033ae44260094b28982cda2604f996c93a~wQCYlwpJb2504325043epoutp03W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1634877197;
        bh=0U3l0OVhxApoSO19qfFa2vX6tNlXFReVvNSbNiNvaUs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bF5F1N4j9Mg88cnRRiaMA8UG/9IaQK2JzOlMnirndFslkFyGDmMjDiesaERreLHZC
         HvydIiDCp4yG+/nK1KWewe5X8gRS8k1lYX34FipQLOgdNR8A/SrnP2w5KjyvRxGkBh
         TfkEgP37Sh29WW02eoXWL7FuL7/PLiztyOk6kAGc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20211022043316epcas1p33211a107bb8d57bb36795f910612bc2c~wQCYO9l7z2899928999epcas1p3I;
        Fri, 22 Oct 2021 04:33:16 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.249]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4HbBL05rQrz4x9QZ; Fri, 22 Oct
        2021 04:33:12 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        3E.68.10331.60F32716; Fri, 22 Oct 2021 13:33:10 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20211022043310epcas1p22952e8fa3eb3675717badae9a3e1223e~wQCSULdFP2262222622epcas1p2C;
        Fri, 22 Oct 2021 04:33:10 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20211022043310epsmtrp257ef8fa922c04b1680ceefba8899a3fe~wQCSTXTtt2106121061epsmtrp2j;
        Fri, 22 Oct 2021 04:33:10 +0000 (GMT)
X-AuditID: b6c32a38-cafff7000000285b-56-61723f063841
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EC.22.08902.60F32716; Fri, 22 Oct 2021 13:33:10 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.98.109]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20211022043310epsmtip27fb0aa2b66c8d96db828d6d834f669e0~wQCR-fiLu1328013280epsmtip2X;
        Fri, 22 Oct 2021 04:33:10 +0000 (GMT)
From:   Manjong Lee <mj0123.lee@samsung.com>
To:     willy@infradead.org
Cc:     akpm@linux-foundation.org, hch@infradead.org,
        jisoo2146.oh@samsung.com, junho89.kim@samsung.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mj0123.lee@samsung.com, nanich.lee@samsung.com,
        seunghwan.hyun@samsung.com, sookwan7.kim@samsung.com,
        yt0928.kim@samsung.com
Subject: Re:Re: [PATCH 1/1] mm: bdi: Initialize bdi_min_ratio when bdi
 unregister
Date:   Fri, 22 Oct 2021 22:39:47 +0900
Message-Id: <20211022133947.14874-1-mj0123.lee@samsung.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <YXIoxefk8UDDCt0M@casper.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKJsWRmVeSWpSXmKPExsWy7bCmvi6bfVGiwbNrRhZz1q9hszg9YRGT
        Rc+TJlaLrw+LLS7vmsNmcW/Nf1aL6ZvnMFtcu3+G3eLcyU+sFvMeO1j8/gGUXL/3J5sDj8fm
        FVoemz5NYvc4MeM3i0ffllWMHp83yQWwRmXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjq
        GlpamCsp5CXmptoqufgE6Lpl5gAdp6RQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkp
        MCvQK07MLS7NS9fLSy2xMjQwMDIFKkzIzvh80LRgOmfFqb3TWRsYF7J3MXJySAiYSBw7fZOx
        i5GLQ0hgB6PE1q3zmSGcT4wS+/etgXK+MUqc+PsZruXViwssEIm9jBJPZ+2G6v/MKLGgcRtY
        FZuAlsTyZxfAbBEBcYljU0+CFTELzGSSuPHhFxNIQlggWOLfyS6wIhYBVYmnV1exgdi8AtYS
        uw49ZoZYJy9xatlBsHpOoNUN8xayQtQISpyc+YQFxGYGqmneOhvsVgmBXg6J7YdeQN3qIvH6
        SAOULSzx6vgWKFtK4vO7vWwQDd2MEp17DkB19zBKzPjRDVVlLPHp82eguzmAVmhKrN+lDxFW
        lNj5ey4jxGY+iXdfe1hBSiQEeCU62oQgSlQkdjd/g9v15tUBRgjbQ+JUz2s2SHC1M0p8fPyX
        cQKjwiwkD81C8tAshM0LGJlXMYqlFhTnpqcWGxaYwCM5OT93EyM4vWpZ7GCc+/aD3iFGJg7G
        Q4wSHMxKIry7K/IThXhTEiurUovy44tKc1KLDzGaAoN7IrOUaHI+MMHnlcQbmlgamJgZmVgY
        WxqbKYnzfpYrTBQSSE8sSc1OTS1ILYLpY+LglGpgiolru6rPzNVVoZIsqr0qQ/d65mRR51Rf
        Rz+JwCbRi7dljhj/K2rirbByirn3Id0n/Onllz+YTbRnTfNdel3g5kvfQxM2iPp8Xb0kLkX3
        WIPcGf6v91tVq0xYxdesWZBUrX16kVnWrIMccayXPfb6+DKoTgi7rW5RcbUk/8Pfn0sYHrvf
        NhbvcTy8ne0c+4zEJedqG+eGijVJKM40+MKasXvDC/n+B1YFnFyFgcfuLAipefn9fGN56w6V
        PuUP3dsmsBe/iF1Y8NPTStRTy2z+q+IZpyJLf672DBI03nqkd9IRGRZp1S23ZcJmfza5FrfR
        rN39ygFOWfeHj6f0zPP4t/aO07bXmUc21TSv37tTiaU4I9FQi7moOBEAHsBYhzgEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDLMWRmVeSWpSXmKPExsWy7bCSvC6bfVGiwc9dEhZz1q9hszg9YRGT
        Rc+TJlaLrw+LLS7vmsNmcW/Nf1aL6ZvnMFtcu3+G3eLcyU+sFvMeO1j8/gGUXL/3J5sDj8fm
        FVoemz5NYvc4MeM3i0ffllWMHp83yQWwRnHZpKTmZJalFunbJXBlfD5oWjCds+LU3umsDYwL
        2bsYOTkkBEwkXr24wNLFyMUhJLCbUWLaxNNQCSmJeWsb2LoYOYBsYYnDh4shaj4ySqz98psF
        pIZNQEti+bMLYPUiAuISx6aeZAQpYhZYziQxrWkTG0hCWCBQYsKVJ8wgNouAqsTTq6vA4rwC
        1hK7Dj1mhlgmL3Fq2UEmEJsT6KKGeQtZQWwhAWOJ5p9zWSHqBSVOznwCtpgZqL5562zmCYwC
        s5CkZiFJLWBkWsUomVpQnJueW2xYYJiXWq5XnJhbXJqXrpecn7uJERwBWpo7GLev+qB3iJGJ
        g/EQowQHs5II7+6K/EQh3pTEyqrUovz4otKc1OJDjNIcLErivBe6TsYLCaQnlqRmp6YWpBbB
        ZJk4OKUamGTEJDa7TJp8yyvltKHt7Vw3XuvYO/Nv3DRp+Hv078FtfyY53GPebTHrt+qxhZPF
        Qnl/ytZzJEjti+9R4VwUdcchObv9zracq0f3lXzWm7XxbwxXO8PO8kgdA+VJzwJPlk5liC7z
        7jE78E/5zL+Hn3y3s3y98uXj9Eer53/WzHT3lFb9tuwo2/SX94pKBCQudeawaH26rHaqLi89
        YS8//9Zjb2XzSkSdy8+bHD/+5/2RYwa7d8c7bq/3MW06cu/t662r2sTbp85dFhzcWP535e+7
        nXd+Hf68y0xwyVsJlTzL1P/+/77+kPKJlhXa2n0oO2de1oL2LQ9u/RTMYp0k03U7oMRJSoOz
        Tcal5uLSbHclluKMREMt5qLiRACj9u5w7wIAAA==
X-CMS-MailID: 20211022043310epcas1p22952e8fa3eb3675717badae9a3e1223e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211022043310epcas1p22952e8fa3eb3675717badae9a3e1223e
References: <YXIoxefk8UDDCt0M@casper.infradead.org>
        <CGME20211022043310epcas1p22952e8fa3eb3675717badae9a3e1223e@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Thu, Oct 21, 2021 at 07:45:30PM -0700, Andrew Morton wrote:
>> On Thu, 21 Oct 2021 13:01:30 +0100 Matthew Wilcox <willy@infradead.org> wrote:
>> 
>> > On Thu, Oct 21, 2021 at 04:16:52AM -0700, Christoph Hellwig wrote:
>> > > On Fri, Oct 22, 2021 at 01:19:43AM +0900, Manjong Lee wrote:
>> > > > Because when sdcard is removed, bdi_min_ratio value will remain.
>> > > > Currently, the only way to reset bdi_ min_ratio is to reboot.
>> > > 
>> > > But bdis that are unregistered are never re-registered.  What is
>> > > the problem you're trying to solve?
>> > 
>> > The global bdi_min_ratio needs to be adjusted.  See
>> > bdi_set_min_ratio() in mm/page-writeback.c.
>> 
>> I added cc:stable to this and tweaked the comment & coding style a bit:
>
>Definitely improvements on that front.
>
>I don't know the BDI code particularly well, and the implementation of
>bdi_set_min_ratio() confuses me, so I can't say whether the original
>patch is clearly correct or not.


Thank Andrew Morton for modifying the comment & style. :)

Dear Matthew Wilcox. 
Please tell me about it more? I want to know more, 
and I want to find a way to improve it. :)
