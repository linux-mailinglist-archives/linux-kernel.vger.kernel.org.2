Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A936233EC07
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 09:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhCQI6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 04:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhCQI5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 04:57:22 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6432BC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:57:22 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id x16so960636wrn.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tIEkLMKAtbUUByHxgsDytjqimEjUNe0j+Mn0l5iX50M=;
        b=a+DMI4iVTnhLsQaNH5HsLRD0p4jmOwH4c+OdsIB5mhlSZImVjQj67NzOFVCvxEZiEz
         qf3nxfzbCn1cPpyn2nBZt1S/puwJcu3eV83BgIHeszYCACXSaS9Xm/rCAUSS3wbVSTee
         ggp2QrfifWznoxjMwD8BRF6HCnYJUvIJmT3GGE8GCwgFXhkpD657Iqe0qoqmXx0dFnpv
         X9pBn5+2cc8mMirWmY0lRKr7DehTGXhNAVJfcDLknUxKRYg/vJZkIhtqLKfgKxOmGOcs
         lKOa9zBBQMjwcDgfz4yQMmpgoKoHMjJJVmV3Whx0vt/OPJACLEY8ZMF0eqhq1s9fXr6L
         Z0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tIEkLMKAtbUUByHxgsDytjqimEjUNe0j+Mn0l5iX50M=;
        b=P4HJBYhMd6OEMj4NUzE3FqQ9+s3VdLbKGeQkuMb/vHsKwYfMU4km12+Vuh+HzumdeD
         8jDjR1b1v2F/PimH7an05VUfZDpiZqwCh24AF0f43DmTLkTH5W7ie30uxMIHDfcy1fmZ
         UP66gKYbKkPBVVHIH8XnLAzqp3ZvCAeTfdYLMt3kwsr6o9aYORfVj4xHIgvrWH55DfDb
         InWmiBEYjW9d5Sf1wJ3uhpJx6uiJl89PeF0KLM9mzwfRPEEkQMQi4y2g8llLwEBYUYVK
         RlNXlfUNVHwnm0Sml5CVOTW9S/IZLva+r49SGtvXbSuWK4xIgqEbbkWXxiUCcJYADN3/
         9+/A==
X-Gm-Message-State: AOAM531BjEeBoRC/30lsnQO0abWlHGA4c1JBzwjpNWHI6Ctcg9zKpBMh
        xrI+QOzVibEWQNcoLDzatwYxeYjHqFd2Hw==
X-Google-Smtp-Source: ABdhPJzu9vdM0OUd6qmkmrhg8ngUL9mmunRKcl7uLbkfhxy5NL5s2Jl0Y/e3r3KTbRZAar9WWWzy/Q==
X-Received: by 2002:adf:f4ce:: with SMTP id h14mr3204003wrp.257.1615971441165;
        Wed, 17 Mar 2021 01:57:21 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id j123sm1807243wmb.1.2021.03.17.01.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 01:57:20 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 16/18] scsi: isci: port: Make local function 'port_state_name()' static
Date:   Wed, 17 Mar 2021 08:56:59 +0000
Message-Id: <20210317085701.2891231-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210317085701.2891231-1-lee.jones@linaro.org>
References: <20210317085701.2891231-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/isci/port.c:65:13: warning: no previous prototype for ‘port_state_name’ [-Wmissing-prototypes]

Cc: Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/isci/port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/isci/port.c b/drivers/scsi/isci/port.c
index 448a8c31ba359..5a362ba76d63f 100644
--- a/drivers/scsi/isci/port.c
+++ b/drivers/scsi/isci/port.c
@@ -62,7 +62,7 @@
 
 #undef C
 #define C(a) (#a)
-const char *port_state_name(enum sci_port_states state)
+static const char *port_state_name(enum sci_port_states state)
 {
 	static const char * const strings[] = PORT_STATES;
 
-- 
2.27.0

