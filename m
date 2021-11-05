Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE08F445F9D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 07:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhKEGPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 02:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhKEGPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 02:15:51 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B118DC061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 23:13:12 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id fv9-20020a17090b0e8900b001a6a5ab1392so2694865pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 23:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gRs3W8sfuDcyX3dCF84m8zhv0Sr6d2guyKmOwxp+H8o=;
        b=k3XckD2cwappfaIpEMZ+Od4rGEsyL6dq18s03wPZ2+oh99/66xp+GiFmOYab5aC/Ya
         kepxdYE1vas0UQgDJpeebUX20NpwJ30TDdh2KTWaYIWzLIzdWmcJnUyW6gyytjeY3nSP
         lpGboZlacJTHnooddheYQ8GXh5Q0DQIUjw6c5Q+rmsP1X8tRi55C6m/Qu+YnKpz6fIuj
         TjnOorchNj+O0GStOIW6u3Wmdu/NjpFGMq22cfRPqECXDc/5nbGhM/PwdI07T7Isp6IW
         WGqIDQEr+I32fWgvkpFx9Rn4G2kbrMUXHMefj/4YR4l9mv71un/r8ehaQi8p+BfAXptv
         3jIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gRs3W8sfuDcyX3dCF84m8zhv0Sr6d2guyKmOwxp+H8o=;
        b=Ycyo9c6pxIEDQqZYWX0AChmCeBSjMCUcD93bi67EJtjRkB46FSyIhfDoY320tLse2v
         McywymayYJiAsz+X3j7xp+GLTrn+DqJMFBJ0Y510jJGIPuSxnZwCZ/kveN+oSCG8fXiP
         a9v4/gIhDsppVbBMvLWRVolslw/NigQSDAhJcwr+EtAhOpL/OPNkab+74uEvFSdwemHj
         g3Iv5Jf83WHVd8zkawHM4YxfYHgbufwPF0NlbxGHHRMTma9FcZ/O2n4ZeOkIDU8IQ1c4
         QGGGAafFEdf+EmyZEN2DbtUje40bdQit/mUW3TRolsyGeR4hLXCMUFzNMHNg17NFm1y/
         W53g==
X-Gm-Message-State: AOAM533thsHvyOIuHZW2wRXufQsfeegDvUTBW5Nz4tUDwxvcm1QGkwzb
        O9PKKKJFmUZDrloo+aQ0u8A=
X-Google-Smtp-Source: ABdhPJwEl4sPKPUxMCpFiTBNkkACIlrT8sL1Zxcj3uUOlKLeheDSkKDeJoGmokVFg2Ic8Zfsjkb+zw==
X-Received: by 2002:a17:90a:2c02:: with SMTP id m2mr28085538pjd.109.1636092792337;
        Thu, 04 Nov 2021 23:13:12 -0700 (PDT)
Received: from debian11-dev-61.localdomain (192.243.120.180.16clouds.com. [192.243.120.180])
        by smtp.gmail.com with ESMTPSA id d13sm6576485pfu.196.2021.11.04.23.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 23:13:11 -0700 (PDT)
From:   davidcomponentone@gmail.com
X-Google-Original-From: yang.guang5@zte.com.cn
To:     jdike@addtoit.com
Cc:     davidcomponentone@gmail.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com, johannes.berg@intel.com,
        yang.guang5@zte.com.cn, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH v2] um: use swap() to make code cleaner
Date:   Fri,  5 Nov 2021 14:12:59 +0800
Message-Id: <80d5d60030f9f4c0d299e139597f67c562f1d6b2.1636092427.git.yang.guang5@zte.com.cn>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <7f95e669-fba3-32e6-cdb9-41fb415b3b82@cambridgegreys.com>
References: <7f95e669-fba3-32e6-cdb9-41fb415b3b82@cambridgegreys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>

Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
opencoding it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
---
 arch/um/os-Linux/sigio.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/um/os-Linux/sigio.c b/arch/um/os-Linux/sigio.c
index 9e71794839e8..37d60e72cf26 100644
--- a/arch/um/os-Linux/sigio.c
+++ b/arch/um/os-Linux/sigio.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2002 - 2008 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  */
 
+#include <linux/minmax.h>
 #include <unistd.h>
 #include <errno.h>
 #include <fcntl.h>
@@ -50,7 +51,7 @@ static struct pollfds all_sigio_fds;
 
 static int write_sigio_thread(void *unused)
 {
-	struct pollfds *fds, tmp;
+	struct pollfds *fds;
 	struct pollfd *p;
 	int i, n, respond_fd;
 	char c;
@@ -77,9 +78,7 @@ static int write_sigio_thread(void *unused)
 					       "write_sigio_thread : "
 					       "read on socket failed, "
 					       "err = %d\n", errno);
-				tmp = current_poll;
-				current_poll = next_poll;
-				next_poll = tmp;
+				swap(current_poll, next_poll);
 				respond_fd = sigio_private[1];
 			}
 			else {
-- 
2.30.2

