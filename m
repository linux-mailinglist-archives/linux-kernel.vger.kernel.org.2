Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99129358271
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 13:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbhDHLvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 07:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhDHLva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 07:51:30 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071B0C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 04:51:18 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id p12so1219836pgj.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 04:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=i9s9BkLvRdlumIZwdRHabgMYGpHTAnHPSYT3zj0wSJ4=;
        b=Rz7Wb35MSnfgOdBmx+0oOrmFk7TaMhak5y/1PKg7A63DQqMc7bao3B4L//s4n8ViUB
         My65OmynzFNM0EP1ctF+nOY97dx7RnG0yWcpVP2/PnP+qSVHsRW2PTCt+JpM50qjW96F
         e7X0Km1r3NN7MRrafpZ3sAFD0LNoyzhiagsdpP5ZSk5GYqczy8F1cCVHPDk3PCL/co7U
         YNXHyLekJyiH/HKKbxNpVdAzgUTzJ4cue9/jfofhYGit2btwMVKhIePRBe1x/DjGX6Ca
         rqAR/1lVp05cyQrOPRTHLmY4dgXxAmF/y7synx2PzBxX32pd3ebaQ/wf9q9ne0uHCowO
         Zxzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=i9s9BkLvRdlumIZwdRHabgMYGpHTAnHPSYT3zj0wSJ4=;
        b=GtlHGj0SfftgIA5pEO/4awu6/k9iySAUJvw3joq/kIBtumBh2Lqr51+SooCUk+vP70
         i0kJWdXzq6s6t20CnxcUawE8cDqOrNZmkYcIbsbpiFfa961VbzarcbVJSGQh+zfb/OP6
         UYzZuLrttGJ3IKsJO4xG2Tk89hfyNzgN28l7XFFWpVAG0XXkkq8Nk2P09tzt6DuU/1im
         UoXEf8kov1mt/5NnIfaiVn61xYuND1gdlUmxUBalx1c3TIsr6dMzh1OD/WgwGxqTxQhM
         sYwc0NU5iS6sGxfA9PMesRkXYgpcdcltLm77yUrjEDRNPyI2tPYchjr2ThMuuFcqYStP
         ggVA==
X-Gm-Message-State: AOAM533L38a0aNUN1/XSuYLH2wMkfqY7GHIzSLgg25gZ40/ODETsGnCt
        L2pKpfY8rX4SnJ/k/+LZejA=
X-Google-Smtp-Source: ABdhPJzR3XqFhA1vwKnkhKlm5OxIy/0gKl/K1Z+6z14beckg1VSoE/A+MPHleyo6rAYfpRyqqOaMiA==
X-Received: by 2002:a63:d153:: with SMTP id c19mr7601140pgj.311.1617882678294;
        Thu, 08 Apr 2021 04:51:18 -0700 (PDT)
Received: from kali ([152.57.11.236])
        by smtp.gmail.com with ESMTPSA id c9sm22688550pfl.169.2021.04.08.04.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 04:51:17 -0700 (PDT)
Date:   Thu, 8 Apr 2021 17:21:09 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: [PATCH v2] staging: rtl8712: add spaces around '+'
Message-ID: <YG7uLQLGmAh97xB1@kali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added spaces around '+' to improve readability and adhere to linux
kernel coding style.
Reported by checkpatch

Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
---

Changes from v1: No changes in the code, but only to subject description
and patch body. 
Changed the subject decription according to PatchPhilosophy and made
patch body more clearer.

drivers/staging/rtl8712/wlan_bssdef.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/wlan_bssdef.h b/drivers/staging/rtl8712/wlan_bssdef.h
index b54ccaacc527..ec3749813728 100644
--- a/drivers/staging/rtl8712/wlan_bssdef.h
+++ b/drivers/staging/rtl8712/wlan_bssdef.h
@@ -176,7 +176,7 @@ struct NDIS_802_11_WEP {
 #define MIC_CHECK_TIME	60000000
 
 #ifndef Ndis802_11APMode
-#define Ndis802_11APMode (Ndis802_11InfrastructureMax+1)
+#define Ndis802_11APMode (Ndis802_11InfrastructureMax + 1)
 #endif
 
 struct	wlan_network {
-- 
2.30.2

