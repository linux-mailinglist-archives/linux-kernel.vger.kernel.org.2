Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16FC421FCB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 09:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbhJEH45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 03:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbhJEH4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 03:56:55 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E50FC061745;
        Tue,  5 Oct 2021 00:55:05 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id v127so15583488wme.5;
        Tue, 05 Oct 2021 00:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sqv2+Fzsw4VFUqF5jcrK2fMBM5s+t6zGZIuN7AjliCs=;
        b=ogtuapvWy4lmoaN8DT1LEABgdS8DJtRYDIkglwNLp9cCTu4oT+tCvnA9nX/VtR5XSb
         XlSBu6v49nFhJUeCW/EDZ1ArnBeds3wTxFppidAoiFwl6Pr10G/a724jSIRab7N2zTA7
         dkPnm/OPXs8xCMqNly84mXY1VH3sbMbSDaFmdDkz+HDVYhHZd+XhOCOlg28KAPZ2XzdK
         YoqxyA/UX/9jiakQaXIv6BGBhRehY4kKnD3EA+MAFemnTUdPsGId21gC6HTL2R+cF3MV
         adbYqphQHRTz4btRdsia+rAth8l9ePhK4M4+6cJ6irrSgOtm86oPAhvzANv0Zo3cdbZc
         P5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sqv2+Fzsw4VFUqF5jcrK2fMBM5s+t6zGZIuN7AjliCs=;
        b=7C1wR5+cC8SC0NbFz4mo5c2PlqYnvYgbj62e0kXqelqpDAU3xGMPXRhxj6d+cf9uyx
         YDNLPGfrtTeTnbCCnjQcT7AFv3kVHDhk1OWbiAgkGGous02ZSdcPxFOYTeHR96xr2NLX
         YPS2WzRUd3kwW5oCLWPJTEYOQNxuOJfwoZX8BHGRWc8gW9rSrgiJ+8Cr4YEPECrqIKId
         FIFO95Pia6EvpG7ns0oO7I82m3uaD0Ec/rr4ezRwq5woO4RwewsVLVX9eAhnGrrxHlKs
         mmlOgQZ9quYWCtlIewo/kuQ2yqFFo/pFXuKDn17lBZ9RUF8nmRpbl++Uf5JE8LkG3JCm
         rSfw==
X-Gm-Message-State: AOAM533YLesqa062Bs7QfNhzaGjwHaPunoLN6bSyhVJlAD+mg3ux4dGe
        Um1Kge0I1ZjTe4V/+909x/0=
X-Google-Smtp-Source: ABdhPJwWWpo0Ba68UuNQdV7lPLsV1bDi18sGhpZ74YCPZc08MwplH7Zn+I7iPXcj+tfM4qUXexwvmg==
X-Received: by 2002:a7b:c303:: with SMTP id k3mr1862314wmj.44.1633420503708;
        Tue, 05 Oct 2021 00:55:03 -0700 (PDT)
Received: from localhost.localdomain (i59F67A83.versanet.de. [89.246.122.131])
        by smtp.gmail.com with ESMTPSA id o1sm1176984wmq.26.2021.10.05.00.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 00:55:03 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Yu Chen <chenyu56@huawei.com>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Deepak Saxena <dsaxena@plexity.net>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v4 00/11] Rectify file references for dt-bindings in MAINTAINERS
Date:   Tue,  5 Oct 2021 09:54:40 +0200
Message-Id: <20211005075451.29691-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

here is a patch series that cleans up some file references for dt-bindings
in MAINTAINERS. It applies cleanly on next-20211001.

This is a v4 of the still relevant patches from the first submission
of the patch series (see Links) send out 2021-03-15 and resent on 2021-04-19
and on 2021-07-26.

It now further includes more clean-up, see patches 9 to 11.

Could you pick this series for your devicetree bindings tree?

No functional change, just cleaning up MAINTAINERS.

If I do not get a response on if this patch series can travel through
your dt-bindings tree to Linus, I will send the next attempt to Andrew Morton
as set of trivial clean-up patches for him to pick.

Lukas

