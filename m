Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC56438EA6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 07:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbhJYFMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 01:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbhJYFML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 01:12:11 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D5EC061745;
        Sun, 24 Oct 2021 22:09:49 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v17so9155510wrv.9;
        Sun, 24 Oct 2021 22:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=//SRG6POY3bT3QCKeIqmkxs8hlmmaajtIGEz2pM5OXQ=;
        b=U0d9S582b2PwDZuCydPICzITeVJvPzJyT3DS864vryvNUklVTNnUWL7Xmz7ygsGf6B
         etQOajIznmvYDGYMA7Oub+6IWSZ1VDde+ICe+f8B0cocMMsqtyB19lS0YyUzhxR94/S1
         HgKDd6lQHbESrg6Jk+oESpXLnpjKT5M/r837HFTxcdKm/KsN5SIann90DN/VaZU+E9Y9
         2EIimyXJjNdYiZAvIpYr8LrKOS+vd+7EtkoY3I3fxAz6/BpdP6F+/w2mCltP2Fe3xHem
         EpEXJNJ0AKUq3tL5xpIEcKKN423ly0LDIDZTKaPzLPSGrD3A33KINT7ieyzkwtWI1fDN
         QvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=//SRG6POY3bT3QCKeIqmkxs8hlmmaajtIGEz2pM5OXQ=;
        b=nILwJhSyxeWy5+dcKeC4PvCLTGFwTl4z6YMvFnqUFSGpf7z2jd7qQZyG1FQ0e4vdxY
         NIS9loDTzfVYnlQaCzQdOp6S5b/X46QgwcF3VzUNWI0DQHhxsoen9dMFYgT7s0Cqa416
         AQ9PTbiUqkf8T3pU0rZoNl3fnkRaPKSQoSeeyQVF0IYeOfIEMxBkExX8U5TctUMpMz2M
         aafo5XN1t+xZXfCiU6+kacsEqQBj+26EwQ6JuzsYAkpdeevpWaDy/ZURWSfOJnoxp7V6
         Cv3o1ThaebTT2wD3tBh4fyksQ0oYt/RCwqzEO/nQNzE52MXvqQKGD/XCKW9lw6dWFcY9
         ZwnQ==
X-Gm-Message-State: AOAM530lTe8Jsk+IsPmIhPqF6Wm9wSP249Qj9qwRjL2LSIsZKiEioJgL
        TAhAHHoFB4tluDaGJFjWt9Usha4TZiE=
X-Google-Smtp-Source: ABdhPJyTwExh5bG7cfzAyzzGJo5AlD5hj3m8bnsTAJsePiPukbzfNfzac96yvIYfzIYKIST1f9IOLw==
X-Received: by 2002:a5d:4b0f:: with SMTP id v15mr20290573wrq.313.1635138588297;
        Sun, 24 Oct 2021 22:09:48 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p200300c78f4e06658ca10b404d232775.dip0.t-ipconnect.de. [2003:c7:8f4e:665:8ca1:b40:4d23:2775])
        by smtp.gmail.com with ESMTPSA id f1sm11012708wrc.74.2021.10.24.22.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 22:09:47 -0700 (PDT)
Date:   Mon, 25 Oct 2021 07:09:46 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org
Subject: [PATCH 1/2] Docs: usb: update struct usb_driver
Message-ID: <8084ad0e369d4e0bf10598292ee4bac46d09d03d.1635138058.git.philipp.g.hortmann@gmail.com>
References: <cover.1635138058.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1635138058.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update struct usb_driver from usb-skeleton.c.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 Documentation/driver-api/usb/writing_usb_driver.rst | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/usb/writing_usb_driver.rst b/Documentation/driver-api/usb/writing_usb_driver.rst
index 2176297e5765..a511c6fecf96 100644
--- a/Documentation/driver-api/usb/writing_usb_driver.rst
+++ b/Documentation/driver-api/usb/writing_usb_driver.rst
@@ -57,9 +57,12 @@ structure. The skeleton driver declares a :c:type:`usb_driver` as::
 	    .name        = "skeleton",
 	    .probe       = skel_probe,
 	    .disconnect  = skel_disconnect,
-	    .fops        = &skel_fops,
-	    .minor       = USB_SKEL_MINOR_BASE,
+	    .suspend     = skel_suspend,
+	    .resume      = skel_resume,
+	    .pre_reset   = skel_pre_reset,
+	    .post_reset  = skel_post_reset,
 	    .id_table    = skel_table,
+	    .supports_autosuspend = 1,
     };
 
 
-- 
2.25.1

