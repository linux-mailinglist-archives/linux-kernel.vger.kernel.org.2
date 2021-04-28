Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C9E36D364
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 09:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236879AbhD1Hqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 03:46:42 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:26228 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhD1Hqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 03:46:40 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210428074554epoutp01c2501d9aca4115ff47ea498d2f0f011e~59fCE5m9n0859808598epoutp01I
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 07:45:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210428074554epoutp01c2501d9aca4115ff47ea498d2f0f011e~59fCE5m9n0859808598epoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1619595954;
        bh=HqbiJJEEgs5jUMz5TJpWMAnCbdchKGywZl4ZPqvG1WQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=qoFsIi+bIPG9gXA4YyHN8FIjUXha7ayws1JU2u0PZqu4nS+dqq/AOQD9zwSiM0xSl
         3INAqchhQ//mRaiOtnA9ZHqljqICvr+dzETf0SZDQJCm6sWgyR0dExxy0yRqtksAIu
         HjcQDvWHF1/GelKxMOyajHA2XO/oLjtJbWaTDYv4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210428074553epcas1p32092991ea803af0d28c1ba24224a6b24~59fBtvkxH2771127711epcas1p36;
        Wed, 28 Apr 2021 07:45:53 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.159]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4FVW004fBCz4x9Py; Wed, 28 Apr
        2021 07:45:52 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A8.C1.09701.EA219806; Wed, 28 Apr 2021 16:45:50 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210428074549epcas1p33641467e86ad0d0e3915d8ba0b936f90~59e976hZE2771127711epcas1p3w;
        Wed, 28 Apr 2021 07:45:49 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210428074549epsmtrp1362eb50950fa0366d19adbc3bd9a9bff~59e96taEd2454224542epsmtrp1x;
        Wed, 28 Apr 2021 07:45:49 +0000 (GMT)
