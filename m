Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2BE406C72
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 14:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbhIJMqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 08:46:47 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:53587 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233559AbhIJMqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 08:46:46 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210910124533epoutp024c1f8b45cc054b3c291762034c40933f~jdqM8RmrH3195931959epoutp02y
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 12:45:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210910124533epoutp024c1f8b45cc054b3c291762034c40933f~jdqM8RmrH3195931959epoutp02y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1631277933;
        bh=lOcmrQBKqFtpYDC8vrDmy3K/bJ9ui5jmkS279d2Cn64=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=FXpdBMKyzMrK+b6NVpOrn7Xx/1jY/ob4wJD0zJ5xAS6ktGn2LRZZJP8LlprVIZejo
         2/ow8ODEdYyKR/I03ESpNwqrgGDijSis5UxjWnSosGMx2rwecBQg/t2i3SRPbt6d+f
         IlZa7J24CWA5wFWs0HsdIbLaIsJAVP9H3yk9Sh3M=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20210910124532epcas5p336995bb63633949fea4acee875577b3e~jdqMVGzAN0678906789epcas5p30;
        Fri, 10 Sep 2021 12:45:32 +0000 (GMT)
X-AuditID: b6c32a4b-251ff700000095ca-14-613b536c5c67
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A9.F7.38346.C635B316; Fri, 10 Sep 2021 21:45:32 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH 1/1] scripts/checkpatch.pl: remove warning for
 pritk_deferred also
Reply-To: maninder1.s@samsung.com
Sender: Maninder Singh <maninder1.s@samsung.com>
From:   Maninder Singh <maninder1.s@samsung.com>
To:     Andy Whitcroft <apw@canonical.com>
CC:     "joe@perches.com" <joe@perches.com>,
        "dwaipayanray1@gmail.com" <dwaipayanray1@gmail.com>,
        "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        AMIT SAHRAWAT <a.sahrawat@samsung.com>,
        Vaneet Narang <v.narang@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <YTZ22IfeYanMEMpH@brain>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20210910124532epcms5p3b63de3ee7ae2511817cb106c55a74946@epcms5p3>
Date:   Fri, 10 Sep 2021 18:15:32 +0530
X-CMS-MailID: 20210910124532epcms5p3b63de3ee7ae2511817cb106c55a74946
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPIsWRmVeSWpSXmKPExsWy7bCmhm5OsHWiwYf9WhYXd6dafFirYbF+
        4TJmi9n3H7NYXN41h82i5Wg7i8Whk3MZHdg9ZjX0snnsnHWX3ePLqmvMHn1bVjF6fN4kF8Aa
        xWWTkpqTWZZapG+XwJXx8qVlwUzeiq1vDjI2MH7l6mLk5JAQMJG4+3Q/C4gtJLCbUWLmRsMu
        Rg4OXgFBib87hEHCwgIREt97NkCVKEpcmLGGEaREWMBA4tdWDZAwm4CexKpde8BKRATUJO6e
        6WbuYuTiYBZYxiTRcXI1G8QqXokZ7U9ZIGxpie3LtzKC2JwCqhKnl3+AiotK3Fz9lh3Gfn9s
        PiOELSLReu8sM4QtKPHg526ouIzE6s29LCDLJAS6GSXWv9sL5cxglOh5NA2qw1xi/ZJVYFN5
        BXwljj1bygzyAQvQ5v8b1SBKXCQeHj3MCmIzC8hLbH87B6yEWUBTYv0ufYgwn0Tv7ydMML/s
        mAdjq0q03NzACvPX548fWUBaJQQ8JI4tCwW5RkhgJaPE056pLBMY5WchQncWkmWzEJYtYGRe
        xSiZWlCcm55abFpgnJdarlecmFtcmpeul5yfu4kRnEa0vHcwPnrwQe8QIxMH4yFGCQ5mJRHe
        ExssE4V4UxIrq1KL8uOLSnNSiw8xSnOwKInzfnwNlBJITyxJzU5NLUgtgskycXBKNTD11feU
        bLKbOe959qELITwc3Y//Lfzo9VDu217dEq/J996nzvyjE7GoL6/vyvGIkjnrbfXeq5Sc+ZjC
        dSe/LUlnV0ZY6E6ddOl/M5sn6jjz1mtEu645cmJmy7XmfY/sYk/v94lt/NJ2+0hCj9qKxeuP
        iEXsv/Lr3sKf85p5DoX8497Rud9h/syXj07t3plv/ObykYX3t3b9KFR3ktEtbzxcJZzcHRG+
        7gsvi+eOWvVQoas923mP3JDaM/v3rVdrFpYwiP9SkxZZOSfg5ZXUi4JX502Zv+eDz9RJZZIW
        9y8EXtzgwJe/M9rZLc0zz82kfU38gqj5Mw9ciZY9L7jlpACvHv/a4Pb81ik8110ilTZzK7EU
        ZyQaajEXFScCANaU/CySAwAA
X-CMS-RootMailID: 20210824063513epcas5p46ba8b375c3e32fab210640a28041efb6
References: <YTZ22IfeYanMEMpH@brain>
        <1629786900-4644-1-git-send-email-maninder1.s@samsung.com>
        <CGME20210824063513epcas5p46ba8b375c3e32fab210640a28041efb6@epcms5p3>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


>It looks sensible to add `_deferred`, there also looks to be an
>`_deferred_once` variant which should also be added.  See the first
>stanza of `$logFunctions`.  We might also consider splitting up
>`$logFunctions` so that we can consume the reset without that first
>stanza?  Something like this (completly untested):
>
>    our $logFunctionsCore = qr{(?x:
>        (?:[a-z0-9]+_){1,2}(?:printk|emerg|alert|crit|err|warning|warn|notice|info|debug|dbg|vdbg|devel|cont|WARN)(?:_ratelimited|_once|)|
>        TP_printk|
>        WARN(?:_RATELIMIT|_ONCE|)|
>        panic|
>        MODULE_[A-Z_]+|
>        seq_vprintf|seq_printf|seq_puts
>    )};
>    our $logFunctions = qr{(?x:
>        printk(?:_ratelimited|_once|_deferred_once|_deferred|)|
>	$logFunctionsCore
>    )};
>


sent V2 patch with testing basic checks:

https://lkml.org/lkml/2021/9/7/329

$ cat test.c


printk_deferred(KERN_ALERT "checking deferred\n");
printk_deferred_once(KERN_ALERT "checking deferred\n");
printk(KERN_ERR"error");
pr_emerg("Protocol: %#06hx\n", ntohs(eth->h_proto));
printk_deferred(KERN_ALERT "Protocol: %#06hx\n", ntohs(eth->h_proto));



WARNING: Prefer [subsystem eg: netdev]_err([subsystem]dev, ... then dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...
#22: FILE: test.c:22:
+printk(KERN_ERR"error");

WARNING: Integer promotion: Using 'h' in '%#06hx' is unnecessary
#23: FILE: test.c:23:
+pr_emerg("Protocol: %#06hx\n", ntohs(eth->h_proto));

WARNING: Integer promotion: Using 'h' in '%#06hx' is unnecessary
#24: FILE: test.c:24:
+printk_deferred(KERN_ALERT "Protocol: %#06hx\n", ntohs(eth->h_proto));


Thanks,
Maninder Singh
