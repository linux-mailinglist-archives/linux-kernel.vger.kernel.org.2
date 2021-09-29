Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4134C41C575
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 15:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344116AbhI2NXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 09:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344061AbhI2NXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 09:23:49 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD539C06161C;
        Wed, 29 Sep 2021 06:22:08 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id i4so10774215lfv.4;
        Wed, 29 Sep 2021 06:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZIfPPR8Y6M8QrZI7k+3qFY1C12hTObWlSZ7JR9t1bmI=;
        b=EJda13FMU2yNPpbk/oPlQIjSYPvOZTbGShVXeUpjizmYGe2dgYBVx6y9ZrJXa6q0bf
         a0Nwomi2FNaq5epwxPxE0cJ41wRytWSZ1oHD/WRtHplIbXoV7VYXWvFYmQGAUmBBPawT
         xSrZRf4M4Klyu3aVe2zbTHriKXaCPdiWTKMhb1b8mTJbf/UA2yjYIsPKAPUMGPwD1sZj
         RLnJieZuXOJghL6u+BRROzigoEkrWOE+AfeZLN0q9+dur6v67AXwWIzaMcI9ajlz1zph
         wdCpCooz6wnFgvPGYqhKECChk35qBN7z2vGun0t6ZX/YFrEmOSslA9RLGPK1JgYUTtzQ
         kvcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZIfPPR8Y6M8QrZI7k+3qFY1C12hTObWlSZ7JR9t1bmI=;
        b=EWnTI3813lmaUrv89go2nA1PJCl5V3y4a9hXRn82bT1FWNk+H322hYk8FwVjDhNxQl
         2J248EApvO0KSTNWA50lc9PbK03bQqVBsmwZfY6P8xpSOB37Ye/EH9VeIhO0MjzxCQWp
         KNSe6qT6pFRhSgxC9jM33tv20wkYzpP0YqNy1tOpH6hS3yqgy6g1SQDCeJ1S1Z8b4Rfh
         As4zudT6sFQOVU5XhUqU4xRvFiJQWwFUF1zhYrSQlSdwa9FZG3E8UWVzcqv/0vIfjLsD
         QiAamlylWkzIKT99Q4kMEK9IzjnQNXM06Comp6A9fLoJXIPSRJsl5w6osYy5niYqA8hS
         LMuA==
X-Gm-Message-State: AOAM533mCebVoiB5qmMs1QqexQy/wyLoda2oW0dS+MI6dUi9CvFGICOi
        wVmxYk79pnWbhyaoNz8BfL0rtEvYlhc=
X-Google-Smtp-Source: ABdhPJx5S6sxUiSp6jR5sqnMbtsWT7cURKpnttNzWJ9X5bVR17VHfJdNoewHdchjxZ+aIBK400Lyaw==
X-Received: by 2002:a2e:a54d:: with SMTP id e13mr2233131ljn.159.1632921727113;
        Wed, 29 Sep 2021 06:22:07 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-228-193.NA.cust.bahnhof.se. [98.128.228.193])
        by smtp.gmail.com with ESMTPSA id z10sm283695ljc.117.2021.09.29.06.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 06:22:06 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Oliver Neukum <oneukum@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Junlin Yang <yangjunlin@yulong.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 0/2] usb: cdc-wdm: Fix config and constify
Date:   Wed, 29 Sep 2021 15:21:41 +0200
Message-Id: <20210929132143.36822-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes an wrong ifdef which caused a chunk of the code to
never be compiled, regardless of config selected.

While at it, constify a static struct full of function pointers.

Rikard Falkeborn (2):
  usb: cdc-wdm: Fix check for WWAN
  usb: cdc-wdm: Constify static struct wwan_port_ops

 drivers/usb/class/cdc-wdm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.33.0

