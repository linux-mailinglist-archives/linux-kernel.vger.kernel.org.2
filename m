Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED91394CD6
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 17:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhE2PU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 11:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbhE2PU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 11:20:56 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FB5C061574;
        Sat, 29 May 2021 08:19:18 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id g18so5550509pfr.2;
        Sat, 29 May 2021 08:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Vnafq7RVp7VAT1/+Lx872/XLk4/H3v8bYUHr0j7OeBM=;
        b=I2X5qQq6ZF0GMTTHJ9NIicNH9snA7WkUEKAe+Gmc7b9b8jZ2TSSRTWqtBceuAX4TRz
         yb8QcT3+opS2X7XiTT5Qdd+fe8Bzp+I55KhSN9tWIN7N+s5SkPYVzi72G87tip+jmlSs
         qsh5dsANxKVzvqOfdNKv5Fxsb4YQzgx920pO+/aJjg7OkEYOr3cyoKdSA+k2Y/SqSBpi
         QHwqoI4fgbkJiHXfOOqWJw2EcbzBIjf+MJWP/DaRDkQCfTGazsUa9P9is/Y26dTvbfFW
         SZxLhdhanKFfpBHw2DbKbtfYChx1kdoYklfT0O9HGFAhP/LeTbIW2NToXMwj653B2DsS
         mcag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Vnafq7RVp7VAT1/+Lx872/XLk4/H3v8bYUHr0j7OeBM=;
        b=QVSzdin55pcJaaAAaguVLbAo0+kbuEvsEhVCh/fqETCi/rS1LHtdCmDBOkyNSmxIt5
         AOdOOotEHDZVB2qCekVDjY50XGtiNub6SM50CbcOoGdqC68I0K+pOS9x3Hv/i12yZzzq
         vpK+xGgovEZ+2fn1xAdDCgx3K8olha4FDaOuWfXn6rVwefkmRnR42h5naUast8JTfLRN
         RDEnLXezhf+pT8qtpE4Uh3hZnbFvvvcoJZvd0Mhy5C0ctVNT3Yhn4RO2QemAac2cRAvJ
         p12gUkeHPBp83jyJkxZGIcwkINppWdzjwThjq8WZqgmlJEN9uYVYJ/hjks+SunCDXUY8
         qyXg==
X-Gm-Message-State: AOAM531kdreyds0hk88tRBWCSHazG59LjPVxamIBqNmkkv/YDqU3DVF5
        BgxJCFlItPdPGCn5TCVY+lk=
X-Google-Smtp-Source: ABdhPJwf4cRahCCSx4nCN0kvbiC/RKLwNf/orvToNafmKvot7msn84yMsZVyKwIruesf5bHGUG27DQ==
X-Received: by 2002:aa7:8809:0:b029:2de:3b94:487e with SMTP id c9-20020aa788090000b02902de3b94487emr9031300pfo.33.1622301558399;
        Sat, 29 May 2021 08:19:18 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id h26sm7096180pfk.19.2021.05.29.08.19.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 May 2021 08:19:18 -0700 (PDT)
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     "Wu X.C." <bobwxc@email.cn>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH] docs: pdfdocs: Prevent column squeezing by tabulary
Message-ID: <277d68fa-c96a-0ccb-6ce0-4d314851d9fe@gmail.com>
Date:   Sun, 30 May 2021 00:19:14 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting a reasonable width to \tymin prevents column squeezing
by tabulary.
Width of 20em works well in almost all the tables still in the
ascii-art format.

Excerpt from tabulary package documentation at [1]:

    To stop very narrow columns being too 'squeezed' by this process
    any columns that are narrower than \tymin are set to their natural
    width.

[1]: https://mirrors.ctan.org/macros/latex/contrib/tabulary/tabulary.pdf

Note: Sphinx has its own default value of \tymin set in
sphinxlatextables.sty (Sphinx 4.0.2) and sphinxmulticell.sty
(Sphinx 2.4.4) as follows:

    \setlength{\tymin}{3\fontcharwd\font`0 }

, which is not sufficient for kernel-doc.

Tested against Sphinx versions 2.4.4 and 4.0.2.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
---
Hi all,

This is another attempt to improve pdfdocs output.
As far as I see, I don't see any obvious regression by
this change.

The effect of this change can be seen in (not limited to)
the MODULE_LICENSE section in process.pdf (pages 10 and 11).

I'd like to know this change looks reasonable to you.

Any feedback is welcome!

        Thanks, Akira

--
 Documentation/conf.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 25aa00c707b0..a05225056e08 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -353,6 +353,8 @@ latex_elements = {
 
     # Additional stuff for the LaTeX preamble.
     'preamble': '''
+	% Prevent column squeezing of tabulary.
+	\\setlength{\\tymin}{20em}
         % Use some font with UTF-8 support with XeLaTeX
         \\usepackage{fontspec}
         \\setsansfont{DejaVu Sans}
-- 
2.17.1

