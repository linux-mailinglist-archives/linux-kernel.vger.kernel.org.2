Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 951F53E3D70
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 03:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbhHIBPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 21:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhHIBPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 21:15:17 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2729C061757;
        Sun,  8 Aug 2021 18:14:56 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id j1so25425113pjv.3;
        Sun, 08 Aug 2021 18:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zt2CmxMPCinxqJp6yrtjTUclK9S1FTTtiWMYSxiy/GI=;
        b=LwcoY4iel4SCKpMGObt02q1sX7p5gUKg8iVhxN3y/BYcvKvHcA6E5LMNRVRBYfX4df
         NFeiXx0EakxWuLU+JnB4WLJR+XkOvpGu23aoIrSsOtHDffC5oCJgWc9sNS8GNG4106N9
         r+J/T+ySxEicCNjfP6ccywArkOFDvkUZyUSxYd24FOSW2K19MY8OdZM3y6vVhugkleyx
         CgCSUiOXsoojyHL39AmFRspmFSlgYaE4jIMkKCxzarmgv7IB8ICQrYtO8VzhGWzYcgxJ
         zSaWmJ3y9ptTXFJwNbHrWjNucncuc4GCu5zo1DjVDBWP+oVbrKscE/VEM7moshGg3Jgx
         zZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zt2CmxMPCinxqJp6yrtjTUclK9S1FTTtiWMYSxiy/GI=;
        b=LjYkbHr/vb3e2OLhl5sAYvVA+UEUZKZv5JwcA+Vw8wVaYfcUpES2palgyfPG9zVxS5
         QiS3QvJvvrvHzPkE7Ird+JQIjqZq13LlUvacUzFUlYlrCQ1eSbaef9GrbzcvZNC4cHh+
         IbZK2+r2LVD8ge6oTl58Yk+hqgjZMqwamloYag64A0TelYmOjhJzwFRLWSwrOD1F8GUo
         1GWztndwgFh2U8sZ+DnUYcnMZfWKCR7SR/m3OM1gelmhDchhGbq1LoDRqxIMXb+ET/om
         ztqVjaelFbhoov8hvxAFwPP5UAb+ENf9FUvit0hT1+4kwB3EH7k/O8c4xbf7R6VTe7CP
         3mhQ==
X-Gm-Message-State: AOAM533VROP6b05GLQWD4InxJhdCEdeAV+mbA3n9DHCFrldifApjRJhI
        lcfkzy8oUkVde2refZUXOTM=
X-Google-Smtp-Source: ABdhPJzjnsj9nHNa0Y+9JpOFKuG55hLwj4EHgCsVQw4dlFAQn1risIUsX+gzY18tUxKOwjD5je9Geg==
X-Received: by 2002:aa7:9254:0:b029:3c9:268e:ae68 with SMTP id 20-20020aa792540000b02903c9268eae68mr10326181pfp.58.1628471696403;
        Sun, 08 Aug 2021 18:14:56 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id lk17sm19611012pjb.37.2021.08.08.18.14.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Aug 2021 18:14:56 -0700 (PDT)
Subject: [PATCH v4 2/9] docs: pdfdocs: Add CJK-language-specific font settings
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Wu X.C." <bobwxc@email.cn>, SeongJae Park <sj38.park@gmail.com>,
        Hu Haowen <src.res@email.cn>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <39d0fb0f-b248-bca4-2dac-df69e8d697b1@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <31906baf-7490-68cd-7153-4e4d320fb9b0@gmail.com>
Date:   Mon, 9 Aug 2021 10:14:53 +0900
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

zh_TW, ko_KR, and ja_JP translations have their preferred glyph sets
different from that of zh_CN.

To switch CJK font in the middle of the translations, introduce custom
LaTeX macros listed below:

    \kerneldocBeginSC
    \kerneldocEndSC
    \kerneldocBeginTC
    \kerneldocEndTC
    \kerneldocBeginKR
    \kerneldocEndKR
    \kerneldocBeginJP
    \kerneldocEndJP

, and embed a pair of macros in each language's index.rst.

NOTE 1: Update of zh_TW/index.rst is deferred to a follow-up change.

