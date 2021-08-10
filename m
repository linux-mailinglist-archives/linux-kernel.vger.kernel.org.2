Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 925CF3E5691
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 11:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238802AbhHJJRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 05:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238745AbhHJJRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 05:17:04 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15D3C06179C;
        Tue, 10 Aug 2021 02:16:36 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id pj14-20020a17090b4f4eb029017786cf98f9so4358759pjb.2;
        Tue, 10 Aug 2021 02:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1eMLWbyBU/sRONtQIPvGPa9Xul5GM1ibC93IbV30gmk=;
        b=uRHNZ/XSXpSd2EekLcyPlKNakWbcXrgdNHhu4LPh24wCi09/V4P/V4//poEFhQT9Kl
         pJnwCjtsahSbrHXcUEEZSDvW4mau1uhNU0laOY0m+keJqPyLiHiAWpUbjM6x+rvEvP8E
         9G+rYO9vvvb9qaf/oUS18om/kibXtTWxdFOqUpwP2Jpn4OtbY/ZUcrlf1j4WzCKfaVJI
         6KIbbnv59I9a1r1X/AUarC2XIyyh+2wQZ78CwrpkYP26shn5C6oMV5AMd+qGL5SHMeZ3
         XzMC+4/vaQTdQpqk6BdJIRE7Zx0VWFqxlyCFDECrChxBr5ra+M3u8qhCKGjD8Fn1F8v+
         23MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1eMLWbyBU/sRONtQIPvGPa9Xul5GM1ibC93IbV30gmk=;
        b=AY8sXAqpvkW0Zh9jVvSSN5gok1b5sCQWwpJWxXWVQnt5hrkrubbj+6ILjDQzpPzto7
         W8s5xmnnHifd1J1q4zW9vquxY9ZixylTzhEH0J/fk0ia+2HuFdlqv1UvvCwDR1xumbqD
         rxxYngxPdWVGmde+LtBNz20xq0X9NEtPboaly8p31dI4OAZLsK+wu7GQg2Vbb1kKyhLi
         I1Qb96RIjXNoTWeQCmJswyqnh9Sko7Ynb7Kn4riOeFjy/SeMspdVtiJXrEsUhGbu1jka
         9lsAVLoEjyqcwUhgvYW1fvw5Qe1kmHXzVv95am1ET/1zoVsBn8HXJeYXouzed3CcRraZ
         R6rA==
X-Gm-Message-State: AOAM530xgmas4CzQejhtMoxZ7/vvUKOha+ejLwaoy2JlFuTn10a9AAqZ
        RpykGqqEJXhV2IyouyowkNo=
X-Google-Smtp-Source: ABdhPJwo3IHlpSusugq84VzN8wuuLt/+jy01P9rYCZOEZCnx35yOgUFBFnfRqrRDwfFvwfVKiRGV9Q==
X-Received: by 2002:a63:5fd4:: with SMTP id t203mr46726pgb.141.1628586996243;
        Tue, 10 Aug 2021 02:16:36 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id x2sm2281054pjq.35.2021.08.10.02.16.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 02:16:35 -0700 (PDT)
Subject: [PATCH v2] docs: sphinx-requirements: Move sphinx_rtd_theme to top
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <974babfe-540f-40e4-38b3-ab294ba70ccc@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <75f14c88-6091-1072-41cb-16b886aee5a0@gmail.com>
Date:   Tue, 10 Aug 2021 18:16:32 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <974babfe-540f-40e4-38b3-ab294ba70ccc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sphinx_rtd_theme 0.5.2 has "docutils<0.17" in its requirements.
docutils 0.17 released this April caused regression in
sphinx_rtd_theme 0.5.1 [1].

By removing docutils and moving sphinx_rtd_theme before Sphinx in
requirements.txt, the requirement of "docutils<0.17" can be met
naturally.

[1]: https://github.com/readthedocs/sphinx_rtd_theme/issues/1112

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
---
Hi,

It is better to keep requirements as minimal as possible.
Let's leave the dependency to the sphinx_rtd_theme package.

Changes in v1 [2] -> v2:

    o Remove docutils entry.
    o Move sphinx_rtd_theme to top.
    o Adjust patch title.

[2]: https://lore.kernel.org/linux-doc/974babfe-540f-40e4-38b3-ab294ba70ccc@gmail.com/

        Thanks, Akira
--
 Documentation/sphinx/requirements.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/sphinx/requirements.txt b/Documentation/sphinx/requirements.txt
index 489f6626de67..9a35f50798a6 100644
--- a/Documentation/sphinx/requirements.txt
+++ b/Documentation/sphinx/requirements.txt
@@ -1,3 +1,2 @@
-docutils
-Sphinx==2.4.4
 sphinx_rtd_theme
+Sphinx==2.4.4
-- 
2.17.1


