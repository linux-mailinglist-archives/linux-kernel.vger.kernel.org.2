Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF903E3D80
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 03:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbhHIBZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 21:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbhHIBZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 21:25:49 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E164C061757;
        Sun,  8 Aug 2021 18:25:29 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id nt11so2250665pjb.2;
        Sun, 08 Aug 2021 18:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c4zBEXHSnnZcsQHQ8z4JVrNIpxRpFJ4lGSST5YzfDQs=;
        b=t+DkEpL/uHqaIk87ck3eObxGbVLPuCBfoWwjaRcgvgeaK8CUK1uoq824QbvZqXP7tA
         dEaxk6UxNT6v1OMmFkajqnZwbLePiOaA0L+6ks3bq5a+SDVebkOoq0wBYbJGgmcPXruj
         pNUpk3AHmcFKzLMCR3WaODbbnFbYtV+aJhf7v2ikOaY5+2AKS1ibC9TjlurVR403/o7s
         /hlnGetOo6DuamApPHNBeyfjA7oWqrzOYPGENY4lF3/BRo6hhJlZHxbdnNoEl5Sg+joZ
         bKkdCSOSmM4LZUByaaUnYdUMOGaXgOQPzaIM4SpGNV660QqxnmDJuy8aaY3A/G4kIGxw
         bq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c4zBEXHSnnZcsQHQ8z4JVrNIpxRpFJ4lGSST5YzfDQs=;
        b=GZTF+WfsKx2AH6DKWUnW9Hxdv41W0jJnF8abArbFcS9MyV7YXrP219lktp22wFLj1A
         yU4I5L17cnTeHEK75gQ+P7cq9BFoSjPLhtV00bkcM2Idzj1RFnGZDNxDRsIrMnqo75BT
         pamVIHEK+Te1/v9JhvTdC/LA7qjIYth95pXvSixFV99YmLq9rQv36dJlj6/0Ol3Wx6oX
         QSqBaJjkg5IV3ZG3+HlM6G67ckU1Q0nqZ4QGYL66KQGsXqyNaEAMjlx0Z5fd4yG/ZC7i
         9dcAEOR08ePooY3+mm+MFfxepDxUzq+UHfTeKXfoy3AR6dRwsWh/Qic/hPBb7omnuSBE
         fWzw==
X-Gm-Message-State: AOAM530E8t88E75FXgOn/7JChFLsqSzyaOW1+r5BGfSz/WGO5Ex0zHNh
        09qWZzFK5vxcWHoB3VM+NoA=
X-Google-Smtp-Source: ABdhPJwXR46ObH9UvkrxhSE88xMu+gTyvJhvrUFYrT9zMu9+gO9knvpMDUZkPIYakXn4PZ6rh16STA==
X-Received: by 2002:a17:902:a988:b029:12c:4609:f182 with SMTP id bh8-20020a170902a988b029012c4609f182mr10653329plb.14.1628472328922;
        Sun, 08 Aug 2021 18:25:28 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id c26sm11677888pfo.3.2021.08.08.18.25.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Aug 2021 18:25:28 -0700 (PDT)
Subject: [PATCH v4 7/9] docs: pdfdocs: Permit AutoFakeSlant for CJK fonts
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Wu X.C." <bobwxc@email.cn>, SeongJae Park <sj38.park@gmail.com>,
        Hu Haowen <src.res@email.cn>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <39d0fb0f-b248-bca4-2dac-df69e8d697b1@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <502335cc-9a95-3c2a-7744-6cc56ecaf628@gmail.com>
Date:   Mon, 9 Aug 2021 10:25:25 +0900
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

