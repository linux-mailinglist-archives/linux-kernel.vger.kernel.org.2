Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7EE73510B9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 10:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbhDAIRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 04:17:31 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:45132 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbhDAIRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 04:17:17 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210401081715epoutp02e9afa73eb866322a1eedd5ab410a4663~xrfseB8Pw0212702127epoutp026
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 08:17:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210401081715epoutp02e9afa73eb866322a1eedd5ab410a4663~xrfseB8Pw0212702127epoutp026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1617265035;
        bh=vgbPXoR2wLvBR7QZ88GMHoPZAHxfQlH41VOC/Czif9g=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=Hvj54Vdw77qFxPIbwOqZM4WJ1bjFsqFn6hNbGApgo/3pEL3p7vRVoUW1rs5o7ufVW
         qbGb7H87rI7Oywh2aFzQr0y8fcKqmoeYmUG65HF4QAIV+EqC8+BvRJeBwWYtIX/ur0
         DNgWLu7rXjT/cEjA8P5e8U7MK0SxyyJWShCRlKas=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210401081714epcas1p3d04cef095c860f8d0fca63940df1e2c4~xrfr8_lVe1503215032epcas1p33;
        Thu,  1 Apr 2021 08:17:14 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.160]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4F9wyd5lsXz4x9Q2; Thu,  1 Apr
        2021 08:17:13 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        CA.45.02277.98185606; Thu,  1 Apr 2021 17:17:13 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210401081713epcas1p3aee989bb7fdfb07918cafe96ab6be33c~xrfqnQLhi1504115041epcas1p3t;
        Thu,  1 Apr 2021 08:17:13 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210401081713epsmtrp248a9eb5cfb39cb2fe6be4e61d6b8e9e4~xrfqmcNSP2201922019epsmtrp2T;
        Thu,  1 Apr 2021 08:17:13 +0000 (GMT)
X-AuditID: b6c32a36-4d7ff700000108e5-b0-606581897d8c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F3.A2.08745.98185606; Thu,  1 Apr 2021 17:17:13 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20210401081712epsmtip1f1cb5e77e7f1ca84725115f2c061b3da~xrfqXktBa0332003320epsmtip11;
        Thu,  1 Apr 2021 08:17:12 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Muhammad Usama Anjum'" <musamaanjum@gmail.com>,
        "'Sergey Senozhatsky'" <sergey.senozhatsky@gmail.com>,
        "'Steve French'" <sfrench@samba.org>,
        "'Hyunchul Lee'" <hyc.lee@gmail.com>,
        "'open list:COMMON INTERNET FILE SYSTEM SERVER \(CIFSD\)'" 
        <linux-cifs@vger.kernel.org>,
        "'open list:COMMON INTERNET FILE SYSTEM SERVER \(CIFSD\)'" 
        <linux-cifsd-devel@lists.sourceforge.net>,
        "'open list'" <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, <colin.king@canonical.com>,
        <dan.carpenter@oracle.com>
