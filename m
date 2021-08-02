Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3046E3DD36E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 11:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbhHBJyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 05:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232973AbhHBJyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 05:54:03 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DB4C0613D5;
        Mon,  2 Aug 2021 02:53:53 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id s22-20020a17090a1c16b0290177caeba067so4941967pjs.0;
        Mon, 02 Aug 2021 02:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qt3JSp3w7IVZ6nUcMxFL1E+Q1Rl42RnvY6bsLilfOP0=;
        b=tFLvNFWlP9OKYWlVXF3EayL0NSYtDVs62tKe08+BkAMWY2yeZKdKyHU6L2E/KZkaBt
         hBG/w9uOeh/WYetYjHYcEZ2zEtrZQzniVEWjgubwONP07GIuXrTfV2yq3WhVSddq93MM
         H7/fBYVQmfbmWHnG+Hodkyda4+cfoaYUgJGOGvWi+izZloephZYRUsjhEGz6mkg1k6JI
         HAIsun4maLbXha7SBx2eL75vkdOLwDXGPnLx39pCBDDeiKMbGH6EyMCA84d11yqDMEeD
         CYe6CPA8eR+0OZ7QUfMwvg4GvNzOJCK+uGXnl4nnlKr80WFMBeXjVPctDlho6kGXMbUT
         71kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qt3JSp3w7IVZ6nUcMxFL1E+Q1Rl42RnvY6bsLilfOP0=;
        b=UkwY49UWcY3ez0GykokiNly2iRaDIlfq419min3hwj2CDvXHGxHe7hcDptcwLDgmml
         oqweu72EQ0rgddnvXICF8zaSJcIok3ZOqYDNGLli22gcZmQqEWQ4Fq6q19LMTQwetjmW
         hRcMuySDb8Em2V1U3gfUK3RONQYJKX8HcEoF48psFYcHGw3zjB5haN5IIzTVTlzXdPIF
         /anBx18opAGWxDqOD26XZYNULpo6b6Lpx2kQYwkBXRDUf0eBkgFSSDec9KsirkVqxWIm
         ZkBESq/IRUDj03sqWEsZOr2EdxRyVh6esZBOyqM+Svg6S2+5jFB7V41YVgBRwYRNs2K+
         RpGw==
X-Gm-Message-State: AOAM532DH9Yfia2HjHrwiwrWk8zOakD/I08kPxTp3dKg0pY4P5j01r1Q
        unXzGPZ4dXcjCUbfCZyLVlIMxI7YVPA=
X-Google-Smtp-Source: ABdhPJwbJbuwBer3/YJK/NXFylhb1pvCYpPNbs9wNT1pLMfGU9DcxX9DnYgFFs+o8SoLy71uVaQXBQ==
X-Received: by 2002:a17:902:850a:b029:12c:8da9:8bd2 with SMTP id bj10-20020a170902850ab029012c8da98bd2mr13665734plb.58.1627898033364;
        Mon, 02 Aug 2021 02:53:53 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id q17sm13168726pgd.39.2021.08.02.02.53.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 02:53:53 -0700 (PDT)
Subject: [PATCH v3 5/9] docs: pdfdocs: Add conf.py local to translations for
 ascii-art alignment
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Wu X.C." <bobwxc@email.cn>, SeongJae Park <sj38.park@gmail.com>,
        Hu Haowen <src.res@email.cn>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <eb8184ab-cfab-680b-f180-1157a7f709b3@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <3a2644eb-2889-92ba-b139-22b21a9e1026@gmail.com>
Date:   Mon, 2 Aug 2021 18:53:50 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <eb8184ab-cfab-680b-f180-1157a7f709b3@gmail.com>
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


