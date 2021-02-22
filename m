Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E28FF321168
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 08:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbhBVHdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 02:33:22 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:43834 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbhBVHdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 02:33:20 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210222073236epoutp04ae7fcba3dc706db8b29a0c468d1f43c4~mAX3x3Z6y2562925629epoutp04h
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 07:32:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210222073236epoutp04ae7fcba3dc706db8b29a0c468d1f43c4~mAX3x3Z6y2562925629epoutp04h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1613979156;
        bh=iZx6VigwQWjjO26EiDbMB3w6IcCHTRwr/k8CxG1UNUM=;
        h=From:To:Cc:Subject:Date:References:From;
        b=WfQXZy/Mq6FoEkB7uAvjZeezNG5/0fuXY/UASzZ3gLfGEukKuhPWFBmEJFS7SgBdG
         5I9+a0kP5SnJdKUKN419F37pCUP2VYibvNHHJIaMb6prS1ycp8nX4Ts70dvOvsNiFz
         GKqOIYplodwFpXV0EWZTja5HArarSLfYa92b0quA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210222073236epcas1p1afd1640ecd82affc7d4ce2c3efe2f2d0~mAX3YNUhV3193931939epcas1p1d;
        Mon, 22 Feb 2021 07:32:36 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.165]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4DkYmg2zjNz4x9Pw; Mon, 22 Feb
        2021 07:32:35 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        69.5D.09582.01E53306; Mon, 22 Feb 2021 16:32:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210222073232epcas1p49025fce773d7139d71dc395dfdc383d8~mAXzp7z4K2830328303epcas1p4B;
        Mon, 22 Feb 2021 07:32:32 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210222073232epsmtrp1b883fc344e09462c93c2431d7599c0de~mAXzoiFCw2127521275epsmtrp1U;
        Mon, 22 Feb 2021 07:32:32 +0000 (GMT)
X-AuditID: b6c32a37-8afff7000000256e-11-60335e101f7e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        32.0C.13470.01E53306; Mon, 22 Feb 2021 16:32:32 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20210222073232epsmtip16d8905b2fa4798091b34f3554e65fa51~mAXzatb3e1733917339epsmtip1k;
        Mon, 22 Feb 2021 07:32:32 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Linus Torvalds'" <torvalds@linux-foundation.org>
