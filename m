Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00DF3CD3B2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 13:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236473AbhGSKge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 06:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235999AbhGSKgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 06:36:31 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3183C061574;
        Mon, 19 Jul 2021 03:27:31 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id a6so11326932pgw.3;
        Mon, 19 Jul 2021 04:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RbZ1fp7+3stRY8Uk9v8nVPrVKsRUvay5H0101Cor1uw=;
        b=s4ToIQa77FMsUGF4lYXMm5uZ08NBZ4YXQmu156fcz17EtNkGjmgn1I8PurEN31ZUQT
         3NeMOE9wW9Q0rqxLn5lktzPmUa7nSYQRmOfDWeV8KAhwaDj1NTtyJcA9oKiGG/U164LO
         /c/eFte6RQNv0O9c5/Ovt4D9P5IKKB2KKngxRqbYjXrVcHyUsUAHofzvzTjeK/IryZFd
         GmFYF/5kXjFMSUdLNgUspF6cPE/XmDdOoW4klrFwhonQHyq2SesrfB0UKfCV/u8U0ieL
         gMhJuWguZw9ivuQtOizZWsnI1sUDeXxaDKwCEqvYxNFxsJaBtugQF7MtbF2eZqGwm6Dc
         xedg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RbZ1fp7+3stRY8Uk9v8nVPrVKsRUvay5H0101Cor1uw=;
        b=CZcAlzDNfQuZNn/PxqsvKBzT+SHe3OjtS1zyC3Nk/PfK2yGr6/G8YMrSsK6ZG7CcT2
         PhLL+hqKI4O1r5wGz0O6JLX5dU32OsgrZtb+9rxLLg3THWHYlhboRdyqH3aS16Z3472b
         iWta/YcvM6LbbYXBL3ARjWdupYwmIul8idO2Mhy1ccrLWz4jzUMolnZJs7j8TDEl65hz
         z9nid1tc0+CITti+mbDkA1adsnyxJmgIOowm5nBTKuK8iGYWgM8TCUZeWhMaFvJ5A2nS
         grzNnOiJy5uXQseL2raHNmBdqHf89LJx3JhC5ytFB0ffQTfL7UrTz0a5mty2CyzAswX3
         lgxg==
X-Gm-Message-State: AOAM533fBq+/zIrfHnEC0XUaWtVecuFKaF1gBehqPgNiTKzH4qRLAtk/
        znMlFlTY19cln5Gpk52H3Ura2RZVUMI=
X-Google-Smtp-Source: ABdhPJwdVAkySFY+2g4nXuawJrNPFGgW37tww6RvB2wF38sjh6CFN7ZMf90MX8FDpyMtS+hsCEeYnw==
X-Received: by 2002:a62:e90b:0:b029:30e:4530:8dca with SMTP id j11-20020a62e90b0000b029030e45308dcamr25514964pfh.17.1626693430050;
        Mon, 19 Jul 2021 04:17:10 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id p25sm19633277pff.120.2021.07.19.04.17.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 04:17:09 -0700 (PDT)
Subject: [RFC PATCH v2 6/7] docs: pdfdocs: Add optional choices for Korean
 monospace font
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Wu X.C." <bobwxc@email.cn>, SeongJae Park <sj38.park@gmail.com>
Cc:     Hu Haowen <src.res@email.cn>,
        Shinwoo Lee <shinwoo.lee.us@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <20ff8a65-6a5c-c062-fe1a-0f5c5ddc813c@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <c5eccdd8-8172-6dc0-c412-4d7655bd26cc@gmail.com>
Date:   Mon, 19 Jul 2021 20:17:06 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20ff8a65-6a5c-c062-fe1a-0f5c5ddc813c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Candidates of alternative choices of a *true* monospace font would
be "D2Coding", "Sarasa Mono K", or "Unifont" font.

The alignment of Korean ascii-art figures matters when the optional
conf.py under Dodumentation/translations/ is effective.
So, add conditional settings in the local config so that when one of
the candidate fonts is found, it is used instead of "Noto Sans Mono
CJK KR".

