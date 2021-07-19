Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A12B93CD398
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 13:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236629AbhGSKcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 06:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236330AbhGSKcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 06:32:00 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A621C061574;
        Mon, 19 Jul 2021 03:22:39 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id j4so1942906pgk.5;
        Mon, 19 Jul 2021 04:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fYTMnDkP9q2SzYe/Y2tqKXWv0310Kicj8uhBUBFBLuc=;
        b=iRPCqkO4vhkioJ/Iby726pf4Wm9p1CJ5DUupzq/2xSfMHGTBQIQSa5Hl66etVSDRWK
         yI+j3/TTJfp80VqzgpAKwG1E26pZmfHx6yIzZkglmXb0hQGIwnFshBGJZBT09uwczVfT
         dSMGEpINkd8MSooTBfONL9FpX6ttNnaCeCUQE0WMRSuehp5S+Z7hg5F3kbW/Xo0JYAHf
         EfGj5tvfZeKQbDgueLhmwrMP5lW3flwKgHx5azAMSsED6bx6zl5wOAEXuFMVupknzj9h
         yHR5346eyZicoJaX+XOrd32i7GiBoc28lixWAzB9cvZtoFS3DuSN5L9Jzu0QvHZT9Yrw
         C9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fYTMnDkP9q2SzYe/Y2tqKXWv0310Kicj8uhBUBFBLuc=;
        b=Em6Xb3FnKjetfsQ+AtiIaA4sM4A2QULHbH4ZWHD6atMm6o2cJu9bPSsypbVH5JraxC
         MhVic+EOHED5PfaR87+Avj95Y+fu98HTAgkr0oZWv8otzFpfwWk95m95qF/pYP1ql+eJ
         /Dh1Z5r/uC9bN+CftI+DucA6CrcxSY4gtNK6XbwXi5C9/oTT4hz1NaLKGh9HAIGaIc2F
         hkVV1CrRACNhDCJogMkdM549H8zREWSTOewjCYsE0zspliTyVH9sFt6jrZvZ4qCAwbB7
         xvSpg25kQ6i0J/tLAj5Aeqd9PJ99sfelMb6behX+FdjwtQh9Szd7jLyJh4jQK+4/o1/P
         GGRw==
X-Gm-Message-State: AOAM533hWBfQctR4j7cb9OklIBRqWKA75w/qf5k+/ig5rXcQUv6fFLHw
        KVT8Z1p4NVhNZoKPTgeHNug=
X-Google-Smtp-Source: ABdhPJzncBr9Kg9GbTG77435cIJ+idpoUziSymlTqLLmWKuctiv+gEa6WLL6z6tEmA6HPNZUb47WHg==
X-Received: by 2002:a63:fa11:: with SMTP id y17mr25179999pgh.128.1626693160122;
        Mon, 19 Jul 2021 04:12:40 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id m21sm16194429pjz.36.2021.07.19.04.12.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 04:12:39 -0700 (PDT)
Subject: [RFC PATCH v2 2/7] docs: pdfdocs: Add CJK-language-specific font
 settings
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Wu X.C." <bobwxc@email.cn>, SeongJae Park <sj38.park@gmail.com>
Cc:     Hu Haowen <src.res@email.cn>,
        Shinwoo Lee <shinwoo.lee.us@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <20ff8a65-6a5c-c062-fe1a-0f5c5ddc813c@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <9305a392-8b90-ce3e-693a-96f82f52cdae@gmail.com>
Date:   Mon, 19 Jul 2021 20:12:36 +0900
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

ko_KR and ja_JP translations have their preferred glyph sets
different from that of zh_CN.

To switch CJK font in the middle of the translations, introduce custom
LaTeX macros listed below:

    \kerneldocBeginSC
    \kerneldocEndSC
    \kerneldocBeginKR
    \kerneldocEndKR
    \kerneldocBeginJP
    \kerneldocEndJP

Note that CJKmainfont is changed to "Noto Serif CJK SC" as it suits well
with the roman font of Latin letters.

As for Korean translations, inter-phrase spaces in Hangul text can be
preserved by the \xeCJKsetup{CJKspace=3Dtrue} option.

