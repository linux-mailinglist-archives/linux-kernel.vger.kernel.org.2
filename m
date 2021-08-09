Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8156E3E3D6C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 03:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbhHIBM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 21:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbhHIBM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 21:12:28 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1ADC061757;
        Sun,  8 Aug 2021 18:12:09 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id pj14-20020a17090b4f4eb029017786cf98f9so27595768pjb.2;
        Sun, 08 Aug 2021 18:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d42hFxmAR+de/Ma3nHp16RLBWTaxq6GVIwZuqgtugdw=;
        b=WBEauSONXkZ0AXxGMRNg8dK7JGIs4aQMEPyTcfIRvUpCImeL/p1sLE0USgR0zQuwvj
         qrghzgoBbyA6JyABKkhCa/nlQ2S/WBVnE1pIBxw64Ps6FpMaA65eE8i3whIIMmCZSjq4
         Fhefw44JqDl1EUWFwne5pLoCc1PNZuutn3fw1Epm5yTYjFt712bnndaX2MmWOx104H+L
         lNRR/gVTAhaKzxGU0xXWwAqzCwFrkzHPlVQyMciBZEwN6L574u1qUwCYPxHMR9o5XJab
         5nnYz30HBD1Ljk735CUEkzilBp0L0hwvOCZ7anE1KO+cZ+f8num/A5bXxIYGi5gvUw+H
         XIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d42hFxmAR+de/Ma3nHp16RLBWTaxq6GVIwZuqgtugdw=;
        b=g//cPa0ioaCNLQVFCXdXEZTuBV1zoatX5nocm5dVH5wiS1653L6S9n6DwH7G/QEBO2
         4CeaNskoM+XUgJLitVZrIqH2WakIZu3ktbssNhtVQ6dDh72S5B96uue/87H17cDIR3MR
         pignsVA1Dsj/EcoQxP0rXKPLYPG93kawUaT1Eory3oj1O4XsDDd9LcVLDIpMIooxB9Ch
         RJBjEpgq50s3U+to/0SDut9vSAQs4h2YIWCg3X+3wvfDF5lUEPuQVmtgH8yeqoPDq7ff
         PqfSP4DkAbJ1YKgv4ReaRt1Lw34CrTT0o8Rhd+Et32117twfYs0LlLrefYVZBzVTJPFL
         lxAA==
X-Gm-Message-State: AOAM5301kdipHN/MZ3LBrnYV05P53yrncpZn+eQE4zGyujq/0yFvkY/d
        B4cwHfaZcaRsDMmuGl7PewQ=
X-Google-Smtp-Source: ABdhPJz7yPM5PSMKocX8szSgCcIDmxTsXRMUNGrs9PQaPU4Z7SpGIpGETvDiwVQVZ1XSFX0JT0WZXg==
X-Received: by 2002:a17:90b:8ca:: with SMTP id ds10mr4184805pjb.105.1628471528641;
        Sun, 08 Aug 2021 18:12:08 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id 129sm13200250pfg.50.2021.08.08.18.12.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Aug 2021 18:12:08 -0700 (PDT)
Subject: [PATCH v4 1/9] docs: pdfdocs: Refactor config for CJK document
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Wu X.C." <bobwxc@email.cn>, SeongJae Park <sj38.park@gmail.com>,
        Hu Haowen <src.res@email.cn>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <39d0fb0f-b248-bca4-2dac-df69e8d697b1@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <4baf88af-316d-8aee-240f-6ccbc20907d7@gmail.com>
Date:   Mon, 9 Aug 2021 10:12:05 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <39d0fb0f-b248-bca4-2dac-df69e8d697b1@gmail.com>
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

Remove import of check_output as it is unused any more.

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


