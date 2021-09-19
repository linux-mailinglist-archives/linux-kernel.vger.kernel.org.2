Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB4A2410DE5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 01:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbhISX4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 19:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbhISXzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 19:55:39 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0F3C061766
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 16:54:12 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id n10so53226610eda.10
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 16:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wRB+dn+G7DU/01+RXlsX/eYdlXKVOcULOeR8KEA1XlQ=;
        b=VXdST4ScdMYP96cMxnuLmsszEFhSFjXxAwlokUVFqXxXt8nekjcDl21jB4kuwkhWVp
         4hpzWnvgEE4vLkNpGfms+XN35g63zDLxmcRYMpYYkKoKvNNT393h7f2tAgoxDdwTOC0O
         wDg/dakIikWYYZ86A1Mc5tj+XA/zG+a4f4/TVZ/hwtNjXcBoYS92SCxiH9x8XLffFXHW
         zr6UCG3JZYLKMOm62B6uwKQxg1wbEFQiyUJGLId6vMnelbld9wYLuH/T/AAYPEHRpoQG
         koOpH5I883aq5Hlg6r9weWLcylBfaIa9fA27icpTOGvPXQCsTJE6afv7jgKmGWaSQYCY
         iHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wRB+dn+G7DU/01+RXlsX/eYdlXKVOcULOeR8KEA1XlQ=;
        b=dSMqYJaiDOpfZkEcU3AUBstJkcUh1AXbQdOBCuy0nsmtxhQNkXPxjYKAOVuGKC1KvR
         jxvN5DykFBptVYGtjH8fdxypFDDQdOHHzj/cVSjGE3eYIDrQ9SspDDixus6muFvLp6/R
         suJekqjJMgzEXocofpXbt/7DcfN5juDyrmvez2xw3GA9qbM6hJpt7dDpUCQ/IUuDQ9H6
         YENVnC8Gjh5FWACiSCne9GNe1DlAAM0BGpeDl3vJ+DQDDElMlUtkQCD+191yy9ypNDU9
         32XAJ31mnsfIzbmYY4CwHGS8BFmxl0Vv/beDe5KRLAOow00Fp+elA6NVPTuASfTML39U
         FTRw==
X-Gm-Message-State: AOAM531Lz+9q0Y6maja0gF84scX+25l7L5LikJNOApaxtQmGRg3E8lqf
        iJ/zD2/YN1y34X0G42PhspY=
X-Google-Smtp-Source: ABdhPJzqOh4qKksuTrwmwrqW9Vx/IX3pJWgtLq6ZCCNr1ccrSzA7NfPG1T0Ja/lqCyfMuDfNieajrw==
X-Received: by 2002:a17:906:2cd6:: with SMTP id r22mr24871505ejr.398.1632095651555;
        Sun, 19 Sep 2021 16:54:11 -0700 (PDT)
Received: from localhost.localdomain (host-79-47-104-104.retail.telecomitalia.it. [79.47.104.104])
        by smtp.gmail.com with ESMTPSA id e11sm5353636ejm.41.2021.09.19.16.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 16:54:11 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v8 07/19] staging: r8188eu: remove unnecessary comment in usbctrl_vendorreq()
Date:   Mon, 20 Sep 2021 01:53:44 +0200
Message-Id: <20210919235356.4151-8-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210919235356.4151-1-fmdefrancesco@gmail.com>
References: <20210919235356.4151-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove an unnecessary comment in usbctrl_vendorreq().

Co-developed-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index a52aeb2558ad..fc3da0fbf474 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -73,7 +73,6 @@ static int usbctrl_vendorreq(struct intf_hdl *intfhdl, u16 value, void *data, u1
 				/* status != len && status >= 0 */
 				if (status > 0) {
 					if (requesttype == REALTEK_USB_VENQT_READ) {
-						/*  For Control read transfer, we have to copy the read data from io_buf to data. */
 						memcpy(data, io_buf,  len);
 					}
 				}
-- 
2.33.0

