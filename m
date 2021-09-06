Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 968CD401B51
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 14:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242114AbhIFMmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 08:42:18 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:64920 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241923AbhIFMmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 08:42:17 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210906124111epoutp0126e7daf84e012b50d73a943c712d71f7~iPBP2QuM12796827968epoutp01d
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 12:41:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210906124111epoutp0126e7daf84e012b50d73a943c712d71f7~iPBP2QuM12796827968epoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1630932071;
        bh=p/73OE9Ni/5HiZfdRCngY+tKtSiO3hGX4iuJV1031/U=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=gKNY338NpSTp1q5/5oRhSrnlKR3koZQUbgvbMJi8XO/UkPhrJHgQfqy9DHIpa7SIS
         z9eeHR9fpKQo4Ztmz3dMypc0wr9VbWYrW/4805qkexCaceZOmr1/x8PcA+fOt+VSUi
         d+nahrz/f0HXwx2LGmzTsG/wmXjPUsTSzkfY7Hto=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20210906124110epcas5p45c1192d39368a1c4bbaf131bf64210f5~iPBPEkT9c1933919339epcas5p44;
        Mon,  6 Sep 2021 12:41:10 +0000 (GMT)
X-AuditID: b6c32a4a-b2dff7000000287f-d6-61360c66a8f8
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8E.D4.10367.66C06316; Mon,  6 Sep 2021 21:41:10 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH 1/1] scripts/checkpatch.pl: remove warning for
 pritk_deferred also
Reply-To: maninder1.s@samsung.com
Sender: Maninder Singh <maninder1.s@samsung.com>
From:   Maninder Singh <maninder1.s@samsung.com>
To:     "apw@canonical.com" <apw@canonical.com>,
        "joe@perches.com" <joe@perches.com>,
        "dwaipayanray1@gmail.com" <dwaipayanray1@gmail.com>,
        "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        AMIT SAHRAWAT <a.sahrawat@samsung.com>,
        Vaneet Narang <v.narang@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <1629786900-4644-1-git-send-email-maninder1.s@samsung.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20210906124109epcms5p88026ef667efae06506f03e61868a7996@epcms5p8>
Date:   Mon, 06 Sep 2021 18:11:09 +0530
X-CMS-MailID: 20210906124109epcms5p88026ef667efae06506f03e61868a7996
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPIsWRmVeSWpSXmKPExsWy7bCmlm4aj1miwb7LKhYXd6dafFirYbF+
        4TJmi9n3H7NYXN41h82i5Wg7i8Whk3MZHdg9ZjX0snnsnHWX3ePLqmvMHn1bVjF6fN4kF8Aa
        xWWTkpqTWZZapG+XwJVxff0r5oJ5HBWbTlxhbGCczdbFyMkhIWAisXzmA8YuRi4OIYHdjBIN
        09azdzFycPAKCEr83SEMUiMsECHxvWcDC4gtJKAocWHGGkaQEmEBA4lfWzVAwmwCehKrdu1h
        ARkjIrCPUeL+2t9gM5kFJjJKnOrZzQixjFdiRvtTFghbWmL78q1gcU4Bd4lvS/5CHSQqcXP1
        W3YY+/2x+VC9IhKt984yQ9iCEg9+wsyUkVi9uRdss4RAN6PE+nd7oZwZjBI9j6ZBdZhLrF+y
        CuozX4nmfXUgJouAqsSu3VUgpoSAi8SVdzogxcwC8hLb385hBgkzC2hKrN+lDxHmk+j9/YQJ
        5pMd82BsVYmWmxtYYb76/PEjC8RED4ljy0IhodbHKHHhp8EERvlZiLCdhWTXLIRdCxiZVzFK
        phYU56anFpsWGOWllusVJ+YWl+al6yXn525iBKcRLa8djA8ffNA7xMjEwXiIUYKDWUmEN9rZ
        KFGINyWxsiq1KD++qDQntfgQozQHi5I4r+4rmUQhgfTEktTs1NSC1CKYLBMHp1QDE8/fXPWp
        ssJ+DDt2fdwVlBGW4HBi2ifWqnh2psRV0kamrnx8cxOXsInqPGWI2bJ6/sRf4nNlGg7Fsbu7
        8s1fY9RfLXdK3M15PW/YR+m6mZ7ndgWcbmKorOydfv2ho7LJCZ6KwOyME0FaF4vlX3e/ZDx0
        8cr5xUd4w1/bfV626nGbBN97C/cCDVXh6k5e77oC+3f/T9VkMKrqTmx+1iUXkPrs+97FvAmG
        /FMW7fxl+t17QrmBYb+T1YWuBsmkTw+7+xjWJtvcKzq4p/rb1X8SEdWzpgb3S0w4wNpzkT/2
        b1mLpEnKzZOTL3/W/j3l1MUqk42dPr+e6WcYFgat4wybKac/ScbAcuvu3UbK8neUWIozEg21
        mIuKEwGPFRT4kgMAAA==
X-CMS-RootMailID: 20210824063513epcas5p46ba8b375c3e32fab210640a28041efb6
References: <1629786900-4644-1-git-send-email-maninder1.s@samsung.com>
        <CGME20210824063513epcas5p46ba8b375c3e32fab210640a28041efb6@epcms5p8>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Any comments?
 
>WARNING: Possible unnecessary KERN_ALERT
>+printk_deferred(KERN_ALERT "checking deferred\n");
> 
>total: 0 errors, 1 warnings, 20 lines checked
> 
>Thus removing warning for printk_deferred also.
> 
>Signed-off-by: Vaneet Narang <v.narang@samsung.com>
>Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
>---
> scripts/checkpatch.pl | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
>diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>index 161ce7fe5d1e..e3bea0d36c10 100755
>--- a/scripts/checkpatch.pl
>+++ b/scripts/checkpatch.pl
>@@ -6252,7 +6252,7 @@ sub process {
>                 }
> 
> # check for logging functions with KERN_<LEVEL>
>-                if ($line !~ /printk(?:_ratelimited|_once)?\s*\(/ &&
>+                if ($line !~ /printk(?:_ratelimited|_once|_deferred)?\s*\(/ &&
>                     $line =~ /\b$logFunctions\s*\(.*\b(KERN_[A-Z]+)\b/) {
>                         my $level = $1;
>                         if (WARN("UNNECESSARY_KERN_LEVEL",
>-- 
