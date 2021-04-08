Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E825A357C98
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 08:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbhDHG1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 02:27:21 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:50641 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhDHG1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 02:27:20 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210408062708epoutp03760eafd7679bd07916dc5926b1aa1864~zzgjKGFMw1719517195epoutp034
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 06:27:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210408062708epoutp03760eafd7679bd07916dc5926b1aa1864~zzgjKGFMw1719517195epoutp034
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1617863228;
        bh=R7rGjjvXxtZaWN8oUFSKjNosrBlTy2YoWS09dnwcrcQ=;
        h=From:Subject:To:Cc:Date:References:From;
        b=JFhiP3ooxdW9+eTTntTsqIjrxA5X/+q0yFbMJ/v2j9MxSlVJw93FPos4QJ6rztGBl
         4rPF74qFNC8M76gNzj5wnPivd5VbyqcR20XI6M82gBkC4ejy6MDz8wwZ8ey2d1I9vD
         Cd6nw9zPKu+JV9yg5ZXT1cvsl/uF/wf2wjIBizxg=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210408062707epcas1p1c14cd44f909a57d7413b6be483136bfd~zzgivk6HB3169731697epcas1p12;
        Thu,  8 Apr 2021 06:27:07 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.158]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4FGBBJ42kYz4x9Q1; Thu,  8 Apr
        2021 06:27:04 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        8A.16.23820.832AE606; Thu,  8 Apr 2021 15:27:04 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210408062703epcas1p22b2d793d4c5f7231964ff258e2ba40e5~zzgfGMFP12329223292epcas1p2D;
        Thu,  8 Apr 2021 06:27:03 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210408062703epsmtrp2f692124a8af1d43e1bed608201c8969f~zzgfCjppz2782227822epsmtrp2f;
        Thu,  8 Apr 2021 06:27:03 +0000 (GMT)
X-AuditID: b6c32a37-a59ff70000015d0c-2e-606ea238ae7f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E2.B5.08745.732AE606; Thu,  8 Apr 2021 15:27:03 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210408062703epsmtip17a35c74694002e3442bd498d5d744f5a~zzge2ortq1703017030epsmtip1N;
        Thu,  8 Apr 2021 06:27:03 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
Subject: [GIT PULL] extcon next for v5.13
Organization: Samsung Electronics
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        cw00.choi@samsung.com, chanwoo@kernel.org, cwchoi00@gmail.com,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
Message-ID: <6b1dea1d-331c-e349-6ff4-14585826cc52@samsung.com>
Date:   Thu, 8 Apr 2021 15:44:35 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRmVeSWpSXmKPExsWy7bCmga7ForwEgxk3ZSwm3rjCYnH9y3NW
        i2dHtS2aF69ns7i8aw6bxe3GFWwObB47Z91l99i0qpPNY//cNewefVtWMXp83iQXwBqVbZOR
        mpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdICSQlliTilQ
        KCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CyQK84Mbe4NC9dLzk/18rQwMDIFKgwITuj/216
        wXaBisYzm1gaGFfydjFycEgImEj03/HpYuTiEBLYwSjRtOsBWxcjJ5DziVFiwiI5iMRnRolt
        Pa+ZQRIgDZ/+vmCCSOxilGh5/J4NwnnPKHFrYgMLSBWbgJbE/hc3wEYJC2hKzL7Uxw5i8wso
        Slz98ZgRxBYR0JB4efQWC0gzs8BORon5L66CFfEK2Emsm/oXrJlFQEViwYafYKtFBcIkTm5r
        YYSoEZQ4OfMJ2DJmAXGJW0/mM0HY8hLb385hBhkqIfCTXeL1+n1Qd7tIXJ4/nQ3CFpZ4dXwL
        O4QtJfH53V6oeLXEypNH2CCaOxgltuy/wAqRMJbYv3QyEyjEmIHeWb9LHyKsKLHz91xGiMV8
        Eu++9rBCApVXoqNNCKJEWeLyg7tMELakxOL2TqhVHhKdxxvZJzAqzkLyziwk78xC8s4shMUL
        GFlWMYqlFhTnpqcWGxYYI0f2JkZw2tQy38E47e0HvUOMTByMhxglOJiVRHh39GYnCPGmJFZW
        pRblxxeV5qQWH2I0BQbwRGYp0eR8YOLOK4k3NDUyNja2MDE0MzU0VBLnTTJ4EC8kkJ5Ykpqd
        mlqQWgTTx8TBKdXAtEL8uYbgG9H8X6+kBd0NZF6Kru2rFF+uJBMoGfn2pJCBs8qT3ALW/NkV
        r7527l5+2pxZI6esKM5O89xbvbMfTq1If79MaUfd3aL7l+YnKjpWTCzV95a5LLaYjSN4RofE
        lJm/pH2CPgjwpCYsqPky4enmG+wxckzvN3hP7fU+s61rF4+3UNi0vJtszw1Zy6awZrs6+FVM
        tK485bZgpvb+hHaegHOa6/b2RGVyppunC9ufvrNy2wHP3rUrbjYkW07dzNFxL8k069fjmfOP
        ad1g1zymX7xtd1Gy3Kt2bp59TftuH2c4s2DOhaXMefszv006/Piau+omkTlzGETnPjYVU8g6
        MlnJsoXDyvNeGb+eEktxRqKhFnNRcSIA9rELVCQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsWy7bCSnK75orwEg97dhhYTb1xhsbj+5Tmr
        xbOj2hbNi9ezWVzeNYfN4nbjCjYHNo+ds+6ye2xa1cnmsX/uGnaPvi2rGD0+b5ILYI3isklJ
        zcksSy3St0vgyuh/m16wXaCi8cwmlgbGlbxdjJwcEgImEp/+vmDqYuTiEBLYwSixdv8NdoiE
        pMS0i0eZuxg5gGxhicOHiyFq3jJKHHlwhgmkhk1AS2L/ixtsILawgKbE7Et9YL38AooSV388
        ZgSxRQQ0JF4evcUC0swssJNRYumyFmaQBK+AncS6qX/BmlkEVCQWbPgJFhcVCJPYueQxE0SN
        oMTJmU9YQGxmAXWJP/MuMUPY4hK3nsxngrDlJba/ncM8gVFwFpKWWUhaZiFpmYWkZQEjyypG
        ydSC4tz03GLDAqO81HK94sTc4tK8dL3k/NxNjOCI0NLawbhn1Qe9Q4xMHIyHGCU4mJVEeHf0
        ZicI8aYkVlalFuXHF5XmpBYfYpTmYFES573QdTJeSCA9sSQ1OzW1ILUIJsvEwSnVwLSleHqt
        67o/M10T72p3afKWp+9ZtLZAJvfvX8HaKwc5J8xR6v9uqd0isUcud1dC8Ycnlo3aM7+l7mHM
        U/K3dV18h+drq+72WTtSPmx0X23gfM2r4+m0n+sutvxymK1XsFQ6hVPgul7M4ZKmc0lfWlhc
        I203mOfJ1c2p8rit8juK7+iBjIRuZn+PZaFnm+Izf1TYcAdb9L82ybizYm3llacNbFulzQ8v
        8HeOE1e9vS/OsDr+hKK5wO4pzCG+9q0G/x692WU/O15y/9Wl2Y+YvdzeXk5MXjr7ieh8tZdB
        MlyqvyM2W+nG1B4t6ImNDeeq3pkTbf63XiXM6FuNm3FNQZ5BAFeRFKfTvJZzKtOUWIozEg21
        mIuKEwEVUNsK9wIAAA==