In-Reply-To: <20210401075531.GA2766105@LEGION>
Subject: RE: [PATCH] cifsd: fix memory leak when loop ends
Date:   Thu, 1 Apr 2021 17:17:13 +0900
Message-ID: <003901d726cf$6b75d890$426189b0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG8FoHjOwNMvoZKP6UmJNrFtYqTewIzYq1UqsPWbrA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNJsWRmVeSWpSXmKPExsWy7bCmgW5nY2qCwdZ36ha/V/eyWbz+N53F
        4tr99+wWW29JW7z4v4vZ4uf/74wWl3fNYbPY27qN0WLt58fsFh0vjzI7cHnMauhl89g56y67
        x+4Fn5k8Pj69xeIxd1cfo8fnTXIBbFE5NhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaW
        FuZKCnmJuam2Si4+AbpumTlAlykplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCgwN
        CvSKE3OLS/PS9ZLzc60MDQyMTIEqE3Iy2k6eZiqYwVwxZdZMlgbG00xdjBwcEgImEidWmnYx
        cnEICexglFj9sIsFwvnEKLGocxk7hPOZUWL7unVsXYycYB2L77yAqtrFKLFm8ylmCOclo8S6
        +VPAqtgEdCX+/dnPBpIQEehlkXj/9wgTSIJTQE9i4ocfzCC2sICVxP8ta1hAbBYBFYl362Yx
        gti8ApYSh6/dYoGwBSVOznwCZjMLyEtsfzuHGeIMBYmfT5exgtgiQHNWLJ/ODFEjIjG7sw3s
        IgmBlRwSD9a/Y4JocJHo7fzHCmELS7w6voUdwpaS+PxuLxskNKolPu6Hmt/BKPHiuy2EbSxx
        c/0GVpASZgFNifW79CHCihI7f89lhFjLJ/Huaw8rxBReiY42IYgSVYm+S4ehDpCW6Gr/ALXU
        Q6Lj9gXmCYyKs5A8OQvJk7OQPDMLYfECRpZVjGKpBcW56anFhgVGyJG9iRGcarXMdjBOevtB
        7xAjEwfjIUYJDmYlEV7hA4kJQrwpiZVVqUX58UWlOanFhxhNgcE+kVlKNDkfmOzzSuINTY2M
        jY0tTMzMzUyNlcR5Ew0exAsJpCeWpGanphakFsH0MXFwSjUwhZ6RCt8+Iy/TZNunO1wHbwWk
        P2ysbdBb8nqO6psJxvLzrwcfue/kGSsYUr3q+Rq12JqQTmVe3/u6N/ZfYGD8da373tWjPwUt
        TzmeNfHV1t9SueRtKcMK0ZgIxzsdfVHPOydcYLgmGvv3/QNdJZO4MkXBW67HAw/eVHY+enGC
        cN3Js49EBC5pluWs1QxIcpUOUnr4Kn5Nt2/LIz23pWkT1vKe9HRYmKu9KaQgnPfntG8Peg8w
        ZG8LD5w5X9U402JmvbjJjMe5v7Z9X82pLBg0I5Qtb8XWAxkWq/zPpYZn9L4+86xtpulPUaEn
        8Qd4Rf8aP+tsqy6Q+TP/XtPa8+ttFF8X3tCbdJzhAEv78ac8SizFGYmGWsxFxYkAT2wuwD4E
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42LZdlhJTrezMTXB4Nomdovfq3vZLF7/m85i
        ce3+e3aLrbekLV7838Vs8fP/d0aLy7vmsFnsbd3GaLH282N2i46XR5kduDxmNfSyeeycdZfd
        Y/eCz0weH5/eYvGYu6uP0ePzJrkAtigum5TUnMyy1CJ9uwSujLaTp5kKZjBXTJk1k6WB8TRT
        FyMnh4SAicTiOy9Yuhi5OIQEdjBKbNn3jR0iIS1x7MQZ5i5GDiBbWOLw4WKImueMEu+3vgGr
        YRPQlfj3Zz8bSEJEYCKLxLcFF8ESQgL1Emumv2UDsTkF9CQmfvjBDGILC1hJ/N+yhgXEZhFQ
        kXi3bhYjiM0rYClx+NotFghbUOLkzCcsIIuZgXrbNoKVMAvIS2x/O4cZ4jYFiZ9Pl7GC2CJA
        I1csn84MUSMiMbuzjXkCo9AsJJNmIUyahWTSLCQdCxhZVjFKphYU56bnFhsWGOWllusVJ+YW
        l+al6yXn525iBEeWltYOxj2rPugdYmTiYDzEKMHBrCTCK3wgMUGINyWxsiq1KD++qDQntfgQ
        ozQHi5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkGJr2zEb8XPVu3t8oy511Zadj6SK53gZVF
        Tk5TPorabWZiTlBVdgvZyP5w7RfFt4s/xvKvnPtwu+Tlc68UVyXJ1TvO+a4h5iDGOW850+9/
        3Rfl9JaqxS9+LWx7PjyCqeFkYZCibTn7588BhhuvTfLO/b+6Xz5YNnfRxolmXz3LC/5NNRTf
        /HiT5aNLvp3ZmhuL/D8UHPy6TSNroaVWXCWz1Bz2rN/tlzZ0FCsUdm89I7zW0u/T1bvPVN3D
        mRMYhF7fevBj0gyOv7qfE94lC/xnLRbwybTacYi9dUZWtgPbr7jZJvsyZ4ql3rl2ib3yUcGU
        H1a/f971cT7iovrDybbwDJPZNPtdT3Yau73O+MnBqMRSnJFoqMVcVJwIAHtoyzcbAwAA
X-CMS-MailID: 20210401081713epcas1p3aee989bb7fdfb07918cafe96ab6be33c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210401075539epcas1p3b7cb52923217b212c80185aab135fe22
References: <CGME20210401075539epcas1p3b7cb52923217b212c80185aab135fe22@epcas1p3.samsung.com>
        <20210401075531.GA2766105@LEGION>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Memory is being allocated and if veto_list is zero, the loop breaks without cleaning up the allocated
> memory. In this patch, the length check has been moved before allocation. If loop breaks, the memory
> isn't allocated in the first place. Thus the memory is being protected from leaking.
> 
> Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
I will apply. Thanks for your patch!

