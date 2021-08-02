Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF36F3DD37C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 12:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbhHBKAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 06:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233185AbhHBKAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 06:00:33 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F4CC06175F;
        Mon,  2 Aug 2021 03:00:23 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id c16so19047085plh.7;
        Mon, 02 Aug 2021 03:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RcxOxac7/ciqF1QxRMn81p1ctmELfJnE42KUARmvkN8=;
        b=Z8bglMB+t9575Ms2ZAcRnkzAhedfNKqIfcSN/eZO3ZoeVSk9IE7ufViBT2kGS2W2iF
         2z6ZQ6lK6WJGXI07u3sXMTd/VhESBCki2q/mTvxtWbB7rYgatWM6kGFhQC7gKwJIEpEC
         1E6Q9vOO7JM/yKvi7bI/4df/U9J0VgyJpoI/c5uVQNZZuzWNKbEuaW6rD/3kb78kYTzK
         +P5CbXXUVR5G450yv+jJTNURVoLVdOWROBY2X9HqLPpDG08g8MfM2POp17F7BSegqpXo
         5bmD/c5BrSgKGntRsPOCftVxZq7zEpg0mdmw2l396BEOKD8IsxR38VWqf+D8AUuuj23y
         yzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RcxOxac7/ciqF1QxRMn81p1ctmELfJnE42KUARmvkN8=;
        b=iH1T+yacigmIi/2H37zDhK7ZTQfaeldBeARe7+BWbcSuVRqF2RIMeN+e8+GDxk7Qv2
         lHGbmdcOYCkAvex3i0cvoqw7IgaTqQqX44W55CMORAikPWpksWhTJCzKH0FLBLGFrX9G
         btqxangF2awZiDNJiRpvr62scpQ1KojMs0/By8kET5zLh6u+bfa1qzQUrMaIiJEJAaTS
         1qAZXdG141iWFtrbbqERbNLn0TrkFu2iqdSwO5enmrVn6Wv10F/LlaZzG2bobfd0QtZ0
         SpuoI4V+7wfuXIQcewOUxcBKk1PysS//lfCWfo6TYgwxkw361sHQ4aLd7rVdmCw4b5Id
         iGTw==
X-Gm-Message-State: AOAM530wkBEksY1FqwjySvjUfO/ktlX02Rh+LLeBMUQnZjiGUUCiRdnY
        mzYcq68qUTF0Y3pcHI5y1sleNDFFCZQ=
X-Google-Smtp-Source: ABdhPJwrCGlyl4YBZHPR+gqY5gRb0cHJ+o3PZYmv6BnKO6MBeWECMnDZLvv58nz+0+nRbWE5AmO8Pw==
X-Received: by 2002:a17:90a:428e:: with SMTP id p14mr16775354pjg.92.1627898423128;
        Mon, 02 Aug 2021 03:00:23 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id y24sm10399978pfp.191.2021.08.02.03.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 03:00:22 -0700 (PDT)
Subject: [PATCH v3 9/9] docs: pdfdocs: Enable language-specific font choice of
 zh_TW translations
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Wu X.C." <bobwxc@email.cn>, SeongJae Park <sj38.park@gmail.com>,
        Hu Haowen <src.res@email.cn>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <eb8184ab-cfab-680b-f180-1157a7f709b3@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <48810e08-595f-fb87-603f-fa642823b84c@gmail.com>
Date:   Mon, 2 Aug 2021 19:00:19 +0900
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

The "TC" variant is supposed to be the choice for traditional
Chinese documents.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Hu Haowen <src.res@email.cn>
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


