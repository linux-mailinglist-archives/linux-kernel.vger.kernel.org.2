Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC63031E857
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 11:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbhBRJ5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 04:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbhBRIyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 03:54:19 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89199C0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 00:44:42 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id p21so708568pgl.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 00:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A8UH8Y8lnFDky7j02NHxVDP5/IqVpxpPoD+z++23Jjw=;
        b=KcPhApM8QnfE4f6XhayOfxpNYtpLFoBj4X6Q50ax20kEpve+i2AY2e7hE+/RvDRK94
         G1079KlZZE+OeMHGr56EnqRiIY7hsaait//CumGNLzc2dzjOZ1XFqxxXNoZM3BZYst5v
         rS4N3BdRHSou9HQSO+sDhsPcogyRhZRN6KPiSyir0Beo26QXjdXQZwC0Wk0BRLTccwKN
         MpWs4HgGExNeIMGrbco2wT1lbefbHeyFQol17vD+cX+B7wLlrHmFQhvJxzsRmtchR4CM
         +5TofU5YQ+gC4PYHRllmnAS7hoTAunscoPFiQePc8diCok1A//q+GNdwAizix9wNTr8c
         cXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A8UH8Y8lnFDky7j02NHxVDP5/IqVpxpPoD+z++23Jjw=;
        b=B7B2hLRzwl6JX+qJJ5VAFcMfP67ywyaxAvU8I0bX2cJ4xGjdXKrNgHxEdQh/eZdC4z
         m/ys36qB4uuB1LsWrLpcgNKQfllXvGZhvynNcp0REGbBPGJTicTqB4/vAbT2NzKjh21P
         0+eqMXkL1s5+wuYA+VbXAgi8oVuoVI2t7jzciXX6KHLoDrbQuaBVLXISxILSVFqHIW8i
         Kx8/gLlPep5UnAUsldfxNA6ouerGoDQw7envKCLAXdwgGGJAhrfN6mOaBK509k2XnQ3G
         9Ux178NjA5IhX+eQ/w1eTxdXmn50LJ3rT8oakTnsnt8HvqaHfhUEFmNKOxouDRdH460Z
         aHvA==
X-Gm-Message-State: AOAM533OVamwUSIlkkT1t+m7w6dMPGLzwNSzttCfa0ZFLZ4btq/ZAfNM
        ArHJAFWlHkQCjkFhCMH/gIQ=
X-Google-Smtp-Source: ABdhPJw8yyKBD2DR0EjYn0UoijXcz7jeuCoHRYAwEUJcFfGRh1Fv15rr4596TMoqt4RVchZmyV8coQ==
X-Received: by 2002:a63:e64e:: with SMTP id p14mr3120255pgj.374.1613637882213;
        Thu, 18 Feb 2021 00:44:42 -0800 (PST)
Received: from localhost.localdomain ([106.200.12.142])
        by smtp.gmail.com with ESMTPSA id u20sm4941761pjy.36.2021.02.18.00.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 00:44:41 -0800 (PST)
From:   Atul Gopinathan <atulgopinathan@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     abbotti@mev.co.uk, hsweeten@visionengravers.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Atul Gopinathan <atulgopinathan@gmail.com>
Subject: [PATCH v2 2/2] staging: comedi: cast function argument to expected type (void __user *)
Date:   Thu, 18 Feb 2021 14:14:04 +0530
Message-Id: <20210218084404.16591-2-atulgopinathan@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210218084404.16591-1-atulgopinathan@gmail.com>
References: <20210218084404.16591-1-atulgopinathan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resolve the following sparse warning:

drivers/staging//comedi/comedi_fops.c:2983:41: warning: incorrect type in argument 1 (different address spaces)
drivers/staging//comedi/comedi_fops.c:2983:41:    expected void [noderef] <asn:1> *uptr
drivers/staging//comedi/comedi_fops.c:2983:41:    got unsigned int *chanlist

cmd->chanlist is of type (unsigned int *) as defined in
"struct comedi_cmd" in file drivers/staging/comedi/comedi.h

The function "ptr_to_compat()" expects argument of type
(void __user *) as defined in include/linux/compat.h

Signed-off-by: Atul Gopinathan <atulgopinathan@gmail.com>
---
 drivers/staging/comedi/comedi_fops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/comedi/comedi_fops.c b/drivers/staging/comedi/comedi_fops.c
index fc4ec38012b4..8b2672c3c408 100644
--- a/drivers/staging/comedi/comedi_fops.c
+++ b/drivers/staging/comedi/comedi_fops.c
@@ -2980,7 +2980,7 @@ static int put_compat_cmd(struct comedi32_cmd_struct __user *cmd32,
 	v32.stop_src = cmd->stop_src;
 	v32.stop_arg = cmd->stop_arg;
 	/* Assume chanlist pointer is unchanged. */
-	v32.chanlist = ptr_to_compat(cmd->chanlist);
+	v32.chanlist = ptr_to_compat((void __user *)cmd->chanlist);
 	v32.chanlist_len = cmd->chanlist_len;
 	v32.data = ptr_to_compat(cmd->data);
 	v32.data_len = cmd->data_len;
-- 
2.27.0

