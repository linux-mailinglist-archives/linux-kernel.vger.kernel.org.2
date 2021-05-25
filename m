Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF703902A3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 15:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbhEYNkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 09:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbhEYNkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 09:40:31 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7E8C061574;
        Tue, 25 May 2021 06:39:02 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso1815147pjx.1;
        Tue, 25 May 2021 06:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EzbYyP5UwyIoTXWlozrjLuefjB8+xmFA5gSv1CO0XqA=;
        b=ht9PyNjwM0xJQqbm93JGLTTQLLWLYf1k8n2d3gr3phUdAROvLwaJSXJ94nUmShMfWm
         L/AF3cm6aFGEqJXNXb5qM+HhUWrV2KqOoX3FC347kToiIHs3UqHa7XE4GvGy4OLdDn7V
         TSFi8AqQ5NmXx6TuNbX492BiRTysf5RcN6gMRovxUnaywqBOTQZhFSqDZMXqvxBPAsgd
         69NX+TkHtcXRxNwKiaASo867tjUovU6XCtfXFIbBLi5PngvPeTdvgtlkKPxR/YX4xXFG
         YJ1sn9vVJDXDupiSKrUS9BZ8ZH1t/bmUP5JbZ65+JUt5NPbCgqujSRnuwNC5Z04Iznnt
         kTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EzbYyP5UwyIoTXWlozrjLuefjB8+xmFA5gSv1CO0XqA=;
        b=mhYWIZJVUGuSXD5e36YZ7sD+eZhXuUAdwgFkw/ZdL88s/8QLY9hI1qjyOVH8OLkaWP
         qacQKggk8wp+firI3ZoPM9/y5s3ojEnz6JUW6O689SrxhRtbG4zypBIrYBVHzKMTaCt6
         chw6ZXTQW/GGsHH4/BHYb/dGwq+tKPTBh2Yb9D8oZnPbyb/Ftp5/+3myEn05HlNqKjj3
         mh70EKCeobEoNFpiGsYp1cc+T8V7hWTMSgAeKH91QaT1AtV1amQB3mgmadeADMMiXvJ3
         NkaWCDd07raEYHps1NHc4RWKBgsOs5J/iQbtzadd9yTv4DcyRs3JdcYFuaUSapUWCY4Q
         M7ZA==
X-Gm-Message-State: AOAM532AO0Uq9IQ7yoC+/cm/aS9+iPJzqMMEgs9BymvtleBTPrGWk6zK
        n3ZrsAy0p6RO/dmcG423UF0=
X-Google-Smtp-Source: ABdhPJxIUXDq1ROLXbIWYVSxaqp8kSg7EwK1KE9h0zUfkcaYnaW8gynZqfMkIvgty6NY17kQY327CA==
X-Received: by 2002:a17:902:9302:b029:f6:32d3:e10a with SMTP id bc2-20020a1709029302b02900f632d3e10amr27234897plb.29.1621949941518;
        Tue, 25 May 2021 06:39:01 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id jz7sm2114759pjb.32.2021.05.25.06.38.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 06:39:01 -0700 (PDT)
Subject: [PATCH v3] docs: Activate exCJK only in CJK chapters
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Wu X.C." <bobwxc@email.cn>, Akira Yokosawa <akiyks@gmail.com>
References: <2061da0a-6ab1-35f3-99c1-dbc415444f37@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <f8ce1d37-8f8c-c1de-2afe-7e0a1038838c@gmail.com>
Date:   Tue, 25 May 2021 22:38:58 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2061da0a-6ab1-35f3-99c1-dbc415444f37@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Activating xeCJK in English and Italian-translation documents
results in sub-optimal typesetting with wide-looking apostrophes
and quotation marks.

The xeCJK package provides macros for enabling and disabling its
effect in the middle of a document, namely \makexeCJKactive and
\makexeCJKinactive.

So the goal of this change is to activate xeCJK in the relevant
chapters in translations.

To do this:

    o Define custom macros in the preamble depending on the
      availability of the "Noto Sans CJK" font so that those
      macros can be used regardless of the use of xeCJK package.

    o Patch \sphinxtableofcontents so that xeCJK is inactivated
      after table of contents.

    o Embed those custom macros in each language's index.rst file
      as a ".. raw:: latex" construct.

Note: A CJK chapter needs \kerneldocCJKon in front of its chapter
heading, while a non-CJK chapter should have \kerneldocCJKoff
below its chapter heading.

