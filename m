Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46147326050
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 10:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhBZJkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 04:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbhBZJjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 04:39:32 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0093BC061788;
        Fri, 26 Feb 2021 01:38:47 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id t29so5883763pfg.11;
        Fri, 26 Feb 2021 01:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J0JCxRwK/cVF01edZZLT5Wj+Rr/9cd4HuWjSUBop7vU=;
        b=Q5H0AZJTL1NSQGD7LnRILO+s/R0FFXQzHQBSHMRLI6O9gW2U5wMXdyQtJWYmEP6Vtw
         UOgyAb6NQz6CFU12TsYsfJ5T+fXSjZULazZfmx8DVPXi32RUHeKpmKY81aYQzubmnGtv
         wwmaK1dNv2CDfPxTqz1WgKar9J3bKWYUuKGztfKNB5WdQu+38JrdfRZQjrVG6hCv6MgZ
         6QZyn9jLMvUddMF9deJAwcLDIgdX/4XaUo5NXaDhg5Z8sPjgFbIklodv9hM25g7qOh1F
         M/UQZ4QOz/6w0NHS2vdWM/vAKVI4Cogzqx8S+DxhJCWDny5BHPstxIF36NFatGtFdAGH
         7cJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J0JCxRwK/cVF01edZZLT5Wj+Rr/9cd4HuWjSUBop7vU=;
        b=bluVjZ5JAuR4v9YIVgDpLxlgwB3D2Xc/t7iKvtO3utlOW96IjagLuC1flvJeRlsYtO
         dX0ktZ5rl60IXM7VUOwrJQustUW7RZL7zXOCwj/rCVrzePPnzkY650giN8hL/3jXks+G
         t/VtXlKxBSJsvj1tXDnWVbSW2tKltmvmHt1DQN7L6brNi9C2zytEn9NNA2JyG4T+AC96
         KZJKvG6ta8xM4+Hh4vlgc7aA/H4V227gCzZKG6AOHRuHjjjbelWmeaCpfKZe+Ds8OF3G
         3AnlosxtDbdSnpegZv+m0+c658kVH1CZnTg+ZiNDylJf+U2BicmUw1lDs6GIuDTzuIGt
         VBFw==
X-Gm-Message-State: AOAM532ki4/lpMou3aVvBpLbfdlXRyeQegm/GVa+WWtQrbJj499kT3ff
        F/RVDr4yx7VX/nem7FDeMVU=
X-Google-Smtp-Source: ABdhPJxQtiuvKwP1IU33GuRG5bLiQh02WQ5ZBlGfKG82cdoz0yv2PpI0englQ2YmAzvh/Nww++M9NA==
X-Received: by 2002:a62:bd05:0:b029:1ab:6d2:5edf with SMTP id a5-20020a62bd050000b02901ab06d25edfmr2347975pff.32.1614332327499;
        Fri, 26 Feb 2021 01:38:47 -0800 (PST)
Received: from localhost.localdomain ([2405:201:9004:6adb:2468:cd7e:b0b6:7857])
        by smtp.gmail.com with ESMTPSA id n1sm8548833pgi.78.2021.02.26.01.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 01:38:47 -0800 (PST)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com, corbet@lwn.net, mchehab@kernel.org
Cc:     lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Subject: [PATCH v8 3/3] MAINTAINERS: clarify responsibility for checkpatch documentation
Date:   Fri, 26 Feb 2021 15:08:27 +0530
Message-Id: <20210226093827.12700-4-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210226093827.12700-1-dwaipayanray1@gmail.com>
References: <20210226093827.12700-1-dwaipayanray1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lukas Bulwahn <lukas.bulwahn@gmail.com>

As discussed, Dwaipayan and Lukas take the responsibility for maintaining
the checkpatch documentation that is currently being built up.

To be sure that the checkpatch maintainers and the corresponding
documentation maintainers can keep the content synchronized, add them as
reviewers to the counterpart.

Link: https://lore.kernel.org/lkml/bcee822d1934772f47702ee257bc735c8f467088.camel@perches.com/
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 16ada1a4b751..6b48b79ba284 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4181,9 +4181,18 @@ X:	drivers/char/tpm/
 CHECKPATCH
 M:	Andy Whitcroft <apw@canonical.com>
 M:	Joe Perches <joe@perches.com>
+R:	Dwaipayan Ray <dwaipayanray1@gmail.com>
+R:	Lukas Bulwahn <lukas.bulwahn@gmail.com>
 S:	Maintained
 F:	scripts/checkpatch.pl
 
+CHECKPATCH DOCUMENTATION
+M:	Dwaipayan Ray <dwaipayanray1@gmail.com>
+M:	Lukas Bulwahn <lukas.bulwahn@gmail.com>
+R:	Joe Perches <joe@perches.com>
+S:	Maintained
+F:	Documentation/dev-tools/checkpatch.rst
+
 CHINESE DOCUMENTATION
 M:	Harry Wei <harryxiyou@gmail.com>
 M:	Alex Shi <alex.shi@linux.alibaba.com>
-- 
2.30.0

