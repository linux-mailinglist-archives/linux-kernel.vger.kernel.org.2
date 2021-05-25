Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1AF539055C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 17:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbhEYP1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 11:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbhEYP1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 11:27:14 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63D3C061756;
        Tue, 25 May 2021 08:25:43 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 29so11913922pgu.11;
        Tue, 25 May 2021 08:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7s/DRCuiVE2NCE6TZGnaI6FsGmYiMHrl3j/NuLD4A3w=;
        b=BD7fbb13Q1YIw/FxPOiIQmMqfP4qbH2j2DC9zZR2GH3qpK9iRoZOORhmd5cK3Z1JBl
         3soLUus5h4S9Ic2w2+a+e+YYy3vN+aS4ebWMt9duja209vs6ewxH+6J5N7k9tZq+EzdL
         /KxZz3FvMuLudJZMbsc+L9WOA27A8xMo/MSeHOKjh/ZVbH+oH92ki+rLNMg2MsSbA+u3
         Ze1HRuPGvzYEExOTMoU8xkv7Z9JIMC9Xjb5LgXanMN7A0EfDq2wX8AOkav6WAu6oakxB
         o8RTzqTj1LHCygSLUhuQ+WsP1Uw/GkjEf3DdRQxQYJJKa9YV7X8P3eCpl2eFDD/HBnq2
         RruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7s/DRCuiVE2NCE6TZGnaI6FsGmYiMHrl3j/NuLD4A3w=;
        b=iYFPwOyJQxmMdU5Yo5UOJZK+oJGNkYNu8g33yxdndlSt0uCcCNMNZnVLOcqU2Gnssc
         zSYTtz3hszBCUfK9Fni6XC+3F96JaxC3NPf28m15vfUBf44sgWA2GDhd4h53KC+4NZ+B
         is241wvDj9hUTLkmGrPL6qmOyUN0UswjKKubSNCFLbpvyM3XH9ZVPeJzrkaGoLxYvKfg
         T9oTUy+4IePkA4l+7qEt1CGYqRjr1+I21xIF1J+zOLeYJNB9R+G5fFQksBzjuS4fpkEp
         1aL1VCE/QoSQC7x2SqZOQviOjhIjrjolREYPJcvD0sKtTpTEJgr09eQR8evgMmFbNmoz
         ZbXA==
X-Gm-Message-State: AOAM5338cEcrTX2h0qbM6qzhcZ1KF3pBfcNF3/jtOWpmuw5cCixRo95W
        LJy/zmXWOXAR3cyOps8O1/0=
X-Google-Smtp-Source: ABdhPJy9//JkIzsLKxyP85ttFbYKeDK9ncWcBGA7fNuw+JDoqQA4o4vOONzqmcSmcS5N349hVkCjng==
X-Received: by 2002:aa7:8703:0:b029:2da:b87f:7d38 with SMTP id b3-20020aa787030000b02902dab87f7d38mr31336530pfo.20.1621956343379;
        Tue, 25 May 2021 08:25:43 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id ie5sm2333077pjb.14.2021.05.25.08.25.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 08:25:42 -0700 (PDT)
Subject: [PATCH v4] docs: Activate exCJK only in CJK chapters
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Wu X.C." <bobwxc@email.cn>, Akira Yokosawa <akiyks@gmail.com>
References: <2061da0a-6ab1-35f3-99c1-dbc415444f37@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <83208ddc-5de9-b283-3fd6-92c635348ca0@gmail.com>
Date:   Wed, 26 May 2021 00:25:39 +0900
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

Tested against Sphinx versions 2.4.4 and 4.0.2.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Tested-by: Wu XiangCheng <bobwxc@email.cn>
Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Link: https://lore.kernel.org/lkml/2061da0a-6ab1-35f3-99c1-dbc415444f37@g=
mail.com
---
v3 -> v4: (Change log update)

    o Added Reviewed-by from Mauro
    o Added note on Sphinx versions (2.4.4 and 4.0.2) tested against

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