NOTE 2: Custom macros added here do not imply \kerneldocCJK(on|off).
This is intentional.  For example, \kerneldocCJKoff needs to be
at the top of Italian translations' index.rst for the footer of
final zh_TW page to be properly typeset.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
---
 Documentation/conf.py                      | 51 +++++++++++++++++++++-
 Documentation/translations/ja_JP/index.rst |  5 +++
 Documentation/translations/ko_KR/index.rst |  2 +
 Documentation/translations/zh_CN/index.rst |  5 +++
 4 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index b440cb606d22..24e5427588e7 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -361,10 +361,51 @@ latex_elements['preamble']  +=3D '''
 	% This is needed for translations
 	\\usepackage{xeCJK}
 	\\setCJKmainfont{Noto Sans CJK SC}
+	\\setCJKsansfont{Noto Sans CJK SC}
+	\\setCJKmonofont{Noto Sans Mono CJK SC}
+	% CJK Language-specific font choices
+	\\newCJKfontfamily[SCmain]\\scmain{Noto Sans CJK SC}
+	\\newCJKfontfamily[SCsans]\\scsans{Noto Sans CJK SC}
+	\\newCJKfontfamily[SCmono]\\scmono{Noto Sans Mono CJK SC}
+	\\newCJKfontfamily[TCmain]\\tcmain{Noto Sans CJK TC}
+	\\newCJKfontfamily[TCsans]\\tcsans{Noto Sans CJK TC}
+	\\newCJKfontfamily[TCmono]\\tcmono{Noto Sans Mono CJK TC}
+	\\newCJKfontfamily[KRmain]\\krmain{Noto Sans CJK KR}
+	\\newCJKfontfamily[KRsans]\\krsans{Noto Sans CJK KR}
+	\\newCJKfontfamily[KRmono]\\krmono{Noto Sans Mono CJK KR}
+	\\newCJKfontfamily[JPmain]\\jpmain{Noto Sans CJK JP}
+	\\newCJKfontfamily[JPsans]\\jpsans{Noto Sans CJK JP}
+	\\newCJKfontfamily[JPmono]\\jpmono{Noto Sans Mono CJK JP}
 	% Define custom macros to on/off CJK
 	\\newcommand{\\kerneldocCJKon}{\\makexeCJKactive}
 	\\newcommand{\\kerneldocCJKoff}{\\makexeCJKinactive}
-	% To customize \sphinxtableofcontents
+	\\newcommand{\\kerneldocBeginSC}{%
+	    \\begingroup%
+	    \\scmain%
+	}
+	\\newcommand{\\kerneldocEndSC}{\\endgroup}
+	\\newcommand{\\kerneldocBeginTC}{%
+	    \\begingroup%
+	    \\tcmain%
+	    \\renewcommand{\\CJKsfdefault}{TCsans}%
+	    \\renewcommand{\\CJKttdefault}{TCmono}%
+	}
+	\\newcommand{\\kerneldocEndTC}{\\endgroup}
+	\\newcommand{\\kerneldocBeginKR}{%
+	    \\begingroup%
+	    \\krmain%
+	    \\renewcommand{\\CJKsfdefault}{KRsans}%
+	    \\renewcommand{\\CJKttdefault}{KRmono}%
+	}
+	\\newcommand{\\kerneldocEndKR}{\\endgroup}
+	\\newcommand{\\kerneldocBeginJP}{%
+	    \\begingroup%
+	    \\jpmain%
+	    \\renewcommand{\\CJKsfdefault}{JPsans}%
+	    \\renewcommand{\\CJKttdefault}{JPmono}%
+	}
+	\\newcommand{\\kerneldocEndJP}{\\endgroup}
+	% To customize \\sphinxtableofcontents
 	\\usepackage{etoolbox}
 	% Inactivate CJK after tableofcontents
 	\\apptocmd{\\sphinxtableofcontents}{\\kerneldocCJKoff}{}{}
@@ -372,6 +413,14 @@ latex_elements['preamble']  +=3D '''
 	% Custom macros to on/off CJK (Dummy)
 	\\newcommand{\\kerneldocCJKon}{}
 	\\newcommand{\\kerneldocCJKoff}{}
+	\\newcommand{\\kerneldocBeginSC}{}
+	\\newcommand{\\kerneldocEndSC}{}
+	\\newcommand{\\kerneldocBeginTC}{}
+	\\newcommand{\\kerneldocEndTC}{}
+	\\newcommand{\\kerneldocBeginKR}{}
+	\\newcommand{\\kerneldocEndKR}{}
+	\\newcommand{\\kerneldocBeginSC}{}
+	\\newcommand{\\kerneldocEndKR}{}
     }
 '''
=20
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
index e0d51a167032..510ec10959fa 100644
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
@@ -189,3 +190,7 @@ TODOList:
 ----------
=20
 * :ref:`genindex`
+
+.. raw:: latex
+
+	\kerneldocEndSC
--=20
2.17.1



