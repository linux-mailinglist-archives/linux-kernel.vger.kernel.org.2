Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBCC327E70
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 13:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235045AbhCAMg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 07:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbhCAMg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 07:36:56 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5024EC061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 04:36:16 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id u12so11487180pjr.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 04:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aHKl2ifjfFue0mX7AlhZwlZkgYLL6KuO5Evur3d7teY=;
        b=rtiZd5gC6kPJr3YwWqhGX23hoyV/0rnI1ney+wD2Qfu/xruPUrh6WhKRWaGTO/EvDQ
         5BRqCCUgOxplOvmZA3aERlUOS5SYSL/fiTG/Oav2IUtdohRqUMg91wQruJkyRdu4Sge0
         pZ8vDbJjDZfLJ8rRP46CyoGEH5Zhdn+cy6arY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aHKl2ifjfFue0mX7AlhZwlZkgYLL6KuO5Evur3d7teY=;
        b=e2mR+eGQBKMkvTm9DC4PIXLzHQYOxnQ2anC7FmxLE0hbujKRYAArEJWrJENOhN4juH
         ELM5e0tONsZBHP13h7bw7fo/2Lernq7TwCOLk4wMNw9l+WjhCEMFcN0HN073EMbWaiL/
         vofLltSGmdQCIW/ioQIKh9e5Dada82rLYua2HhDu25OE1M4oz+EsR1etstJg53QsaJQe
         Y6Se9/MjIb0fG4f8ozLXb62E/osDiCRTlB6J8TOokKzCQPHUkfd+bKKuq1I0uVMHeQZQ
         xuBAOfS5Kdi/47wTZEeSFMOKbstHpEVH8HZyzJqK51RIkNUVyZ+7i01oFIqy760yMeTo
         jsUA==
X-Gm-Message-State: AOAM532xyWbp3ncLTbo4ebde8j2Fpz36cWXFWqygv4pIPheLEzndPgjT
        uW02anLoYxl3Q8EpAKR4FNTPLA==
X-Google-Smtp-Source: ABdhPJxOr/a6RlVgTyLEJ1PiMM+lPrd84tutb8D9p3gWD2fgAKluwDJh3vEg5M+cXvXJHFimSWH0wQ==
X-Received: by 2002:a17:90a:13:: with SMTP id 19mr17624768pja.116.1614602175901;
        Mon, 01 Mar 2021 04:36:15 -0800 (PST)
Received: from shiro.work (p345188-ipngn200408sizuokaden.shizuoka.ocn.ne.jp. [124.98.97.188])
        by smtp.googlemail.com with ESMTPSA id 8sm18130928pfp.171.2021.03.01.04.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 04:36:15 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     soc@kernel.org
Cc:     arnd@kernel.org, olof@lixom.net, w@1wt.eu,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 0/3] ARM: mstar: MPLL mop up
Date:   Mon,  1 Mar 2021 21:35:39 +0900
Message-Id: <20210301123542.2800643-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is just 3 small patches that got left behind
when the MPLL driver was merged.

Link: https://lore.kernel.org/linux-arm-kernel/20210211052206.2955988-1-daniel@0x0f.com/

Daniel Palmer (3):
  ARM: mstar: Select MSTAR_MSC313_MPLL
  ARM: mstar: Add the external clocks to the base dsti
  ARM: mstar: Add mpll to base dtsi

 arch/arm/boot/dts/mstar-v7.dtsi | 23 +++++++++++++++++++++++
 arch/arm/mach-mstar/Kconfig     |  1 +
 2 files changed, 24 insertions(+)

-- 
2.30.1

