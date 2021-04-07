Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFC43576C5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 23:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbhDGV1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 17:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbhDGV1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 17:27:02 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D52FC061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 14:26:52 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id i9so139351qka.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 14:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6fSIQirtWShuMIqpJMly6hnk0nfAVM8QytarwMk1/LU=;
        b=IVZAyFvqO9O89xj9O1O9ykqVptDVd7tedXBblPm+epR23LJBte2B7EJMkHJmCnRKyS
         IpfaJUustIJhnXc9lLq6WwH5rJjr3ikQ8v7H7Vu3sZ451VnC3kKidUhvXuUx//A4wjj8
         61ol6UAc4npaKWK0CTZvdTC9PKCDDbamF8WAhlHTuF5xZ9AHnuk7FpaL6fJ7vmZtB1wQ
         NNM8HVMcLPOyAJZXg+0eDPq8dVMgFx3bJ1lvW7bRe6iSnwfmh0n+nDhN7o0H+Q9QIc5Z
         ONUz8EUYwtq0dA1uDgy2jF6D1HT3Nowpj1T2d698XEYMNNIHPg7ejV8k/gCEz4xrlHQA
         kx0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6fSIQirtWShuMIqpJMly6hnk0nfAVM8QytarwMk1/LU=;
        b=JqTYLWy5LmcRedX475eghkDu3ev6BBIN335hhX/ffLlTJgD6YxH335CCF3WW5iY4c7
         e1WxzC90VFAtuqFJ4YQFk9GrPd+wDULs7tJsJhq+QVMbxz/O/RmnRaxz3L1Lv3WPeqxi
         M+UxybGvGirIOpqdLM7l9NUcwetEzNpooLF8f8QZ2UhtCRGMV5pqmyrj+A/XSuRUCHME
         QCckOU3KDpfO2WPlwjLHD8Pc1EdLmXAIYJJE6yO9mcW79RXZ3MiXWndjoM9HKKihWQyM
         dGz2Eh8CvnhmJa68Ej1WlqlQzauBcEmhwqqwheBWmqn1UrBbHLBv+Hn7qi83duLMtiNw
         WNdw==
X-Gm-Message-State: AOAM531+3/2GedguWTE/FFU1ZGQu79u+JuzrwkOFKnI23Mnq/fwMCBt/
        CCp/5b4sgfmu+7LZb+pEWis=
X-Google-Smtp-Source: ABdhPJw8TYtK4wRL5V8dtqZvOlGV725hsJCUULZMsZp2X6ZLExfKE9SyBAmLIFnkt6Qunqb++p8JGQ==
X-Received: by 2002:a37:63d1:: with SMTP id x200mr5270774qkb.179.1617830811526;
        Wed, 07 Apr 2021 14:26:51 -0700 (PDT)
Received: from focaruja ([2001:1284:f013:b099:91d8:678f:6a0a:466d])
        by smtp.gmail.com with ESMTPSA id i25sm18917141qka.38.2021.04.07.14.26.50
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 07 Apr 2021 14:26:51 -0700 (PDT)
Date:   Wed, 7 Apr 2021 18:26:48 -0300
From:   Aline Santana Cordeiro <alinesantanacordeiro@gmail.com>
To:     Ezequiel Garcia <ezequiel@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, alinesantanacordeiro@gmail.com
Subject: [PATCH 2/2] staging: media: hantro: Align line break to the open
 parenthesis
Message-ID: <8209d15ab3a8391b74939cb942daffc556d72942.1617829497.git.alinesantanacordeiro@gmail.com>
References: <cover.1617829497.git.alinesantanacordeiro@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617829497.git.alinesantanacordeiro@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aligns line break with the remaining function arguments
to the open parenthesis. Issue found by checkpatch.

Signed-off-by: Aline Santana Cordeiro <alinesantanacordeiro@gmail.com>
---
 drivers/staging/media/hantro/hantro_mpeg2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/hantro/hantro_mpeg2.c b/drivers/staging/media/hantro/hantro_mpeg2.c
index 1d334e6..53a99a9 100644
--- a/drivers/staging/media/hantro/hantro_mpeg2.c
+++ b/drivers/staging/media/hantro/hantro_mpeg2.c
@@ -19,7 +19,7 @@ static const u8 zigzag[64] = {
 };
 
 void hantro_mpeg2_dec_copy_qtable(u8 *qtable,
-	const struct v4l2_ctrl_mpeg2_quantization *ctrl)
+				  const struct v4l2_ctrl_mpeg2_quantization *ctrl)
 {
 	int i, n;
 
-- 
2.7.4

