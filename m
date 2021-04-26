Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A38EB36BB92
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 00:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237301AbhDZWSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 18:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237202AbhDZWSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 18:18:47 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19E0C061756
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 15:18:04 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id v23so6157690qkj.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 15:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q5djI1+HvAi/jye2T39my6fOjQXVXyZ1kxwVi3Zvr5I=;
        b=EAi5uyySjPdGipCrswy0SXYnFkwYEeOzpyIl22pa2qiu0REzNSACOnIFsiJu5dK5li
         qPlpnwmtOhb1JKrcv+WHcG9TJCws2nHlbMo/I8sPbN+vx76BFfuoA92KAwHrIZ1H4O+a
         QIqYrDnnpU4Z8vPX7avDJUMQ9BJMWRBjmOUS7ATHABJZzKaMxE1HPWaavLVz+bG12rt5
         QO5l5ZQM+fugMNAwvews0sqGl6xKlTd2BJLSxl+1ERLSJtkB7jc6dJJCxwubQO2ir+8/
         CM4B4KqeP0bf8vGG1rDcugahF6CZdhoAinDAHM+LYJOu248bQYeYAAVC2o1tn2a2DdOl
         JjXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q5djI1+HvAi/jye2T39my6fOjQXVXyZ1kxwVi3Zvr5I=;
        b=iDBRGNOZUTlV2x51heZwlHjkRJpPDQ4AXy74YPJQE2FoNUA9JaGEBwL9043GvUVCI0
         NdIJenj5jYP+PYjbq9YsYL6wl83vCXCoYW2TF9G9QgvpzBy0K6Q/AhYALi+vvG/5ya9B
         C0aQwhOBvC9VuKE77kFaKQ12kc1s/6gMJvs1J5l/S5JeI6GpdbaaG1jDcFvT4dA5DL1c
         uOXXpdApwYiAQYl5wTNRkrb+gx3rgPIu1GHaWLwccJz5CLG6PLqDxWJm5pn68G1nol+e
         IhtRtPQbH/IJQNKOtTh0dk5JlL/x26J42WaQ7OKKcAPBber43oHB2/0ndx3d3IoE2MZg
         iOCg==
X-Gm-Message-State: AOAM531ZOh0hHy2B/W3A0Cn8BAna+JOWt+y1AZKc9O3ms8S0u/QMgHxd
        Tb+GBAoLVp1VWMEBA48M0/XHv9LlkJt3kA==
X-Google-Smtp-Source: ABdhPJzEmprnfZKsoP3VMo8EfpdtDYwPivVtB5Kglo8Rzf/gAfSGcTuCxe2Z1e43p2vihQjewJSlsQ==
X-Received: by 2002:a37:65c1:: with SMTP id z184mr19942258qkb.431.1619475484059;
        Mon, 26 Apr 2021 15:18:04 -0700 (PDT)
Received: from localhost.localdomain ([156.146.37.247])
        by smtp.gmail.com with ESMTPSA id x20sm1374111qkf.42.2021.04.26.15.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 15:18:03 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     corbet@lwn.net, nathan@kernel.org, linux-kernel@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH 2/3] oprofiled version output line removed from the list
Date:   Tue, 27 Apr 2021 03:38:46 +0530
Message-Id: <8d1928ff2fea29d67143d235839a5e845e4402c9.1619181632.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1619181632.git.unixbhaskar@gmail.com>
References: <cover.1619181632.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oprofiled version output line removed from the list.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/process/changes.rst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index dac17711dc11..d3a8557b66a1 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -48,7 +48,6 @@ quota-tools            3.09             quota -V
 PPP                    2.4.0            pppd --version
 nfs-utils              1.0.5            showmount --version
 procps                 3.2.0            ps --version
-oprofile               0.9              oprofiled --version
 udev                   081              udevd --version
 grub                   0.93             grub --version || grub-install --version
 mcelog                 0.6              mcelog --version
--
2.26.3

