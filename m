Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D72F9413CC1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 23:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbhIUVnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 17:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235138AbhIUVnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 17:43:19 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E524EC061574;
        Tue, 21 Sep 2021 14:41:50 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id d21so683540wra.12;
        Tue, 21 Sep 2021 14:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=fJxtCIEGiYTqFIi58LyN+hctM+2eeA6/eYccpurq6ZE=;
        b=G+4Z/09LU9g/61EOXrog2KVPzZ44IIYYTYUDkMlh0Bt+jtTReR03PTulMk5cpFNsfA
         t4PhMu5EVakMuQC0AKydhfUzQD+OtZ7W6TdMjOnQe5xAbTTZxQEWt9wSTmlr/1151NGi
         IBe83WmqbI+nHCh1CpGm4X9DeuNuCJZaD3TCeejL5jYWe4T4t3IWhrVqEW1HeYznHWpt
         FGhgGUvebQZcJKGxsBCxTlneaHRWE/GYSeHprVabpPZIVuAyxeTBAMGzFqj4/LLIo4AW
         nnh9+jqn4tFxrqAcPFq1R8k1kyfOm6YnBHzgwUTHv8TvOptxiFlFvkF5dCOlHBcYp7+L
         c3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=fJxtCIEGiYTqFIi58LyN+hctM+2eeA6/eYccpurq6ZE=;
        b=mhx1jj1dkov1DBOISOSPik5Ut+NBPYll6doolwH19tnvhJ7cMm65UdKrfjW8Xa45oY
         tJJdkFpmc6TzQ0TZBsUIHBG5jgPrzvBW2Qq31kCJBmo1PMz8o9Di1vgST+ob8G7pEayn
         oKZnFYN5GLo0XlOGIQmk9un0SLlf+gRjLIk1YIkvBn4eHAzH2trnrPx/K/5JcYRYCOGh
         sqTYY9XOJOiptB4eaHyNsSnwwN84qHKf5y9daLHZpTkMk0yrnPP1GHAjriWOJ6JoC90v
         kMkKf+WbwQR3ThuCW2EP30tuCHV8Sx4t5l2nLHKREkLaMgxVAEjyPC0U3Jq+gxDB/qjz
         XFZw==
X-Gm-Message-State: AOAM531GoKim8YfucCC3rmytShcZZ1FlWF2QZw0zQ79Vo2V6TT0RWtI/
        0GL4tbnKj+UhPcGQMkgoVXD3bJw00LQ=
X-Google-Smtp-Source: ABdhPJznvPEFPEBolStKTf6z4nv0bQiVYDDevFma4P86PueyvIFtM6E1BF6/vuOZajLZhNnzyM5Dxw==
X-Received: by 2002:a7b:c112:: with SMTP id w18mr7048243wmi.86.1632260509603;
        Tue, 21 Sep 2021 14:41:49 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p200300c78f4e0664d2c35468e13948d7.dip0.t-ipconnect.de. [2003:c7:8f4e:664:d2c3:5468:e139:48d7])
        by smtp.gmail.com with ESMTPSA id c7sm67430wmq.13.2021.09.21.14.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 14:41:49 -0700 (PDT)
Date:   Tue, 21 Sep 2021 23:41:47 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: usb-skeleton: remove obsolete comment
Message-ID: <20210921214147.GA9648@matrix-ESPRIMO-P710>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl warning:
WARNING: It's generally not useful to have the filename in the file
7: FILE: drivers/usb/usb-skeleton.c:7:
+ * This driver is based on the 2.6.3 version of drivers/usb/usb-skeleton.c

Deleting both lines as the -2.6.3- makes the reader belief this is an
unusable old file and the -rewritten to be easier ...- is only of value for
the reader that knows what the driver was before.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/usb/usb-skeleton.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/usb-skeleton.c b/drivers/usb/usb-skeleton.c
index d87deee3e26e..91da019a1171 100644
--- a/drivers/usb/usb-skeleton.c
+++ b/drivers/usb/usb-skeleton.c
@@ -4,8 +4,6 @@
  *
  * Copyright (C) 2001-2004 Greg Kroah-Hartman (greg@kroah.com)
  *
- * This driver is based on the 2.6.3 version of drivers/usb/usb-skeleton.c
- * but has been rewritten to be easier to read and use.
  */
 
 #include <linux/kernel.h>
-- 
2.25.1