X-AuditID: b6c32a36-631ff700000025e5-cf-608912ae1891
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        89.A9.08637.DA219806; Wed, 28 Apr 2021 16:45:49 +0900 (KST)
Received: from namjaejeon01 (unknown [10.89.31.77]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20210428074549epsmtip12374f6a3c214dfd9bfc74950ead80061~59e9uX4rW1914219142epsmtip1M;
        Wed, 28 Apr 2021 07:45:49 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Linus Torvalds'" <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>
Subject: [GIT PULL] exfat update for 5.13-rc1
Date:   Wed, 28 Apr 2021 16:45:49 +0900
Message-ID: <003c01d73c02$81e6b2a0$85b417e0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: Adc7x/brfov9na/wQX6hlyFfV4gC/w==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBKsWRmVeSWpSXmKPExsWy7bCmvu46oc4EgztHpC0u75rDZrHl3xFW
        i0d9b9kdmD1OzPjN4tG3ZRWjx+dNcgHMUTk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6
        hpYW5koKeYm5qbZKLj4Bum6ZOUCLlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkF
        hgYFesWJucWleel6yfm5VoYGBkamQJUJORnrJzczFazlrfi6ex9TA+MXri5GTg4JAROJ35Nf
        s3QxcnEICexglLj+5Dg7SEJI4BOjxMneHIjEN0aJZR962WA6zq3sZ4VI7GWUWNAM0/6CUWLy
        710sIFVsAroS//7sB+rg4BARMJP4tsQRJMws4C/RdvUwE4gtDFTy7fYysHIWAVWJV+92gC3g
        FbCUOD//HyOELShxcuYTFoheeYntb+cwQxyhIPHz6TJWEFtEQE9izY33rBA1IhKzO9uYQe6R
        EDjFLtFxeAnU1S4Spzr+M0LYwhKvjm9hh7ClJF72t7GD3CkhUC3xcT/U/A5GiRffbSFsY4mb
        6zewgpQwC2hKrN+lDxFWlNj5ey4jxFo+iXdfe1ghpvBKdLQJQZSoSvRdgvhWQkBaoqv9A9RS
        D4kNp36zT2BUnIXkyVlInpyF5JlZCIsXMLKsYhRLLSjOTU8tNiwwQo7qTYzgJKhltoNx0tsP
        eocYmTgYDzFKcDArifCy7WpNEOJNSaysSi3Kjy8qzUktPsRoCgz2icxSosn5wDScVxJvaGpk
        bGxsYWJmbmZqrCTOm+5cnSAkkJ5YkpqdmlqQWgTTx8TBKdXAtKK7uCOswjHM5WPOV7H0S0Hr
        /KfPk7i12XjLSR0Wb9/Sfzz9E+uFdB8tsYw/9fGL+S4x5RlucqlJDkefvX2k8ftE9slp4aUK
        uZVbLnZoi0mVicuw/73I3qXpIFfb8Vy54NuMn1+5uFmFBLn+KvE0COxeLH7TKn3W9eWvD7U3
        lx6YzTVl+cNDDAYuh0XTkl6kL1r9Vi7n/NGWmTVzj+z4fH93+wdvmTP6ey/yCypEZTw8zvRX
        UOftQ6fsJyf9zJZ2LokrbZ0yI+8x05c9h2qfsj/yyvLbNTkrN3ji/NfrN/icX27/p+TGqgNS
        qnorT0+8v7zpwOFLO/XED4XYGz8VtN7D1Gaf88SFRf5vgVOymRJLcUaioRZzUXEiAGleLcML
        BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBLMWRmVeSWpSXmKPExsWy7bCSnO5aoc4Eg/dXDCwu75rDZrHl3xFW
        i0d9b9kdmD1OzPjN4tG3ZRWjx+dNcgHMUVw2Kak5mWWpRfp2CVwZ6yc3MxWs5a34unsfUwPj
        F64uRk4OCQETiXMr+1m7GLk4hAR2M0rcXvGSGSIhLXHsxBkgmwPIFpY4fLgYouYZo8TJNa/B
        atgEdCX+/dnPBlIjImAm8W2JI4jJLOAvcf+yO0iFMFDFt9vLWEBsFgFViVfvdrCB2LwClhLn
        5/9jhLAFJU7OfMIC0aon0bYRLMwsIC+x/e0cqGMUJH4+XcYKYosAlay58Z4VokZEYnZnG/ME
        RsFZSCbNQpg0C8mkWUg6FjCyrGKUTC0ozk3PLTYsMMxLLdcrTswtLs1L10vOz93ECA5sLc0d
        jNtXfdA7xMjEwXiIUYKDWUmEl21Xa4IQb0piZVVqUX58UWlOavEhRmkOFiVx3gtdJ+OFBNIT
        S1KzU1MLUotgskwcnFINTAtfytsL3StqOLE4LHT+xr8zLC6cTxXaNelxbcychM6y9lc/152b
        5HhYeZGdvPnzBxK3LNZZKSpr2B+uSWs967s44Pc9/4RTnUfF1b/WzlQQ/HhtueOszRYP85PP
        md0xZpLgPzhZ3PRgvFrm4dKu/cpfY7f3Tb7sx/PWuMJin2X1cck9k/ULzurOPZ9tvHEZw+2l
        HsskOFYdbal+l/Tdquif13LThVqxgreWXDrNeM/Xpk1EdnJl0t+MGccW7ZV5Wndv7blVci6F
        Sr/F85dflXy16di0OE7/NUaqofEPXKuD/nX1Z763KGWr+eCr+NDzQHBI/aVddkwxqvbTctsE
        OIN8H7izOLM6rRUwTdlqpsRSnJFoqMVcVJwIAMHQnJ/bAgAA
X-CMS-MailID: 20210428074549epcas1p33641467e86ad0d0e3915d8ba0b936f90
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210428074549epcas1p33641467e86ad0d0e3915d8ba0b936f90
References: <CGME20210428074549epcas1p33641467e86ad0d0e3915d8ba0b936f90@epcas1p3.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is exfat update pull request for v5.13-rc1. I add description of
this pull request on below. Please pull exfat with following ones.

Thanks!

The following changes since commit 9f4ad9e425a1d3b6a34617b8ea226d56a119a717:

  Linux 5.12 (2021-04-25 13:49:08 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-5.13-rc1

for you to fetch changes up to c6e2f52e3051e8d898d38840104638ca8bbcdec2:

  exfat: speed up iterate/lookup by fixing start point of traversing cluster chain (2021-04-27 20:45:07 +0900)

----------------------------------------------------------------
Description for this pull request:
 - Improve write performance with dirsync mount option.
 - Improve lookup performance.
 - Add support for FITRIM ioctl.
 - Fix a bug with discard option.

----------------------------------------------------------------
Hyeongseok Kim (5):
      exfat: fix erroneous discard when clear cluster bit
      exfat: introduce bitmap_lock for cluster bitmap access
      exfat: add support ioctl and FITRIM function
      exfat: improve write performance when dirsync enabled
      exfat: speed up iterate/lookup by fixing start point of traversing cluster chain

 fs/exfat/balloc.c   | 95 ++++++++++++++++++++++++++++++++++++++++++++++-------
 fs/exfat/dir.c      | 26 +++++++++++----
 fs/exfat/exfat_fs.h | 11 +++++--
 fs/exfat/fatent.c   | 41 +++++++++++++++++------
 fs/exfat/file.c     | 53 ++++++++++++++++++++++++++++++
 fs/exfat/inode.c    |  3 +-
 fs/exfat/namei.c    | 11 +++++--
 fs/exfat/super.c    |  1 +
 8 files changed, 206 insertions(+), 35 deletions(-)

