Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 474903DD373
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 11:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbhHBJ4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 05:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbhHBJ4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 05:56:30 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80425C06175F;
        Mon,  2 Aug 2021 02:56:20 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id pj14-20020a17090b4f4eb029017786cf98f9so13285318pjb.2;
        Mon, 02 Aug 2021 02:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OY621qtdmVWZ38CJeyYLBUQk3E+swMG75TLPhTfGkB8=;
        b=JUOdWPx68FHcfPSwWUnfufpZM8LPoPzn1zOcQcZnNeU4v2IaRv4IhcpQlnqhqqiqxT
         FSfOY41eBUE/PLY/VJ95ckCnDh4S2JlwFmfACCoQ3Wwah+FPAbn8Iv9nWUlRkP2iOFpA
         U3Oz/ZfUtRpT/XwkLX69mkcMVbGtbSi67nBb5LXfLR2HLzgbZrhuVsuTPrFuJPmzz/8Q
         ADh/nGJsAZRHXpMczoeCKgiKyfJFxkOnj29ow5T3EMLtmkUt5BvUWSNMAPRcAqOpOIa+
         3m1++M62S9Xfsa8ychKiZ0JPfVBfaYTDg+UDnIr8Biw9oW0F7Mc17gIJJvTWuOvEmh3V
         RPzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OY621qtdmVWZ38CJeyYLBUQk3E+swMG75TLPhTfGkB8=;
        b=YZXuNBLw4k9qlngO6W6ixnkBqnLOxJfUEcaiQkQZSSSbXTZgMVu6dJnBIMCrtb7BFx
         pcCzxJkkJECIDNCMSzxV85N1cn15YsVQBX2lhCYN1TKbE4HMhb5SU2hSvTuoGHqNPGfj
         MZJvz1TOyMK9hu1+HXAOM+mydmNEBo4ex+6Hw+fawqUe+gyqZWVQtOiJSXUfk3Wpf+jp
         xuc5VFnCySoEUcfa46uAEfW8ct6BAOQMC7gCkOdE9zMQk/Yt6TCIEtGbrCxjEnSbXOus
         L741r5Vc8/WVX/gM8A4a0LtEAJu5jX36cKP9gDIKCQhsZmu+DGw5CLSFFpHbq/jAURB2
         lFXQ==
X-Gm-Message-State: AOAM532wqv7c7ZXP9z3L1ZGlH62lWC+ldjp5HQWlEvxtab6e0nvAMlzh
        a2pU94Vg4u4YSKckfp7w3JA=
X-Google-Smtp-Source: ABdhPJxTSzqg9lavz5cTbKauPZLHC+LHry67WakvCZQZSNiMHIc1T0FHjnJ3U1kizCn+n9EFaJIXeA==
X-Received: by 2002:a17:90a:a78d:: with SMTP id f13mr16113279pjq.206.1627898180022;
        Mon, 02 Aug 2021 02:56:20 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id c14sm11040854pjr.3.2021.08.02.02.56.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 02:56:19 -0700 (PDT)
Subject: [PATCH v3 6/9] docs: pdfdocs: One-half spacing for CJK translations
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Wu X.C." <bobwxc@email.cn>, SeongJae Park <sj38.park@gmail.com>,
        Hu Haowen <src.res@email.cn>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <eb8184ab-cfab-680b-f180-1157a7f709b3@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <a1c19fe1-2960-1c4b-b355-7e6da13b9630@gmail.com>
Date:   Mon, 2 Aug 2021 18:56:16 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <eb8184ab-cfab-680b-f180-1157a7f709b3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CJK documents are much easier to read with a wider baseline stretch.
Applying the onehalfspacing option of "setspace" package looks
reasonable.

