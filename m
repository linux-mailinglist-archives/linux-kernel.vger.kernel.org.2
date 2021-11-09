Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D699A44B17D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 17:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240402AbhKIQtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 11:49:43 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:38908 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238174AbhKIQti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 11:49:38 -0500
Received: by mail-ot1-f42.google.com with SMTP id z2-20020a9d71c2000000b0055c6a7d08b8so19557344otj.5;
        Tue, 09 Nov 2021 08:46:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=arzfWqK0hGCq14CNUsPpTNtAe/8DBcFmT+M6WnZX4wQ=;
        b=Mb0W2HxgqP6LsMh+3bEPrVVCUNDNVeOzONB0NKEE0ZsGGc8hfaLFDW8vH0UzTmxc0i
         pnxGbTDhDDi+lGmu2IDqbjDNjfGo5Bc/AFwQMI/lkqyYqIh/Yy651K/VmORXWphCPSmV
         twww7nPpjw13jHfqEwT0UgCV5HbN/yqJM4ijTuMgwdmtNyN0PXBhmuoG/rReXL6X5gWO
         u403YvcZ6CdmxmDx5upP88SOuvHcRa40S5Q+5OJlTTW05+THLfpartd6zKzvqzpQa5XX
         SrT1WQLgTJTHBUVGCefcxFPfnAGBrSCEYrTvHkKSs5cq7u+PGMffPdkKTHRvrLby/n7z
         bTBw==
X-Gm-Message-State: AOAM531Yl2R6Uk6SUEkG8YgBdcakTBXIhNwi+T99Z0ZZZIYMTTNQ9FUV
        qZTL1iYzdTOHQGz+Cxjcmg==
X-Google-Smtp-Source: ABdhPJzegdQDYjAxQMqk7anNTgjJTs08c4V8fztPM8C+wm2mMMEkkL/zRwrZbFF/zjlZNGp+G0SdoA==
X-Received: by 2002:a9d:bef:: with SMTP id 102mr7218561oth.239.1636476411683;
        Tue, 09 Nov 2021 08:46:51 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id w22sm7514338otp.50.2021.11.09.08.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 08:46:51 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Guenter Roeck <linux@roeck-us.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Fix Arm Ltd board node name collisions
Date:   Tue,  9 Nov 2021 10:46:48 -0600
Message-Id: <20211109164650.2233507-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node name changes in commits 25b892b583cc ("ARM: dts: arm: Update 
register-bit-led nodes 'reg' and node names") and 2d3de197a818 ("ARM: 
dts: arm: Update ICST clock nodes 'reg' and node names") caused name 
collisions with the kernel's handling of ICST clock names and platform 
device names. This series fixes the kernel side to handle the DT 
changes.

This does break DT ABI compatibility which is partially mitigated if 
these changes are backported to stable. The alternative is reverting the 
referenced DT changes and coming up with different node names without 
unit-addresses. Ultimately, ABI issues are platform maintainers' 
decision, not mine.

Rob


Rob Herring (2):
  of: Support using 'mask' in making device bus id
  clk: versatile: clk-icst: Ensure clock names are unique

 drivers/clk/versatile/clk-icst.c |  6 ++++--
 drivers/of/platform.c            | 10 ++++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

-- 
2.32.0

