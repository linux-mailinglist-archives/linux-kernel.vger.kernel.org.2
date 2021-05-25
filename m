Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A351938FFDA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 13:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhEYLTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 07:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhEYLTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 07:19:00 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3F6C061574;
        Tue, 25 May 2021 04:17:30 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id 69so16188523plc.5;
        Tue, 25 May 2021 04:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Uqov9+FQrcMyLpDp6pVOHvJod0/ZjMr0E8znSBCKxs8=;
        b=PKbtWZ3MIiHUUY0isZVYSiV/fnp4dTzSageOlP8NiqnS5CpqLHctkXNTMWXekByDtx
         GgUpEU3C4y6FuR2wn90fwLTDea3oUh75WTh6FCNSqsEUtCG/Sk6Jv2wAbYv976JLhlKG
         Eb2VkUBC9O0y4hrtvM0Y0t452lbNZN4Uc9FmBW3o3zcdeFpyyX8qsWlxgXrzvO6DOMf5
         ITPyrXPnog+kb4ziD77rBoNGJdrBqH1F7Gd3OvZWDhwZLd0fLE2pq6JGXOB/G5nR1yQf
         +T4oU5DG16rD5OtmT4isOHNXvaKlt3GngF6yf3yAyXXJ0sQqbMhhf1m2on6D6hT1gWk+
         h9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Uqov9+FQrcMyLpDp6pVOHvJod0/ZjMr0E8znSBCKxs8=;
        b=B36jQWVj82+InVjv0X3EBvScDmqzBDelrmZogPsqBWBRshvXyGA8Z+aj8bKXmOQ9Hg
         Oo3deYxKdNvS725e/bm/kEhOPCTl63xn6XBdneXNsFK1RdtXpHDr67uYT5xAdoZ8HfSN
         t4e4KmDPsmJ8vOD3m7TyWw9NH1L21QB/OMUbgNIUO3oPKVEtkBXWHexFJvM9i2QnA7Gk
         tGK0kkbQIn1t39hANSHC1Z82MQH40NGPERf3V4Ta0aEx4d6+QdUixU3vhwLz3oeHbYq3
         PCRHuOPKWZgGSIeN8W7BO39A7y9MxNZlKTTJTm7Cz2yChCBXLsHfYV9Y/AH2sWiwyNYs
         4OMA==
X-Gm-Message-State: AOAM531TT6PMxBnUuCTnY0vflpFmj4+GVO1Y7MY1UTDKnnLa7LBcKMGl
        Y8c7f+cNXKvNabi3DS0Kf94Kt2gaDgI=
X-Google-Smtp-Source: ABdhPJymjQNyH6izyea4yqL+s7ZbKHHr9+zudahSmh9gcywGhR4AwXcO9depzv1NIwQenu/1FLCx9Q==
X-Received: by 2002:a17:90b:30d0:: with SMTP id hi16mr29584020pjb.30.1621941449935;
        Tue, 25 May 2021 04:17:29 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id 136sm13320163pfu.195.2021.05.25.04.17.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 04:17:29 -0700 (PDT)
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH v2] docs: Activate exCJK only in CJK chapters
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Wu X.C." <bobwxc@email.cn>,
        Akira Yokosawa <akiyks@gmail.com>
References: <2061da0a-6ab1-35f3-99c1-dbc415444f37@gmail.com>
Message-ID: <0229bc4d-b391-41b9-e900-b88089c493df@gmail.com>
Date:   Tue, 25 May 2021 20:17:26 +0900
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
---
Hi all,

I'm still unable to manage the per-directory conf.py idea to work,
but as far as activation/inactivation of xeCJK is concerned,
the custom LaTeX macros can be embedded in each language's
index.rst.

Also note that the on/off macros added here are still useful
when the xeCJK related settings are moved into per-directory
conf.py, because of the Disclaimer in English.

I think per-directory conf.py can be tried as a follow-up
change after this patch is applied.

Thoughts?

        Thanks, Akira
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
index e446e5ed00a6..f07eb317cfba 100644
--- a/Documentation/translations/index.rst
+++ b/Documentation/translations/index.rst
@@ -18,6 +18,10 @@ Translations
 Disclaimer
 ----------
=20
+.. raw:: latex
+
+	\kerneldocCJKoff=09
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


