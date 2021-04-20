Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F02AE365887
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 14:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbhDTMHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 08:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbhDTMHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 08:07:15 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA919C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 05:06:43 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id bx20so43619547edb.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 05:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x9c3r13HPylppoMPao4ledc3mbYWLGl4YkdEgW4VZvA=;
        b=Ek0bA+l5MzxGUC/5g7l67MICM4Uh7CjRfjjdhE9VBxIoPsksBobOlUj1JSFtCu6uEv
         pE5sceaIYjsIQNK8fyzIEz+2jCQtoGdU0A1SAAsCfUKWkPG0CGLyqyiSHsVDlYhBxwm0
         +ll6w1U7w1L1Z+qKeF3iPJr1RsBZYbKzMgoiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x9c3r13HPylppoMPao4ledc3mbYWLGl4YkdEgW4VZvA=;
        b=hHH1+GA+OOFHgFzxkXaIks51D4Ezv4AuS5j7iQHGGbKxUie3JadOSN7STljHsCglKX
         ntiV5W7BtrcaRJ3gx12ojSXphAKlCWMEWfCnwkmu86PPi9vn6JvXwxV7GbXekXOkLI08
         GZtXRJ6SNGJVetf2mxaK+8YCwgpSEdwyL74CHdgoXtOX6726vvsa6AqlxHBww04gVrm6
         Fn1XVaxDtU+s+kluRyYIL/IvAN9by6HFz35pkJ5EW/0ld1YzZDt+CRrnBGcfPpfwn614
         OHRLUGJeKWLOSrLcS9jCPHM453rW62wUUROO15s9Ud+hBQNExXdpaLWZ+fo5xafsQ5iq
         p3yA==
X-Gm-Message-State: AOAM533nfTTkUjiJiKWqAklg2lgRL+B40mWtDZFiQVSXqHa3SWRlH/y6
        WkCTClpGqFIeYoUpNY6ztfSHCg==
X-Google-Smtp-Source: ABdhPJzDMI1SxSR+7L9SKSloUbd8WrblJjsRu0Cg1QtdYfJSIJzmvkefnMruL+WbZ5Q8SoSrOP9AHA==
X-Received: by 2002:a05:6402:2807:: with SMTP id h7mr31548676ede.217.1618920402614;
        Tue, 20 Apr 2021 05:06:42 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id q25sm15615644edt.51.2021.04.20.05.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 05:06:42 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Jonathan Corbet <corbet@lwn.net>,
        Kay Sievers <kay.sievers@vrfy.org>,
        Greg Kroah-Hartman <gregkh@suse.de>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] docs: admin-guide: update description for kernel.hotplug sysctl
Date:   Tue, 20 Apr 2021 14:06:38 +0200
Message-Id: <20210420120638.1104016-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's been a few releases since this defaulted to /sbin/hotplug. Update
the text, and include pointers to the two CONFIG_UEVENT_HELPER{,_PATH}
config knobs whose help text could provide more info, but also hint
that the user probably doesn't need to care at all.

Fixes: 7934779a69f1 ("Driver-Core: disable /sbin/hotplug by default")
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 Documentation/admin-guide/sysctl/kernel.rst | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 1d56a6b73a4e..c24f57f2c782 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -333,7 +333,12 @@ hotplug
 =======
 
 Path for the hotplug policy agent.
-Default value is "``/sbin/hotplug``".
+Default value is ``CONFIG_UEVENT_HELPER_PATH``, which in turn defaults
+to the empty string.
+
+This file only exists when ``CONFIG_UEVENT_HELPER`` is enabled. Most
+modern systems rely exclusively on the netlink-based uevent source and
+don't need this.
 
 
 hung_task_all_cpu_backtrace
-- 
2.29.2