As for monospace font, employing "Noto Sans Mono CJK SC" globally
will result in sub-optimal look of literal blocks in Latin documents
due to its rather tight width.
So, localize the font choice by adding conf.py under
Documentation/translations/.
The additional conf.py is enabled when the command:

    make SPHINXDIRS=3Dtranslations pdfdocs

is used to build the PDF.
Resulting translations.pdf (under Documentation/output/translations/pdf)
will have properly aligned ascii-art figures except for those in Korean
translations.

NOTE 1: Korean ascii-art figures' mis-alignment is due to the fact that
Hangul characters in "Noto Sans Mono CJK KR" are slightly narrower than
Hanja characters.

NOTE 2: Custom macros added here do not imply \kerneldocCJK{on|off}.
This is intentional.  For example, \kerneldocCJKoff needs to be
at the top of Italian translations' index.rst for the footer of
final zh_CN page to be properly typeset.

NOTE 3: Actual implementation of added macros has rooms to improve.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
---
 Documentation/conf.py                      | 44 +++++++++++++++++++++-
 Documentation/translations/conf.py         | 12 ++++++
 Documentation/translations/ja_JP/index.rst |  5 +++
 Documentation/translations/ko_KR/index.rst |  2 +
 Documentation/translations/zh_CN/index.rst |  5 +++
 5 files changed, 66 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/translations/conf.py

diff --git a/Documentation/conf.py b/Documentation/conf.py
index b440cb606d22..a61628339d55 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -360,11 +360,45 @@ latex_elements['preamble']  +=3D '''
     \\IfFontExistsTF{Noto Sans CJK SC}{
 	% This is needed for translations
 	\\usepackage{xeCJK}
-	\\setCJKmainfont{Noto Sans CJK SC}
+	\\setCJKmainfont{Noto Serif CJK SC}
+	\\setCJKsansfont{Noto Sans CJK SC}
+	\\setCJKmonofont{Noto Sans Mono CJK SC}
+	% CJK Language-specific font choices
+	\\newCJKfontfamily[SCserif]\\scserif{Noto Serif CJK SC}
+	\\newCJKfontfamily[SCsans]\\scsans{Noto Sans CJK SC}
+	\\newCJKfontfamily[SCmono]\\scmono{Noto Sans Mono CJK SC}
+	\\newCJKfontfamily[KRserif]\\krserif{Noto Serif CJK KR}
+	\\newCJKfontfamily[KRsans]\\krsans{Noto Sans CJK KR}
+	\\newCJKfontfamily[KRmono]\\krmono{Noto Sans Mono CJK KR}
+	\\newCJKfontfamily[JPserif]\\jpserif{Noto Serif CJK JP}
+	\\newCJKfontfamily[JPsans]\\jpsans{Noto Sans CJK JP}
+	\\newCJKfontfamily[JPmono]\\jpmono{Noto Sans Mono CJK JP}
 	% Define custom macros to on/off CJK
 	\\newcommand{\\kerneldocCJKon}{\\makexeCJKactive}
 	\\newcommand{\\kerneldocCJKoff}{\\makexeCJKinactive}
-	% To customize \sphinxtableofcontents
+	\\newcommand{\\kerneldocBeginSC}{%
+	    \\begingroup%
+	    \\scserif%
+	    }
+	\\newcommand{\\kerneldocEndSC}{\\endgroup}
+	\\newcommand{\\kerneldocBeginKR}{%
+	    \\begingroup%
+	    \\krserif%
+	    \\renewcommand{\\CJKrmdefault}{KRserif}%
+	    \\renewcommand{\\CJKsfdefault}{KRsans}%
+	    \\renewcommand{\\CJKttdefault}{KRmono}%
+	    \\xeCJKsetup{CJKspace =3D true} % For inter-phrase space
+	    }
+	\\newcommand{\\kerneldocEndKR}{\\endgroup}
+	\\newcommand{\\kerneldocBeginJP}{%
+	    \\begingroup%
+	    \\jpserif%
+	    \\renewcommand{\\CJKrmdefault}{JPserif}%
+	    \\renewcommand{\\CJKsfdefault}{JPsans}%
+	    \\renewcommand{\\CJKttdefault}{JPmono}%
+	    }
+	\\newcommand{\\kerneldocEndJP}{\\endgroup}
+	% To customize \\sphinxtableofcontents
 	\\usepackage{etoolbox}
 	% Inactivate CJK after tableofcontents
 	\\apptocmd{\\sphinxtableofcontents}{\\kerneldocCJKoff}{}{}
@@ -372,6 +406,12 @@ latex_elements['preamble']  +=3D '''
 	% Custom macros to on/off CJK (Dummy)
 	\\newcommand{\\kerneldocCJKon}{}
 	\\newcommand{\\kerneldocCJKoff}{}
