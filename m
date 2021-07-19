Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5C853CD3AC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 13:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236300AbhGSKeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 06:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235999AbhGSKeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 06:34:13 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96217C061574;
        Mon, 19 Jul 2021 03:25:02 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id i16-20020a17090acf90b02901736d9d2218so12183405pju.1;
        Mon, 19 Jul 2021 04:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VbSyjx0b79X9MWWrl7W4V/9MT7EYJcbNoe91ulELaUI=;
        b=YjwYXRbMZtSYZ7rUweVBRILpY79XYb6sh2XyBrBdMrwEOxd+cR4ZUTQKcQQeVv6+We
         R5DBz2MDVxSebV8mpsy6LO9Hwczt81XNAPBuCHPW68ITxC31b9FiScNUfNYkw5zZfEQ9
         988qGBX7/uBcP+nErXoN9yOFUgjbyBmv5jaD8cChDC+wD3YosJ9rLdmQH57W3dDP+W+I
         7nU7J01Qn6wKCS0WlLjDJAwdQU8uZiiDmRSUbd2Q7u7EJxUSepatyxhDHBjc4ONrg/pJ
         +bK1eDeCTkvqMskUuSJ/RxZTsPBQgKUpSMlV4izH+5HMDRsSaks7doKeb7EjVHdF0VRu
         5tHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VbSyjx0b79X9MWWrl7W4V/9MT7EYJcbNoe91ulELaUI=;
        b=OwEAmu/UbEsB3YGKU9RQjaDaUMwBeEiLIk/ma0UPgtkETJtba62cPEYuJMis11Z7kV
         utaXOTNRfXJedPqqM9OtLl1ufumFQ6DZPUjeUoY5pU6sBF+zd3IMS+3jYvtlkvuuESdC
         yH/UzP7BNkvQWdVbT38Ig3o9yS8VXlDlRWmSMpnhE8R4ycOLzWFBQQO6XbSYDWmRLEOf
         sTznGFAAyjkuRMnR7/Q55by1aWv7M4oZKJ5NUHz4rr7EExk9hRV4d9NaeQLEt8z+2Dmq
         pRdRcRWmB/NQOKMxjHHNTNs4VJI4Hf/PX0inEvhH6sn/cNiApxcW9TEd0+Xdwqo09LQM
         sI+w==
X-Gm-Message-State: AOAM5328I5yyGkCYHEqvPFKXtNTxAqT49dCGm2RYLVSF7ruoo0fzyrBn
        W6oBAjkNOtbYH7cfTq7UmWGlgpVcC2M=
X-Google-Smtp-Source: ABdhPJxJEw52ySpoikIbl6e2Nk3WGVCfshk56SANE8dhhXAWZ0RnKDamMXXli9fuE/kOX5VZnkNmYA==
X-Received: by 2002:a17:902:d652:b029:12b:45c1:21ba with SMTP id y18-20020a170902d652b029012b45c121bamr19124087plh.9.1626693292209;
        Mon, 19 Jul 2021 04:14:52 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id c15sm11136239pfl.181.2021.07.19.04.14.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 04:14:51 -0700 (PDT)
Subject: [RFC PATCH v2 4/7] docs: pdfdocs: Permit AutoFakeSlant for CJK fonts
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Wu X.C." <bobwxc@email.cn>, SeongJae Park <sj38.park@gmail.com>
Cc:     Hu Haowen <src.res@email.cn>,
        Shinwoo Lee <shinwoo.lee.us@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20ff8a65-6a5c-c062-fe1a-0f5c5ddc813c@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <08fcefa3-d09b-b7a7-a171-a5b9557a63c3@gmail.com>
Date:   Mon, 19 Jul 2021 20:14:48 +0900
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

"Noto CJK" fonts don't provide italic shapes.
The AutoFakeSlant option of fontspec and xeCJK packages can be used as
a workaround.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
---
 Documentation/conf.py              | 24 ++++++++++++------------
 Documentation/translations/conf.py |  2 +-
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 23d647881f6e..9a237471289b 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -360,19 +360,19 @@ latex_elements['preamble']  += '''
     \\IfFontExistsTF{Noto Sans CJK SC}{
 	% This is needed for translations
 	\\usepackage{xeCJK}
-	\\setCJKmainfont{Noto Serif CJK SC}
-	\\setCJKsansfont{Noto Sans CJK SC}
-	\\setCJKmonofont{Noto Sans Mono CJK SC}
+	\\setCJKmainfont{Noto Serif CJK SC}[AutoFakeSlant]
+	\\setCJKsansfont{Noto Sans CJK SC}[AutoFakeSlant]
+	\\setCJKmonofont{Noto Sans Mono CJK SC}[AutoFakeSlant]
 	% CJK Language-specific font choices
-	\\newCJKfontfamily[SCserif]\\scserif{Noto Serif CJK SC}
-	\\newCJKfontfamily[SCsans]\\scsans{Noto Sans CJK SC}
-	\\newCJKfontfamily[SCmono]\\scmono{Noto Sans Mono CJK SC}
-	\\newCJKfontfamily[KRserif]\\krserif{Noto Serif CJK KR}
-	\\newCJKfontfamily[KRsans]\\krsans{Noto Sans CJK KR}
-	\\newCJKfontfamily[KRmono]\\krmono{Noto Sans Mono CJK KR}
-	\\newCJKfontfamily[JPserif]\\jpserif{Noto Serif CJK JP}
-	\\newCJKfontfamily[JPsans]\\jpsans{Noto Sans CJK JP}
-	\\newCJKfontfamily[JPmono]\\jpmono{Noto Sans Mono CJK JP}
+	\\newCJKfontfamily[SCserif]\\scserif{Noto Serif CJK SC}[AutoFakeSlant]
+	\\newCJKfontfamily[SCsans]\\scsans{Noto Sans CJK SC}[AutoFakeSlant]
+	\\newCJKfontfamily[SCmono]\\scmono{Noto Sans Mono CJK SC}[AutoFakeSlant]
+	\\newCJKfontfamily[KRserif]\\krserif{Noto Serif CJK KR}[AutoFakeSlant]
+	\\newCJKfontfamily[KRsans]\\krsans{Noto Sans CJK KR}[AutoFakeSlant]
+	\\newCJKfontfamily[KRmono]\\krmono{Noto Sans Mono CJK KR}[AutoFakeSlant]
+	\\newCJKfontfamily[JPserif]\\jpserif{Noto Serif CJK JP}[AutoFakeSlant]
+	\\newCJKfontfamily[JPsans]\\jpsans{Noto Sans CJK JP}[AutoFakeSlant]
+	\\newCJKfontfamily[JPmono]\\jpmono{Noto Sans Mono CJK JP}[AutoFakeSlant]
 	% Define custom macros to on/off CJK
 	\\usepackage{setspace}
 	\\newcommand{\\kerneldocCJKon}{\\makexeCJKactive\\onehalfspacing}
diff --git a/Documentation/translations/conf.py b/Documentation/translations/conf.py
index e859c2e19e8b..92cdbba74229 100644
--- a/Documentation/translations/conf.py
+++ b/Documentation/translations/conf.py
@@ -7,6 +7,6 @@
 latex_elements['preamble']  += '''
     \\IfFontExistsTF{Noto Sans CJK SC}{
 	% For CJK ascii-art alignment
-	\\setmonofont{Noto Sans Mono CJK SC}
+	\\setmonofont{Noto Sans Mono CJK SC}[AutoFakeSlant]
     }{}
 '''
-- 
2.17.1


