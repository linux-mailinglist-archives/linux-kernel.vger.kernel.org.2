Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37A75310A95
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 12:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbhBELrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 06:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbhBELlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 06:41:17 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAB7C061794;
        Fri,  5 Feb 2021 03:40:36 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id hs11so11529703ejc.1;
        Fri, 05 Feb 2021 03:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DUZ2th2akMgZXbhWAwF/Rtcar/hbaUZaN5WHosC7d0E=;
        b=f6WLEzoX0YM3pJ/2GhrxKeXnaaiA5sYjXtPQX7wV9zO5f5TqAVgxWZq5Y/PPOhy1FY
         VYv1XRwJUHWjOE3yTC+8+DAqDK56eUppD5qN7sBDKxb9hjID3iutLMuTxXou9Btm8FAF
         t3cTZYJTMtuzapncz1CVgvNl8O+sbfxLCjPO/9ac39ZDVWlG0D2afoX1Md4R7Al8BT7d
         KnXhyvpQpj4Rw5Zlgxs32xdh0v6mGXFiJkM0omi6OUELi8bkMFm/nzauKFNxuSTCZTFh
         t9JRJaQDQT7rX5xFPjT8Nx3LLJPGGe9lGiQAGVVR08gJI6JDZaZs60gU/VI5F6k5cmlq
         AwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DUZ2th2akMgZXbhWAwF/Rtcar/hbaUZaN5WHosC7d0E=;
        b=IeYmFQjdH4QdA3MIqCJ2VQTa5To5Q3YUG5HvzmzXtCG61NMPwAY7nNujnJnwgNu18V
         vLF6bQqmbLEHwOEbApHja9f/V81FDvTmRc8bsUZu/yeuCgtHSCsHDKDHX/jZUsXRfQp7
         aLkSMA2DD2PP8JkOvxHKhREqD+YwTJWbhJZDC7GR8wx8bIdQNLSsQu0pOPMJfPzWzjYl
         yG9Ahqc02Q5JoOoRKuqbE5SCcNUmEt/Bp5+hftBGM1d6QKXLSla13/qyTaeTUwDW6Zmv
         CH8dwUMwkAuiuU1VNvsX+NvgBwuRYC9DsQv1c9EEoB2jDFnhMn4NBoysGE7eqmHAQZwn
         XVqg==
X-Gm-Message-State: AOAM531t8K6sgBwRin2ZDUWsHHgHfsxBHamOQ3aXBjicM8ClI8qcKexz
        44g/W4SfWoJ8RNC/ptiXBTk=
X-Google-Smtp-Source: ABdhPJyGtC2+rZ/s56VvOPOR0Xd9wRs0zBRTjb2MtyEeIhdb1SAlC4pzD+JV1KnPtu0vn5G4JuUOkg==
X-Received: by 2002:a17:906:f2cd:: with SMTP id gz13mr3592128ejb.83.1612525235435;
        Fri, 05 Feb 2021 03:40:35 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id o4sm3883476edw.78.2021.02.05.03.40.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Feb 2021 03:40:35 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org, balbi@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/8] usb: dwc3: of-simple: add compatible for rk3328
Date:   Fri,  5 Feb 2021 12:40:09 +0100
Message-Id: <20210205114011.10381-6-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210205114011.10381-1-jbx6244@gmail.com>
References: <20210205114011.10381-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cameron Nemo <cnemo@tutanota.com>

Add a compatible to be hooked into by the Rockchip rk3328 device tree.

The rk3399 compatible cannot be reused because the rk3328 SoCs may
require a specialized driver in the future and old device trees must
remain compatible with newer kernels.

Signed-off-by: Cameron Nemo <cnemo@tutanota.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/usb/dwc3/dwc3-of-simple.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
index e62ecd22b..93bc34328 100644
--- a/drivers/usb/dwc3/dwc3-of-simple.c
+++ b/drivers/usb/dwc3/dwc3-of-simple.c
@@ -171,6 +171,7 @@ static const struct dev_pm_ops dwc3_of_simple_dev_pm_ops = {
 };
 
 static const struct of_device_id of_dwc3_simple_match[] = {
+	{ .compatible = "rockchip,rk3328-dwc3" },
 	{ .compatible = "rockchip,rk3399-dwc3" },
 	{ .compatible = "xlnx,zynqmp-dwc3" },
 	{ .compatible = "cavium,octeon-7130-usb-uctl" },
-- 
2.11.0

