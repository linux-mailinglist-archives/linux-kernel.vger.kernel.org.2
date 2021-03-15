Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE96433A994
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 03:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhCOCVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 22:21:02 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:29225 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhCOCUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 22:20:51 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210315022049epoutp0405bf9f77131add763e046aaaeea5d660~sYqobsx6D0188601886epoutp04M
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 02:20:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210315022049epoutp0405bf9f77131add763e046aaaeea5d660~sYqobsx6D0188601886epoutp04M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1615774849;
        bh=WJNqTjiih7FrucggwRYNztSZ0OR1d0+uBA23/e9KbM0=;
        h=To:Cc:From:Subject:Date:References:From;
        b=H8BQnSH2eie+ZQ/8ZlLaaxOsr8931HYzQ9vbZUyisqJ093Ga0IQzpAcxiJcrElL7M
         yIKSpFxb3c2EgFsJSacjJ5C5TU4X/hFdBgziRyLnZo6w65qJOGrNOdIyCjS2ZWtnDC
         CV413x0WC20MpRVEJHU81XlEYuoUvHn0KTLX4Wxw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210315022048epcas1p25f343560fc415e56bc19f0b35d174b69~sYqnxT00L1706917069epcas1p2X;
        Mon, 15 Mar 2021 02:20:48 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.157]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4DzKs84ynHz4x9Q1; Mon, 15 Mar
        2021 02:20:44 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        61.82.63458.B74CE406; Mon, 15 Mar 2021 11:20:43 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210315022041epcas1p1df3749fbe6488d47e58b2da0f64a9edb~sYqhnfXG_2977729777epcas1p1T;
        Mon, 15 Mar 2021 02:20:41 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210315022041epsmtrp1578289a2d9125def2a9b19fed5fe35a7~sYqhm4hCT0282102821epsmtrp1S;
        Mon, 15 Mar 2021 02:20:41 +0000 (GMT)
X-AuditID: b6c32a36-c6d65a800000f7e2-b7-604ec47bcb52
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        EC.70.08745.974CE406; Mon, 15 Mar 2021 11:20:41 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210315022041epsmtip1147c410b513fa95bece14ed64b43e28b~sYqhcV1hY2420524205epsmtip1g;
        Mon, 15 Mar 2021 02:20:41 +0000 (GMT)
To:     Greg KH <gregkh@linuxfoundation.org>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        chanwoo@kernel.org,
        "Chanwoo Choi (samsung.com)" <cw00.choi@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Subject: [GIT PULL] extcon fixes for v5.12-rc4
