Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2EF53CD37C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 13:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236452AbhGSK32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 06:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235905AbhGSK3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 06:29:25 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6256FC061574;
        Mon, 19 Jul 2021 03:19:50 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id y4so18580271pgl.10;
        Mon, 19 Jul 2021 04:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EtS9KZrtxy9xubLLJzujdJdVgsBmAdfNXTJNwmkcji8=;
        b=RsH+YOe1qFM2h5KIJY2I6ZTWLdjO8AZSVfKYwWv4IYm7iD5bQOcC4zl1KDZXrL0KoN
         Fo30saFMP4DKOfG2duPrktNoaShxc9DsiJsYz3TXtme8ZxQ/3ADy1ua4pqDuItAcMH0J
         Rh5cKS7A6LfKzxRuemDE/Ui2a0lirC1/2Qx/tSJZT1uy781SYIkrKu1b3GMEMpJsPfZE
         zNHpCf2Gyt2X6ebKyPYxGPszQvQE5uwhzILbpicKN4cmvPLx8sCb8z9gq65UQr6mkXZM
         wG689N0ruhvBSXw2HzbEPZX1X5lfc0bUCXIAkTim55b6tpryKu/xcDIMFfIC6QCScHwP
         vo0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EtS9KZrtxy9xubLLJzujdJdVgsBmAdfNXTJNwmkcji8=;
        b=IHHUWvPrKPqdKqHgtnb17Bg22ZMc7zVCmXAlHia+2carcKdBwDWALamaqkLlN8o6Ej
         XQ+GSUyxHUHiiRJfAbznVXmj9YzZLAPuh0co0ug+knvYG7O33Vm8NVVwyZXnA0jlFggR
         Lzb9kRU+mNIPCeV+DF0g2U0bvm5LrdcKFtkx/RgZuTP7aqXMAF2N10UhSicnPriXEVKr
         PPGHyZEV3UebYRjhjBC52AATwzKIM0M80VrricKYVHHs63u/iaVFhvc7PFyWS9jWo1uB
         EcxvMr6Bk0gQFZp0Lf8FV7FAopw4v7m1QnWSsTwsvQKiiqLbOL4le/CxjGY2urZw2Rcc
         f/rA==
X-Gm-Message-State: AOAM531O6DwPhBJXUXwS9fbD3Kho4Tj+j1EZdkXFZs9jI6Q2J2BTS1Rt
        yBjCdWitBgJ8N8vflq+JzcA=
X-Google-Smtp-Source: ABdhPJyK9EXDUG77WfRmR3tVNgQJk335m5RTBGLiu27ngFPS3jS/RPqITlUeM+hIpNIr48BtT8ZNpA==
X-Received: by 2002:aa7:804f:0:b029:334:4951:da88 with SMTP id y15-20020aa7804f0000b02903344951da88mr19219440pfm.29.1626693003944;
        Mon, 19 Jul 2021 04:10:03 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id l6sm21727265pgh.34.2021.07.19.04.10.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 04:10:03 -0700 (PDT)
Subject: [RFC PATCH v2 1/7] docs: pdfdocs: Refactor config for CJK document
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Wu X.C." <bobwxc@email.cn>, SeongJae Park <sj38.park@gmail.com>
Cc:     Hu Haowen <src.res@email.cn>,
        Shinwoo Lee <shinwoo.lee.us@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <20ff8a65-6a5c-c062-fe1a-0f5c5ddc813c@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <ea17ce02-07f3-a34c-ced2-c585caa50607@gmail.com>
Date:   Mon, 19 Jul 2021 20:10:00 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20ff8a65-6a5c-c062-fe1a-0f5c5ddc813c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make generated LaTeX code portable across systems with different sets
of available fonts, convert font-availability check in python code to
LaTeX code by using a conditional command provided by the "fontspec"
package.

This will help those who run Sphinx on one machine/container and run
latexmk on other machines/containers.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
---
 Documentation/conf.py | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 7d92ec3e5b6e..b440cb606d22 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -16,8 +16,6 @@ import sys
 import os
 import sphinx
 
-from subprocess import check_output
-
 # Get Sphinx version
 major, minor, patch = sphinx.version_info[:3]
 
@@ -355,15 +353,14 @@ latex_elements = {
      ''',
 }
 
-# At least one book (translations) may have Asian characters
-# with are only displayed if xeCJK is used
+# Translations have Asian (CJK) characters which are only displayed if
+# xeCJK is used
 
-cjk_cmd = check_output(['fc-list', '--format="%{family[0]}\n"']).decode('utf-8', 'ignore')
-if cjk_cmd.find("Noto Sans CJK SC") >= 0:
-    latex_elements['preamble']  += '''
+latex_elements['preamble']  += '''
+    \\IfFontExistsTF{Noto Sans CJK SC}{
 	% This is needed for translations
-        \\usepackage{xeCJK}
-        \\setCJKmainfont{Noto Sans CJK SC}
+	\\usepackage{xeCJK}
+	\\setCJKmainfont{Noto Sans CJK SC}
 	% Define custom macros to on/off CJK
 	\\newcommand{\\kerneldocCJKon}{\\makexeCJKactive}
 	\\newcommand{\\kerneldocCJKoff}{\\makexeCJKinactive}
@@ -371,13 +368,12 @@ if cjk_cmd.find("Noto Sans CJK SC") >= 0:
 	\\usepackage{etoolbox}
 	% Inactivate CJK after tableofcontents
 	\\apptocmd{\\sphinxtableofcontents}{\\kerneldocCJKoff}{}{}
-     '''
-else:
-    latex_elements['preamble']  += '''
+    }{ % No CJK font found
 	% Custom macros to on/off CJK (Dummy)
 	\\newcommand{\\kerneldocCJKon}{}
 	\\newcommand{\\kerneldocCJKoff}{}
-     '''
+    }
+'''
 
 # Fix reference escape troubles with Sphinx 1.4.x
 if major == 1:
-- 
2.17.1


