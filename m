Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1D003B173B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 11:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhFWJvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 05:51:06 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:59628 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbhFWJvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 05:51:04 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210623094845epoutp020d04c69e3d1b913ce99c2b936cdbf05a~LLSSXcDYM1046310463epoutp025
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 09:48:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210623094845epoutp020d04c69e3d1b913ce99c2b936cdbf05a~LLSSXcDYM1046310463epoutp025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1624441725;
        bh=Exl+MkuV26OXs288zirbzDdW8ZVkFMLfTtSOkNSuniI=;
        h=To:Cc:From:Subject:Date:References:From;
        b=sXRB9mxOE/ANCvDPOCXgztCF5EcQpB0RnptXkMFNQC4SKsAMAs/91mNn/JjdGB/Wp
         uE+KKs7hn1mkpubRF4iMCpzlwbl2NeSGwj5da6KBKNQinvhStAV6LQGsNi/P9h887H
         TOgB3tAuUCbe0S9Bu7wkCrUbDR4yAEu9jssYUjlQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210623094845epcas1p3d82256c46a2d040fc414ce262e44da61~LLSSCNzjH1482514825epcas1p3x;
        Wed, 23 Jun 2021 09:48:45 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.152]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4G8z3s6Ck0z4x9Q2; Wed, 23 Jun
        2021 09:48:41 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        82.F8.09586.97303D06; Wed, 23 Jun 2021 18:48:41 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210623094841epcas1p16ed20c34344bde1fd1720e8ca73d4ad3~LLSOHZRzV1907819078epcas1p1R;
        Wed, 23 Jun 2021 09:48:41 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210623094841epsmtrp2838ddd625413a07722cfa984011b8f7b~LLSOGti8X0538905389epsmtrp2P;
        Wed, 23 Jun 2021 09:48:41 +0000 (GMT)
X-AuditID: b6c32a39-857ff70000002572-d8-60d303792ecd
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        FB.CC.08289.97303D06; Wed, 23 Jun 2021 18:48:41 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210623094840epsmtip1158e38819bac92623e08b93a6e3b69d0~LLSN5XQoc1020810208epsmtip1W;
        Wed, 23 Jun 2021 09:48:40 +0000 (GMT)
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (samsung.com)" <cw00.choi@samsung.com>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Subject: [GIT PULL] extcon next for v5.14
Organization: Samsung Electronics
Message-ID: <985190ea-dafc-875e-49d5-e40011c00406@samsung.com>
Date:   Wed, 23 Jun 2021 19:07:55 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgk+LIzCtJLcpLzFFi42LZdlhTX7eS+XKCweMuDYuJN66wWFz/8pzV
        onnxejaLy7vmsFncblzB5sDqsWlVJ5vH/rlr2D36tqxi9Pi8SS6AJSrbJiM1MSW1SCE1Lzk/
        JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwdor5JCWWJOKVAoILG4WEnfzqYo
        v7QkVSEjv7jEVim1ICWnwLJArzgxt7g0L10vOT/XytDAwMgUqDAhO2PJzj2MBZv5Kz43vWFq
        YJzI08XIySEhYCLxYe1Vli5GLg4hgR2MEnsO97GDJIQEPjFKLJusCJH4zCgxefd5NpiOIzv7
        mSESuxgl5h7eygThvGeUuDN7HyNIlYiAhsTLo7fA5jILvGGU2Pe5kxUkwSagJbH/xQ2wUcIC
        mhJnzk0Ea+AXUJS4+uMxkM3BwStgJ9E1RwckzCKgKrFo5mSwVlGBMImT21rAynkFBCVOznzC
        AmIzC4hL3HoynwnClpfY/nYO2HUSAh/ZJdZf/coOMlNCwEXi7IVSiA+EJV4d38IOYUtJfH63
        F+qzaomVJ4+wQfR2MEps2X+BFSJhLLF/6WQmkDnMQDev36UPEVaU2Pl7LiPEXj6Jd197WCFW
        8Up0tAlBlChLXH5wlwnClpRY3N4JtcpD4v6TaWwTGBVnIflmFpJvZiH5ZhbC4gWMLKsYxVIL
        inPTU4sNC0yRI3sTIzhJalnuYJz+9oPeIUYmDsZDjBIczEoivI9aLiUI8aYkVlalFuXHF5Xm
        pBYfYjQFhu9EZinR5Hxgms4riTc0NTI2NrYwMTQzNTRUEufdyXYoQUggPbEkNTs1tSC1CKaP
        iYNTqoHJ8ldc12r+9LafPRX/bS/OuVV/b9aGFvNM3uMtItkNb/8mzoz9be/9rGHN7jmXlD8m
        xTwuOqs/nfdWxR7ZK3Kh/RdsOsxcmBWDuVx/1ndW6X9Z8DyLZ5nRBX/5tITgxqd9nS6Czy5y
        tDlIN135qnfUNbLjTuLvH9eFtiVNWD49LTr3+FOZZrkiFcUOO8sY3z1ryj4XXy1euIxNeose
        76OgvbFL97Yya52XK/vg6+R8wPfhc0OVqSeOCM1OuT1lYti53ZGfavWnvUlfLbgq8fF15/m2
        jZ+qS953savlWFhOXq/d/V3y8G1vvrxbPUfZ/jk+tXOdIXjQ7rGPctfbpQEyDVdSD2U+ErQS
        WFLQP0GJpTgj0VCLuag4EQCqwO7XGwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNLMWRmVeSWpSXmKPExsWy7bCSnG4l8+UEg3Wv2C0m3rjCYnH9y3NW
        i+bF69ksLu+aw2Zxu3EFmwOrx6ZVnWwe++euYffo27KK0ePzJrkAligum5TUnMyy1CJ9uwSu
        jCU79zAWbOav+Nz0hqmBcSJPFyMnh4SAicSRnf3MXYxcHEICOxgllv++yA6RkJSYdvEoUIID
        yBaWOHy4GKLmLaPEwV39YDUiAhoSL4/eYgFJMAu8YZToX7MFLMEmoCWx/8UNNhBbWEBT4sy5
        iYwgNr+AosTVH48ZQYbyCthJdM3RAQmzCKhKLJo5mRXEFhUIk9i55DETiM0rIChxcuYTFhCb
        WUBd4s+8S8wQtrjErSfzmSBseYntb+cwT2AUnIWkZRaSlllIWmYhaVnAyLKKUTK1oDg3PbfY
        sMAoL7Vcrzgxt7g0L10vOT93EyM4/LW0djDuWfVB7xAjEwfjIUYJDmYlEd5HLZcShHhTEiur
        Uovy44tKc1KLDzFKc7AoifNe6DoZLySQnliSmp2aWpBaBJNl4uCUamByFhRev+1+sU6x7N2M
        +q87nmVKfNh+v3lp2ufox108Ny/e57ZoOxzImhc+yat4WlnvrczSDv+ieXFcKWnnHGs1aycc
        5WE1YdzM8vmE05GdPDZ/nZ7OXaPQezlgWvLiXdoacUZnb7fJq2/Y0vJ1/kKTOae1C3hEneyu
        cEwTufrZaPKtvRWnpq6Ofy2tXhExnfvtR8Fvq/wXxv7Pl2eU5xcXWxlqpXK0rajDnCe/oFro
        6MT7uS8tGRMc5Ds+73lmJrGjp2OXZFtH4vozpyTkOPwTzBY/urxZ40njhpyjknP+h7FnqCzz
        f/5wsXPWnuDaC8bdYvoxKa588UnBFhZNecEPNsydlr3m/+kPv7zXNimxFGckGmoxFxUnAgAp
        k1co7gIAAA==
