Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0475A31B6BB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 10:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhBOJuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 04:50:51 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:36286 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbhBOJuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 04:50:37 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210215094954epoutp045b2260be66890acbf86482824cb301f7~j4uwIpGhU0801308013epoutp04-
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 09:49:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210215094954epoutp045b2260be66890acbf86482824cb301f7~j4uwIpGhU0801308013epoutp04-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1613382594;
        bh=PVFbZ93e8iqMlDddHz6oMLG2JQ3zqy5IKMRcv/tLRNA=;
        h=From:To:Cc:Subject:Date:References:From;
        b=aCV7fGdRWNQCjUODZSv/sxaEwSuWJP7ETmfbUlECPSK1AABzvcYhko2/Cfz4BXO7f
         XTBPdMuTraSgpobXqP0/zuAKGr0tkqnriDe6NM5c/wWOa2AVB+6I8xmhK/XxGDbbXo
         BPrGTb5t/0Q0e8P3jWBGAZ3/c8MjuKHFu4D9F8og=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210215094954epcas1p3bd5b2f90e800f2589f1aedff73d19645~j4uv4wE3b0273302733epcas1p30;
        Mon, 15 Feb 2021 09:49:54 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.154]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4DfK8H2wV8z4x9QD; Mon, 15 Feb
        2021 09:49:51 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        A8.F5.10463.FB34A206; Mon, 15 Feb 2021 18:49:51 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210215094951epcas1p1f9ab27ece5ee0deaf64ac1f593bdc976~j4uslQBHl0465304653epcas1p1l;
        Mon, 15 Feb 2021 09:49:51 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210215094951epsmtrp159e419e6faebbe7b6469535b5a12ca76~j4uskkCcT2219322193epsmtrp19;
        Mon, 15 Feb 2021 09:49:51 +0000 (GMT)
X-AuditID: b6c32a38-f11ff700000028df-8a-602a43bf8633
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        70.2E.13470.EB34A206; Mon, 15 Feb 2021 18:49:51 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210215094950epsmtip22b963f92fe72e716ed684e15edc3abd7~j4usZTJXb1840318403epsmtip2I;
        Mon, 15 Feb 2021 09:49:50 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     gregkh@linuxfoundation.org
Cc:     cw00.choi@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] extcon: Add missing function defintion and update
 extcon driver
