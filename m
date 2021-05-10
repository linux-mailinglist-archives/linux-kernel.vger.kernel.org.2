Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E981378EF2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 15:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344877AbhEJNZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 09:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349479AbhEJNUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 09:20:49 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5C1C061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 06:19:37 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id l14so16610772wrx.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 06:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mYmyfdN9IRbyb1UDqQtdljWba9muih00OArIPxbSCPo=;
        b=mAhAk99Xq5F1y+Ub8X6v5P2fu1+97AFrQZLfMByYFJg0Ua6FXjj+U3NFg165q6G3Tr
         XgKu0p7I3qvT4kkMf4kyYywPnlSp/OKS6A6HccXqyXNv6LWSPui8WyiO7gNk7bf6cxZ8
         tDMzgj+/9TzTeg02aTNkmL+0hGYjTyIfKMm3zW7XYkQZIfTINBGtOw54WpsDTIO+oi4T
         KYXJeOU7RWPVGW2/TLDXhgbYqKow3ZOltJcGiGB+hyhE3/AEV1TkTSpWW68kJd1Qqzsh
         tgCBK+m7kh5+B06iHFAMLykeb4OrKbl0TtffBZ7FJtomlcuS8BZ/47SrTYWh/xOoHqDB
         XuGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mYmyfdN9IRbyb1UDqQtdljWba9muih00OArIPxbSCPo=;
        b=gozfA18Gtj5N8XNqt1YpKZpka6eGpRfE4D0M906GPB4XRFCo6X0pIZnG2yu7gvmxCv
         9HE+mGmaySmYnUElfnoBrEuzhsDYJwdBLumrENhwJitn4v3Fo40+qba8TNuLbvUjunxU
         bGPZk3n13+4hgytJ2+uUXd+lp3tn7SWzUyczCYBYcMEF+/pJARk8KStHQikbqkzMTffp
         MoP2NdSkjwzyvvogWnubaKPHei/C5ptpnSpfdKcuAxaFNOKulLPNohLvc+4xA0HF7Xqq
         K36XgKJoN4HCkFsoMsMtyGVLa7dX+8FeQJjNyEHqTHU1QNDayGpY6xkWAQQX2EBOSrvZ
         yVLw==
X-Gm-Message-State: AOAM531CChVfoTLNqA0/3Q5y1rXDa+aHUcG6cFgfkVAv2sjikZMEIE7a
        66Lf9BiwLuxg/Dsz10aRvpnqJuv06B6HYg==
X-Google-Smtp-Source: ABdhPJyAiJ3qBNdMiYw0WcPY1g+C1NTLb8VPhIZDexuVfakZIhEQ4BekXqBFhz8R7k9rRpeXkAunLg==
X-Received: by 2002:adf:ec02:: with SMTP id x2mr30360138wrn.35.1620652775635;
        Mon, 10 May 2021 06:19:35 -0700 (PDT)
Received: from agape ([5.171.73.3])
        by smtp.gmail.com with ESMTPSA id n2sm23230677wmb.32.2021.05.10.06.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 06:19:35 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] staging: rtl8723bs: use of generic CRC-32
Date:   Mon, 10 May 2021 15:19:31 +0200
Message-Id: <cover.1620652505.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset replaces all private CRC-32 routines with
generic ones.

-------------------------
Changes in v2:
	- Patch two remove comments instead of
	  moving them

Fabio Aiuto (2):
  staging: rtl8723bs: replace private CRC-32 routines with in-kernel
    ones
  staging: rtl8723bs: remove unneeded comments to silence 'line too
    long' warning

 drivers/staging/rtl8723bs/core/rtw_security.c | 67 +++----------------
 1 file changed, 8 insertions(+), 59 deletions(-)

-- 
2.20.1

