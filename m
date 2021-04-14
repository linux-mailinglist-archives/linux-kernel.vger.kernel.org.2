Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35B1535FBA2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 21:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349223AbhDNT2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 15:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235028AbhDNT2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 15:28:19 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F4CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 12:27:56 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id e14so33097939ejz.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 12:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l3Dfg+t81O6iIBFRL3yKUv5Drx9glzGHFqa+e6m1HgM=;
        b=TymgCV05iTqKAdGAjC97+N/q4GoSVXD9mWjK5skpZ9Ge6BbpWqu2DXzQW9WE6/8cjq
         wU2UPbCkn5qKzQWpjLVCWSPqASNcrfE8z6DabgcvTz8bLUZkLgv5HrG+RMHig5A3LPOw
         QOqnHyEB7S+QA63x/mmarxWpDRn+Vtwe+2wsB7M+r83OMnlB9fjDY3sYagbJNJP1En9t
         NwAw9KNdeum0QixGZL1ah3EVdG1KryTeoGyldKiSW+httLClEAsk/9Dcqm9mWxhvL49D
         j3yNpJ/PCY2j5sSG4r5b0bNzTan7LIAqce3iKOa51qSEstbeX34x4I1hMM75gLGgOIFe
         YTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l3Dfg+t81O6iIBFRL3yKUv5Drx9glzGHFqa+e6m1HgM=;
        b=mP/VkFQmEjDs5Bc6Q/8QdKjmMa7Tf9nMKAFQJ5nhbL/4DtdNCFbilp2kqQFo0iTlPO
         RCmvYMcpACXqBh1FDrIVCUmuQIhxCgkummBkPwRj9cjmZb6Bjh7VcUisBP3uZJRKdV39
         IH5QqMnu3ZKmBDsdFSpNnoSQul48SofVys7LwSEQEWLpFAy6MAAVsTScK0olrNQpTiI6
         SgqfatgNDxOWs+YUYtWo3iX1BGI0enxOiC56ogmRU4VCpbl4dJS19ULwdrWxEaPzRPRq
         zTkVEO82b1fvzj9bBVykPy6cx6+FtXprKTr6ophoAW/AQN7ezDoTTJL1gqrwolrjmCCE
         1qOg==
X-Gm-Message-State: AOAM533IYd13vz4nNGqNgQKm3o52Xvp/FayFRiCbSC8bd3DSjB3GXZI7
        unx5+LN/Nvs4WjVLc+Q3OUo=
X-Google-Smtp-Source: ABdhPJwm7LizrJVVwMgBW5UwqHZE3wKCjwCzoDBLYgdgpt984xNVzoEd0jiH9BOVBVdYp9WTzJ7VkA==
X-Received: by 2002:a17:906:6d01:: with SMTP id m1mr421426ejr.501.1618428475504;
        Wed, 14 Apr 2021 12:27:55 -0700 (PDT)
Received: from linux.local (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id gn3sm259049ejc.2.2021.04.14.12.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 12:27:55 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [Outreachy kernel] [PATCH v3 0/2] Remove led_blink_hdl and other related symbols
Date:   Wed, 14 Apr 2021 21:27:48 +0200
Message-Id: <20210414192750.4974-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed useless led_blink_hdl() prototype and definition.
Removed struct LedBlink_param. Removed LedBlink entries in
rtw_cmd_callback[] and in wlancmds[]. Everything related to LedBlink is
not anymore needed. Removed extra blank lines in the two mentioned
arrays and changend the numbers set in comments for having them in line
with the shift. 

Fabio M. De Francesco (2):
  staging: rtl8723bs: Remove useless led_blink_hdl()
  staging: rtl8723bs: Remove everything related with LedBlink

 drivers/staging/rtl8723bs/core/rtw_cmd.c      | 27 +++++--------------
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c |  9 -------
 drivers/staging/rtl8723bs/include/rtw_cmd.h   | 14 +++-------
 .../staging/rtl8723bs/include/rtw_mlme_ext.h  |  1 -
 4 files changed, 11 insertions(+), 40 deletions(-)

-- 
2.31.1