Cc:     "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>
Subject: [GIT PULL] exfat update for 5.12-rc1
Date:   Mon, 22 Feb 2021 16:32:32 +0900
Message-ID: <00c601d708ec$e1d8e0f0$a58aa2d0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdcIuOJPanb1V4akSryL76uicXxxMQ==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOKsWRmVeSWpSXmKPExsWy7bCmrq5AnHGCQd8aM4vLu+awWWz5d4TV
        4lHfW3YHZo8TM36zePRtWcXo8XmTXABzVI5NRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGu
        oaWFuZJCXmJuqq2Si0+ArltmDtAiJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6B
        oUGBXnFibnFpXrpecn6ulaGBgZEpUGVCTsa0KV1MBT+4Ktau3MbUwDiFs4uRk0NCwERi6rxm
        xi5GLg4hgR2MEq9PzGUHSQgJfGKUeLVGEyLxjVHi/YMfbDAdVyYvYIUo2ssoMX97BkTRS0aJ
        R/tfg3WzCehK/PuzH6iBg0NEwEzi2xJHkDCzQK7Exw1NYCXCQCUrH08Cs1kEVCUezrsKNpNX
        wFKi5+ENdghbUOLkzCcsEL3yEtvfzmGGuEFB4ufTZWD1IgJ6Ej/m3GaDqBGRmN3Zxgxyj4TA
        OXaJxs4DTBANLhIrT32DahaWeHV8CzuELSXxsr+NHeROCYFqiY/7oUo6GCVefLeFsI0lbq7f
        wApSwiygKbF+lz5EWFFi5++5jBBr+STefe1hhZjCK9HRJgRRoirRd+kw1AHSEl3tH6CWekic
        +dbHMoFRcRaSJ2cheXIWkmdmISxewMiyilEstaA4Nz212LDAGDmmNzGCU6CW+Q7GaW8/6B1i
        ZOJgPMQowcGsJMLLdtcoQYg3JbGyKrUoP76oNCe1+BCjKTDYJzJLiSbnA5NwXkm8oamRsbGx
        hYmZuZmpsZI4b5LBg3ghgfTEktTs1NSC1CKYPiYOTqkGpv4QgVXBsbf0n7zytn18aP/Tp/x6
        8286KEq1HNOtY5K52bz6qZY0y/4Vz5OKIzvUWQ9MYbv7f0HOgvCw5aefFyrus0t6Yj1DlHXK
        Dybd2SoNOyJC/3+T8qpewPrA/c3vMOsL0fmOMQePLe9LkLmwZdXUbx/4Dl1c6FQidGHqqnW/
        5ul+3/du1fkDLdNmPN5+LmShhmXXVJkn4v+TXes961Pbw6sSLXvteKZWnRPcs351dkph+dlO
        W9FSr2drH7s+m96x4uwrnzbbJKXa+YrzS2YWqgnclM5xmP7IPHGv48ae9c0VRVZy+teD3H5I
        fkvb9i/lA1tXQ3jAjYjpHKyG17YvNFvN4GT0v2ode066kxJLcUaioRZzUXEiALjXkwAKBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsWy7bCSnK5AnHGCwaldwhaXd81hs9jy7wir
        xaO+t+wOzB4nZvxm8ejbsorR4/MmuQDmKC6blNSczLLUIn27BK6MaVO6mAp+cFWsXbmNqYFx
        CmcXIyeHhICJxJXJC1i7GLk4hAR2M0ocvfKNHSIhLXHsxBnmLkYOIFtY4vDhYoia54wSlzom
        g9WwCehK/Puznw2kRkTATOLbEkeQMLNArsSfmZtZQWxhoJKVjyeBlbMIqEo8nHcVLM4rYCnR
        8/AGO4QtKHFy5hMWkDHMAnoSbRsZIcbIS2x/O4cZ4hoFiZ9Pl4G1igCV/Jhzmw2iRkRidmcb
        8wRGwVlIJs1CmDQLyaRZSDoWMLKsYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQIDm0t
        zR2M21d90DvEyMTBeIhRgoNZSYSX7a5RghBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeC10n44UE
        0hNLUrNTUwtSi2CyTBycUg1M7ItapFZ4Xb8TtLpQml3IZ9b1H2v6ruYf/51w5GDZpTcqB1Ze
        mGthYHKRLaJFSaaCPdJ43eK/iV6sLYt+zri3Iiv54L00Fc6POe6yIWJTfSU+tD6f9eH3tKdT
        +8MM9nwUmfDW/GKtXE/ho7NXnq7/bxdndMA70eiJ7J9y6Y3Ldad1dabrb1XzPm/5j69J+I7X
        hwZT7yNeRizPPs6L7DL0L/4+PW+e5ZeiBRmLnx0q+BC7923Nvz7pU++NGtR+84vuTGaf88BH
        /4Xc+3fbirQs7A2ZNhcZbpZeEPL518PKVu4Hvz92LnpW/H//C0F/idQHJUtCjz9+HLrkPZPG
        HN5wx4U5z8o123nnn3nb0bJOWYmlOCPRUIu5qDgRAAkCHcvcAgAA
X-CMS-MailID: 20210222073232epcas1p49025fce773d7139d71dc395dfdc383d8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210222073232epcas1p49025fce773d7139d71dc395dfdc383d8
References: <CGME20210222073232epcas1p49025fce773d7139d71dc395dfdc383d8@epcas1p4.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is exfat update pull request for v5.12-rc1. I add description of
this pull request on below. Please pull exfat with following ones.

Thanks!

The following changes since commit f40ddce88593482919761f74910f42f4b84c004b:

  Linux 5.11 (2021-02-14 14:32:24 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-5.12-rc1

for you to fetch changes up to f728760aa923f1dd3a4818368dbdbd2c7d63b370:

  exfat: improve performance of exfat_free_cluster when using dirsync mount option (2021-02-22 09:55:14 +0900)

----------------------------------------------------------------
Description for this pull request:
- Improve file deletion performance with dirsync mount option.
- fix shift-out-of-bounds in exfat_fill_super() generated by syzkaller.

----------------------------------------------------------------
Hyeongseok Kim (1):
      exfat: improve performance of exfat_free_cluster when using dirsync mount option

Namjae Jeon (1):
      exfat: fix shift-out-of-bounds in exfat_fill_super()

 fs/exfat/balloc.c    |  4 ++--
 fs/exfat/exfat_fs.h  |  2 +-
 fs/exfat/exfat_raw.h |  4 ++++
 fs/exfat/fatent.c    | 43 +++++++++++++++++++++++++++++++++++++------
 fs/exfat/super.c     | 31 ++++++++++++++++++++++++++-----
 5 files changed, 70 insertions(+), 14 deletions(-)

