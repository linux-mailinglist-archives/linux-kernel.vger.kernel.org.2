Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A218359B94
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 12:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbhDIKNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 06:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbhDIKE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 06:04:59 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A6FC0613B1
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 03:02:02 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id hq27so7714955ejc.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 03:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g5fH5MF8Mh/cdom53aeKYjv6Ynby/OWeuuO+jFx6DpI=;
        b=q60mapN4fJd9Pmbhf0k9KGgtMsKHpTz2t5ajYkALWBibGJUdD7BCTNpq8c18qiEynH
         w+J7XwFXdsndH7Ayy0mfY8xyu3TplReHLRKUUqK5/AD9+fVdiQVFSR4KBr+eiwBbVD2n
         skoCqnlm0+I/4hXEw0WNUZLy+E8gl/TNsywuShk8Mj8n+WYrTN7U0iUJd0yJoO/YW0vm
         sSOgFuqoOpgAJ6ZQxn9xGpXZLzAeGcuCYOnv5qfiCujFhrIelc8WnQtIOD3bsOzlnhcH
         N1v5sYQlYE714XeahYBjHqhbC92rk4A1okNwZGtGes9sCozNi0M2gDmTCTWdFbQ6oJka
         OOzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g5fH5MF8Mh/cdom53aeKYjv6Ynby/OWeuuO+jFx6DpI=;
        b=Y2V9F24H8l91JRSfzZ/nEIEHWCscjVKC78HL5EOWx6dYqAxrvh1+el1j4w6h4nEL+u
         DGLUNPIpgpkSJ8BUD9pa6kqbZ7k0hlfk0U+un9WDJnTPJ2iynuniH+gEPjx1UXlUef15
         KbKQOkGRD1QtUwOabUn5cRak8QwuAIbyFl+MoDuMB0V8cA58oOmQelNJUaOUCtiMCqdG
         WWSXkjmrkf9BIFYJEVQCPSEhoJBABR0AvzE9funUq6vigTRGcSA5Pgv0bXjyoYtKMTXV
         wPseGWUqkYklLqducnzk0sOOJh6NTv39YKS4wXmLl6peeO8+JFwyb/ztpbhHYrzKzull
         m57w==
X-Gm-Message-State: AOAM532zXn6A+9QqavTx9iWfpF6GX4Nd3xQxccjbDOrswdYJufnJy2y0
        hhD0TNjqfsXZoupo5E4hEag=
X-Google-Smtp-Source: ABdhPJxHLRn1GnLyWTZlMJAJO7Xb2HrKjS4S/VwhUsswIruhrzreobdYhw3LFNXS3gDgbkNgVc9YnQ==
X-Received: by 2002:a17:906:b296:: with SMTP id q22mr15272496ejz.161.1617962520751;
        Fri, 09 Apr 2021 03:02:00 -0700 (PDT)
Received: from agape ([5.171.72.173])
        by smtp.gmail.com with ESMTPSA id bq18sm974563ejb.27.2021.04.09.03.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 03:02:00 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 08/11] staging: rtl8723bs: remove unused pmlmepriv variable in rtw_dbg_port() in os_dep/ioctl_linux.c
Date:   Fri,  9 Apr 2021 12:01:36 +0200
Message-Id: <e8a31937b0075162104347e1c8ecc5e6d079f6d2.1617962215.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617962215.git.fabioaiuto83@gmail.com>
References: <cover.1617962215.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused variable. Fix W=1 compiler warning:

drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:
In function ‘rtw_dbg_port’:
drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:2444:20:
warning: unused variable ‘pmlmepriv’ [-Wunused-variable]
  struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 2f215e5e28b0..0ff6fbbb4e4f 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -2441,7 +2441,6 @@ static int rtw_dbg_port(struct net_device *dev,
 	u16 arg;
 	u32 extra_arg, *pdata, val32;
 	struct adapter *padapter = rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 
-- 
2.20.1