Date:   Mon, 15 Feb 2021 19:06:07 +0900
Message-Id: <20210215100610.19911-1-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAKsWRmVeSWpSXmKPExsWy7bCmnu5+Z60EgyezRCwm3rjCYnH9y3NW
        i+bF69ksLu+aw2Zxu3EFmwOrx6ZVnWwe++euYffo27KK0ePzJrkAlqhsm4zUxJTUIoXUvOT8
        lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygvUoKZYk5pUChgMTiYiV9O5ui
        /NKSVIWM/OISW6XUgpScAssCveLE3OLSvHS95PxcK0MDAyNToMKE7IyGu/+YC05yVjReusvY
        wPiNvYuRk0NCwETiwNaNzF2MXBxCAjsYJS59aGSBcD4xShz7Mh0q841RYsaX60xdjBxgLeff
        V0HE9zJKzJ59kBXC+cIocednHxPIXDYBLYn9L26wgdgiAnIST27/YQaxmQXSJX7/XscGMkhY
        IExi+ksjkDCLgKrE2saPYCfxClhJzOtewQRxnrzE6g0HwI6QEJjHLnHz4mlWiISLxJ3l26F+
        EJZ4dXwLlC0l8bK/Dcqullh58ggbRHMHo8SW/Regmo0l9i+dDPYNs4CmxPpd+hBhRYmdv+cy
        QtzJJ/Huaw8rxMO8Eh1tQhAlyhKXH9yFuk1SYnF7JxuE7SHx698CsOlCArESWz/3sU9glJ2F
        sGABI+MqRrHUguLc9NRiwwIT5EjaxAhOSloWOxjnvv2gd4iRiYPxEKMEB7OSCO9VCY0EId6U
        xMqq1KL8+KLSnNTiQ4ymwACbyCwlmpwPTIt5JfGGpkbGxsYWJoZmpoaGSuK8SQYP4oUE0hNL
        UrNTUwtSi2D6mDg4pRqYuBt33OSPL2w4nVyibJV8pe/BVObqZ39WPnHYLn376ncOcfYH3B+D
        413KBX/Fzjv4mzVKP+E8f/6mLNPu0G0Xkyd97tz6+6rChv0Z+6Rec5k8frqgLOX/YabJwfXt
        W/QWHFmy83uCkVlA0fPlq1bOXjinhY2b5Uj/9y3xduI2Ny77XuNVPqYr02HDdddw6goT48Kb
        4ssO/bBPnpBk3Xim4nJ1VKVSoa3oq1fVhV/Wl0jdPlDe7/AyiS/mpNtC4zVdkxSr5nhnrb+2
        55SY6rr7D1dNDvz2IvHzJOU/mgIv1k70vrvYaRm31oqiw1a1gYF22/SFf23QexvJveg+c59q
        rWbQBbZXP3Z6Md5Y2rnOVImlOCPRUIu5qDgRANjUNd7TAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHJMWRmVeSWpSXmKPExsWy7bCSvO5+Z60Eg94NTBYTb1xhsbj+5Tmr
        RfPi9WwWl3fNYbO43biCzYHVY9OqTjaP/XPXsHv0bVnF6PF5k1wASxSXTUpqTmZZapG+XQJX
        RsPdf8wFJzkrGi/dZWxg/MbexcjBISFgInH+fVUXIxeHkMBuRokHc16xdDFyAsUlJaZdPMoM
        USMscfhwMUTNJ0aJW+uPMILUsAloSex/cYMNxBYRkJN4cvsPM4jNLJAtMfnNelYQW1ggROLu
        3VtgM1kEVCXWNn5kB7F5Bawk5nWvYILYJS+xesMB5gmMPAsYGVYxSqYWFOem5xYbFhjmpZbr
        FSfmFpfmpesl5+duYgQHiZbmDsbtqz7oHWJk4mA8xCjBwawkwntVQiNBiDclsbIqtSg/vqg0
        J7X4EKM0B4uSOO+FrpPxQgLpiSWp2ampBalFMFkmDk6pBqbeJUwzk2ws979OcdReKu4TcvbJ
        Dq4NhjOsL/6r5f5i3zjD7Pm7WSXHHl74eXwNw2rD3pM1/1/N9vr5bjq//sZYOYvX0w378uVf
        RAdMWShwnGNu+sXHTyy701kj1yvHXeXsidPwmSwWdTOmgLW2pkeNXVGw78DEGZn3Uswf3lh8
        T/ac5J7/P6x+plVZpi5qndzzLWPGvYfXC31OGwpPVv30IuJ8//wJQTOyeXpcWNdyV73jXiGc
        /4n768x8X+a30u85724LvyAUX626eOHlrzFHFn19YjCnsihQ5YulML/1lDAz1TvrHHcu2sP/
        QPS+tFx0Scay1ve5X1ufvUzWv9b/ZUrc1Bm7RHe9Zj2/uqJLiaU4I9FQi7moOBEAmBWmM4EC
        AAA=
X-CMS-MailID: 20210215094951epcas1p1f9ab27ece5ee0deaf64ac1f593bdc976
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210215094951epcas1p1f9ab27ece5ee0deaf64ac1f593bdc976
References: <CGME20210215094951epcas1p1f9ab27ece5ee0deaf64ac1f593bdc976@epcas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of pull request for extcon next of v5.12, send the patches
because the pull request was too late for merging them.

Detailed description of this patchset as following:
- Add missing function definitions for extcon_register_notifier()
- Add charging interrupt handling such as CHGINS and CHGRM interrupt for extcon-max8997.c
- Detect OTG when USB_ID is connected to ground for extcon-sm5502.c

Reference of previous pull request,
[1] [GIT PULL ,v3] extcon next for v5.12
- https://lore.kernel.org/patchwork/patch/1380533/
[2] [GIT PULL v2] extcon next for v5.12
- https://lore.kernel.org/patchwork/patch/1379836/
[3] [GIT PULL] extcon next for v5.12
- https://lore.kernel.org/patchwork/patch/1378261/

Krzysztof Kozlowski (1):
  extcon: Add stubs for extcon_register_notifier_all() functions

Nikita Travkin (1):
  extcon: sm5502: Detect OTG when USB_ID is connected to ground

Timon Baetz (1):
  extcon: max8997: Add CHGINS and CHGRM interrupt handling

 drivers/extcon/extcon-max8997.c |  4 ++++
 drivers/extcon/extcon-sm5502.c  | 22 ++++++++++++++++++++--
 include/linux/extcon.h          | 23 +++++++++++++++++++++++
 3 files changed, 47 insertions(+), 2 deletions(-)

-- 
2.17.1

