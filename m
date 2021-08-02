Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDC3F3DD34E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 11:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbhHBJuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 05:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbhHBJun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 05:50:43 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7C9C06175F;
        Mon,  2 Aug 2021 02:50:32 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id a20so19107523plm.0;
        Mon, 02 Aug 2021 02:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pYYxiw41X17NhD1Q5oNmXyZafkiZ20OypLI54Gm/l6w=;
        b=PBYV5ZO7ap/7i/caSWm7Ts73J38ANeTq1O619lapI5kkEvLUTd+Y7F4LQK76SNgmJq
         0owGMbx/YtU7hA+wR1Fvbi5vAjh6efQB8CpmeA2vG/eSQNMN7MR3PPC6tp5s0TVvweG/
         zoznDx//m+Jj99qUo5V6jUcJ+mc3x6hQ8uIiRyP6gw5YP6qFh50J9p7r8Pf04e8Q6fvZ
         qUnR3QTXPmiZUvCY+7jNBvRs9tuTh5C0K9Tz0kuDdLNHJupMcFxLlR2x3KGKMVTiGtAa
         JNhQKL4utJrRmhLDkaBoVIwE2oTtdP+7OXyqSx4BWB+h+8ybLN0AKNGwD2d5TEg6y3yW
         OdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pYYxiw41X17NhD1Q5oNmXyZafkiZ20OypLI54Gm/l6w=;
        b=Y12QgF2m2O1fyMgdXXHbiH5tkHkFkGL8pREO6WiF6TW/SaTPw+K7cizjHTMLGSELgw
         vhJu2fknqpBinI4Wh6pQePTdp7Kcz2TmtGA7xJR0yDiLtROubM8gbVr3oxY5+HTQjvXi
         IGwW0KwPtbTrY561jt1usWqB66fo6RAOGP+4xnuWVCLmMIJO1AFFX2KGJsULj12Ln/gY
         woxJRmld4K3J9UW5G4G+zkPdp29anGDIKwUUdQjTdZYkQRqJTGmwCbB+gRWNL12ghO0a
         c1B2ADP3jL6w1Klc/gtxRFtBTJQ0j1Voo6degqeAPzLCi/daZdzeYtod1csBQ03l29e4
         gYDQ==
X-Gm-Message-State: AOAM530w+pzj3ASEJmYYD39f++Pj1Zyp97y17xMUiXxYO4IU/A3bO4KG
        cVyRu5sKYfF7YvrbtIx28MA=
X-Google-Smtp-Source: ABdhPJyngiOh2Q+gMrC1PpzeTiWlpjrxWkYfZauoV8AxRynoQQFODJmI42SbA9qy7MI6uyyjuEPnDg==
X-Received: by 2002:a63:154d:: with SMTP id 13mr1171759pgv.116.1627897832462;
        Mon, 02 Aug 2021 02:50:32 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id 31sm6585437pgy.26.2021.08.02.02.50.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 02:50:32 -0700 (PDT)
Subject: [PATCH v3 3/9] docs: pdfdocs: Choose Serif font as CJK mainfont if
 possible
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Wu X.C." <bobwxc@email.cn>, SeongJae Park <sj38.park@gmail.com>,
        Hu Haowen <src.res@email.cn>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <eb8184ab-cfab-680b-f180-1157a7f709b3@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <ab7400aa-24d8-06ad-74b4-8a83ef343e47@gmail.com>
Date:   Mon, 2 Aug 2021 18:50:29 +0900
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

"Noto Serif CJK SC" and its variants suit better with the roman font
of Latin letters.

