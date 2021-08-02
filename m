Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF803DD375
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 11:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbhHBJ5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 05:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbhHBJ5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 05:57:42 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC27C06175F;
        Mon,  2 Aug 2021 02:57:32 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id e2-20020a17090a4a02b029016f3020d867so23917442pjh.3;
        Mon, 02 Aug 2021 02:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WyVL4WkI11l9/NdQwJ/0fZLbGwz2h2oimxqqge5BiNQ=;
        b=ndrKliUD0Sc9p+aCtLJrxxKD2lc9vgphyirwq2T3xuJByqS/DynAru4cWLSQMaXou0
         wibAYzyoQ/AVTGkwKu9idwl5yQEd1tznvXIU1OWNBfJy3XWDKUWd/7T0t77Z5DA4wKhj
         A9vjjczHmO3Jv8LPW0LPI9VFs1XDUQWKjs2AENsX5FT3X/ax6GkUsJeU+I65jm4aBn9W
         bcPUlK6BpL+n0a+rn0vT+lJKkAf0d8pFk43hFfNcS404uUQkSO4kGetzrlt6tveX2SN1
         fLjEiMCawEyvakYwP+vGCrXXDWRgjgDmR0sHbypwzcuM5S323063Yr3vBUCFy7YO+GdD
         5SmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WyVL4WkI11l9/NdQwJ/0fZLbGwz2h2oimxqqge5BiNQ=;
        b=h/uoKrV4QtZCmbUleunee8MAo7SgjaeF39yHdNU/foS3H5xDAW1qbRrgstpXkKoUQL
         fSgK+o2bzjTdKp+FBNTxTy5GPrG7VcK8zJ7jglJ2zbfo3ow0rcL4szUqdxzFJgDqbN/8
         C4O/MRyTs4Hkys076rXX3LBJ/gYX3i/Xl2BobhbPt+DHAmInqKAXrUUrtMQBE83R3tf4
         cqK4mGqeO0Qealhxk6/ORQYqWsFaROsbxbM/w7Jh1pqKunAEL7+Zdphgq/73OBqV6S5U
         epZGxY/ocKF69zs4LJdy722/JXk0JI2xQULfpdXy6+y8l83xpxu/45MJFsI6dZzrFbq/
         eNvw==
X-Gm-Message-State: AOAM531+xn78WR9lE0HGdT9vLnob4V3YVjcBwju34swVrBXv6IkfoU/1
        sfhrEg55CT+l0klUYJ7kmPo=
X-Google-Smtp-Source: ABdhPJzWJx0GKb/F6uqyHSLT2U5kE2dOItxh3Qfib6W5rWuVsUKfN/2vKRNm6YaMHOB1CKR8I3COLw==
X-Received: by 2002:a17:90a:bd06:: with SMTP id y6mr16659572pjr.6.1627898251901;
        Mon, 02 Aug 2021 02:57:31 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id h7sm8659462pjs.38.2021.08.02.02.57.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 02:57:31 -0700 (PDT)
Subject: [PATCH v3 7/9] docs: pdfdocs: Permit AutoFakeSlant for CJK fonts
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Wu X.C." <bobwxc@email.cn>, SeongJae Park <sj38.park@gmail.com>,
        Hu Haowen <src.res@email.cn>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <eb8184ab-cfab-680b-f180-1157a7f709b3@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <8acd5b35-7635-a367-9802-39d16aac2a18@gmail.com>
Date:   Mon, 2 Aug 2021 18:57:28 +0900
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

Noto CJK fonts don't provide italic shapes.
The AutoFakeSlant option of fontspec and xeCJK packages can be used as
a workaround.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
---
 Documentation/conf.py              | 56 +++++++++++++++---------------
 Documentation/translations/conf.py |  2 +-
 2 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 2e54488e2480..c4813e51dbc9 100644
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
 	% Define custom macros to on/off CJK
 	\\newcommand{\\kerneldocCJKon}{\\makexeCJKactive\\onehalfspacing}
 	\\newcommand{\\kerneldocCJKoff}{\\makexeCJKinactive\\singlespacing}
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


