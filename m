Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4F83D7303
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 12:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236192AbhG0KXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 06:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236260AbhG0KX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 06:23:28 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E045C061764;
        Tue, 27 Jul 2021 03:23:28 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id i1so15222391plr.9;
        Tue, 27 Jul 2021 03:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=tMKA2ifWKjSwq26sVGYmnYRIVyYgXhCEXgOEdfsHUfY=;
        b=qgN6Uut8PANqwls2+KSCvB4IeNnd8x0nqA20AGOw1C5w5o1ufyokoe7hRpKZe/QMCf
         fzBVDwbipJtSdTm6d1eSqZFIQSh/527N/XO5JVNGg7MSWdnay61EUZjgWYTrgWdzP11/
         9A+q9o3HPG1GYa6YX6b8p9IPJPZovOTEA5Nd8DhZ/ChP0Fv/G6sIdKpDdwn8Q6pkq5fA
         KXaXxp1TpvHSP7WuFNAZcCqLZ1Id062u75joYu9oPd9uROdWC3/MRzFU+m/3baeA2JOZ
         X/QIeE5eDX2ZsW+r+Jn5zrCALXIjqeYWx/a2WJndQuyUB+YUtR5Y20ag46npJ1fUE+VA
         DyvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=tMKA2ifWKjSwq26sVGYmnYRIVyYgXhCEXgOEdfsHUfY=;
        b=TGfEgWQ14PEGAEEE8nJpg5x8joe/sdFtF2r4qeWktT7whuAvdYXvPPgauWYv9pT9vi
         zvlkT51djJAz3MI5YnkEPhmmpFmg4himrU4+kV9BW21CXJxhJYBfYov4d44XcBUmgwvF
         vnAtcdJ1VGXEbS4ABRYTxO9viWmnBiAm0HumZ/A02kI/2yeyko8rwJSF9Zyw9c0c9znw
         7uzGr6HCxzr89QnftprvazajCjD4iA/wt3sX13DqnKZZ6Q3CJnhnuNSuOwRUDkd+qyj+
         DpGTX1PcrRWXdRubAuH9NugGWMBRXTItoBMO7WkFE1w/TE0v8EaSUIRsEanJdj9lJvae
         1Adw==
X-Gm-Message-State: AOAM530Hi2M/FDZmIsnlSCw64Er0IaC582Q/4fApmGu8RaT3pjwprQj9
        YfgxExVM3/C45aZIK0aKxjdUeDvAuRE=
X-Google-Smtp-Source: ABdhPJyNHNiXElw9dtxO7JS+BkuYuSt8hwxZJgu1FdEXP2YQ7qnquHPUtExrqr0BztarnQiobSl//w==
X-Received: by 2002:a17:90a:7441:: with SMTP id o1mr21263247pjk.96.1627381407819;
        Tue, 27 Jul 2021 03:23:27 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id d14sm1107761pjc.0.2021.07.27.03.23.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 03:23:27 -0700 (PDT)
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH] docs: Set upper limit of docutils (<0.17)
Message-ID: <974babfe-540f-40e4-38b3-ab294ba70ccc@gmail.com>
Date:   Tue, 27 Jul 2021 19:23:24 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sphinx_rtd_theme 0.5.2 has "docutils<0.17" in its requirements.
docutils 0.17 was released this April and caused regression in
sphinx_rtd_theme 0.5.1 [1].
Put the same limit in sphinx/requirements.txt.

[1]: https://github.com/readthedocs/sphinx_rtd_theme/issues/1112

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 Documentation/sphinx/requirements.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/sphinx/requirements.txt b/Documentation/sphinx/requirements.txt
index 489f6626de67..f8974875c0ec 100644
--- a/Documentation/sphinx/requirements.txt
+++ b/Documentation/sphinx/requirements.txt
@@ -1,3 +1,3 @@
-docutils
+docutils<0.17
 Sphinx==2.4.4
 sphinx_rtd_theme
-- 
2.17.1

