Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F793E3D77
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 03:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbhHIBR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 21:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbhHIBRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 21:17:24 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF32FC061757;
        Sun,  8 Aug 2021 18:17:03 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id q2so14613688plr.11;
        Sun, 08 Aug 2021 18:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pYYxiw41X17NhD1Q5oNmXyZafkiZ20OypLI54Gm/l6w=;
        b=m0glI4mtBx6gFQq7XMZbzWzpo2QRbQ5tvHAayhoG3rePzTciRkb4aOzdynj+DXti0X
         nTlMMB9pQo8sS2OWyRSvJUO9u1Zvz2ghDQHWPc/d1Ccg3QCJ1pEfaRcSy8cKLZZFZoRP
         hojFkdOnZ5b216Ykb6e6sUHC0x5PRWCKFtTpVniwAqVb20F4Ugx4SFP369IXh7BUr+4O
         +ZljzuH34cczn4FsMhdHgQsyQGsvKqpgv5FfnR6q+/E4+5OW8p+mHagCu+cA0kAqwUWB
         8Z2yKVeCK3kJs8CeL10SC+umJsnWCGhCAzYtjxwzeGiGvnsvNIaIPr+xB1RZlgBJbqQ7
         SkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pYYxiw41X17NhD1Q5oNmXyZafkiZ20OypLI54Gm/l6w=;
        b=ejgzmpp6W1l5UAM/r57bO0ZzHW7TH2WTcO3n3Lg82OhEX9HERZQFN9khRqa/maIJtx
         iI0M/mwH1pt5csiFrxv7Itgk37QnD3cqLq/2S5CgoymvGl4VciX9J9AGH/T2QTtTYElp
         ZvjXVtdEO3AER3GYCsplwvN/N/8bAL55QLcMZz1D5W3wNco1N0D3SckH0+1YIcgMFsQ6
         Ep1ZsC8WE5dfX/bmO2EeLvcUgpW+tZFOke1eTrXb0TUj/RHD+/SQqnQiwy7Xs5ugq/Qk
         tEIArp4yQy+J9tcsug0uNKiu1gBMJYdzQKbgpcuv+7JGSn++avj+t/K1hfUho8cHuxko
         6wrA==
X-Gm-Message-State: AOAM533daJ3ALuMH90JPZb4j5FNa1af6ybhXCkWhxNE/GxSLPHN/nFiD
        +HlFLcKhc9EE6FvolotGyMZ152uNeJs=
X-Google-Smtp-Source: ABdhPJyG9Po7iac+KbYe3ueM8VeOhZbaOdLuwfqWPTwGCZ+vDB74YliMgaxhhxyJz+howoukoUiT5Q==
X-Received: by 2002:a63:1155:: with SMTP id 21mr574134pgr.346.1628471823431;
        Sun, 08 Aug 2021 18:17:03 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id v16sm9573074pje.24.2021.08.08.18.17.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Aug 2021 18:17:03 -0700 (PDT)
Subject: [PATCH v4 3/9] docs: pdfdocs: Choose Serif font as CJK mainfont if
 possible
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Wu X.C." <bobwxc@email.cn>, SeongJae Park <sj38.park@gmail.com>,
        Hu Haowen <src.res@email.cn>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <39d0fb0f-b248-bca4-2dac-df69e8d697b1@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <5e454140-5d0c-35d4-8c31-3ffb2420793a@gmail.com>
Date:   Mon, 9 Aug 2021 10:17:00 +0900
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

"Noto Serif CJK SC" and its variants suit better with the roman font
of Latin letters.

