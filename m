Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42AD63E3D83
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 03:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbhHIB1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 21:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbhHIB1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 21:27:42 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE415C061757;
        Sun,  8 Aug 2021 18:27:21 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id oa17so573018pjb.1;
        Sun, 08 Aug 2021 18:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cnqTbXmmA+ClGgIm+08APSfICc9j7eEK30S97HC1gQ8=;
        b=mqJcFEc8wwJnJBTlXcp+Dhbs5+cUv25eXYpq6+PAFnhLTdKIjl/FN9UEunjFY1mvC0
         F6WzSLxcL9EgsPXfaukruFOssv0LCtFBV9H9aIju3GAkn08N8Vlz20Xs07zDcNBe/XUh
         xKUFPgFl0+XPlUg48s/kHNH/UmWXypQl/ldN6sjr13AyVsuYTY8dUBwt7wBL/r5b/sNC
         MH036B/822JDCJkzHk6Kq6XztdMY4+QgWkLaMVPHbLIEEDuTgMGBoL2g6HQmVax1t6CK
         rsqS0jUw7L0gLBygrcbFjoaMJk/BfGVCTNNr+yn9paYh/a60wwIhWou1bBffDixOp5II
         Hs6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cnqTbXmmA+ClGgIm+08APSfICc9j7eEK30S97HC1gQ8=;
        b=IDinmdINP2aecqhXSD0ZYPdQOpjYLvZLKE1xwS1rlEWuFSFY2NyYlYB4btAc6OVKEs
         qR36cBibtiW6g3mel8lWI0ndzwUxFp/1Nnhb/WhQiyLXOPi2kD0u8cx+DBNC0FxD+k3B
         mkwM0sUFmLJ5tJZdlWH2cK7rsDaB9+aMhnZh8BshD7z36eXi+pbwAakqUlWipnYcSBVx
         FrN/VFVZpUdGDSkAHKcHc+uWL5V9qItz1HucnuuVgPZeG3ZIsbU0ruT6+9AoPbzgAuvH
         eF0v1VDJ71Q8taB36rKkiY98NFrP/qlk0WKSsi32rg+KzHS+6fQEBLfSjeLY0Wswfgyt
         GgoA==
X-Gm-Message-State: AOAM530bTNsvLChfBwnmZh7jax71HHuwYco8dWX8ipak3qBBF6AY7lGm
        /4cTob9Zimoah/0oOXS22pI=
X-Google-Smtp-Source: ABdhPJy2mNAjTfZw6q4LHl2cYEXVibApC5QG1dgrj9MQ23/Mg/QtiBvoCVI6f0j8KNtfEDzixZ92rg==
X-Received: by 2002:a62:ea10:0:b029:399:ff48:e9da with SMTP id t16-20020a62ea100000b0290399ff48e9damr21500610pfh.56.1628472441473;
        Sun, 08 Aug 2021 18:27:21 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id r14sm10534384pff.106.2021.08.08.18.27.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Aug 2021 18:27:21 -0700 (PDT)
Subject: [PATCH v4 8/9] docs: pdfdocs: Teach xeCJK about character classes of
 quotation marks
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Wu X.C." <bobwxc@email.cn>, SeongJae Park <sj38.park@gmail.com>,
        Hu Haowen <src.res@email.cn>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <39d0fb0f-b248-bca4-2dac-df69e8d697b1@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <0da9e3c5-2716-f576-1df5-2f28ea69f0e8@gmail.com>
Date:   Mon, 9 Aug 2021 10:27:18 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <39d0fb0f-b248-bca4-2dac-df69e8d697b1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quotation marks in "KR" and "JP" variants of Noto CJK fonts are half
width.
xeCJK assumes they are full width by default and does excessive kerning
around them in Korean and Japanese translations.

Give xeCJK proper hints by the \xeCJKDeclareCharClass command.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
---
 Documentation/conf.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index afa085c71781..75650f6443af 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -428,6 +428,8 @@ latex_elements['preamble']  +=3D '''
 	\\newcommand{\\kerneldocEndTC}{\\endgroup}
 	\\newcommand{\\kerneldocBeginKR}{%
 	    \\begingroup%
+	    \\xeCJKDeclareCharClass{HalfLeft}{`=E2=80=9C,`=E2=80=98}%
+	    \\xeCJKDeclareCharClass{HalfRight}{`=E2=80=9D,`=E2=80=99}%
 	    \\krmain%
 	    \\renewcommand{\\CJKrmdefault}{KRserif}%
 	    \\renewcommand{\\CJKsfdefault}{KRsans}%
@@ -437,6 +439,8 @@ latex_elements['preamble']  +=3D '''
 	\\newcommand{\\kerneldocEndKR}{\\endgroup}
 	\\newcommand{\\kerneldocBeginJP}{%
 	    \\begingroup%
+	    \\xeCJKDeclareCharClass{HalfLeft}{`=E2=80=9C,`=E2=80=98}%
+	    \\xeCJKDeclareCharClass{HalfRight}{`=E2=80=9D,`=E2=80=99}%
 	    \\jpmain%
 	    \\renewcommand{\\CJKrmdefault}{JPserif}%
 	    \\renewcommand{\\CJKsfdefault}{JPsans}%
--=20
2.17.1



