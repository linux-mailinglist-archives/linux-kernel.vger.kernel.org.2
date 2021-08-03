Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F263DE3AC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 02:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbhHCAyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 20:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbhHCAx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 20:53:59 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27D5C06175F;
        Mon,  2 Aug 2021 17:53:48 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id b13so12541608wrs.3;
        Mon, 02 Aug 2021 17:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=6tj/BGDafQ8lrxdJ2t8l1OedOVwRD/dAn1LAouPasMU=;
        b=EBs7lZtEVyqVB6Z9ged4Gm/+67A6At6Ie8Er/qkz7v6EoGss2bj52/DobpH2qpAesL
         0I9JcZUl1sfOLJDLhpi9rqyR/a7+Ysw8sDlrQO7ViQEu/h/uoYkwu+X51+bkJRdJH/Ld
         0nCXWOdOcLQPdJ+n5fS9dWOsEVwLHTwAqB5B0loxt6u532Apw8sQmTjNV+7+tHK0eQwo
         OZxEXO6gJ+FQ6ydiPWXS+DxLz91Plf9psksJa3fxXiRGE5i3mSOqQVS1uxDeW9LkspVu
         Xhi8a44+09szEx9VZZ/9SLn7KDnRLmPQjhAfHs3Gkn09v6urJOxHvQpy+T4JLlA0p5Gf
         qhPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=6tj/BGDafQ8lrxdJ2t8l1OedOVwRD/dAn1LAouPasMU=;
        b=bSXgE6bAYm608MMIAGZqn/BcAVXlPzW9gN6lIVTsqAXQJ0X1A5qhy2ROT1xbx65rI/
         kTalclu0VaD08pU+qx3DfnG4F/zlitXcX0sRz7uRjMSsQFlCi6CaxjdSquwpvhim7P/C
         B2SZDhOm+VwZjhpgbzQ4I+ILdthTFAAcZCAnTw1CK/klIWzmRFhcSx4sLkBgXyNfOVRM
         uTXl0sqnws3+QfUVrlSOjk67vwHAdlygNquUPViHSPtE7FtwyidWkhCsPY7JJffcEbfu
         3Q0Ax1kqhEDOuUgFGJUhX/6RRYcozNVhmB69aYg104lfnPm/niduCL9IZ9KHaxCg0p9d
         kGeg==
X-Gm-Message-State: AOAM532jK9kXP1Q8QHFSG223OY+zoiVTO82z4pQB4eSEfztMRhtc1Tas
        j9XrYdPXpWSGwE+MLoM2S0E=
X-Google-Smtp-Source: ABdhPJx5nwiOrVtl31n/MDa57wRh+jvoj52WtLAgtPjQlOxPPoVsHVbG5D4vvYzTNVK9Zai6D8uwgg==
X-Received: by 2002:adf:f64b:: with SMTP id x11mr19929406wrp.155.1627952027267;
        Mon, 02 Aug 2021 17:53:47 -0700 (PDT)
Received: from pc ([196.235.140.151])
        by smtp.gmail.com with ESMTPSA id w13sm12635701wrq.91.2021.08.02.17.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 17:53:46 -0700 (PDT)
Date:   Tue, 3 Aug 2021 01:53:43 +0100
From:   Salah Triki <salah.triki@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Malte Deiseroth <mdeiseroth88@gmail.com>,
        Oliver Neukum <oneukum@suse.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: misc: adutux: use swap()
Message-ID: <20210803005343.GA1578854@pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use swap() in order to make code cleaner. Issue found by coccinelle.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/usb/misc/adutux.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/usb/misc/adutux.c b/drivers/usb/misc/adutux.c
index 6d15a097b007..ed6a19254d2f 100644
--- a/drivers/usb/misc/adutux.c
+++ b/drivers/usb/misc/adutux.c
@@ -394,13 +394,10 @@ static ssize_t adu_read(struct file *file, __user char *buffer, size_t count,
 			spin_lock_irqsave (&dev->buflock, flags);
 			if (dev->read_buffer_length) {
 				/* we secure access to the primary */
-				char *tmp;
 				dev_dbg(&dev->udev->dev,
 					"%s : swap, read_buffer_length = %d\n",
 					__func__, dev->read_buffer_length);
-				tmp = dev->read_buffer_secondary;
-				dev->read_buffer_secondary = dev->read_buffer_primary;
-				dev->read_buffer_primary = tmp;
+				swap(dev->read_buffer_primary, dev->read_buffer_secondary);
 				dev->secondary_head = 0;
 				dev->secondary_tail = dev->read_buffer_length;
 				dev->read_buffer_length = 0;
-- 
2.25.1

