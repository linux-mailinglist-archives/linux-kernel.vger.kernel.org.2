Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 581DD4381F8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 07:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhJWF2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 01:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhJWF2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 01:28:01 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807B4C061764;
        Fri, 22 Oct 2021 22:25:42 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id a20-20020a1c7f14000000b003231d13ee3cso6003217wmd.3;
        Fri, 22 Oct 2021 22:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=VoXUsfUGCdD62DajcXC9f8MFNVK93WpYf6qTnnAOaN4=;
        b=Q46XNOIc18yeGmnm2TF48VMCfMM5b/pXedvJTpDxABJnnvrG4qrW4jqnaXbzPfU4nv
         fYSAQNaFsIzGRZf0oqIwhflvqRHvqnRNoBjAs4OVxOyjADPSt2OiQWgmFWWnz3VBXb1s
         aJPheXyvszKDJ7Wuplbp/lhp/bC/kckJkIFKwxZnx7cJP8B6LygrIlyeJr39COzHOQRr
         hJwsKMFOwux4bZcvf9VaaE8Ed2Wi9HVnjm70iZFDN3lcmisZ7Yj9yotBLcYQ2GNzDbr1
         gOHdcJnKeu/budC8uRchG4Brt9ls75YWdxGFy3FZpVe/p+xvgak2yaWh3gccjQys2Qj/
         lM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=VoXUsfUGCdD62DajcXC9f8MFNVK93WpYf6qTnnAOaN4=;
        b=xEP6Dv2Yr2Vn42V3VHWPRQcpnzpgbSXk6nXklMs3kzgpshZ3Jh4lfkAe6n38B7IFfi
         ltE8/57nLX2KQzwgEtdv8j04vDoOdQw+17QnJ5reRtQ1KJjjIVWP2n4D3XWlbojCK22C
         gNbRUnDLU2tVyLSP1un1QT1zAxzX4Xp7Op9R1SRvmxC/UlPsXtJ1187RwH2VBhQLGHBc
         salxxvtVSYwxyBvwG85DUP4czUAwnzPom34hz8hnTeOtw+d0CpAyPyBXKlWqzFj3Uzyk
         8mbO1bw4wgDSaqH9srq1BnpHfJ9m3vFJU8I05vyZ98Q66sz+2BNwmKYgFZPGA7dFUE+W
         xbWQ==
X-Gm-Message-State: AOAM530X6lCNjJG2KXYOGcWC9JTjdGOpLksaUkU7R4r42RcFWyK7B+8E
        wVkvGNaOMgWqhZf3bX7C1D+tspibYRw=
X-Google-Smtp-Source: ABdhPJxD6m3qDi/ax4mGEPWfA3bL6AAPxxcKQbYmLCupu3G47U6G3xBzqVz8QvwNNLKUYlhcm9Qz3w==
X-Received: by 2002:a05:600c:1c21:: with SMTP id j33mr33891037wms.163.1634966740997;
        Fri, 22 Oct 2021 22:25:40 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p200300c78f4e0684ec383d1d224ce07d.dip0.t-ipconnect.de. [2003:c7:8f4e:684:ec38:3d1d:224c:e07d])
        by smtp.gmail.com with ESMTPSA id t6sm4112221wrw.78.2021.10.22.22.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 22:25:40 -0700 (PDT)
Date:   Sat, 23 Oct 2021 07:25:38 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org
Subject: [PATCH] usb: usb-skeleton: Add hint to find __init and __exit
Message-ID: <20211023052538.GA5141@matrix-ESPRIMO-P710>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Comment to find __init and __exit.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/usb/usb-skeleton.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/usb-skeleton.c b/drivers/usb/usb-skeleton.c
index 2dc58766273a..80338a50dcde 100644
--- a/drivers/usb/usb-skeleton.c
+++ b/drivers/usb/usb-skeleton.c
@@ -641,6 +641,7 @@ static struct usb_driver skel_driver = {
 	.supports_autosuspend = 1,
 };
 
+/* __init and __exit */
 module_usb_driver(skel_driver);
 
 MODULE_LICENSE("GPL v2");
-- 
2.25.1

