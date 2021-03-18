Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD71340153
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 09:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbhCRIw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 04:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbhCRIwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 04:52:03 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C2DC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 01:52:02 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id o16so4621951wrn.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 01:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u5wivGTr87AFeSVjq+RPxAGgUPqftM9xBrGW+nIjIr0=;
        b=n6g2xoisS0ymTmWPWtvMfF3pktpNrRfc38MouzDXCl2G9wZiRyN1IJDDU0DrjekF0f
         G6GW9SmWZmmnoBQvbNepQYyYcSCHHGzUAYyvZMoV+ZCkn3JmPYfu78sXT9V/9RgyJysU
         peE/74Rml5/Me/rthJLUdzQALRajCSfLvmYbHPx2/WTIWIJcWv3nfCM+jKTeAIPKo5je
         LVvrFLkcdxQdiZG3XNhChfZMIVlqo2KyOAEeOTguUbezO6Pq3LWjYpMTM8fvpdn+q2pU
         rRISqXuHy+MgDpbwz2LNQ63udW8Wewm/TO/uZyJqCeCUNzKER6TGJsbtHu+4FqBH0+Cr
         0d6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u5wivGTr87AFeSVjq+RPxAGgUPqftM9xBrGW+nIjIr0=;
        b=s+xop3qgazqBkJxeYSfwrf1pLqKjgdJMYdA5cWyOLRu27sYORWaKt6CNIJuXix91Yd
         fRDzug4e45EHzTBg6qXzPBoc/UWbgIEWlMa+sk3s8Eww8r98/Z/R6QRUz5QLjrv3sSem
         HAvmsafj57jhLhuREnG+ANuKjocnnmbfJZIMnLUp/rA2LVfC1QInp0yLBSifVTLE+vSN
         qlsdl74kG++hgcAk3STJq0+ak8rN1c2JsPd95VY8gheSwxEpj1sRnhGdXOc1iK0NANib
         eFsBzCpL/gmp9YotloTjRm0uXwRbHc8lSa2XsnkViZ1Fdry5pdia8JtRmU4XRvwqE8CT
         6HgA==
X-Gm-Message-State: AOAM532JRoQBWxvcihTTV31womaRPKJzbZ2tFtopEd9qwVLEPMbcEVZh
        x31Cno5vOpDgApYwyQyyUTqzaw==
X-Google-Smtp-Source: ABdhPJw2Na7Ak0qwm6kHBbG3Of6Eg8McOWqQOjJsj4cpF+pgsUQWGQ4wyl9sDf8tJEBgBkCkLW+Riw==
X-Received: by 2002:a5d:424c:: with SMTP id s12mr8629682wrr.161.1616057521488;
        Thu, 18 Mar 2021 01:52:01 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id w131sm1526868wmb.8.2021.03.18.01.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 01:52:01 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Andre Hedrick <andre@linux-ide.org>, Hat Inc <alan@redhat.com>,
        linux-ide@vger.kernel.org
Subject: [PATCH 10/15] ata: ata_generic: Fix misspelling of 'ata_generic_init_one()'
Date:   Thu, 18 Mar 2021 08:51:45 +0000
Message-Id: <20210318085150.3131936-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210318085150.3131936-1-lee.jones@linaro.org>
References: <20210318085150.3131936-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/ata_generic.c:164: warning: expecting prototype for ata_generic_init(). Prototype was for ata_generic_init_one() instead

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Andre Hedrick <andre@linux-ide.org>
Cc: Hat Inc <alan@redhat.com>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/ata_generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ata_generic.c b/drivers/ata/ata_generic.c
index 9ff545ce8da3e..20a32e4d501d3 100644
--- a/drivers/ata/ata_generic.c
+++ b/drivers/ata/ata_generic.c
@@ -151,7 +151,7 @@ static int is_intel_ider(struct pci_dev *dev)
 }
 
 /**
- *	ata_generic_init		-	attach generic IDE
+ *	ata_generic_init_one		-	attach generic IDE
  *	@dev: PCI device found
  *	@id: match entry
  *
-- 
2.27.0

