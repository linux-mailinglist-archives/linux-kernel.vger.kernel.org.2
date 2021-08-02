Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 510803DD33E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 11:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbhHBJrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 05:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbhHBJrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 05:47:17 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6259BC06175F;
        Mon,  2 Aug 2021 02:47:08 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id l19so24515620pjz.0;
        Mon, 02 Aug 2021 02:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d42hFxmAR+de/Ma3nHp16RLBWTaxq6GVIwZuqgtugdw=;
        b=lrkCtg3EBxhYAaaO7jYTzvYd4CZ73i6NY40N6MgMS0cbkI8w5AoDuwBtl0QbdpOT5r
         NgfLqzFYPlgANOIY5vYqcn9PjA12zqfVjsYo3wx1m/k082UBsEmruM3nzBcVmXs66zLR
         BehZ16j73Ddr8xuT1wYNqhcfypaHL4RLu5IN+BkuSqbT0RFx02e7ohy85pfvZyS5T1sf
         OYy7dvfqw4tUgksAwRKRK7RAWF/1dCNnHUdRbP9+eYDemqVEG+mkHSAdptSfJDgtc3Vh
         vYyIjsNSagGFeVYvpbo+uTfiLKAYk3JQh+7NqpY+SFbgQtTpuE6gjmWgKPY91uv7GMq1
         VXlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d42hFxmAR+de/Ma3nHp16RLBWTaxq6GVIwZuqgtugdw=;
        b=AjJ7hsOaBEK2+knncNmM87k/2Rl06Li8Cy5ChoN91+6ByRU8PaIlxMbHZJmrBMWM+J
         M2yUvaLW4QSkIq4jNHfH+obOLgteW9mKaIaSnLw5/oJ2BriaGnjrawaLurVry4tpKCvI
         4cWnnMm5bt3+EZaC6gwcjVvkFF9jXwUKqhXhBKwmHWmcy/WutGBUD3Z03ou8AvU4pANk
         auntvzC5fjXOVaDcaCmmUakVIwO2HUMd/d/fSb+mWMJoMotLZL5ZtSv8H5pdVGtMKZI3
         5TmMykyB94mqAoxGoJ09lXnAQF2WnZ80P1CUJxwvgKFfIVcbMLm4RWofV18nIJBq8ebd
         DVlQ==
X-Gm-Message-State: AOAM532k6j56cJRrgBHFbJOzXaCbpUu1dW+KbRpBFd6jNT4vN8NHZWWl
        g3H6cBxvGxaCsZo/9AQG3jM=
X-Google-Smtp-Source: ABdhPJz62g2FBiKz4QoKeNEWc6h1WMOsR3oM++En4qr5VT0CVVonFcZ5PumpzqIAKZAihO3XDuMF4A==
X-Received: by 2002:a63:d244:: with SMTP id t4mr2251165pgi.367.1627897627925;
        Mon, 02 Aug 2021 02:47:07 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id r18sm13290019pgk.54.2021.08.02.02.47.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 02:47:07 -0700 (PDT)
Subject: [PATCH v3 1/9] docs: pdfdocs: Refactor config for CJK document
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Wu X.C." <bobwxc@email.cn>, SeongJae Park <sj38.park@gmail.com>,
        Hu Haowen <src.res@email.cn>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <eb8184ab-cfab-680b-f180-1157a7f709b3@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <1a13dea8-8f73-2773-a077-233b8e5480a6@gmail.com>
Date:   Mon, 2 Aug 2021 18:47:04 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <eb8184ab-cfab-680b-f180-1157a7f709b3@gmail.com>
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