Link: https://lore.kernel.org/lkml/20210315160451.7469-1-lukas.bulwahn@gmail.com/
Link: https://lore.kernel.org/lkml/20210419092609.3692-1-lukas.bulwahn@gmail.com/
Link: https://lore.kernel.org/lkml/20210614112349.26108-1-lukas.bulwahn@gmail.com/
Link: https://lore.kernel.org/all/20210726142943.27008-1-lukas.bulwahn@gmail.com/

Adjustment from original to resend version:
  - drop subsumed patches

Adjustment to resend version:
  - add Fixes-tags as requested by Nobuhiro Iwamatsu

Adjustment from v2 to v3:
  - add more clean-up for file references on dt-bindings

Adjustment from v3 to v4:
  - add more recent clean-up for file references on dt-bindings (patches
    9 to 11)

  - add tags from previous versions:

  MAINTAINERS: rectify entry for ARM/TOSHIBA VISCONTI ARCHITECTURE

    Acked-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
      collected from https://lore.kernel.org/all/OSBPR01MB298322B4D87B2BA2F24515AD926C9@OSBPR01MB2983.jpnprd01.prod.outlook.com/
      collected from https://lore.kernel.org/all/20210419232800.cbcyjlyrqywkrqdt@toshiba.co.jp/
    
    Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
      collected from https://lore.kernel.org/all/TYAPR01MB62520BAEC54CC5D235489D6C92E99@TYAPR01MB6252.jpnprd01.prod.outlook.com/


  MAINTAINERS: rectify entry for FREESCALE IMX / MXC FEC DRIVER

    Reviewed-by: Joakim Zhang <qiangqing.zhang@nxp.com>
      collected from https://lore.kernel.org/all/DB8PR04MB679585B2A7F359F415591356E6E99@DB8PR04MB6795.eurprd04.prod.outlook.com/

   
  MAINTAINERS: rectify entry for ALLWINNER HARDWARE SPINLOCK SUPPORT

    Reviewed-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
      collected from https://lore.kernel.org/all/20210728070608.5f5b8d14@monster.powergraphx.local/


  MAINTAINERS: rectify entries with documentation-file-ref check

    Acked-by: Linus Walleij <linus.walleij@linaro.org>
      collected from https://lore.kernel.org/all/CACRpkdYH=rQEK0sRU8DueUbvffe8DhKdH_nu7u4Pnk3MaBNmig@mail.gmail.com/

    For the line which rectifies nxp,imx8-jpeg.yaml:
    Reviewed-by: Mirela Rabulea <mirela.rabulea@nxp.com>
      collected from https://lore.kernel.org/all/647389a9a4db416550bb4c44c9ef87b6f3091fac.camel@nxp.com/

  MAINTAINERS: rectify entries to mtd-physmap.yaml

    Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
      collected from https://lore.kernel.org/all/20210726172902.4ce8892f@xps13/  

    Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
      collected from https://lore.kernel.org/all/CACRpkdb-3nesRvmwO8t-sQxxb1HAXe-GVL98MZnmisnf_0ji+A@mail.gmail.com/


Lukas Bulwahn (11):
  MAINTAINERS: rectify entry for ARM/TOSHIBA VISCONTI ARCHITECTURE
  MAINTAINERS: rectify entry for HIKEY960 ONBOARD USB GPIO HUB DRIVER
  MAINTAINERS: rectify entry for INTEL KEEM BAY DRM DRIVER
  MAINTAINERS: rectify entries with documentation-file-ref check
  MAINTAINERS: rectify entry for ALLWINNER HARDWARE SPINLOCK SUPPORT
  MAINTAINERS: rectify entries to mtd-physmap.yaml
  MAINTAINERS: rectify entry for ARM/ASPEED I2C DRIVER
  MAINTAINERS: rectify entry for FREESCALE IMX / MXC FEC DRIVER
  MAINTAINERS: rectify more entries with documentation-file-ref check
  MAINTAINERS: rectify entry for SY8106A REGULATOR DRIVER
  MAINTAINERS: rectify entry for CHIPONE ICN8318 I2C TOUCHSCREEN DRIVER

 MAINTAINERS | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

-- 
2.26.2