X-CMS-MailID: 20210408062703epcas1p22b2d793d4c5f7231964ff258e2ba40e5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210408062703epcas1p22b2d793d4c5f7231964ff258e2ba40e5
References: <CGME20210408062703epcas1p22b2d793d4c5f7231964ff258e2ba40e5@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,

This is extcon-next pull request for v5.13. I add detailed description of
this pull request on below. Please pull extcon with following updates.

Best Regards,
Chanwoo Choi


The following changes since commit e49d033bddf5b565044e2abe4241353959bc9120:

  Linux 5.12-rc6 (2021-04-04 14:15:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-5.13

for you to fetch changes up to 7b1222b224aff41739319ae81cd266825464ad8f:

  extcon: qcom-spmi: Add support for VBUS detection (2021-04-08 13:10:16 +0900)

----------------------------------------------------------------

Detailed description for this pull request:

1. Update extcon provider driver
- Add the support of charging interrupt to detect charger connector
for extcon-max8997.c

- Detect OTG when USB_ID pin is connected to ground for extcon-sm5502.c

- Add the support for VBUS detection for extcon-qcom-spmi-misc.c
and replace qcom,pm8941-misc binding document with yaml style.

----------------------------------------------------------------
Anirudh Ghayal (1):
      extcon: qcom-spmi: Add support for VBUS detection

Guru Das Srinagesh (2):
      bindings: pm8941-misc: Convert bindings to YAML
      bindings: pm8941-misc: Add support for VBUS detection

Nikita Travkin (1):
      extcon: sm5502: Detect OTG when USB_ID is connected to ground

Timon Baetz (1):
      extcon: max8997: Add CHGINS and CHGRM interrupt handling

 .../bindings/extcon/qcom,pm8941-misc.txt           | 41 ---------
 .../bindings/extcon/qcom,pm8941-misc.yaml          | 62 ++++++++++++++
 drivers/extcon/extcon-max8997.c                    |  4 +
 drivers/extcon/extcon-qcom-spmi-misc.c             | 99 +++++++++++++++++-----
 drivers/extcon/extcon-sm5502.c                     | 22 ++++-
 5 files changed, 166 insertions(+), 62 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.txt
 create mode 100644 Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.yaml