Organization: Samsung Electronics
Message-ID: <d1835c2d-f24a-4779-8c1a-beaa4bc5729c@samsung.com>
Date:   Mon, 15 Mar 2021 11:37:18 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmk+LIzCtJLcpLzFFi42LZdljTQLf6iF+CwbuZChYTb1xhsbj+5Tmr
        RfPi9WwWl3fNYbO43biCzYHVY9OqTjaP/XPXsHv0bVnF6PF5k1wAS1S2TUZqYkpqkUJqXnJ+
        SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QXiWFssScUqBQQGJxsZK+nU1R
        fmlJqkJGfnGJrVJqQUpOgWWBXnFibnFpXrpecn6ulaGBgZEpUGFCdsafY0/YCmZwVLzbsYGt
        gfEFWxcjJ4eEgInEpYY17F2MXBxCAjsYJWbs3MMM4XxilHjaMQ3K+cwose7EKVaYlk83Wlkg
        ErsYJT41XIBy3jNKPNzSzwxSJSIQL7G+9xbYYGaBXkaJNVd2grWzCWhJ7H9xA2y7sICeRMuW
        PewgNr+AosTVH48ZQWxeATuJa6v+gsVZBFQltn06DhYXFQiTOLmtBapGUOLkzCcsIDazgLjE
        rSfzmSBseYntb+eA3S0h8JZd4siqhUwQd7tIPLt2nx3CFpZ4dXwLlC0l8bK/Dcqullh58ggb
        RHMHo8SW/RegnjaW2L90MtAgDqANmhLrd+lDhBUldv6eywixmE/i3dceVpASCQFeiY42IYgS
        ZYnLD+5CnSApsbi9ExryHhJn/85jnsCoOAvJO7OQvDMLyTuzEBYvYGRZxSiWWlCcm55abFhg
        hBzfmxjBqVLLbAfjpLcf9A4xMnEwHmKU4GBWEuH9rOObIMSbklhZlVqUH19UmpNafIjRFBjA
        E5mlRJPzgck6ryTe0NTI2NjYwsTQzNTQUEmcN9HgQbyQQHpiSWp2ampBahFMHxMHp1QDE9cT
        NxH+bfuyl7LvsTw/O3ZOZMW75Fcvdha1rC3c6r2zLOaPs6jH2nvTKrh07G/8f3t+eXRL25cz
        Io/9Nrk+W3foYcjS4n82r4Vn9k57em7CYv6/mf9W3rDQWbSA2/i/gfaGMBHvkwXcD5/rNCgf
        3OUUmDb1yNvos6mBFQqeTwQLtDavF55qk79mpkKKR2n8TIaG8hclnYq1Tl1V1zqNlXdpCcQf
        WqrBVM25ar35HI3iGzWNP/giD9fHmQt3iTFwr5zUeKb1B6P3u2CN6CfvI5hzXgbXdf6fkdbV
        ffKApMxj64OJ9zpcz77frpZ0PmnPaf6NdzZ6K6iu+HVOpHbWRG3mrbt2H9q+Sef+cyH+mUos
        xRmJhlrMRcWJADKR0eseBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDLMWRmVeSWpSXmKPExsWy7bCSnG7lEb8Egz8NWhYTb1xhsbj+5Tmr
        RfPi9WwWl3fNYbO43biCzYHVY9OqTjaP/XPXsHv0bVnF6PF5k1wASxSXTUpqTmZZapG+XQJX
        xp9jT9gKZnBUvNuxga2B8QVbFyMnh4SAicSnG60sXYxcHEICOxglem9vg0pISky7eJS5i5ED
        yBaWOHy4GKLmLaPEr8/fwWpEBOIljq5+zAqSYBboZZTYMOk1K0iCTUBLYv+LG2BFwgJ6Ei1b
        9rCD2PwCihJXfzxmBLF5Bewkrq36CxZnEVCV2PbpOFhcVCBMYueSx0wQNYISJ2c+YQGxmQXU
        Jf7Mu8QMYYtL3HoynwnClpfY/nYO8wRGwVlIWmYhaZmFpGUWkpYFjCyrGCVTC4pz03OLDQuM
        8lLL9YoTc4tL89L1kvNzNzGCI0BLawfjnlUf9A4xMnEwHmKU4GBWEuH9rOObIMSbklhZlVqU
        H19UmpNafIhRmoNFSZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVANTZKnp4XDTHSs/CroxRmic
        FCjb1rz31N7Xv//O/Km4rTPra3sBm83v5LQSmV86bFMfnXRTNU55G7aPraQlgHdZxgcNy1UR
        z54kPXtu55DefSClWMbznW/I489KaQFFSW98rk6ak3H+yYsToVv2Ga2dv+DarMaWv9LLnv7e
        arguco9D2b3NPJfF1KZ+3fbMWa3jT3JyjOcv67zOPbwP0oXiypQzvaX/FOUdOV1Tx7vtl7ZG
        QrVaekXmtfjssj9rzKIefXgaqrbzwvkJP/9uy5fvVWs5eDFgmsT5Jok6VuVsxe3cRh2yax8d
        u9TX3+e4zinzQ+TUq4828x61mijhYN+x7cjnpanpaoebnSY8jf2rxFKckWioxVxUnAgATN8c
        Wu8CAAA=
X-CMS-MailID: 20210315022041epcas1p1df3749fbe6488d47e58b2da0f64a9edb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210315022041epcas1p1df3749fbe6488d47e58b2da0f64a9edb
References: <CGME20210315022041epcas1p1df3749fbe6488d47e58b2da0f64a9edb@epcas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,

This is extcon-fixes pull request for v5.12. I add detailed description of
this pull request on below. Please pull extcon with following updates.

Best Regards,
Chanwoo Choi


The following changes since commit 1e28eed17697bcf343c6743f0028cc3b5dd88bf0:

  Linux 5.12-rc3 (2021-03-14 14:41:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-fixes-for-5.12-rc4

for you to fetch changes up to d3bdd1c3140724967ca4136755538fa7c05c2b4e:

  extcon: Fix error handling in extcon_dev_register (2021-03-15 11:09:38 +0900)

----------------------------------------------------------------
Dinghao Liu (1):
      extcon: Fix error handling in extcon_dev_register

Krzysztof Kozlowski (1):
      extcon: Add stubs for extcon_register_notifier_all() functions

 drivers/extcon/extcon.c |  1 +
 include/linux/extcon.h  | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)
-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
