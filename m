Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D688E3CD39C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 13:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236613AbhGSKdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 06:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236317AbhGSKdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 06:33:05 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914FFC061574;
        Mon, 19 Jul 2021 03:23:48 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id u14so18596346pga.11;
        Mon, 19 Jul 2021 04:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oH104RqPQFTQ1G6K4VMCFEyDvv4XbBXop+ivW0W8MLA=;
        b=CBP/jhcFqx1x1tucvIyE7TF4o3g6la2+OV184MmbtvS9Es3KFoR7ca6Uedzv6nVFb9
         1rJNgfBGKbnBvvmmleaIOc8jhaZpJx5/QpvFMICuIQxvsom4RoFTdIGhYbz2EtUKtf3y
         /cIr/v3TB20Vs/QP/iDxO4A4TNSgTDHPgoOERv0FcHqF6ZEa5xzCDR2oqtkXq9O+wWYj
         AtZ0oe9p7f1gkmECGvYGzBk38n77JiDkH/HJjoXyu5OxnbYLta6sqpLSYiF75BXZiKoG
         2POkvw/AOFjPX05PIO/WAKpxoNdNxJWG5brh72ZXAdU4hb5NSQlyMzUoWQraPZG/biQO
         O8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oH104RqPQFTQ1G6K4VMCFEyDvv4XbBXop+ivW0W8MLA=;
        b=epX09XRv4PJNNKDCjYFms9I42w18FsIUkNMLhbDAVQb5FRV0pY2Ln9SVI1FQlHk6u9
         xWfbwxi7O+TmTCCf4gErF+FJlssYrKExmmvyHreByWIJywHMVi3olA1mAvt5kcL4PQIM
         kW9OrqkJWyA10GTiWT9O2sfdZQB3xwrmoODxkesUNXE0H7DnijtrZl2qc6hlAdTcfIhn
         yJSM0lerFhSLIkwtE5FdlUzRq61XC1EI/xvsa7bJgeEob+m1CJWGmK6rCxXfMKnFV99Q
         Y49JPctQZ8+lkSmmTtOS5bKpwQwpBa0u7ctBZqzzyK+kND51cQLXARHDrGxjTh7U0Ur0
         Y4lA==
X-Gm-Message-State: AOAM532y1j06jiRAlaluFOHVqQUKfRyPzXYcQdVoDKn+Xu5m4gb6HMFk
        q+wO12LJmKfv916hS2X6gKSOkM1w3Fs=
X-Google-Smtp-Source: ABdhPJyHvx4Wtbf8/ljugDkmmgH/4bYnMqJugWw442a4qDY3v3mrGcf+X18IGi5xHN1RfImGjSoflQ==
X-Received: by 2002:aa7:8154:0:b029:310:70d:a516 with SMTP id d20-20020aa781540000b0290310070da516mr26026255pfn.63.1626693223881;
        Mon, 19 Jul 2021 04:13:43 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id u15sm21441898pgf.77.2021.07.19.04.13.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 04:13:43 -0700 (PDT)
Subject: [RFC PATCH v2 3/7] docs: pdfdocs: Use one-half spacing in CJK
 translations
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Wu X.C." <bobwxc@email.cn>, SeongJae Park <sj38.park@gmail.com>
Cc:     Hu Haowen <src.res@email.cn>,
        Shinwoo Lee <shinwoo.lee.us@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <20ff8a65-6a5c-c062-fe1a-0f5c5ddc813c@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <17e357ad-61a9-7701-bc19-3e5375f10e75@gmail.com>
Date:   Mon, 19 Jul 2021 20:13:40 +0900
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

CJK documents are much easier to read with a wider baseline stretch.
Applying onehalfspacing option of the "setspace" package gives a
reasonable result.

The wider baseline is effective between \kerneldocCJKon and
\kerneldocCJKoff.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
---
 Documentation/conf.py                      | 7 +++++--
 Documentation/translations/ja_JP/howto.rst | 8 ++++++++
 Documentation/translations/ko_KR/howto.rst | 8 ++++++++
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index a61628339d55..23d647881f6e 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -374,8 +374,9 @@ latex_elements['preamble']  +=3D '''
 	\\newCJKfontfamily[JPsans]\\jpsans{Noto Sans CJK JP}
 	\\newCJKfontfamily[JPmono]\\jpmono{Noto Sans Mono CJK JP}
 	% Define custom macros to on/off CJK
-	\\newcommand{\\kerneldocCJKon}{\\makexeCJKactive}
-	\\newcommand{\\kerneldocCJKoff}{\\makexeCJKinactive}
+	\\usepackage{setspace}
+	\\newcommand{\\kerneldocCJKon}{\\makexeCJKactive\\onehalfspacing}
+	\\newcommand{\\kerneldocCJKoff}{\\makexeCJKinactive\\singlespacing}
 	\\newcommand{\\kerneldocBeginSC}{%
 	    \\begingroup%
 	    \\scserif%
@@ -398,6 +399,8 @@ latex_elements['preamble']  +=3D '''
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