On some distros such as Fedora, it is possible to partially install
"Noto Sans CJK" fonts.
So, if the Serif fonts are not found on the system, fall back to the
Sans fonts.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
---
 Documentation/conf.py | 41 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 24e5427588e7..980be06df723 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -360,20 +360,48 @@ latex_elements['preamble']  += '''
     \\IfFontExistsTF{Noto Sans CJK SC}{
 	% This is needed for translations
 	\\usepackage{xeCJK}
-	\\setCJKmainfont{Noto Sans CJK SC}
+	\\IfFontExistsTF{Noto Serif CJK SC}{
+	    \\setCJKmainfont{Noto Serif CJK SC}
+	}{
+	    \\setCJKmainfont{Noto Sans CJK SC}
+	}
 	\\setCJKsansfont{Noto Sans CJK SC}
 	\\setCJKmonofont{Noto Sans Mono CJK SC}
 	% CJK Language-specific font choices
-	\\newCJKfontfamily[SCmain]\\scmain{Noto Sans CJK SC}
+	\\IfFontExistsTF{Noto Serif CJK SC}{
+	    \\newCJKfontfamily[SCmain]\\scmain{Noto Serif CJK SC}
+	    \\newCJKfontfamily[SCserif]\\scserif{Noto Serif CJK SC}
+	}{
+	    \\newCJKfontfamily[SCmain]\\scmain{Noto Sans CJK SC}
+	    \\newCJKfontfamily[SCserif]\\scserif{Noto Sans CJK SC}
+	}
 	\\newCJKfontfamily[SCsans]\\scsans{Noto Sans CJK SC}
 	\\newCJKfontfamily[SCmono]\\scmono{Noto Sans Mono CJK SC}
-	\\newCJKfontfamily[TCmain]\\tcmain{Noto Sans CJK TC}
+	\\IfFontExistsTF{Noto Serif CJK TC}{
+	    \\newCJKfontfamily[TCmain]\\tcmain{Noto Serif CJK TC}
+	    \\newCJKfontfamily[TCserif]\\tcserif{Noto Serif CJK TC}
+	}{
+	    \\newCJKfontfamily[TCmain]\\tcmain{Noto Sans CJK TC}
+	    \\newCJKfontfamily[TCserif]\\tcserif{Noto Sans CJK TC}
+	}
 	\\newCJKfontfamily[TCsans]\\tcsans{Noto Sans CJK TC}
 	\\newCJKfontfamily[TCmono]\\tcmono{Noto Sans Mono CJK TC}
-	\\newCJKfontfamily[KRmain]\\krmain{Noto Sans CJK KR}
+	\\IfFontExistsTF{Noto Serif CJK KR}{
+	    \\newCJKfontfamily[KRmain]\\krmain{Noto Serif CJK KR}
+	    \\newCJKfontfamily[KRserif]\\krserif{Noto Serif CJK KR}
+	}{
+	    \\newCJKfontfamily[KRmain]\\krmain{Noto Sans CJK KR}
+	    \\newCJKfontfamily[KRserif]\\krserif{Noto Sans CJK KR}
+	}
 	\\newCJKfontfamily[KRsans]\\krsans{Noto Sans CJK KR}
 	\\newCJKfontfamily[KRmono]\\krmono{Noto Sans Mono CJK KR}
-	\\newCJKfontfamily[JPmain]\\jpmain{Noto Sans CJK JP}
+	\\IfFontExistsTF{Noto Serif CJK JP}{
+	    \\newCJKfontfamily[JPmain]\\jpmain{Noto Serif CJK JP}
+	    \\newCJKfontfamily[JPserif]\\jpserif{Noto Serif CJK JP}
+	}{
+	    \\newCJKfontfamily[JPmain]\\jpmain{Noto Sans CJK JP}
+	    \\newCJKfontfamily[JPserif]\\jpserif{Noto Sans CJK JP}
+	}
 	\\newCJKfontfamily[JPsans]\\jpsans{Noto Sans CJK JP}
 	\\newCJKfontfamily[JPmono]\\jpmono{Noto Sans Mono CJK JP}
 	% Define custom macros to on/off CJK
@@ -387,6 +415,7 @@ latex_elements['preamble']  += '''
 	\\newcommand{\\kerneldocBeginTC}{%
 	    \\begingroup%
 	    \\tcmain%
+	    \\renewcommand{\\CJKrmdefault}{TCserif}%
 	    \\renewcommand{\\CJKsfdefault}{TCsans}%
 	    \\renewcommand{\\CJKttdefault}{TCmono}%
 	}
@@ -394,6 +423,7 @@ latex_elements['preamble']  += '''
 	\\newcommand{\\kerneldocBeginKR}{%
 	    \\begingroup%
 	    \\krmain%
+	    \\renewcommand{\\CJKrmdefault}{KRserif}%
 	    \\renewcommand{\\CJKsfdefault}{KRsans}%
 	    \\renewcommand{\\CJKttdefault}{KRmono}%
 	}
@@ -401,6 +431,7 @@ latex_elements['preamble']  += '''
 	\\newcommand{\\kerneldocBeginJP}{%
 	    \\begingroup%
 	    \\jpmain%
+	    \\renewcommand{\\CJKrmdefault}{JPserif}%
 	    \\renewcommand{\\CJKsfdefault}{JPsans}%
 	    \\renewcommand{\\CJKttdefault}{JPmono}%
 	}
-- 
2.17.1