+	\\newcommand{\\kerneldocBeginSC}{}
+	\\newcommand{\\kerneldocEndSC}{}
+	\\newcommand{\\kerneldocBeginKR}{}
+	\\newcommand{\\kerneldocEndKR}{}
+	\\newcommand{\\kerneldocBeginJP}{}
+	\\newcommand{\\kerneldocEndJP}{}
     }
 '''
=20
diff --git a/Documentation/translations/conf.py b/Documentation/translati=
ons/conf.py
new file mode 100644
index 000000000000..e859c2e19e8b
--- /dev/null
+++ b/Documentation/translations/conf.py
@@ -0,0 +1,12 @@
+# -*- coding: utf-8 -*-
+# SPDX-License-Identifier: GPL-2.0
+
+# -- Additinal options for LaTeX output --------------------------------=
--
+# font config for ascii-art alignment
+
+latex_elements['preamble']  +=3D '''
+    \\IfFontExistsTF{Noto Sans CJK SC}{
+	% For CJK ascii-art alignment
+	\\setmonofont{Noto Sans Mono CJK SC}
+    }{}
+'''
diff --git a/Documentation/translations/ja_JP/index.rst b/Documentation/t=
ranslations/ja_JP/index.rst
index f94ba62d41c3..88d4d98eed15 100644
--- a/Documentation/translations/ja_JP/index.rst
+++ b/Documentation/translations/ja_JP/index.rst
@@ -3,6 +3,7 @@
 	\renewcommand\thesection*
 	\renewcommand\thesubsection*
 	\kerneldocCJKon
+	\kerneldocBeginJP
=20
 Japanese translations
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
@@ -11,3 +12,7 @@ Japanese translations
    :maxdepth: 1
=20
    howto
+
+.. raw:: latex
+
+	\kerneldocEndJP
diff --git a/Documentation/translations/ko_KR/index.rst b/Documentation/t=
ranslations/ko_KR/index.rst
index 6ae258118bdf..f636b482fb4c 100644
--- a/Documentation/translations/ko_KR/index.rst
+++ b/Documentation/translations/ko_KR/index.rst
@@ -3,6 +3,7 @@
 	\renewcommand\thesection*
 	\renewcommand\thesubsection*
 	\kerneldocCJKon
+	\kerneldocBeginKR
=20
 =ED=95=9C=EA=B5=AD=EC=96=B4 =EB=B2=88=EC=97=AD
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
@@ -26,3 +27,4 @@
 .. raw:: latex
=20
     \normalsize
+    \kerneldocEndKR
diff --git a/Documentation/translations/zh_CN/index.rst b/Documentation/t=
ranslations/zh_CN/index.rst
index 1f953d3439a5..23c1e595ed78 100644
--- a/Documentation/translations/zh_CN/index.rst
+++ b/Documentation/translations/zh_CN/index.rst
@@ -5,6 +5,7 @@
 	\renewcommand\thesection*
 	\renewcommand\thesubsection*
 	\kerneldocCJKon
+	\kerneldocBeginSC
=20
 .. _linux_doc_zh:
=20
@@ -184,3 +185,7 @@ TODOList:
 ----------
=20
 * :ref:`genindex`
+
+.. raw:: latex
+
+	\kerneldocEndSC
--=20
2.17.1



