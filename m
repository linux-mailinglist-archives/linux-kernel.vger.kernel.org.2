Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9588F3E3D7A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 03:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbhHIBVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 21:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhHIBVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 21:21:53 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EF1C061757;
        Sun,  8 Aug 2021 18:21:33 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id f3so4023931plg.3;
        Sun, 08 Aug 2021 18:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qt3JSp3w7IVZ6nUcMxFL1E+Q1Rl42RnvY6bsLilfOP0=;
        b=ZQwpyZ+oMI7Vub1eMk6YmC/nOH3cVNSQhFDU6QMHq2mNhNdg854h0Q+om7j8VhPexT
         sZdWOKtYiKhizL+D5Gh0712PCjpAF7YHRitheIe+CBKI5eiZZ+IsQjtcAt47FJYleHP4
         2lJiQ/JlTWaA1xWXZIkpNK8KXdTtvx0VE7Fd+p5dCdQAFLFUTuZbBdSE9zx+KRiVyIMF
         Zx5kirwRyGp5E2qA42AK6jmJR0wDxzuYetI+y6v7f9lfiZnAnmCF7gDhnEEi/hyLwr8J
         rT4c9UnOC5W1kpjcZkdqgW78pzIHHqSS0bzRmJcJwrWBMGznMrXmEbmKw6o6DXDlhAKc
         vhhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qt3JSp3w7IVZ6nUcMxFL1E+Q1Rl42RnvY6bsLilfOP0=;
        b=b+ScfOpiHeh4BZUEWJgi1DIy8iEZM3nAnplASdgDCrFcxdiIi73I+v7W7ibgEG+MBk
         R5f3W29mUDhDdL9gcVDbfjctRj5YvjDFKr0zpHT0qwvuuaHzsXKqqF+5N82op9awITMZ
         U3hy9cC4Pp2ySm/Ij+R7Hpqzb8kKSiF+DIJzRTpyGv3YltjOxLlu3wYT5BKri7HTVvlo
         q7qweHs/Ck1y2utItqOLsEwZlxjIkAEQRtl+DONojJw4HuVC2LvrpKdxevdr+exxva2U
         Ynx/6kaGOwsHaVsRXhUyIYviS+snAkEIkiIYokyTPbpEr5HJdSkbWh+9MXiUGm76GtF6
         IXfw==
X-Gm-Message-State: AOAM530G1kJe/aldneEWNtTRnfuwY1HqKHHZoD5f0MKH1LHG+zLoLUJl
        5HgZEehtoXA8bWR3Jjkw8jA=
X-Google-Smtp-Source: ABdhPJwQOmRestr/bZCmmkkZiGbnzhAGivd+6MhiLaM4ZJQ5qEpW0lMFIFiFFr61Pl4kmlrcWYWwZQ==
X-Received: by 2002:a17:90b:33c5:: with SMTP id lk5mr33779775pjb.129.1628472093067;
        Sun, 08 Aug 2021 18:21:33 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id 11sm17482904pfl.41.2021.08.08.18.21.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Aug 2021 18:21:32 -0700 (PDT)
Subject: [PATCH v4 5/9] docs: pdfdocs: Add conf.py local to translations for
 ascii-art alignment
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Wu X.C." <bobwxc@email.cn>, SeongJae Park <sj38.park@gmail.com>,
        Hu Haowen <src.res@email.cn>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <39d0fb0f-b248-bca4-2dac-df69e8d697b1@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <79a876fc-a552-f972-4a1b-c6df4cbb36dd@gmail.com>
Date:   Mon, 9 Aug 2021 10:21:29 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <39d0fb0f-b248-bca4-2dac-df69e8d697b1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Globally choosing "Noto Sans Mono CJK SC" would result in sub-optimal look
of literal blocks in Latin documents.
Therefore, localize the font choice to translations by adding conf.py under
Documentation/translations/.

The local conf.py is enabled when the command:

    make SPHINXDIRS=translations pdfdocs

is used to build the PDF.
Resulting translations.pdf (under Documentation/output/translations/pdf)
will have properly aligned ascii-art figures.

NOTE: There remain mis-aligned ascii-art figures in Korean translations.
This is due to the font designer's decision to assign slightly narrower
widths (920) to Hangul characters in "Noto Sans Mono CJK KR" than those
of Hanja (Hanzi/Kanji) characters (1000) [1].

[1]: https://github.com/googlefonts/noto-cjk/issues/17

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
---
 Documentation/translations/conf.py | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/translations/conf.py

diff --git a/Documentation/translations/conf.py b/Documentation/translations/conf.py
new file mode 100644
index 000000000000..e859c2e19e8b
--- /dev/null
+++ b/Documentation/translations/conf.py
@@ -0,0 +1,12 @@
+# -*- coding: utf-8 -*-
+# SPDX-License-Identifier: GPL-2.0
+
+# -- Additinal options for LaTeX output ----------------------------------
+# font config for ascii-art alignment
+
+latex_elements['preamble']  += '''
+    \\IfFontExistsTF{Noto Sans CJK SC}{
+	% For CJK ascii-art alignment
+	\\setmonofont{Noto Sans Mono CJK SC}
+    }{}
+'''
-- 
2.17.1