As xeCJK does not provide a macro to redefine an existing CJK font
family, define a wrapper macro "\setKRmono" and use it in the
"\kerneldocBeginKR" macro.

Also mention the nice-to-have monospace Hangul fonts in the header
comment in conf.py.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
---
 Documentation/conf.py              |  4 +++-
 Documentation/translations/conf.py | 34 +++++++++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 8a715765dada..1368c64e3993 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -382,6 +382,8 @@ latex_elements['preamble']  +=3D '''
 	    \\scserif%
 	    }
 	\\newcommand{\\kerneldocEndSC}{\\endgroup}
+	\\newcommand{\\setKRmono}{% For alternative Hangul monospace font
+	    \\renewcommand{\\CJKttdefault}{KRmono}}
 	\\newcommand{\\kerneldocBeginKR}{%
 	    \\begingroup%
 	    \\xeCJKDeclareCharClass{HalfLeft}{`=E2=80=9C,`=E2=80=98}%
@@ -389,7 +391,7 @@ latex_elements['preamble']  +=3D '''
 	    \\krserif%
 	    \\renewcommand{\\CJKrmdefault}{KRserif}%
 	    \\renewcommand{\\CJKsfdefault}{KRsans}%
-	    \\renewcommand{\\CJKttdefault}{KRmono}%
+	    \\setKRmono%
 	    \\xeCJKsetup{CJKspace =3D true} % For inter-phrase space
 	    }
 	\\newcommand{\\kerneldocEndKR}{\\endgroup}
diff --git a/Documentation/translations/conf.py b/Documentation/translati=
ons/conf.py
index 92cdbba74229..0e171eed1862 100644
--- a/Documentation/translations/conf.py
+++ b/Documentation/translations/conf.py
@@ -3,10 +3,42 @@
=20
 # -- Additinal options for LaTeX output --------------------------------=
--
 # font config for ascii-art alignment
-
+#
+# Note: Ascii-art figures involving Hangul characters need optional
+#       monospace font. (Hangul in "Noto Sans Mono CJK" is slightly narr=
ow.)
+#       If you'd like to see properly aligned ascii-art figures in Korea=
n
+#       translations, you need to install a *true* monospace Hangul font=
=2E
+#
+#       Candidates of such a monospace font which covers Hangul:
+#   1)  D2Coding: Availabe at
+#	    https://github.com/naver/d2codingfont/releases/latest
+#   2)  Sarasa Mono K: Available at
+#	    https://github.com/be5invis/Sarasa-Gothic/releases/latest
+#   3)  Unifont: (easy to install but poor quality)
+#	    Available as distro packages, e.g.:
+#		Ubuntu/Debian: ttf-unifont
+#		Fedora: unifont-fonts
+#
 latex_elements['preamble']  +=3D '''
     \\IfFontExistsTF{Noto Sans CJK SC}{
 	% For CJK ascii-art alignment
 	\\setmonofont{Noto Sans Mono CJK SC}[AutoFakeSlant]
+	\\IfFontExistsTF{D2Coding}{
+	  \\newCJKfontfamily[KRtruemono]\\krtruemono{D2Coding}[AutoFakeSlant]
+	  \\renewcommand{\\setKRmono}{%
+	    \\renewcommand{\\CJKttdefault}{KRtruemono}}
+	}{
+	  \\IfFontExistsTF{Sarasa Mono K}{
+	    \\newCJKfontfamily[KRtruemono]\\krtruemono{Sarasa Mono K}
+	    \\renewcommand{\\setKRmono}{%
+	      \\renewcommand{\\CJKttdefault}{KRtruemono}}
+	  }{
+	    \\IfFontExistsTF{Unifont}{
+	      \\newCJKfontfamily[KRtruemono]\\krtruemono{Unifont}[AutoFakeSlant=
,AutoFakeBold]
+	      \\renewcommand{\\setKRmono}{%
+		\\renewcommand{\\CJKttdefault}{KRtruemono}}
+	    }{}
+	  }
+	}
     }{}
 '''
--=20
2.17.1



