Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8EC38C085
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 09:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbhEUHPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 03:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235573AbhEUHPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 03:15:45 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244E6C061574;
        Fri, 21 May 2021 00:14:23 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id 69so10483348plc.5;
        Fri, 21 May 2021 00:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=NcpK2RBsw9d+FH1vYWla/yzVtY9sK4vFCY/nN/lCEUk=;
        b=BbG8e49EmvkU9/W6Vjados9MvBZOEQMN4XIz7aoZCBc+/xyx9PUiWv4alVvhNJA+ux
         hjru1+tORR9bPY8SIB/y1t07AcnWHONQCXmCKMTBnbZp6Bm600JlV6ak2t3TEiI4Qf33
         nG9KJxBhhpc0ANcDE4YbDjNf/q9KZ4J9xey6d99qfrLA4mm7lM07aWTMW5X4M1dKTY+j
         fPdhtuBG6fPduhuilhDgS43U0TOHKXepmci/DB4+AnPOQgQlPwkqlxl+QvuIYn4/EwAL
         sQKylUInYX6fDo0nvA1CoFOrFoEvNYWdO3x3EGs+ZV2Z2mCWuXjcNuKNS32r9tTd75hz
         pCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=NcpK2RBsw9d+FH1vYWla/yzVtY9sK4vFCY/nN/lCEUk=;
        b=p1v1ILyQ4HCa2Ulk7cp0RCOXHBumGMlj9F8SKHvG5iYMv+AAP6TQvfel3dvbhf5411
         F3d3Ji1zEmbNU5rFrSz3x0jcMiRvf02psuH6vcE38uQE+xg2MKALwESL6Ih7Boh4Vo71
         snV8bSyXNx4G+0BKCDb3UAYLf1hAMXyaEdxuUnSsgN2fGdizTHTyFAWKKjxR3uSvauCd
         wFIK3UgmEuVicPhf6UFx/Msft230HRfXoq0GRxrlw5QWUSAkuff52esuuehsHsth/GwF
         JUWlPvxHMZSlh9ldG/YvzOYwiyMsJuwzH4O/YhKRGnXW6WFGpNWuirBaNTqsivo1ytpt
         ETKw==
X-Gm-Message-State: AOAM530Wq/vGlKdSRJ/bli7V2EyWDqFdlaOTjX45ZTZLdtCwuu7TLa9J
        4hHeodlS4Le5iEIOpIQ0n6Y=
X-Google-Smtp-Source: ABdhPJxQfXPVT4M42wfQqT0W0WKmSS4en3OQpdAKQf8a2WaMotmoNbXAdQ2Gdg/c1HZsregc3GcmCw==
X-Received: by 2002:a17:902:d101:b029:f4:b38a:a10a with SMTP id w1-20020a170902d101b02900f4b38aa10amr10614188plw.46.1621581262713;
        Fri, 21 May 2021 00:14:22 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id f17sm3636528pgm.37.2021.05.21.00.14.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 May 2021 00:14:22 -0700 (PDT)
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH] docs: sphinx-pre-install: Reword warning on installing cjk
 font
Message-ID: <c5652bb4-0bb0-9efa-2b80-a79793a8efa8@gmail.com>
Date:   Fri, 21 May 2021 16:14:19 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Installing a ckj font as recommended by the warning message causes
generated latex code to have:

	% This is needed for translations
	\usepackage{xeCJK}
	\setCJKmainfont{Noto Sans CJK SC}

in its preamble even for an English document.

The package "xeCJK" changes wide characters' appearance including
apostrophe (single quote) and double quotes, and it changes line-break
behavior with regard to the boundary of narrow and wide characters.

This greatly degrades readability of English PDFs typeset by xelatex.

As a band-aid help, reword the message and let the user at least be
aware of the degradation.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
---
Hello,

I'm a newcomer to kernel-doc who started trying sphinx this week.
I have both sphinx 2.4.4 and 1.7.9 installed.
For pdfdocs, I use 2.4.4.

"make htmldocs" was fairly easy, but I struggled a while to get
PDFs as I expected.

The culprit turned out to be the "xeCJK" package mentioned above
in the change log.  It appears in all the generated latex files
due to the "Noto Sans CJK" font I have installed seeing the warning
message from sphinx-pre-install.

By uninstalling the font, I can now build the PDF as I expect.

The reworded message is just a band-aid help.

In the long term, I see that rst2pdf tool is your hope to avoid
LaTeX altogether.  But it would be nice if you can enable xeCJK only
for the translations document.  Can sphinx permit such language
choice per subdirectory (or hopefully per .rst file)?

        Thanks, Akira
--
 scripts/sphinx-pre-install | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index fe92020d67e3..b3c7da2b8ad2 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -101,7 +101,12 @@ sub check_missing(%)
 		}
 
 		if ($is_optional) {
-			print "Warning: better to also install \"$prog\".\n";
+			if ($prog =~ /cjk/ ) {
+				print "Warning: For translations PDF, better to install \"$prog\".\n";
+				print "However, doing so will *degrade* English PDF typesetting.\n";
+			} else {
+				print "Warning: better to also install \"$prog\".\n";
+			}
 		} else {
 			print "ERROR: please install \"$prog\", otherwise, build won't work.\n";
 		}
-- 
2.17.1

