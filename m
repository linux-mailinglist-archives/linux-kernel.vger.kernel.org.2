Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1681A331473
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 18:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbhCHRTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 12:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhCHRSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 12:18:35 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A173C06174A;
        Mon,  8 Mar 2021 09:18:35 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id v13so15836201edw.9;
        Mon, 08 Mar 2021 09:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QpRX9dp3uicxVv487h+YjKRAB2MLML02Fr523RHwB5s=;
        b=mHa/jW+vlyasWldZBY6HZM513XUl/gya5pGtS+wXqYOpOxqp7uAihBmTeVdjXGiIKO
         b36Ncucl/Q8dEgXFGvPwsjS0sIjGXGblBiE27wnryuI/cg+N82dP8U/eMwKPHl1k9zwc
         mWZIKBkHRaQLp0tq/OfSIMNRKX3MOSW6DVo/ae4U88h7iE1nSoWaywWkqVgFkSGx9P7U
         OU98Sb6+tw+NZLk/PuX8YflzyeTcyViT7Azjlqyd8+sh9b2m+yxdxvTeS715/sfX/JjO
         zMrByMSKf/F5SPNOYeDW48ri7LElmh9qGLuabSu9XuvGGPmblCpJBp5TrsPy4Dp2Spqk
         6ekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QpRX9dp3uicxVv487h+YjKRAB2MLML02Fr523RHwB5s=;
        b=JfNRHhDIaP43aZ78jDq9i1isHVjBonx+0MCuR2poI/dV6xOUo6hZTH5xtDBIWeZ5B+
         TOs8nV/aEns48e/4DXuCueE6kne2ywIeTu8BHs2vfCgmy2h+HzGBtVAlA55nN0A86AoB
         WQ82D/lZVIt+NZOIqPo+xdcOfZ45y18gtiEYhJQN3aRMhrMP1Oc0VLNr/SQHR/x9Sm1X
         Eh8EGLJ9kE2Juu2ZgQjkblL31NtH6GmEu64zGyDS9XkYSL3ryxbIZNuJ9siGfD33gF+x
         iNaw4ERdkAgpK0eQdQTFGkxLqn5VjA+XJ/wvIHT0P/20qI4nE5oGTiULDRbwVmwHuzwD
         FI3Q==
X-Gm-Message-State: AOAM532VqzZkhm0aFIdIPMVPQukF6S05LxG+2M/kYbf/eCaqRqWQEi95
        BT693NvwwBpmtupfEc7cyPU=
X-Google-Smtp-Source: ABdhPJwkvSPZSwD1j5sECQgHvEdWtfLEdfmXXdY2vdntniG6pn8yWoVCqpYkNaSqUnHUswEE9/Pv1g==
X-Received: by 2002:aa7:cd6a:: with SMTP id ca10mr23422692edb.7.1615223913709;
        Mon, 08 Mar 2021 09:18:33 -0800 (PST)
Received: from localhost.localdomain ([81.18.95.223])
        by smtp.gmail.com with ESMTPSA id r5sm7457714eds.49.2021.03.08.09.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 09:18:33 -0800 (PST)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 0/6] Improve clock support for Actions S500 SoC
Date:   Mon,  8 Mar 2021 19:18:25 +0200
Message-Id: <cover.1615221459.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While working on a driver to support the Actions Semi Owl Ethernet MAC,
I found and fixed some issues on the existing implementation of the S500
SoC clock subsystem and, additionally, I added two missing clocks.

Thanks,
Cristi

Cristian Ciocaltea (6):
  clk: actions: Fix UART clock dividers on Owl S500 SoC
  clk: actions: Fix SD clocks factor table on Owl S500 SoC
  clk: actions: Fix bisp_factor_table based clocks on Owl S500 SoC
  clk: actions: Fix AHPPREDIV-H-AHB clock chain on Owl S500 SoC
  dt-bindings: clock: Add NIC and ETHERNET bindings for Actions S500 SoC
  clk: actions: Add NIC and ETHERNET clock support for Actions S500 SoC

 drivers/clk/actions/owl-s500.c               | 99 +++++++++++++-------
 include/dt-bindings/clock/actions,s500-cmu.h |  6 +-
 2 files changed, 70 insertions(+), 35 deletions(-)

-- 
2.30.1

