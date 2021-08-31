Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFDA3FC7BF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 14:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbhHaNAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 09:00:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50241 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233575AbhHaM75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 08:59:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630414742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VFi9mk+JrNYqm9om9cI3aYM4Tz+JK5QNKRVw7UvYJXE=;
        b=IwsU7QwrwZoqqfg9gxTDolrNRIRtOe52u8LmNMVzPvrHIJzfyy4IXxpQKqM1/a+gVzqwf3
        vR4HcfQkqG1h6fLP8I51z/HQd0DCS7rGr7pVtgki45qZk4ncbjPj4rnJ+EB378t8E1D53H
        UpXxmu0Uzki4PJ+t9kZYI/JXB6mtiHY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-rtbtUp0KOmG-B6ntOSwDCg-1; Tue, 31 Aug 2021 08:59:00 -0400
X-MC-Unique: rtbtUp0KOmG-B6ntOSwDCg-1
Received: by mail-wr1-f70.google.com with SMTP id q11-20020a5d61cb0000b02901550c3fccb5so4007836wrv.14
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 05:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VFi9mk+JrNYqm9om9cI3aYM4Tz+JK5QNKRVw7UvYJXE=;
        b=jbNvcAlmhzRZP/PUycFVHBwR+HZQrRwaWQWwJsE2WOcliepgk7DjI5j7AFpsuB1pjJ
         uNr3Ae9Pb/IHbJR/3RYV8Yz1PXIXoAzfef6shNTXOmBkwwsC9aYDo0izS8yviGMjsg8U
         R11o0pe3NkVBSyC7PeKD9U0AYvZbzr/kyzZxbzW+SwavmGK5ZDga+GRwiNMjojJJ4MFW
         9tkjNm42P+HT03AxV4q34YgOsZ5VxPj84dmuzOKceGfgIDcEifEEKjzdEEh5L271t+0+
         unBEkXa3aYO+BScnAhO4MUNyTgovoguMsQ5Lw7H24zzJ6fO0X1VG4G9NvKcdcCDt3pzf
         TLDA==
X-Gm-Message-State: AOAM530kBMwYgdRMZDSC31YcH/OphC7zhnNc2cOnfZTA2P2dXhjzn+Di
        dB9Ngz3pErlfLbgulTAA0KNnblU7WvijeN76j96DbwOhe0GIWIqVMswTOkiuD/wK87adPL83oms
        kdWlm4YmaTw8m/6bAIfrMad4l
X-Received: by 2002:a5d:6e84:: with SMTP id k4mr30756122wrz.426.1630414739547;
        Tue, 31 Aug 2021 05:58:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzflIax6tFxvMs9mjbd8B1Mb2iEt9SCQmR/++VhwuAoQyhS9HpVASDt6bCiXW4+7etv8yFh8w==
X-Received: by 2002:a5d:6e84:: with SMTP id k4mr30756112wrz.426.1630414739351;
        Tue, 31 Aug 2021 05:58:59 -0700 (PDT)
Received: from vian.redhat.com ([2a0c:5a80:3c08:b500:afb2:5ebc:3fd2:26de])
        by smtp.gmail.com with ESMTPSA id a133sm2553199wme.5.2021.08.31.05.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 05:58:59 -0700 (PDT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     robh+dt@kernel.org, nsaenz@kernel.org, f.fainelli@gmail.com
Cc:     gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stefan.wahren@i2se.com,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 2/2] ARM: dts: bcm2711-rpi-4-b: Fix usb's unit address
Date:   Tue, 31 Aug 2021 14:58:43 +0200
Message-Id: <20210831125843.1233488-2-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210831125843.1233488-1-nsaenzju@redhat.com>
References: <20210831125843.1233488-1-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The unit address is supposed to represent '<device>,<function>'. Which
are both 0 for RPi4b's XHCI controller. On top of that although
OpenFirmware states bus number goes in the high part of the last reg
parameter, FDT doesn't seem to care for it[1], so remove it.

[1] https://patchwork.kernel.org/project/linux-arm-kernel/patch/20210830103909.323356-1-nsaenzju@redhat.com/#24414633
Fixes: 258f92d2f840 ("ARM: dts: bcm2711: Add reset controller to xHCI node")
Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---

Chages since v1:
 - Add patch as per robh suggestion

 arch/arm/boot/dts/bcm2711-rpi-4-b.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
index 8377dc14b7b5..50530cc91876 100644
--- a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
+++ b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
@@ -225,8 +225,8 @@ pci@0,0 {
 
 		reg = <0 0 0 0 0>;
 
-		usb@1,0 {
-			reg = <0x10000 0 0 0 0>;
+		usb@0,0 {
+			reg = <0 0 0 0 0>;
 			resets = <&reset RASPBERRYPI_FIRMWARE_RESET_ID_USB>;
 		};
 	};
-- 
2.31.1

