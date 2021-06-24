Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946B93B2EA1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 14:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhFXMLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 08:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhFXMLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 08:11:13 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04827C061767;
        Thu, 24 Jun 2021 05:08:53 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id c5so4980461pfv.8;
        Thu, 24 Jun 2021 05:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1HIae1IsTpNnOLreRylFk4etMZm5amtWa1pmqvSZnbI=;
        b=BU698jLDNATJW6K6T1wqHj8gJs1B/N/MXT3RyNcUyJ+CRBqFWVSHBBSHRCC9Nt2RhY
         BuWxOee+vntpLjNRZSvAd0VL/cEhXmDVciNiyDsIdjtGEMLesgbuO8VN1EPJiEjVVkeX
         GUY5MXTDZ13VCyRnjSaPrKrNOV5LUHf6bCbPyRQMKs7uyHyjbo03pIGzOO+5R7c4mvMJ
         s3F0St50qe4dG1e1qTS7xxss7XEE90hjoQUcngLQqHSYQPDCAtShv76gw3bEKpZ+wm/F
         wWMARP6xL44vr+FV+GJATF206EB+M1ijehcALssmEkzNaXTTeqyVziAy+QpChrgHXQly
         8NqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1HIae1IsTpNnOLreRylFk4etMZm5amtWa1pmqvSZnbI=;
        b=WYbLXo3NTxdOiMFTCS+nBbf/Zqm3BrJ9HKB/WXgIRvK8zwnQZd/5c9hqMR44t+KndO
         BpmAhW4QQ7NzJPWQnxP1rfOFLZ72tSEBpc6SIdUwW7wviWt9GAkQB4eIOjV7f0a504Jd
         sJ8mHMzdusLKVlGgrnhDgrEU/vxgOwACXzB3/XgUlcBjvAl4XXzGzlHAWniBA0Jr6KO1
         m/37EbVHZFte75wIPoRecmpg0IhGmTyckjTmCcTtl7hw5mE3mjcCf9rSp0kYcGR96rVC
         gHf7O+kQBfZpU54AQXn78oq6R6gly/yZmMAJnNx11XrGtezZl2kNMYWQlFxBoZJuRN8n
         Qwig==
X-Gm-Message-State: AOAM530C8kinFOOHrzscaxbzU/NuY+6fH3c8YJ9n6Fmybt4kH4bX0BjZ
        UbFgOO6fBERO4W4nlmkgbqk=
X-Google-Smtp-Source: ABdhPJxbM57+WaQXftV0IBJ3FOSmK0pLsvwcVVpBQo6DPJ5c8+lQF8BYK02Rbj5gasrCDEpg549iLQ==
X-Received: by 2002:a63:6e87:: with SMTP id j129mr4490153pgc.45.1624536532533;
        Thu, 24 Jun 2021 05:08:52 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id lb14sm8237455pjb.5.2021.06.24.05.08.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 05:08:52 -0700 (PDT)
Subject: [RFC PATCH 1/3] docs: pdfdocs: Refactor config for CJK document
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     "Wu X.C." <bobwxc@email.cn>, SeongJae Park <sj38.park@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <386938dc-6290-239c-4b4f-c6153f3d98c5@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <45a7b96a-bc27-ade4-716a-c319715e1b4d@gmail.com>
Date:   Thu, 24 Jun 2021 21:08:49 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <386938dc-6290-239c-4b4f-c6153f3d98c5@gmail.com>
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

This will help those who want to run Sphinx on one machine/container
and run latexmk on other machines/containers with different font
configurations.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
---
 Documentation/conf.py | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 7d92ec3e5b6e..22f083bafaae 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -358,26 +358,23 @@ latex_elements = {
 # At least one book (translations) may have Asian characters
 # with are only displayed if xeCJK is used
 
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
-	% To customize \sphinxtableofcontents
+	% Inactivate CJK after tableofcontents (using etoolbox)
 	\\usepackage{etoolbox}
-	% Inactivate CJK after tableofcontents
 	\\apptocmd{\\sphinxtableofcontents}{\\kerneldocCJKoff}{}{}
-     '''
-else:
-    latex_elements['preamble']  += '''
+    }{ % No CJK font
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


