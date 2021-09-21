Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6E97412E60
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 07:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhIUFyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 01:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbhIUFyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 01:54:17 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4C6C061574;
        Mon, 20 Sep 2021 22:52:50 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id i23so35751657wrb.2;
        Mon, 20 Sep 2021 22:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=L66QhiZcUuwlRKorNm9Yc4Tr9VadEmevichCsHyMvjU=;
        b=lU46H28yfT0WqL1Ub2F2Dkq6JhjkVZTECeGntQqTHMLgvQkhu3Iey/mdXXTpBr+W46
         YaCXwn8ftw75hs29QrdQFMxE3WuQgCcFIwz9DaDN6zIm4caRTMB5h49np1iIQ6kyeBNO
         aVBhjR7jRTbzdubwFTiE7kgmJ3tbmjocBh1tpahTIlpjDUl4NNTRtL9me3j660UfR9q7
         0Llp6Vz7ZTtCLOJAgUavQrfchCb7NPrhI5lY1gOtg1KCY8CeFZXT9nF5H+ra0nu+ihOg
         IVw4gn3AxJb+y0RTx/WBtW2BsDLx/g095+j/02pzChkOUcfHk23PmsLCs8G1AyXOnQRt
         Iu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=L66QhiZcUuwlRKorNm9Yc4Tr9VadEmevichCsHyMvjU=;
        b=Peg88PHG8tSuI5wm35422CXSg/WjSOx5Te6zqQdQhRi8kSdNecQXzzhe4yxqqz+DQw
         YS+pAnC62pnPgrYcdYcXBc9/mnrl+dCyBwhSTcue7gP15flw05+WUokNSJQ0vq42Et4A
         D+qGLVI0YkrytRxy3S2PbTayFvF9P81NlLbsftRuP+2DJISN89WoXVtdEy8XaszUM7Ar
         eEfy6m54iQnkyNmipLmnXTckkuzif6zppfHRFrMYJ9YeIFoFQVvKZLQEZZdJRGs4EPpo
         UXFImjmT77/jgyjIwsHnl0zoiBfGbLMq+3GFXyyU+rATldZLm3V5Q2F4M90kzd2aTKix
         yHvw==
X-Gm-Message-State: AOAM5304K0Ry68FbNFqtwkN6jO+2dlCWD2QTZCIjwg83IDmjbp3RjLNF
        9/iihpdkDQqEnQ2lCyuznJF9AbVs2r8=
X-Google-Smtp-Source: ABdhPJwPzZ0TmdPyNHqt6C1ICdsIICxZ3w1bvAH6leVeLVMsvnEmLCSVs1UpnyA3DW5CE+nwCdvrGQ==
X-Received: by 2002:a05:600c:a08:: with SMTP id z8mr2605869wmp.52.1632203568672;
        Mon, 20 Sep 2021 22:52:48 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p200300c78f4e0664ac59f2d108a8bc41.dip0.t-ipconnect.de. [2003:c7:8f4e:664:ac59:f2d1:8a8:bc41])
        by smtp.gmail.com with ESMTPSA id d2sm17897251wrc.32.2021.09.20.22.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 22:52:48 -0700 (PDT)
Date:   Tue, 21 Sep 2021 07:52:46 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Update min() to min_t()
Message-ID: <20210921055246.GA11535@matrix-ESPRIMO-P710>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl warning:
WARNING: min() should probably be min_t(size_t, count, MAX_TRANSFER)
+	size_t writesize = min(count, (size_t)MAX_TRANSFER);

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/usb/usb-skeleton.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/usb-skeleton.c b/drivers/usb/usb-skeleton.c
index 2dc58766273a..d87deee3e26e 100644
--- a/drivers/usb/usb-skeleton.c
+++ b/drivers/usb/usb-skeleton.c
@@ -363,7 +363,7 @@ static ssize_t skel_write(struct file *file, const char *user_buffer,
 	int retval = 0;
 	struct urb *urb = NULL;
 	char *buf = NULL;
-	size_t writesize = min(count, (size_t)MAX_TRANSFER);
+	size_t writesize = min_t(size_t, count, MAX_TRANSFER);
 
 	dev = file->private_data;
 
-- 
2.25.1

