Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039B83403A5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 11:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhCRKlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 06:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbhCRKkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 06:40:47 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9B9C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 03:40:47 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id z6-20020a1c4c060000b029010f13694ba2so3020973wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 03:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hNM7oYxDpUVruJupFtOo+nkAp1rdd1yt5xHzqF7N4tE=;
        b=R8uOHjvb96TRkgdKsmr7NEuIsHxxOwB9zHlgFIeN32iHimikWiYHdnN3fdKtYnf8ZY
         kUtsqru6YrMhLZrJZixPy94Ie+6GMpH9wPAjnVbCDKvO5ZwJuQh3+VzY8Mb32KtFuAlm
         aIRao9qjYO6RrR9T0T7oAWUFDROSvvW/PNGXzcNT90JMG2xklFEuIdRUUIPCtzD99xqW
         Ofwuq8Ocm0dqlL2pl2nvhwGovLNzOiWZF6JwLICdkW4KEZ9BecxPY0kMo1k8p6M3BM9E
         FLaBI2SsciwtncY8+0Jck3PWFbDo+jsgx7VsqD4Uk8MNQlFiQZmGe8u7wQXgPR0WjBm7
         vU1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hNM7oYxDpUVruJupFtOo+nkAp1rdd1yt5xHzqF7N4tE=;
        b=VmUpjctCkIEzKWREHpLJ2+VO3hX9QK9Jg3wBVI513FStlHCmHxqyHHqnOWIyPvneFc
         IQJpXKzGcYma1Eci0yFk8PHA0vMmZ5cRZBbBla3EhqufZ/CHT5csgQRlrG68Arw5uOfF
         1EWxInnpcqgBfSUnd80lhF9lWZwHgMs5MTMsOBMUV1XpsfDZe0NrTcDos3C4CzkhIlEx
         EgeRt6cv6VnUB2Y3G9+sdOXZ3UyMoYEyW55lBjLp80e98gkpPqpKFtz9wQ4NNKq13mQd
         smb38lJp6ggMmUMwchy1oA78PPJ+hl0XDJwDQAkNQK4qnWqptUDBN2d8awyxid70kruA
         906g==
X-Gm-Message-State: AOAM5309UXJFvjXwpq+KKTHxc9GjNyZ1njGBGyMIrKdbiWh7bxxv0u5c
        kJUdauG4lf6y0Kgu+2pPpObqQwxZvIvYAw==
X-Google-Smtp-Source: ABdhPJxbhtsgPmv0QKMRvdkSNXXI59ugi2qKs01BGhNK/DMFYqd5nNsrW4PCHCP0Q4jn8MjMzTc2vA==
X-Received: by 2002:a7b:cf16:: with SMTP id l22mr2938633wmg.26.1616064046073;
        Thu, 18 Mar 2021 03:40:46 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id z1sm2426033wru.95.2021.03.18.03.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 03:40:45 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Subject: [PATCH 02/10] of: dynamic: Fix incorrect parameter name and provide missing descriptions
Date:   Thu, 18 Mar 2021 10:40:28 +0000
Message-Id: <20210318104036.3175910-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210318104036.3175910-1-lee.jones@linaro.org>
References: <20210318104036.3175910-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/of/dynamic.c:234: warning: Function parameter or member 'np' not described in 'of_attach_node'
 drivers/of/dynamic.c:286: warning: Function parameter or member 'np' not described in 'of_detach_node'
 drivers/of/dynamic.c:326: warning: Function parameter or member 'kobj' not described in 'of_node_release'
 drivers/of/dynamic.c:326: warning: Excess function parameter 'kref' description in 'of_node_release'

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/of/dynamic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index 9a824decf61f1..1d7a22e44d787 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -229,6 +229,7 @@ static void __of_attach_node(struct device_node *np)
 
 /**
  * of_attach_node() - Plug a device node into the tree and global list.
+ * @np:		Pointer to the caller's Device Node
  */
 int of_attach_node(struct device_node *np)
 {
@@ -281,6 +282,7 @@ void __of_detach_node(struct device_node *np)
 
 /**
  * of_detach_node() - "Unplug" a node from the device tree.
+ * @np:		Pointer to the caller's Device Node
  */
 int of_detach_node(struct device_node *np)
 {
@@ -318,7 +320,7 @@ static void property_list_free(struct property *prop_list)
 
 /**
  * of_node_release() - release a dynamically allocated node
- * @kref: kref element of the node to be released
+ * @kobj: kernel object of the node to be released
  *
  * In of_node_put() this function is passed to kref_put() as the destructor.
  */
-- 
2.27.0