Noto CJK fonts don't provide italic shapes.
The AutoFakeSlant option of fontspec and xeCJK packages can be used as
a workaround.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
---
 Documentation/conf.py              | 56 +++++++++++++++---------------
 Documentation/translations/conf.py |  2 +-
 2 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index f219a7a41f48..afa085c71781 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -364,49 +364,49 @@ latex_elements['preamble']  += '''
 	% This is needed for translations
 	\\usepackage{xeCJK}
 	\\IfFontExistsTF{Noto Serif CJK SC}{
-	    \\setCJKmainfont{Noto Serif CJK SC}
+	    \\setCJKmainfont{Noto Serif CJK SC}[AutoFakeSlant]
 	}{
-	    \\setCJKmainfont{Noto Sans CJK SC}
+	    \\setCJKmainfont{Noto Sans CJK SC}[AutoFakeSlant]
 	}
-	\\setCJKsansfont{Noto Sans CJK SC}
-	\\setCJKmonofont{Noto Sans Mono CJK SC}
+	\\setCJKsansfont{Noto Sans CJK SC}[AutoFakeSlant]
+	\\setCJKmonofont{Noto Sans Mono CJK SC}[AutoFakeSlant]
 	% CJK Language-specific font choices
 	\\IfFontExistsTF{Noto Serif CJK SC}{
-	    \\newCJKfontfamily[SCmain]\\scmain{Noto Serif CJK SC}
-	    \\newCJKfontfamily[SCserif]\\scserif{Noto Serif CJK SC}
+	    \\newCJKfontfamily[SCmain]\\scmain{Noto Serif CJK SC}[AutoFakeSlant]
+	    \\newCJKfontfamily[SCserif]\\scserif{Noto Serif CJK SC}[AutoFakeSlant]
 	}{
-	    \\newCJKfontfamily[SCmain]\\scmain{Noto Sans CJK SC}
-	    \\newCJKfontfamily[SCserif]\\scserif{Noto Sans CJK SC}
+	    \\newCJKfontfamily[SCmain]\\scmain{Noto Sans CJK SC}[AutoFakeSlant]
+	    \\newCJKfontfamily[SCserif]\\scserif{Noto Sans CJK SC}[AutoFakeSlant]
 	}
-	\\newCJKfontfamily[SCsans]\\scsans{Noto Sans CJK SC}
-	\\newCJKfontfamily[SCmono]\\scmono{Noto Sans Mono CJK SC}
+	\\newCJKfontfamily[SCsans]\\scsans{Noto Sans CJK SC}[AutoFakeSlant]
+	\\newCJKfontfamily[SCmono]\\scmono{Noto Sans Mono CJK SC}[AutoFakeSlant]
 	\\IfFontExistsTF{Noto Serif CJK TC}{
-	    \\newCJKfontfamily[TCmain]\\tcmain{Noto Serif CJK TC}
-	    \\newCJKfontfamily[TCserif]\\tcserif{Noto Serif CJK TC}
+	    \\newCJKfontfamily[TCmain]\\tcmain{Noto Serif CJK TC}[AutoFakeSlant]
+	    \\newCJKfontfamily[TCserif]\\tcserif{Noto Serif CJK TC}[AutoFakeSlant]
 	}{
-	    \\newCJKfontfamily[TCmain]\\tcmain{Noto Sans CJK TC}
-	    \\newCJKfontfamily[TCserif]\\tcserif{Noto Sans CJK TC}
+	    \\newCJKfontfamily[TCmain]\\tcmain{Noto Sans CJK TC}[AutoFakeSlant]
+	    \\newCJKfontfamily[TCserif]\\tcserif{Noto Sans CJK TC}[AutoFakeSlant]
 	}
-	\\newCJKfontfamily[TCsans]\\tcsans{Noto Sans CJK TC}
-	\\newCJKfontfamily[TCmono]\\tcmono{Noto Sans Mono CJK TC}
+	\\newCJKfontfamily[TCsans]\\tcsans{Noto Sans CJK TC}[AutoFakeSlant]
+	\\newCJKfontfamily[TCmono]\\tcmono{Noto Sans Mono CJK TC}[AutoFakeSlant]
 	\\IfFontExistsTF{Noto Serif CJK KR}{
-	    \\newCJKfontfamily[KRmain]\\krmain{Noto Serif CJK KR}
-	    \\newCJKfontfamily[KRserif]\\krserif{Noto Serif CJK KR}
+	    \\newCJKfontfamily[KRmain]\\krmain{Noto Serif CJK KR}[AutoFakeSlant]
+	    \\newCJKfontfamily[KRserif]\\krserif{Noto Serif CJK KR}[AutoFakeSlant]
 	}{
-	    \\newCJKfontfamily[KRmain]\\krmain{Noto Sans CJK KR}
-	    \\newCJKfontfamily[KRserif]\\krserif{Noto Sans CJK KR}
+	    \\newCJKfontfamily[KRmain]\\krmain{Noto Sans CJK KR}[AutoFakeSlant]
+	    \\newCJKfontfamily[KRserif]\\krserif{Noto Sans CJK KR}[AutoFakeSlant]
 	}
-	\\newCJKfontfamily[KRsans]\\krsans{Noto Sans CJK KR}
-	\\newCJKfontfamily[KRmono]\\krmono{Noto Sans Mono CJK KR}
+	\\newCJKfontfamily[KRsans]\\krsans{Noto Sans CJK KR}[AutoFakeSlant]
+	\\newCJKfontfamily[KRmono]\\krmono{Noto Sans Mono CJK KR}[AutoFakeSlant]
 	\\IfFontExistsTF{Noto Serif CJK JP}{
-	    \\newCJKfontfamily[JPmain]\\jpmain{Noto Serif CJK JP}
-	    \\newCJKfontfamily[JPserif]\\jpserif{Noto Serif CJK JP}
+	    \\newCJKfontfamily[JPmain]\\jpmain{Noto Serif CJK JP}[AutoFakeSlant]
+	    \\newCJKfontfamily[JPserif]\\jpserif{Noto Serif CJK JP}[AutoFakeSlant]
 	}{
-	    \\newCJKfontfamily[JPmain]\\jpmain{Noto Sans CJK JP}
-	    \\newCJKfontfamily[JPserif]\\jpserif{Noto Sans CJK JP}
+	    \\newCJKfontfamily[JPmain]\\jpmain{Noto Sans CJK JP}[AutoFakeSlant]
+	    \\newCJKfontfamily[JPserif]\\jpserif{Noto Sans CJK JP}[AutoFakeSlant]
 	}
-	\\newCJKfontfamily[JPsans]\\jpsans{Noto Sans CJK JP}
-	\\newCJKfontfamily[JPmono]\\jpmono{Noto Sans Mono CJK JP}
+	\\newCJKfontfamily[JPsans]\\jpsans{Noto Sans CJK JP}[AutoFakeSlant]
+	\\newCJKfontfamily[JPmono]\\jpmono{Noto Sans Mono CJK JP}[AutoFakeSlant]
 	% Dummy commands for Sphinx < 2.3 (no 'extrapackages' support)
 	\\providecommand{\\onehalfspacing}{}
 	\\providecommand{\\singlespacing}{}
diff --git a/Documentation/translations/conf.py b/Documentation/translations/conf.py
index e859c2e19e8b..92cdbba74229 100644
--- a/Documentation/translations/conf.py
+++ b/Documentation/translations/conf.py
@@ -7,6 +7,6 @@
 latex_elements['preamble']  += '''
     \\IfFontExistsTF{Noto Sans CJK SC}{
 	% For CJK ascii-art alignment
-	\\setmonofont{Noto Sans Mono CJK SC}
+	\\setmonofont{Noto Sans Mono CJK SC}[AutoFakeSlant]
     }{}
 '''
-- 
2.17.1


