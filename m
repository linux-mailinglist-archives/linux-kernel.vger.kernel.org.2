Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4754032E3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 05:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235475AbhIHDXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 23:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbhIHDXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 23:23:42 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F324C061575;
        Tue,  7 Sep 2021 20:22:35 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id m26so850717pff.3;
        Tue, 07 Sep 2021 20:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=JDypbW+LfLzXGf0hDgoUroHgIdfKmH/FQrJkEZpGnbs=;
        b=VGc4LucmZPAYAossEfjwERMo5F1auVco/0qByRPcFFp7OGn8KKBLk3MDEnmncsSaeq
         oYXCkLRJxC4gPqQLv08ax5teRg+AQWC/RSn7pchvbKmcY7Gr14iOlugLcO49q7aBfhaQ
         9hslrKF2qO7cuH9+XEwSnq9Qau9I858/GEUQ+7xhOEeyKTzMiyZL4RTb7ElVe5Ch0+Sy
         Pk1dDfwrsrV0EvjBCcO02E7s9n5E4X5NDMzKfIhgYe8hvufWvQVMmwoV09P0sLE+jFt3
         YiiL9C59UdMTaU0XvkCKnh8GsHrxz44lafKZDy7Ly7VKK0OEhEe2HfYj2oxNhyF/HIey
         MtRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=JDypbW+LfLzXGf0hDgoUroHgIdfKmH/FQrJkEZpGnbs=;
        b=Z0/SBc9cdhqpWgafaUwE2nd1F8VuztQcO0f4STVZ2dLoVR+zacII83nTO+FrrQFp+F
         qMRpytRWokEW8cgS3cuy+LJ6xyI1cLX1R6JuJL2TspytQVHVv57O1PXdjvZ3H0c6ThyH
         aFQLzPWPUf3WzvWRfAVDDcaGfB/WVhTGNPwM/4jDeIY6DDGjWDnQdFdUNHEy0AeIqblW
         HoAVBPfgVHGKSmalZXOHEvMmFFUKun53SO7uf7jZc6rHGeWtbpu8eLqx4r8l+aUWKrn5
         vBaV9HbAHME5RDR1opfM7Vhw6MpZQ3Br/p6Nb63K0zF0RdLwjA3VitBgvxwVap/JvbKm
         z+GQ==
X-Gm-Message-State: AOAM531x7cq+HFHz+NkkBbeHuxI/QVyXyibbTN+gzYe3cJgG9KFhHx4r
        B/Rz+4FFGISiYiMmuaDHtuO59T5wNw0=
X-Google-Smtp-Source: ABdhPJwzTHpLlSU7GIBz982yD7LZnjiPTqQcVWwEi+TFYfdysc3BMG4k9p45bqHa3518TxTBH3cIIw==
X-Received: by 2002:a62:8287:0:b0:3ec:f6dc:9672 with SMTP id w129-20020a628287000000b003ecf6dc9672mr1495384pfd.65.1631071354479;
        Tue, 07 Sep 2021 20:22:34 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id x75sm584134pgx.43.2021.09.07.20.22.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 20:22:34 -0700 (PDT)
To:     Jonathan Corbet <corbet@lwn.net>, Hu Haowen <src.res@email.cn>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH] docs: zh_TW/index: Move arm64/index to arch-specific section
Message-ID: <53d86385-b4db-5d02-be6b-795900166f17@gmail.com>
Date:   Wed, 8 Sep 2021 12:22:30 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arm64/index is architecture specific.
Move it to the section "=E7=89=B9=E5=AE=9A=E9=AB=94=E7=B3=BB=E7=B5=90=E6=A7=
=8B=E6=96=87=E6=AA=94" or "Architecture-specific
documentation".

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Fixes: e5cb9494fe79 ("docs/zh_TW: add translations for zh_TW/arm64")
Cc: Hu Haowen <src.res@email.cn>
---
Hi,

zh_CN/index.rst has arm64/index under the section "=E7=89=B9=E5=AE=9A=E4=BD=
=93=E7=B3=BB=E7=BB=93=E6=9E=84=E6=96=87=E6=A1=A3".
zh_TW should be consistent with it.

        Thanks, Akira
--
 Documentation/translations/zh_TW/index.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/translations/zh_TW/index.rst b/Documentation/t=
ranslations/zh_TW/index.rst
index 2a281036c406..f56f78ba7860 100644
--- a/Documentation/translations/zh_TW/index.rst
+++ b/Documentation/translations/zh_TW/index.rst
@@ -140,11 +140,6 @@ TODOList:
 =E9=AB=94=E7=B3=BB=E7=B5=90=E6=A7=8B=E7=84=A1=E9=97=9C=E6=96=87=E6=AA=94=

 ----------------
=20
-.. toctree::
-   :maxdepth: 2
-
-   arm64/index
-
 TODOList:
=20
 * asm-annotations
@@ -152,6 +147,11 @@ TODOList:
 =E7=89=B9=E5=AE=9A=E9=AB=94=E7=B3=BB=E7=B5=90=E6=A7=8B=E6=96=87=E6=AA=94=

 ----------------
=20
+.. toctree::
+   :maxdepth: 2
+
+   arm64/index
+
 TODOList:
=20
 * arch
--=20
2.17.1


