Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D37623E3D88
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 03:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbhHIB3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 21:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbhHIB3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 21:29:32 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC93AC061757;
        Sun,  8 Aug 2021 18:29:12 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id cp15-20020a17090afb8fb029017891959dcbso4203710pjb.2;
        Sun, 08 Aug 2021 18:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9e/dTAUWTOCCi1nN3rGdg1NsL6ZavcZ8gQG0xuwCChc=;
        b=NEO0UmqlRALFwaGRieJ0h2rn1CZT5WXiV1hTPAkRxbQ2KQp2fmOgxMzXHNdTDbOLVp
         3PapWJbtu9w4cMUMmLRp/kiVbyAXop38NbsarkOYCcdwbX/1SNnY4RMHTwvbRVX/j7PU
         rDCBmNIh+PX+Mq4U4BgAxRS+OWMn8akxYFtst4i1Mihgeg2mDMmIpYQFrb5xHGnIrtVb
         s/RuEXmD1qAiArE1sblexNhX/UkEk0tU67oXcpD5nnZfVnmekRhaQRxQWw2R3tQjDGL+
         5AObGIrKUJJ8V/ISGrV5aqw1Wub2vZ85Jwg40UDiDsS1CVgO/uLlq0lWAdF1o/yWLRxp
         z/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9e/dTAUWTOCCi1nN3rGdg1NsL6ZavcZ8gQG0xuwCChc=;
        b=nNx1uwQ/Lzx3aU5AZyffsQ6A4cyM12x8n7OOfYKtkOuV+i86ayQEk6f7mi4dhjwef6
         8tCCMSvjzNhriSI8nRpx8z/tqD3xplQULx8TNEJBAMJHUHep/JbxRoEc+u9kEicZmvZm
         9CTAgTDsFqSq2uXglDhZ9VxgZv24Ui7rIA7GPo9gvFOZFIe18eVLhGgtmZ0rW703a4UJ
         BLl+b2iLJEwrElfukNd1HoB+ngVQRmjcbTsJJoa9Z7TrACTSseRV3lB3HEBiSVGs4Cqm
         PTmHwhV76JgpD3zIGJzhT+dQC3nwGNzBiZs9LoXBfweJx+XhJXov+fdKhhFoQbYALHVd
         oxNw==
X-Gm-Message-State: AOAM532Wg191AOggGtCxZYGaLUFK7I92ZWLHFWiPKmv5+fN13vCeL/k9
        aU/qaM53Qj0XTd5GiVce2Wk=
X-Google-Smtp-Source: ABdhPJxLiY0LATkcsfExiqGb3MP8Nr2nr6Tqs4/nwyd3NV3f9xYasq9aKf7nV+XNuthzKXyYYnI6MQ==
X-Received: by 2002:a17:902:bb92:b029:12c:31cd:2400 with SMTP id m18-20020a170902bb92b029012c31cd2400mr1004814pls.16.1628472552060;
        Sun, 08 Aug 2021 18:29:12 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id n11sm16322073pjf.17.2021.08.08.18.29.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Aug 2021 18:29:11 -0700 (PDT)
Subject: [PATCH v4 9/9] docs: pdfdocs: Enable language-specific font choice of
 zh_TW translations
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Wu X.C." <bobwxc@email.cn>, SeongJae Park <sj38.park@gmail.com>,
        Hu Haowen <src.res@email.cn>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <39d0fb0f-b248-bca4-2dac-df69e8d697b1@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <9d8e8fa2-3e7a-3a0a-1a0d-7d797a605ff8@gmail.com>
Date:   Mon, 9 Aug 2021 10:29:09 +0900
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

The "TC" variants are supposed to be the choice for traditional
Chinese documents.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Reviewed-by: Hu Haowen <src.res@email.cn>
Tested-by: Hu Haowen <src.res@email.cn>
---
 Documentation/translations/zh_TW/index.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/translations/zh_TW/index.rst b/Documentation/translations/zh_TW/index.rst
index 76981b2111f6..c02c4b5281e6 100644
--- a/Documentation/translations/zh_TW/index.rst
+++ b/Documentation/translations/zh_TW/index.rst
@@ -5,6 +5,7 @@
 	\renewcommand\thesection*
 	\renewcommand\thesubsection*
 	\kerneldocCJKon
+	\kerneldocBeginTC
 
 .. _linux_doc_zh_tw:
 
@@ -162,3 +163,6 @@ TODOList:
 
 * :ref:`genindex`
 
+.. raw:: latex
+
+	\kerneldocEndTC
-- 
2.17.1


