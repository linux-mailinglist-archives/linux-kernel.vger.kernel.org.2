Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE80538D42D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 09:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhEVHaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 03:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbhEVHaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 03:30:24 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB54EC061574;
        Sat, 22 May 2021 00:28:59 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so8369230pjv.1;
        Sat, 22 May 2021 00:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=4p1xhNLzT+c2h4FRUwnsS5yL3/JXZxyrFVhYNGszoIo=;
        b=HVLbLeSW7Co6Dap2TWOwcYmASnP6yfS25NTFf+dkIJJSVQAwMBSGmscScejEcQD2TF
         wjRpam/iUoX9f3sz2SIh5ThsBDR2MT/loTX60ACQ/Gf+HGS9kitnJtePAj4+oGLTQJT7
         b5hbT2ybtIPyFOxqlBQ496TZ18lNceA745GcwG3drqvb3bT3sbL0JMyyp1j9S4PeHGaZ
         /PUO2vgu6nJRQM0MIeGhNOzMwjeupOeT7swT1VZG2F9hIiiXfS9o4bova25J9xxbV5Tz
         mpw0CO6UX2Aoa+UJeLmH1D7aAwOftgo6sNFCwm2gpmeKiYSHA273JSrVtqm0xBJqGhpW
         8tCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=4p1xhNLzT+c2h4FRUwnsS5yL3/JXZxyrFVhYNGszoIo=;
        b=C7RBIKAuN3hB6cBis0ZV7nz54fqCofFbXHjFw0+jCDr0sKtDQCY9GjAzXCrIFymQ8k
         ip7MR5i3cXaeWQqJWSoSHHoBEVQng7J27IYzy6JImMxN0cOIMMcs7XIDEcNo+odqX+Rw
         ONByBEZnxYKP3XoNEwQqw7bMNBJBSHU+cucwY/4Mq3eUAUzuEsIDVudGpjzWa5yTeffB
         Ey81GUqfYUtbQhEfRRc1l1TVi4CiKhSPNrqJIaYjJQ9GnNEbh5UfZW3PwfQ0nOW95z+O
         YDvL4603mKpzA3Jo4QG9kjeg1pJHMfeeqqcZ36N/mbXOqPI2ga2NT42cXgKBoe5tyEqs
         /c7Q==
X-Gm-Message-State: AOAM531SRnSLjXWQHsbQ9gFkkWcr9MXmcXIHIuUGAcBBxjz2YkEFoD69
        nMpvhi53Qywgjq5mUaQ4AfI=
X-Google-Smtp-Source: ABdhPJy8zzL5p93nxZDe/Bj3iqfRQ5HX7n+WZAcGfApwRYErd8PI9BxjR9+4tXmz3taM0tJ3tywPSQ==
X-Received: by 2002:a17:902:f541:b029:f0:7088:95e2 with SMTP id h1-20020a170902f541b02900f0708895e2mr16206949plf.84.1621668539112;
        Sat, 22 May 2021 00:28:59 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id g4sm6362932pgu.46.2021.05.22.00.28.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 May 2021 00:28:58 -0700 (PDT)
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH] docs: Activate xeCJK only in CJK chapters
Message-ID: <2061da0a-6ab1-35f3-99c1-dbc415444f37@gmail.com>
Date:   Sat, 22 May 2021 16:28:55 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Activating xeCJK in English or Italian-translation documents
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
      macros can be embedded in translations.tex after the fact.
      By default, xeCJK is inactive.

    o Add a script retouch-translations.sh to embed the on/off
      macros in translations.tex where necessary.
      The patterns in the script are ad-hoc by nature, and will
      need updates when the chapter organization changes.

    o Invoke the script at the final step of target "latexdocs".


Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
---
Hi Mauro,

Good news.
xeCJK can be activated/deactivated inside a document.
Which means we can activate xeCJK only in the CJK chapters
of the translations document.

This patch is an attempt to do so.

I think there still is ad-hoc aspect in this approach, but it
also fixed the build error of s390.pdf I encountered yesterday
(with the CJK font installed).

"make pdfdocs" now completes successfully both with and without
the CJK font installed.

Can you try this?
Any feedback is welcome!

        Thanks, Akira
--
 Documentation/Makefile                       |  2 ++
 Documentation/conf.py                        | 11 ++++++++
 Documentation/sphinx/retouch-translations.sh | 29 ++++++++++++++++++++
 3 files changed, 42 insertions(+)
 create mode 100755 Documentation/sphinx/retouch-translations.sh

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 9c42dde97671..31ca4d268fa0 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -96,6 +96,8 @@ linkcheckdocs:
 latexdocs:
 	@$(srctree)/scripts/sphinx-pre-install --version-check
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,latex,$(var),latex=
,$(var)))
+	@find $(BUILDDIR) -name translations.tex -exec \
+	sh $(srctree)/Documentation/sphinx/retouch-translations.sh \{\} \;
=20
 ifeq ($(HAVE_PDFLATEX),0)
=20
diff --git a/Documentation/conf.py b/Documentation/conf.py
index 879e86dbea66..b3ab8b6017af 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -371,6 +371,17 @@ if cjk_cmd.find("Noto Sans CJK SC") >=3D 0:
 	% This is needed for translations
         \\usepackage{xeCJK}
         \\setCJKmainfont{Noto Sans CJK SC}
+	% Define custom macro to on/off CJK
+	\\newcommand{\\kerneldocCJKon}{\\makexeCJKactive}
+	\\newcommand{\\kerneldocCJKoff}{\\makexeCJKinactive}
+	% CJK off by default
+	\\kerneldocCJKoff
+     '''
+else:
+    latex_elements['preamble']  +=3D '''
+	% Dummy custom macro to on/off CJK
+	\\newcommand{\\kerneldocCJKon}{}
+	\\newcommand{\\kerneldocCJKoff}{}
      '''
=20
 # Fix reference escape troubles with Sphinx 1.4.x
diff --git a/Documentation/sphinx/retouch-translations.sh b/Documentation=
/sphinx/retouch-translations.sh
new file mode 100755
index 000000000000..edbfde42b1a5
--- /dev/null
+++ b/Documentation/sphinx/retouch-translations.sh
@@ -0,0 +1,29 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Copyright 2021 Akira Yokosawa <akiyks@gmail.com>
+#
+# Retouch translations.tex to add CJK on/off macros.
+# The substitution rules need updates when there is some change in
+# the ordering of chapters.
+#
+# Path of the file to be retouched is passed in command argument $1
+# from docs Makefile.
+# If there is no need of retouch, do nothing.
+
+retouch=3D$1
+
+if [ -e $retouch ]; then
+	if grep -q 'kerneldocCJKon\\chapter' $retouch ; then
+		exit 0
+	fi
+	sed -i -e 's/\(\\sphinxtableofcontents\)/\\kerneldocCJKon\1/' \
+	    -e 's/\(\\chapter{=E4=B8=AD=E6=96=87\)/\\kerneldocCJKon\1/' \
+	    -e 's/\(\\chapter{Traduzione[^}]*}\)/\1\\kerneldocCJKoff/' \
+	    -e 's/\(\\chapter{=ED=95=9C=EA=B5=AD=EC=96=B4\)/\\kerneldocCJKon\1/=
' \
+	    -e 's/\(\\chapter{Disclaimer[^}]*}\)/\1\\kerneldocCJKoff/' \
+	    $retouch
+	echo "$retouch retouched."
+	exit 0
+else
+	exit 0
+fi
--=20
2.17.1


