Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C783A351173
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbhDAJHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbhDAJH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:07:29 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954C8C0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 02:07:26 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id x21so1115486eds.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 02:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hqKqZ9iRjRyPN9EH543S80Z7tugSlkFDhD8jKubgWUg=;
        b=nhcWAEMQZyxjL9hmCvp2KiPL79BTZowgTDPY5mOzLS/XL7saV1FpBP4DR2CHMXRp6d
         ujvaLn+yiTQZC3jjnX1PVCRFCrClZ55qh2GQbEuqtVnGfU2l0SZBpyjqKCGng1YpGm3D
         7rj3K4S9f24JRDo5e9CUGMj6A/4FTwBpZwWXcS1oxb44N0uVaoCf2m3XpCEBDY2/xS3c
         OGw1DhrOe5Zz2szMgvg1lrXJ68NiT9NGeLzCmgUo3zVY0ArKT9S/3dDJYrCSZl4DXbdN
         Ay67zgPWbZkI+71Iq7/QKzt7wl6ncUyr2h07VKw7vcNVLGTkeyqx7p37wrYJXzg/1Im6
         dKdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hqKqZ9iRjRyPN9EH543S80Z7tugSlkFDhD8jKubgWUg=;
        b=D0AqKsxR1VfIXIhibNRiqB37BSv4s0UFtTpmdsPAXW+4yaPxpqlKK0SBPCOdfSt5Cv
         amkZRi0RMiaLDyx+lq4CndjlyC8VYu9v20aVnplsp3jGzCEy2yjNMHlvHyO0aACv/uM7
         8YaBL0XRd7wsG0uI5XZrStJGSn9LnrU5lZtw0BDjyIehpJcy7KPRnpqk8Y7+uYF8/F45
         qNA/e3pQBiF7azhCaikRlpj2MkIJ6+5xf4scTh7rPAYO+liHDKW054k67R7G48E5Rp4/
         jJGva4bmpXF66nqkAhW7XN9BXQlovQe//+ZXc9vcn8pkSdgFHXtGfr9SS1OrwxwIk1mY
         kOLQ==
X-Gm-Message-State: AOAM531/7r25j3N2Xno4fIHogQbgKg+mFvZWpMpkoLpPYsSxnNfQBqYE
        dV8uiKCOHUFM1mAmfEZAQ9M=
X-Google-Smtp-Source: ABdhPJzSSeVqMygi6cvv+ZRKLABJ79m178dLdquDaM0/vdzN98AWriWp06vwoafhOmKXu46DmtBT2g==
X-Received: by 2002:a50:9ea7:: with SMTP id a36mr8846379edf.174.1617268045446;
        Thu, 01 Apr 2021 02:07:25 -0700 (PDT)
Received: from agape ([5.171.80.247])
        by smtp.gmail.com with ESMTPSA id u14sm2444999ejx.60.2021.04.01.02.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 02:07:25 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v2 0/2] staging: rtl8723bs: replace private macro with print_hex_dump_debug
Date:   Thu,  1 Apr 2021 11:07:20 +0200
Message-Id: <cover.1617267827.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this patchset replaces RT_PRINT_DATA private macro for dump hex values
with the kernel helper used for this pourpose.

---------------------------------

Changes in v2:
	- removed the do-nothing macro declaration as well

Fabio Aiuto (2):
  staging: rtl8723bs: use print_hex_dump_debug instead of private
    RT_PRINT_DATA
  staging: rtl8723bs: remove unused macro RT_PRINT_DATA

 drivers/staging/rtl8723bs/hal/hal_com.c       | 13 ++++-------
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c  | 22 ++++++++++++++-----
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c |  3 ++-
 drivers/staging/rtl8723bs/include/rtw_debug.h | 20 -----------------
 4 files changed, 22 insertions(+), 36 deletions(-)

-- 
2.20.1

