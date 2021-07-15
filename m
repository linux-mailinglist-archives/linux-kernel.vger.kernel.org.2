Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 411DC3C966A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 05:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbhGODVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 23:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbhGODVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 23:21:13 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A425EC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 20:18:20 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id a6-20020a37b1060000b02903b488f9d348so2723260qkf.20
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 20:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HilRbJ6r95NIvn8dHJ5PVh0HLH8oAFB6AVFV3SK/JO4=;
        b=ZyHuNUO3vFBpbCV326hQjWqLonrGb0UGGqJL/KLuP0rK++g0O7V0TEkQRK1ln3AUI2
         OzUF388BN1C5ki5dn+Fxmhl1+xDV68FI+7oirwUNrT8RElY7iTc+sLbPN3IFUhlUKIwY
         PGVQ2rV8Lm7o5ioyQzxbA9usiLNozj13hsVy78jddX0QS3qU2xEn4M9pv76/lKZQLFop
         J0xJw4FGX9aGEm/U9FJh5r/X6xjQU+apUlHgcbzXSqDutzMtlknV5KBQGOIffzW8uZuv
         rJJVx6jni+4+6TbgF7qvOtPGgl0C+hRJmIt0y1dHCJvEFBXl8/NNfDrw22oq3gPP/tlm
         x+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HilRbJ6r95NIvn8dHJ5PVh0HLH8oAFB6AVFV3SK/JO4=;
        b=G9uDiEX40/UURrW8ZRVsZOKaHxV/ub7fGoQlIYiUZ/9XyN4wHSwjwXLIO9rFnYvPYo
         4bit0c+ozTrJqcfZwK9XfLE6RlEsxqDCBU/y5Aj/9zMjMIeLRSQ/NK7xP6j/kJWrcIVt
         zN0PcMBMATdGbv4Wlq7QTtaL1cLVlDCXBEAzZ7lRDbCwSGMyOd7eVzyIcz3BVEQ+Aoxn
         1g52NRklT09ewpbQi1NgCtWYOTur9LfGk3xm9MHP9U1qONzDcp59RIky2dmODRaA2ACw
         CVb0qwH+rPmWKIvVkje2i5z9tXPS2AMeIhOnR55De27+Um22EbDDCsCw7jFOXuTC3aXc
         R8cQ==
X-Gm-Message-State: AOAM530GRDpKb7VDoSOFoWUp+deN0bf3zsDyWrp4dKupotf0u0GynPmN
        tfy8NTZgJsh1rr/Hdk+ch/WIW9Vi54jxkQ==
X-Google-Smtp-Source: ABdhPJx28xL3OPQjHVTW48LMumzz9PxL8Mz0w6VJUmQzK+9KRgJQxwMuXfCKoAIIYwEAx3O9ffHO0S+024je/w==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:b1])
 (user=cmllamas job=sendgmr) by 2002:a05:6214:1647:: with SMTP id
 f7mr1800081qvw.18.1626319099797; Wed, 14 Jul 2021 20:18:19 -0700 (PDT)
Date:   Thu, 15 Jul 2021 03:18:04 +0000
In-Reply-To: <20210715031805.1725878-1-cmllamas@google.com>
Message-Id: <20210715031805.1725878-2-cmllamas@google.com>
Mime-Version: 1.0
References: <20210707162419.15510-1-cmllamas@google.com> <20210715031805.1725878-1-cmllamas@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v2 2/3] docs: binderfs: add section about feature files
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Steven Moreland <smoreland@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        Carlos Llamas <cmllamas@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document how binder feature files can be used to determine whether a
feature is supported by the binder driver. "oneway_spam_detection" is
used as an example as it is the first available feature file.

Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 Documentation/admin-guide/binderfs.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/admin-guide/binderfs.rst b/Documentation/admin-guide/binderfs.rst
index 199d84314a14..41a4db00df8d 100644
--- a/Documentation/admin-guide/binderfs.rst
+++ b/Documentation/admin-guide/binderfs.rst
@@ -72,3 +72,16 @@ that the `rm() <rm_>`_ tool can be used to delete them. Note that the
 ``binder-control`` device cannot be deleted since this would make the binderfs
 instance unusable.  The ``binder-control`` device will be deleted when the
 binderfs instance is unmounted and all references to it have been dropped.
+
+Binder features
+---------------
+
+Assuming an instance of binderfs has been mounted at ``/dev/binderfs``, the
+features supported by the binder driver can be located under
+``/dev/binderfs/features/``. The presence of individual files can be tested
+to determine whether a particular feature is supported by the driver.
+
+Example::
+
+        cat /dev/binderfs/features/oneway_spam_detection
+        1
-- 
2.32.0.93.g670b81a890-goog