This is to make sure the CJK font is available to CJK chapter's
heading and ending page's footer.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Tested-by: Wu XiangCheng <bobwxc@email.cn>
Link: https://lore.kernel.org/lkml/2061da0a-6ab1-35f3-99c1-dbc415444f37@g=
mail.com
---
v2 -> v3:

    o Fixed trailing white space
    o Added Tested-By from Wu XiangCheng

--
 Documentation/conf.py                      | 13 +++++++++++++
 Documentation/translations/index.rst       |  4 ++++
 Documentation/translations/it_IT/index.rst |  4 ++++
 Documentation/translations/ja_JP/index.rst |  5 +++--
 Documentation/translations/ko_KR/index.rst |  5 +++--
 Documentation/translations/zh_CN/index.rst |  1 +
 6 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 879e86dbea66..25aa00c707b0 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -371,6 +371,19 @@ if cjk_cmd.find("Noto Sans CJK SC") >=3D 0:
 	% This is needed for translations
         \\usepackage{xeCJK}
         \\setCJKmainfont{Noto Sans CJK SC}
+	% Define custom macros to on/off CJK
+	\\newcommand{\\kerneldocCJKon}{\\makexeCJKactive}
+	\\newcommand{\\kerneldocCJKoff}{\\makexeCJKinactive}
+	% To customize \sphinxtableofcontents
+	\\usepackage{etoolbox}
+	% Inactivate CJK after tableofcontents
+	\\apptocmd{\\sphinxtableofcontents}{\\kerneldocCJKoff}{}{}
+     '''
+else:
+    latex_elements['preamble']  +=3D '''
+	% Custom macros to on/off CJK (Dummy)
+	\\newcommand{\\kerneldocCJKon}{}
+	\\newcommand{\\kerneldocCJKoff}{}
      '''
=20
 # Fix reference escape troubles with Sphinx 1.4.x
diff --git a/Documentation/translations/index.rst b/Documentation/transla=
tions/index.rst
index e446e5ed00a6..556b050884fc 100644
--- a/Documentation/translations/index.rst
+++ b/Documentation/translations/index.rst
@@ -18,6 +18,10 @@ Translations
 Disclaimer
 ----------
=20
+.. raw:: latex
+
+	\kerneldocCJKoff
+
 Translation's purpose is to ease reading and understanding in languages =
other
 than English. Its aim is to help people who do not understand English or=
 have
 doubts about its interpretation. Additionally, some people prefer to rea=
d
diff --git a/Documentation/translations/it_IT/index.rst b/Documentation/t=
ranslations/it_IT/index.rst
index bb8fa7346939..e80a3097aa57 100644
--- a/Documentation/translations/it_IT/index.rst
+++ b/Documentation/translations/it_IT/index.rst
@@ -4,6 +4,10 @@
 Traduzione italiana
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
+.. raw:: latex
+
+	\kerneldocCJKoff
+
 :manutentore: Federico Vaga <federico.vaga@vaga.pv.it>
=20
 .. _it_disclaimer:
diff --git a/Documentation/translations/ja_JP/index.rst b/Documentation/t=
ranslations/ja_JP/index.rst
index 2f91b895e3c2..f94ba62d41c3 100644
--- a/Documentation/translations/ja_JP/index.rst
+++ b/Documentation/translations/ja_JP/index.rst
@@ -1,7 +1,8 @@
 .. raw:: latex
=20
-        \renewcommand\thesection*
-        \renewcommand\thesubsection*
+	\renewcommand\thesection*
+	\renewcommand\thesubsection*
+	\kerneldocCJKon
=20
 Japanese translations
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff --git a/Documentation/translations/ko_KR/index.rst b/Documentation/t=
ranslations/ko_KR/index.rst
index b9e27d20b039..6ae258118bdf 100644
--- a/Documentation/translations/ko_KR/index.rst
+++ b/Documentation/translations/ko_KR/index.rst
@@ -1,7 +1,8 @@
 .. raw:: latex
=20
-        \renewcommand\thesection*
-        \renewcommand\thesubsection*
+	\renewcommand\thesection*
+	\renewcommand\thesubsection*
+	\kerneldocCJKon
=20
 =ED=95=9C=EA=B5=AD=EC=96=B4 =EB=B2=88=EC=97=AD
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff --git a/Documentation/translations/zh_CN/index.rst b/Documentation/t=
ranslations/zh_CN/index.rst
index a736057da41f..1f953d3439a5 100644
--- a/Documentation/translations/zh_CN/index.rst
+++ b/Documentation/translations/zh_CN/index.rst
@@ -4,6 +4,7 @@
=20
 	\renewcommand\thesection*
 	\renewcommand\thesubsection*
+	\kerneldocCJKon
=20
 .. _linux_doc_zh:
=20
--=20
2.17.1



