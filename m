Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD7F3FA832
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 04:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbhH2CHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 22:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbhH2CHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 22:07:11 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E0FC061756;
        Sat, 28 Aug 2021 19:06:20 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id s29so4404664pfw.5;
        Sat, 28 Aug 2021 19:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=gVWbczqtxIj06CLCcw1jNb8lR9aBRy1Y/X8peedp7/w=;
        b=cVuDy9y1/9/Ayawq9aCrpicXg+3TWuCcZ2zDIm2mgdDYTkiNIaJVIW49IXtMvtyvvD
         jPHPLYivai3wfNNFXjeUQIFhUiTgFmwznbVBBsRoKpnG3+b2nFrcGNVrKUmitS9QVtrH
         agD+rgIm2Bm0l94gyegBJG4pySUJO+M9WrlCDaxKljvRsY9hF7PRkoTS4H0H68drJMhq
         EPb6fWnG7vrbNpTHPSMxTpXMVpPTDaaayjNAJTnTUqrFenoBWOiAfnycp0ufEHMUNS6X
         PwxczobUNkmlYeJuY/UScl1h2wJc5JTTzKEhfzYV52ufzT0MjWd/A+CLNH1u/7AUnWwB
         pmwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=gVWbczqtxIj06CLCcw1jNb8lR9aBRy1Y/X8peedp7/w=;
        b=CeRI5Ulj67Br1YjCDvEeuVRXlCRPWxZCDGjC7RrWrVBFvx32pOuKy/8bKfa/y+2JCN
         lLbYrs9rVjC5q4Nmc+4T9x9PiA2hR9lyti3z3l65uVhhwskGEeAQKFEuPeAo542YbMKM
         aGthzIzGB9epIbJPhU76uVF1nSvFlzplsX+Y4wXeFv3iKI/+XwewdV+hxh9EPMjQ+KIc
         toLJfF+pBGYEXn7pme9nFPToFELTo9huHS1Jwi3F5sUR5b9H/m8CZ3+Lw9Ac30wWjJYj
         E0gLTfYqA/nX12ivfTZ5R9z0p9MLZMEbqzHRFsbCRKZmz0DEzcAzid8nEmPizrHkjulh
         81rQ==
X-Gm-Message-State: AOAM530OjQ0vCyh3FBbrhmbiIPX98cix2qYy/REaQhobGagyhICfgBa8
        deoIQbzwRkYE8NJLRrPfzb4+EPm1VVg=
X-Google-Smtp-Source: ABdhPJyyrLqeCTQLH6rOFGNTdYRr9gzEmGYXfnlSIFSRzmoY5kvNErvnm4Phpy4jA7yued6XjHj70w==
X-Received: by 2002:a65:408c:: with SMTP id t12mr14782986pgp.229.1630202780031;
        Sat, 28 Aug 2021 19:06:20 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id y64sm12030710pgy.32.2021.08.28.19.06.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Aug 2021 19:06:19 -0700 (PDT)
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Wu X.C." <bobwxc@email.cn>, SeongJae Park <sj38.park@gmail.com>,
        Hu Haowen <src.res@email.cn>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH] docs: pdfdocs: Fix typo in CJK-language specific font
 settings
Message-ID: <ad7615a5-f8fa-2bc3-de6b-7ed49d458964@gmail.com>
Date:   Sun, 29 Aug 2021 11:06:16 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were typos in the fallback definitions of dummy LaTeX macros
for systems without CJK fonts.
They cause build errors in "make pdfdocs" on such systems.
Fix them.

Fixes: e291ff6f5a03 ("docs: pdfdocs: Add CJK-language-specific font settings")
Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
---
Hi Jon,

I thought I had tested the v4 patch on a container image
without any CJK fonts, but apparently I had not.

These typos affect "make pdfdocs" of all the English documents
as well.
So, if this doesn't make the initial pull request for v5.15,
please consider sending it as an urgent pull request during
-rc stages of v5.15.

Apologies for the lack of test on my side. 

        Thanks, Akira
--
 Documentation/conf.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 75650f6443af..948a97d6387d 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -463,8 +463,8 @@ latex_elements['preamble']  += '''
 	\\newcommand{\\kerneldocEndTC}{}
 	\\newcommand{\\kerneldocBeginKR}{}
 	\\newcommand{\\kerneldocEndKR}{}
-	\\newcommand{\\kerneldocBeginSC}{}
-	\\newcommand{\\kerneldocEndKR}{}
+	\\newcommand{\\kerneldocBeginJP}{}
+	\\newcommand{\\kerneldocEndJP}{}
     }
 '''
 
-- 
2.17.1

