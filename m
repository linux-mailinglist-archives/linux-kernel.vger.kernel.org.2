Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F0A406C95
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 15:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbhIJNBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 09:01:05 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:17159 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233185AbhIJNBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 09:01:04 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210910125951epoutp032b0cb223abd0f7e1847a0578e3f2dae1~jd2sR74uu2235022350epoutp03e
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 12:59:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210910125951epoutp032b0cb223abd0f7e1847a0578e3f2dae1~jd2sR74uu2235022350epoutp03e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1631278791;
        bh=jZAIRI5syEH1dQgQ88ZbFitr00/kCWSSVpXDzAa4vzw=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=iSQr58NNu0UAfFTWlyA5YH2EqyBzShsBSO20wXnUHqwW1MiWYZXTBB3z3r3UGwTsF
         Q5TwptRh6ADtKDPWH68au3L+jNZ0xkNHAkWIupg18dHz+UtD7xp0ONCBLzE13UlFSp
         tKvhy3vrInbDpY3Sxjq39dvIbW45rk5qHp4vtebE=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20210910125950epcas5p2990404d76736db2ec3116cc6986f6d9b~jd2rQT_BH0368703687epcas5p2g;
        Fri, 10 Sep 2021 12:59:50 +0000 (GMT)
X-AuditID: b6c32a4a-b2dff7000000287f-d9-613b56c60c64
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A8.C4.10367.6C65B316; Fri, 10 Sep 2021 21:59:50 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH 1/1] exception/stackdepot: add irqentry section in case
 of STACKDEPOT
Reply-To: maninder1.s@samsung.com
Sender: Maninder Singh <maninder1.s@samsung.com>
From:   Maninder Singh <maninder1.s@samsung.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        "ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
        "glider@google.com" <glider@google.com>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "joey.gouly@arm.com" <joey.gouly@arm.com>,
        "maz@kernel.org" <maz@kernel.org>,
        "pcc@google.com" <pcc@google.com>,
        "amit.kachhap@arm.com" <amit.kachhap@arm.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        Vaneet Narang <v.narang@samsung.com>,
        AMIT SAHRAWAT <a.sahrawat@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <YTYQKgKspSPORGH8@shell.armlinux.org.uk>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20210910125949epcms5p40ddb337f000a5fe46bb6e59f48452060@epcms5p4>
Date:   Fri, 10 Sep 2021 18:29:49 +0530
X-CMS-MailID: 20210910125949epcms5p40ddb337f000a5fe46bb6e59f48452060
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFKsWRmVeSWpSXmKPExsWy7bCmhu6xMOtEgwm3lC0u7k61mLN+DZvF
        lA87WC3eL+thtJjwsI3dov3jXmaLL81tTBYrnt1nstj0+BqrxeVdc9gsDk3dy2ix9PpFJoud
        c06yWvTfuc5mcXzrFmaLQyfnMlq03DF1EPRYM28No8flaxeZPXbOusvusWBTqceeiSfZPDat
        6mTzODHjN4vH5iX1Hn1bVjF6fN4kF8AVxWWTkpqTWZZapG+XwJUx+9I39oI3LBVXf8s3MH5g
        7mLk5JAQMJFYdq+XrYuRi0NIYDejRPOWd4xdjBwcvAKCEn93CIPUCAtES2w4e40dxBYSUJS4
        MGMNWImwgIHEr60aIGE2AT2JVbv2sIDYIgKTGSVmvTMDGckssItV4su6m6wQu3glZrQ/ZYGw
        pSW2L9/KCGJzCphKTFpyA+oeUYmbq9+yw9jvj81nhLBFJFrvnYWqEZR48HM3VFxGYvXmXhaQ
        ZRIC3YwS69/thXJmMEr0PJoG1WEusX7JKrCpvAK+Eus23AGzWQRUJfZeWwV1nYvEyp7vYHFm
        AXmJ7W/nMIN8ySygKbF+lz5EmE+i9/cTJphndsyDsVUlWm5uYIV57PPHjywgrRICHhJL1ipA
        wvYvo8TeK21MExjlZyGCdxaSZbMQli1gZF7FKJlaUJybnlpsWmCUl1quV5yYW1yal66XnJ+7
        iRGc3LS8djA+fPBB7xAjEwfjIUYJDmYlEd4TGywThXhTEiurUovy44tKc1KLDzFKc7AoifN+
        fA2UEkhPLEnNTk0tSC2CyTJxcEo1MCVuEIt9JPnkyFXd2yWLUh6tlvxRnrzs29o/rfLXryX9
        +nHo8llB08O7LspxJ/JO5A7pr5lRWvTnxpmyVd2xBVfNNtmaVb/32ujE4H1x64JTJgv1b6+z
        DmC86DfpWMHRruVOlQwsHqaK+yQdbO91LdETL1r6631f0OP6a8mbHT/tzLrVe473lV/xMisX
        b42CfR075geonC/Jv+7SK9MsOnPbPpVmK5trqgmfXrdP/HfE+92yL3e+75jP94K3ReK7pW2m
        qeLkBIl094xJtW1/w5R6V106YHbkXllbcKRsZ5pPq2GrvP/2U7eCF+/geVMvHTPhbqie+Le6
        RIflulOTdL8Lxt06lvS3Sfu49+G2lUosxRmJhlrMRcWJALDpUcPdAwAA
X-CMS-RootMailID: 20210818071602epcas5p4fecf459638312c95c5d5aaa29e7e983a
References: <YTYQKgKspSPORGH8@shell.armlinux.org.uk>
        <1629270943-9304-1-git-send-email-maninder1.s@samsung.com>
        <20210906124351epcms5p6020fbfe5f885f1e8834a72784b28d434@epcms5p6>
        <CGME20210818071602epcas5p4fecf459638312c95c5d5aaa29e7e983a@epcms5p4>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>No, I've not heard of stackdepot, I don't know what it is, or what
>it does. It doesn't appear to be documented in Documentation - case
>insensitive grep for "stackdepot" gets no hits. No help text on its
>Kconfig option.
> 
>How are arch maintainers supposed to know anything about this?

ok.

Added reviewers/maintainers of stackdepot and KASAN(filter_irq_stack) code.
Because on our ARM H/W it was causing memory issue, and without this change
purpose of filter_irq_stack was gone as it was not filtering irq stacks.

If anyone else has any views or comments for this.

Thanks
Maninder Singh