X-CMS-MailID: 20210623094841epcas1p16ed20c34344bde1fd1720e8ca73d4ad3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210623094841epcas1p16ed20c34344bde1fd1720e8ca73d4ad3
References: <CGME20210623094841epcas1p16ed20c34344bde1fd1720e8ca73d4ad3@epcas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,

This is extcon-next pull request for v5.14. I add detailed description of
this pull request on below. Please pull extcon with following updates.

Best Regards,
Chanwoo Choi

The following changes since commit 009c9aa5be652675a06d5211e1640e02bbb1c33d:

  Linux 5.13-rc6 (2021-06-13 14:43:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-5.14

for you to fetch changes up to d97c0ff5a124f48109c4b32d6471c7bccd497009:

  extcon: sm5502: Add support for SM5504 (2021-06-21 18:28:01 +0900)

----------------------------------------------------------------
Ferry Toth (1):
      extcon: intel-mrfld: Sync hardware and software state on init

Marek Szyprowski (1):
      extcon: max8997: Add missing modalias string

Stephan Gerhold (7):
      extcon: sm5502: Drop invalid register write in sm5502_reg_data
      extcon: sm5502: Use devm_regmap_add_irq_chip()
      extcon: sm5502: Implement i2c_driver->probe_new()
      dt-bindings: extcon: sm5502: Convert to DT schema
      dt-bindings: extcon: sm5502: Document siliconmitus,sm5504-muic
      extcon: sm5502: Refactor driver to use chip-specific struct
      extcon: sm5502: Add support for SM5504

 .../devicetree/bindings/extcon/extcon-sm5502.txt   |  21 --
 .../bindings/extcon/siliconmitus,sm5502-muic.yaml  |  52 +++++
 drivers/extcon/Kconfig                             |   2 +-
 drivers/extcon/extcon-intel-mrfld.c                |   9 +
 drivers/extcon/extcon-max8997.c                    |   1 +
 drivers/extcon/extcon-sm5502.c                     | 212 ++++++++++++++++-----
 drivers/extcon/extcon-sm5502.h                     |  82 +++++++-
 7 files changed, 310 insertions(+), 69 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/extcon/extcon-sm5502.txt
 create mode 100644 Documentation/devicetree/bindings/extcon/siliconmitus,sm5502-muic.yaml
