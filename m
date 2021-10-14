Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C066542D8C2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 14:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbhJNMG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 08:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbhJNMGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 08:06:25 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166ADC061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 05:04:21 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id e65so2935222pgc.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 05:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=92n0moAabT6AS5dGSdK43zewU3rUGs37H16qpFt37P0=;
        b=M5TGLvDdV5GB7BnmG+6NPyEGICwR4d406PUheHDG9uvyo+imp5sL9SvfgGl6t61z8Q
         ejBWvaTzzlkPDzyk5D0bKK3sYzDSIB3dW7mtOiOkFFZ+ZRDgGBqCdcJgKUFvhSrBCAIu
         dQeQeGXZNjJ8hstscY++totv3/mjlOpIC07b0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=92n0moAabT6AS5dGSdK43zewU3rUGs37H16qpFt37P0=;
        b=irZbVcvUc3LMi9nTD+LIMr/ymHF+ZvemKjyM6v1+XdwDv5dlw9YIWRCXvzxGjYKeM5
         TPz1Pqkf08CpMqDP+BJvAyw2lTQoEDgR/r/C4HvA1yY79uwqCTGprYygmKl94DlsJ078
         5i3hWsydJAxQv8uaR3pxru1D1fuc5uPayHPP681Ps0GGYxWFVA7Fx5Omh+PLptNWIG8w
         F+nBGIP3JfT9Gb5XlU0RYX/ExgvTKscYyt80fDPJ8mu0t6Ok5KnMLRcyjPXKQPCo00l9
         /cjtSPHgkCxKmanI5emvJ7p3LKRf0omh2UGeDwzTskZctFTNNT6RISUfRW/4K0eKZsfz
         SmTQ==
X-Gm-Message-State: AOAM531kmnlt0I68MMRQXKsSe9FIs97SgbWrUMDMnW1NBiQnZtlcOsKG
        eozJw1YndONdaeD077+z+gon5A==
X-Google-Smtp-Source: ABdhPJwIWotZPHk184vFFep0mQkX2raEyAkHyKCaAGKFVNw83k5U9hsxrtADiEetCitAyE2LbTbplg==
X-Received: by 2002:a63:7542:: with SMTP id f2mr3918157pgn.64.1634213060611;
        Thu, 14 Oct 2021 05:04:20 -0700 (PDT)
Received: from fshao-glinux.tpe.corp.google.com ([2401:fa00:1:10:64c0:3f2d:5152:a6f1])
        by smtp.gmail.com with ESMTPSA id b11sm2300275pge.57.2021.10.14.05.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 05:04:20 -0700 (PDT)
From:   Fei Shao <fshao@chromium.org>
To:     Jassi Brar <jaswinder.singh@linaro.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Fei Shao <fshao@chromium.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "jason-jh.lin" <jason-jh.lin@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 0/2] Fixups for mtk-cmdq multi-gce support
Date:   Thu, 14 Oct 2021 20:03:50 +0800
Message-Id: <20211014120352.1506321-1-fshao@chromium.org>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series includes some fixup patches for 85dfdbfc13ea ("mailbox:
cmdq: add multi-gce clocks support for mt8195").

Changes in v2:
- Add Reviewed-by tag
- Make clock names static

Fei Shao (2):
  mailbox: mtk-cmdq: Validate alias_id on probe
  mailbox: mtk-cmdq: Fix local clock ID usage

 drivers/mailbox/mtk-cmdq-mailbox.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

-- 
2.33.0.882.g93a45727a2-goog