Note: \usepackage{setspace} needs to be before that of hyperref in the
preamble.  The 'extrapackages' key (available since Sphinx 2.3) is for
this purpose.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
---
 Documentation/conf.py                      | 9 +++++++--
 Documentation/translations/ja_JP/howto.rst | 8 ++++++++
 Documentation/translations/ko_KR/howto.rst | 8 ++++++++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 2ccfe4442acc..2e54488e2480 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -341,6 +341,9 @@ latex_elements =3D {
         verbatimhintsturnover=3Dfalse,
     ''',
=20
+    # For CJK One-half spacing, need to be in front of hyperref
+    'extrapackages': r'\usepackage{setspace}',
+
     # Additional stuff for the LaTeX preamble.
     'preamble': '''
 	% Prevent column squeezing of tabulary.
@@ -405,8 +408,8 @@ latex_elements['preamble']  +=3D '''
 	\\newCJKfontfamily[JPsans]\\jpsans{Noto Sans CJK JP}
 	\\newCJKfontfamily[JPmono]\\jpmono{Noto Sans Mono CJK JP}
 	% Define custom macros to on/off CJK
-	\\newcommand{\\kerneldocCJKon}{\\makexeCJKactive}
-	\\newcommand{\\kerneldocCJKoff}{\\makexeCJKinactive}
+	\\newcommand{\\kerneldocCJKon}{\\makexeCJKactive\\onehalfspacing}
+	\\newcommand{\\kerneldocCJKoff}{\\makexeCJKinactive\\singlespacing}
 	\\newcommand{\\kerneldocBeginSC}{%
 	    \\begingroup%
 	    \\scmain%
@@ -437,6 +440,8 @@ latex_elements['preamble']  +=3D '''
 	    \\renewcommand{\\CJKttdefault}{JPmono}%
 	}
 	\\newcommand{\\kerneldocEndJP}{\\endgroup}
+	% Single spacing in literal blocks
+	\\fvset{baselinestretch=3D1}
 	% To customize \\sphinxtableofcontents
 	\\usepackage{etoolbox}
 	% Inactivate CJK after tableofcontents
diff --git a/Documentation/translations/ja_JP/howto.rst b/Documentation/t=
ranslations/ja_JP/howto.rst
index 73ebdab4ced7..d667f9d8a02a 100644
--- a/Documentation/translations/ja_JP/howto.rst
+++ b/Documentation/translations/ja_JP/howto.rst
@@ -1,3 +1,7 @@
+.. raw:: latex
+
+	\kerneldocCJKoff
+
 NOTE:
 This is a version of Documentation/process/howto.rst translated into Jap=
anese.
 This document is maintained by Tsugikazu Shibata <tshibata@ab.jp.nec.com=
>
@@ -11,6 +15,10 @@ try to update the original English file first.
=20
 ----------------------------------
=20
+.. raw:: latex
+
+	\kerneldocCJKon
+
 =E3=81=93=E3=81=AE=E6=96=87=E6=9B=B8=E3=81=AF=E3=80=81
 Documentation/process/howto.rst
 =E3=81=AE=E5=92=8C=E8=A8=B3=E3=81=A7=E3=81=99=E3=80=82
diff --git a/Documentation/translations/ko_KR/howto.rst b/Documentation/t=
ranslations/ko_KR/howto.rst
index a2bdd564c907..e3cdf0c84892 100644
--- a/Documentation/translations/ko_KR/howto.rst
+++ b/Documentation/translations/ko_KR/howto.rst
@@ -1,3 +1,7 @@
+.. raw:: latex
+
+	\kerneldocCJKoff
+
 NOTE:
 This is a version of Documentation/process/howto.rst translated into kor=
ean
 This document is maintained by Minchan Kim <minchan@kernel.org>
@@ -11,6 +15,10 @@ try to update the original English file first.
=20
 ----------------------------------
=20
+.. raw:: latex
+
+	\kerneldocCJKon
+
 =EC=9D=B4 =EB=AC=B8=EC=84=9C=EB=8A=94
 Documentation/process/howto.rst
 =EC=9D=98 =ED=95=9C=EA=B8=80 =EB=B2=88=EC=97=AD=EC=9E=85=EB=8B=88=EB=8B=A4=
=2E
--=20
2.17.1



