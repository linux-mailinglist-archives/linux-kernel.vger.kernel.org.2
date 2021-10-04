Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6BCA4210D2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 15:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbhJDN63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 09:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238837AbhJDN6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 09:58:18 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA749C04AED9
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 06:53:29 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id e7so16613393pgk.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 06:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pG3mj4bKDd7l8ZFqHwjB1MgvpFgzE+2HiTROeiz4Dcw=;
        b=Ek2T9nV9gQ8EWW8JDLZtRMeCCS4iAzWtRhmGo7yHHo6WzIsUsiRDuBFkc0ZL2A5JwW
         wqYVIeN9ulfTvKJ5+EwL6nPlknmGh4JtbLi6Ql6q0xXPRK8kx1YgBD9LxXlEFQdVRtGC
         mUqtbcO01o3VDHKhrV323LAhW1CTqF81ywr28vwBzxElPYywwVh2i5n8LVlx4EwggwuC
         Qs2khDcDwteSaxo+vdGhUTks5JzBz3Y66YemKDinonJC6aTl6GHzaz0IRMYBAvt5G/6h
         lcf5R8jJSc9rB4cmZdV53j6lHJaYjFDcjzfiI2OOzsrNW20KlPVXTVaa1/KH7AoiJamr
         aScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pG3mj4bKDd7l8ZFqHwjB1MgvpFgzE+2HiTROeiz4Dcw=;
        b=KojhV+c9J7sl48Ef3Pl+LhwH90hKUEFZg2UajjXUyGJLKUWZBh8lv9rQ5ppEmyz+rs
         +in+vav8UJI5n67cLQXtatvKkLcWF82s1H+jluQUxCdcWJJSAxCY7Rsyr+p5vyj19A4P
         G8bjfj+kfOWIUM+tQLh+2rb8Pj9ZThO/Ics6QKrE8ie/eQaTqaL3SaCEytNPDFO10aN+
         aapVYlqMLnEvR2Vk+3UaGyQ+NQ1TeVhzApH8YGR3R15Exyitw9l5RTKMpfrHJ5c2wme/
         CJXNDA6pfoqUZnZZDh2DdVegsyR0s3m2Iwp8atOqV3qtka/RlM2xZGHRemlLw+0uJ+MT
         jQRg==
X-Gm-Message-State: AOAM533/9ndijPxTVYr5jRvzV1nAXkQi7ra/tcm1wlE28vwZkvYlDixs
        pTz3cnCaYGLALFjLcMHx8rs=
X-Google-Smtp-Source: ABdhPJyvIHilOe5lS9NntuhffkTCHZ//p5UWlaai74QhVdLHck17Mlcj4MWEODyY2W6dSYUSaLrhfA==
X-Received: by 2002:a65:6389:: with SMTP id h9mr11100114pgv.83.1633355609139;
        Mon, 04 Oct 2021 06:53:29 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:e8f0:c2a7:3579:5fe8:31d9])
        by smtp.gmail.com with ESMTPSA id k17sm12209548pfu.82.2021.10.04.06.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 06:53:28 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/8] PCI/AER: Remove ID from aer_agent_string[]
Date:   Mon,  4 Oct 2021 19:22:36 +0530
Message-Id: <b4c5a5005d4549420cf6e86f31a01d3fb2876731.1633353468.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633353468.git.naveennaidu479@gmail.com>
References: <cover.1633353468.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before 010caed4ccb6 ("PCI/AER: Decode Error Source RequesterID")
the AER error logs looked like:

  pcieport 0000:00:03.0: AER: Corrected error received: id=0018
  pcieport 0000:00:03.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, id=0018 (Receiver ID)
  pcieport 0000:00:03.0:   device [1b36:000c] error status/mask=00000040/0000e000
  pcieport 0000:00:03.0:    [ 6] BadTLP

In 010caed4ccb6 ("PCI/AER: Decode Error Source Requester ID"),
the "id" field was removed from the AER error logs, so currently AER
logs look like:

  pcieport 0000:00:03.0: AER: Corrected error received: 0000:00:03:0
  pcieport 0000:00:03.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Receiver ID)
  pcieport 0000:00:03.0:   device [1b36:000c] error status/mask=00000040/0000e000
  pcieport 0000:00:03.0:    [ 6] BadTLP

The second line in the above logs prints "(Receiver ID)", even when
there is no "id" in the log line. This is confusing.

Remove the "ID" from the aer_agent_string[]. The error logs will
look as follows (Sample from dummy error injected by aer-inject):

  pcieport 0000:00:03.0: AER: Corrected error received: 0000:00:03.0
  pcieport 0000:00:03.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Receiver)
  pcieport 0000:00:03.0:   device [1b36:000c] error status/mask=00000040/0000e000
  pcieport 0000:00:03.0:    [ 6] BadTLP

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/pcie/aer.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 9784fdcf3006..241ff361b43c 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -516,10 +516,10 @@ static const char *aer_uncorrectable_error_string[] = {
 };
 
 static const char *aer_agent_string[] = {
-	"Receiver ID",
-	"Requester ID",
-	"Completer ID",
-	"Transmitter ID"
+	"Receiver",
+	"Requester",
+	"Completer",
+	"Transmitter"
 };
 
 #define aer_stats_dev_attr(name, stats_array, strings_array,		\
@@ -703,7 +703,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 	const char *level;
 
 	if (!info->status) {
-		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
+		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent)\n",
 			aer_error_severity_string[info->severity]);
 		goto out;
 	}
-- 
2.25.1

