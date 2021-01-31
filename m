Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 302E1309E6E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 20:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbhAaTzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 14:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbhAaTgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 14:36:13 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B42BC0617AB;
        Sun, 31 Jan 2021 09:32:27 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id s23so9152003pgh.11;
        Sun, 31 Jan 2021 09:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KL4ClHuz/7I8c1v93iqBuHCJ0LGBrBIt4lTt0h3HcoY=;
        b=N/B6V8BD5XiYvAupdqW1vbawkg3gyLvdAlZeMM0bF/xLOQGjMnDlOWSSkBZFul0+f5
         EP7QtNlUMFjALXak6Sx5W/LhQa8wUdSw2zzV814nawqfyffFp/qzHxk5oFDD6LvxhwNC
         KuSBJKr5QRBMUi8quKx2XQA6OahBrMn1fCrb+5AzTrcXPfhieGh3yelskc/1ShXYudWm
         mpfa/YeCPiJGRU9Fvc+eAnLd7rkgNuPbq8cbM6hchVCZYs055YHO2nTXx4SybPNyHmhE
         hc5ykRlg+XSnQtHL/8NcEqkoeVrLLMWUj9I0NvDGNSv5BuvZUymDt0LKcmlBYwPKVwHe
         gUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KL4ClHuz/7I8c1v93iqBuHCJ0LGBrBIt4lTt0h3HcoY=;
        b=F8nnL0DcHgpS5flvK+RApQICLKbLwraXysv0TWS5P4CFBHJpGXCO9a5ZpCcgQSxGJY
         GnSfwI8sn2Cwpsa26DDHj7vL0i8XlRSBEDO9NZDQxoNUdTlodn57k+9uQao0T1DlNff5
         KaTcLIz2+IWn9/lnRIC1NqAzrjUgrQ3U6zUwd8fSWtXeT8cPMGdLu2UwsQtv/MT8N+r6
         +AGMEJESTDoSQ/dis6sWqEZfRyYSxpgCfLY0XQvf4/w6OrVU3WQpk6ExK5WwZ6nwQAlP
         VT5lpUaaJHXZ5A7chKq41uiBQfBlYymX02KHuz23raJipW5vK+HAbHiRxp9qdG61eurJ
         o0ew==
X-Gm-Message-State: AOAM532IWy0Rr5kXxbS+AUSxHKYFHR7Z/RDkYC7JBFNcMgIAqdlp6iRl
        HtjbD3STyl7YldoLyybQjSAe8Xi5YB91oQ==
X-Google-Smtp-Source: ABdhPJzABChOsNRDUCRWU+Gq8jzbKzxAgBkonx70PABubyLmysiQb+CwOj4WPPSnTZHh1di8jIFoFQ==
X-Received: by 2002:a62:aa0a:0:b029:1c2:1baa:eaea with SMTP id e10-20020a62aa0a0000b02901c21baaeaeamr12833472pff.52.1612114347133;
        Sun, 31 Jan 2021 09:32:27 -0800 (PST)
Received: from localhost ([2402:3a80:11ea:e144:a2a4:c5ff:fe20:7222])
        by smtp.gmail.com with ESMTPSA id b24sm1597174pjp.12.2021.01.31.09.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 09:32:26 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Ioana Radulescu <ruxandra.radulescu@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Marc Dietrich <marvin24@gmx.de>,
        Jens Frederich <jfrederich@gmail.com>,
        Daniel Drake <dsd@laptop.org>,
        Jon Nettleton <jon.nettleton@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Rapoport <rppt@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Robert Richter <rric@kernel.org>,
        William Cohen <wcohen@redhat.com>,
        greybus-dev@lists.linaro.org, ac100@lists.launchpad.net,
        linux-tegra@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 08/13] staging: rtl8188eu: Switch from strlcpy to strscpy
Date:   Sun, 31 Jan 2021 22:58:29 +0530
Message-Id: <20210131172838.146706-9-memxor@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210131172838.146706-1-memxor@gmail.com>
References: <20210131172838.146706-1-memxor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strlcpy is marked as deprecated in Documentation/process/deprecated.rst,
and there is no functional difference when the caller expects truncation
(when not checking the return value). strscpy is relatively better as it
also avoids scanning the whole source string.

This silences the related checkpatch warnings from:
5dbdb2d87c29 ("checkpatch: prefer strscpy to strlcpy")

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
index 6f42f13a7..bf22f130d 100644
--- a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
@@ -1865,7 +1865,7 @@ static int rtw_wx_set_enc_ext(struct net_device *dev,
 		goto exit;
 	}
 
-	strlcpy((char *)param->u.crypt.alg, alg_name, IEEE_CRYPT_ALG_NAME_LEN);
+	strscpy((char *)param->u.crypt.alg, alg_name, IEEE_CRYPT_ALG_NAME_LEN);
 
 	if (pext->ext_flags & IW_ENCODE_EXT_SET_TX_KEY)
 		param->u.crypt.set_tx = 1;
-- 
2.29.2

