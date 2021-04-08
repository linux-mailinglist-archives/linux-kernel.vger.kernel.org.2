Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9F9357A99
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 05:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhDHDBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 23:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhDHDBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 23:01:12 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2247C061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 20:01:01 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id bg21so372807pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 20:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=uj9M9j69MmEK6kxoKurva3J2kTnrLS58UJHTZwQEUnA=;
        b=f5WVZ9x2JFeVH7A2TmuvMEnm7l1ogQAOQcHxfSih3A9ytP2XSzvWF+7zRJovONlkp/
         uy+FWY2HV9TNZTRbMCc07E9FpCCwyza2XG5p0sKHG6+PwwgrAFhWIlWQyOFLAUwhDBvv
         rK/m3vfpsW00xAIEk8kBB8sQqPjDsnU/31ME5Pk8lCVGYZY519LIdLhsgUn0WtAAbxnL
         PCO1Bbjlqd+/wV4mvwlambSvLYJm4rQCLaA0BlDkGIZjUfzlHZi/UB2DSWByAUbL44dn
         md8mg2h1I6NZrVyw5kisxCE77E3l9RKNRDjevBNRnBg9kQi9aBKEaxByTfaUTzc4s/No
         n0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=uj9M9j69MmEK6kxoKurva3J2kTnrLS58UJHTZwQEUnA=;
        b=HO2MIxec1EhZLMStrs1eK3yfbmfCzjvW07TfjVljBPSf2VN1qyew3VucAxClgh6s7u
         SbvXx8hiLSexnv2cvXom7kaEl3s6zChuSzFIba0+mCDDGICKimoJG/s/+kxrySn5l/xb
         l7lA9MZn9eDjF4Tp6zbgl18FaUH+/XJlktSrln9DKAYdKzrd0rCJRjPSrUbMqNPVdX6m
         Zj7dn0/DAREjjMDYOzdR/4rOk3TBTkHoZvPiwQJm8uOvvk8DGXD2XHXORTnBP7L66d97
         9p7f7CVA2f33Gt2bX4XG0BCHNdvvWjoQzY1DgOXLU7yOFt5bz/V3Q9vneTPSkOt05dwr
         FTQA==
X-Gm-Message-State: AOAM532yRWzIPbuHuDYwDwPiiMMquF7azEBfraGz//of3E8DDRFMKdNL
        wm+8NoIWYaIONp56TFhgNgwJfC6Hp4LfN6Iw
X-Google-Smtp-Source: ABdhPJxdjJCdqW629v23plgurA+QvksAwBIP2TujaN3Ndy7322aDGBqv0j2dbGqFYvbwloTlx5V57A==
X-Received: by 2002:a17:90a:a96:: with SMTP id 22mr6337223pjw.200.1617850860928;
        Wed, 07 Apr 2021 20:01:00 -0700 (PDT)
Received: from kali ([152.57.40.190])
        by smtp.gmail.com with ESMTPSA id c25sm21993738pfo.101.2021.04.07.20.00.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 20:01:00 -0700 (PDT)
Date:   Thu, 8 Apr 2021 08:30:57 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8712: matched alignment with open parenthesis
Message-ID: <YG5x6QOmkQDSM7At@kali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aligned arguments with open parenthesis to meet linux kernel coding
style
Reported by checkpatch

Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
---
 drivers/staging/rtl8712/usb_ops.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8712/usb_ops.h b/drivers/staging/rtl8712/usb_ops.h
index d62975447d29..7a6b619b73fa 100644
--- a/drivers/staging/rtl8712/usb_ops.h
+++ b/drivers/staging/rtl8712/usb_ops.h
@@ -21,9 +21,9 @@
 void r8712_usb_write_mem(struct intf_hdl *pintfhdl, u32 addr,
 			 u32 cnt, u8 *wmem);
 u32 r8712_usb_write_port(struct intf_hdl *pintfhdl, u32 addr,
-			  u32 cnt, u8 *wmem);
+			 u32 cnt, u8 *wmem);
 u32 r8712_usb_read_port(struct intf_hdl *pintfhdl, u32 addr,
-			 u32 cnt, u8 *rmem);
+			u32 cnt, u8 *rmem);
 void r8712_usb_set_intf_option(u32 *poption);
 void r8712_usb_set_intf_funs(struct intf_hdl *pintf_hdl);
 uint r8712_usb_init_intf_priv(struct intf_priv *pintfpriv);
@@ -32,7 +32,7 @@ void r8712_usb_set_intf_ops(struct _io_ops *pops);
 void r8712_usb_read_port_cancel(struct _adapter *padapter);
 void r8712_usb_write_port_cancel(struct _adapter *padapter);
 int r8712_usbctrl_vendorreq(struct intf_priv *pintfpriv, u8 request, u16 value,
-		      u16 index, void *pdata, u16 len, u8 requesttype);
+			    u16 index, void *pdata, u16 len, u8 requesttype);
 
 #endif
 
-- 
2.30.2