On some distros such as Fedora, it is possible to partially install
"Noto Sans CJK" fonts.
So, if the Serif fonts are not found on the system, fall back to the
Sans fonts.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
---
 Documentation/conf.py | 41 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 24e5427588e7..980be06df723 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -360,20 +360,48 @@ latex_elements['preamble']  += '''
     \\IfFontExistsTF{Noto Sans CJK SC}{
 	% This is needed for translations
 	\\usepackage{xeCJK}
-	\\setCJKmainfont{Noto Sans CJK SC}
+	\\IfFontExistsTF{Noto Serif CJK SC}{
+	    \\setCJKmainfont{Noto Serif CJK SC}
+	}{
+	    \\setCJKmainfont{Noto Sans CJK SC}
+	}
 	\\setCJKsansfont{Noto Sans CJK SC}
 	\\setCJKmonofont{Noto Sans Mono CJK SC}
 	% CJK Language-specific font choices
-	\\newCJKfontfamily[SCmain]\\scmain{Noto Sans CJK SC}
+	\\IfFontExistsTF{Noto Serif CJK SC}{
+	    \\newCJKfontfamily[SCmain]\\scmain{Noto Serif CJK SC}
+	    \\newCJKfontfamily[SCserif]\\scserif{Noto Serif CJK SC}
+	}{
+	    \\newCJKfontfamily[SCmain]\\scmain{Noto Sans CJK SC}
+	    \\newCJKfontfamily[SCserif]\\scserif{Noto Sans CJK SC}
+	}
 	\\newCJKfontfamily[SCsans]\\scsans{Noto Sans CJK SC}
 	\\newCJKfontfamily[SCmono]\\scmono{Noto Sans Mono CJK SC}
-	\\newCJKfontfamily[TCmain]\\tcmain{Noto Sans CJK TC}
+	\\IfFontExistsTF{Noto Serif CJK TC}{
+	    \\newCJKfontfamily[TCmain]\\tcmain{Noto Serif CJK TC}
+	    \\newCJKfontfamily[TCserif]\\tcserif{Noto Serif CJK TC}
+	}{
+	    \\newCJKfontfamily[TCmain]\\tcmain{Noto Sans CJK TC}
+	    \\newCJKfontfamily[TCserif]\\tcserif{Noto Sans CJK TC}
+	}
 	\\newCJKfontfamily[TCsans]\\tcsans{Noto Sans CJK TC}
 	\\newCJKfontfamily[TCmono]\\tcmono{Noto Sans Mono CJK TC}
-	\\newCJKfontfamily[KRmain]\\krmain{Noto Sans CJK KR}
+	\\IfFontExistsTF{Noto Serif CJK KR}{
+	    \\newCJKfontfamily[KRmain]\\krmain{Noto Serif CJK KR}
+	    \\newCJKfontfamily[KRserif]\\krserif{Noto Serif CJK KR}
+	}{
+	    \\newCJKfontfamily[KRmain]\\krmain{Noto Sans CJK KR}
+	    \\newCJKfontfamily[KRserif]\\krserif{Noto Sans CJK KR}
+	}
 	\\newCJKfontfamily[KRsans]\\krsans{Noto Sans CJK KR}
 	\\newCJKfontfamily[KRmono]\\krmono{Noto Sans Mono CJK KR}
-	\\newCJKfontfamily[JPmain]\\jpmain{Noto Sans CJK JP}
+	\\IfFontExistsTF{Noto Serif CJK JP}{
+	    \\newCJKfontfamily[JPmain]\\jpmain{Noto Serif CJK JP}
+	    \\newCJKfontfamily[JPserif]\\jpserif{Noto Serif CJK JP}
+	}{
+	    \\newCJKfontfamily[JPmain]\\jpmain{Noto Sans CJK JP}
+	    \\newCJKfontfamily[JPserif]\\jpserif{Noto Sans CJK JP}
+	}
 	\\newCJKfontfamily[JPsans]\\jpsans{Noto Sans CJK JP}
 	\\newCJKfontfamily[JPmono]\\jpmono{Noto Sans Mono CJK JP}
 	% Define custom macros to on/off CJK
@@ -387,6 +415,7 @@ latex_elements['preamble']  += '''
 	\\newcommand{\\kerneldocBeginTC}{%
 	    \\begingroup%
 	    \\tcmain%
+	    \\renewcommand{\\CJKrmdefault}{TCserif}%
 	    \\renewcommand{\\CJKsfdefault}{TCsans}%
 	    \\renewcommand{\\CJKttdefault}{TCmono}%
 	}
@@ -394,6 +423,7 @@ latex_elements['preamble']  += '''
 	\\newcommand{\\kerneldocBeginKR}{%
 	    \\begingroup%
 	    \\krmain%
+	    \\renewcommand{\\CJKrmdefault}{KRserif}%
 	    \\renewcommand{\\CJKsfdefault}{KRsans}%
 	    \\renewcommand{\\CJKttdefault}{KRmono}%
 	}
@@ -401,6 +431,7 @@ latex_elements['preamble']  += '''
 	\\newcommand{\\kerneldocBeginJP}{%
 	    \\begingroup%
 	    \\jpmain%
+	    \\renewcommand{\\CJKrmdefault}{JPserif}%
 	    \\renewcommand{\\CJKsfdefault}{JPsans}%
 	    \\renewcommand{\\CJKttdefault}{JPmono}%
 	}
-- 
2.17.1


