Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4F143B418
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236624AbhJZObl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbhJZObe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:31:34 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39425C061225;
        Tue, 26 Oct 2021 07:29:10 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 83-20020a1c0456000000b0032cb02544aaso2385430wme.5;
        Tue, 26 Oct 2021 07:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Hvrm4U3GaiK84h0Y1EjL6rlYYK+Ee6tQGZAOrMXIkE=;
        b=kHAJVMZElj8ogpOBmbdxzalC9VbHefOSv5bzi1olzHbmqw8auac801zi8xzWeln6zY
         HaotKl6S74zchsDLx+kseIp5wD2KL0V6e2qT2PEYs90LevAYAiARhZvJksG4AP08zC/+
         5wJLtaYNkdsByDgJoA06GkkGLvy1mSQYwpK8In5GH0J4x/Td1LXJFd1T3M5hPhhgkV68
         Qn6ixN6Fnpfh5x97H0G/Sz71odso2r7p1vqVxji/YU/1tMlNMUp033v8Ym9iw79h3ANJ
         58Oeg+OqxCuqdOx/9QSwwtBgnsfsv/cGflkcEObeezUyjPWwi5Irv53XZNBsrZpQqDXX
         ELOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Hvrm4U3GaiK84h0Y1EjL6rlYYK+Ee6tQGZAOrMXIkE=;
        b=8Cn5dA5BoPVuRCFKKShskUhBk2BuJY3F8VfBTbbubDwpE5Zi1qWJ1jotpU4rhfxWtI
         AKjtXK0s3gjCndDJZTTbMXPVSuQONqkuXQ0oQCT4jeJsvOSqkh81uUaqEFP5AKD29868
         aFBmf/6vZD3S+0r21OqN6UPbFsDg2PFXabuVTEwEhtJ2u7ExyjjVK35N6ts+4G8VGaac
         0k5ER8DH4b5jkcsfRu1G2XUH5xlLPAJyHzF+gPRaIbTU+pQU0JfkWncW5O7dlc6+NpPd
         NfKtJFdPmebxfKzdjapHhYo5XQXoLvhVEMqeMI2Cw9L2o/RZVeHGP4v8p8jiZgNnBoeL
         WijQ==
X-Gm-Message-State: AOAM530QAydBzyIKSK48hIVspBKnzFjX/D2I6FMcK2TVhyiUe5CDijF/
        BbW+GxG2G8Gfsk/XNGL6uOs=
X-Google-Smtp-Source: ABdhPJyl6vHxBz9Q8+S+wfU9bVSW0oOt+3LVwS3/rfY2x0Pk8w2Eb/DDxJmrd8PITI0D80TLj/IV9w==
X-Received: by 2002:a05:600c:3511:: with SMTP id h17mr56179132wmq.144.1635258548726;
        Tue, 26 Oct 2021 07:29:08 -0700 (PDT)
Received: from localhost.localdomain (i5C74E3E5.versanet.de. [92.116.227.229])
        by smtp.gmail.com with ESMTPSA id f18sm18745717wrg.3.2021.10.26.07.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 07:29:08 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Yu Chen <chenyu56@huawei.com>, Sam Ravnborg <sam@ravnborg.org>,
        Edmund Dea <edmund.j.dea@intel.com>,
        kernel-janitors@vger.kernel.org, Joe Perches <joe@perches.com>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v5 0/4] Rectify file references for dt-bindings in MAINTAINERS
Date:   Tue, 26 Oct 2021 16:18:58 +0200
Message-Id: <20211026141902.4865-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

here is a patch series that cleans up some file references for dt-bindings
in MAINTAINERS. I send this to you as set of trivial patches to be picked up,
after no one else has picked them in the last few months.

It applies cleanly on next-20211026.

This is a v5 of the remaining relevant patches from the first submission
of the patch series (see Links) sent out on 2021-03-15, on 2021-04-19,
on 2021-07-26, and on 2021-10-05.

Could you pick this series to travel to Linus through -mm?

No functional change, just cleaning up MAINTAINERS.


Lukas

Link: https://lore.kernel.org/lkml/20210315160451.7469-1-lukas.bulwahn@gmail.com/
Link: https://lore.kernel.org/lkml/20210419092609.3692-1-lukas.bulwahn@gmail.com/
Link: https://lore.kernel.org/lkml/20210614112349.26108-1-lukas.bulwahn@gmail.com/
Link: https://lore.kernel.org/all/20210726142943.27008-1-lukas.bulwahn@gmail.com/
Link: https://lore.kernel.org/all/20211005075451.29691-1-lukas.bulwahn@gmail.com/

Adjustment from original to resend version:
  - drop subsumed patches

Adjustment from resend version to v2:
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


Adjustment from v4 to v5:
  - dropped patches 4, 6 to 11 from v4 
    only 4 patches, 1 to 3 and 5, from v4 are remaining, which were not yet addressed by others.
  
  - sent patch series to Andrew Morton for inclusion through the -mm tree.


Lukas Bulwahn (4):
  MAINTAINERS: rectify entry for ARM/TOSHIBA VISCONTI ARCHITECTURE
  MAINTAINERS: rectify entry for HIKEY960 ONBOARD USB GPIO HUB DRIVER
  MAINTAINERS: rectify entry for INTEL KEEM BAY DRM DRIVER
  MAINTAINERS: rectify entry for ALLWINNER HARDWARE SPINLOCK SUPPORT

 MAINTAINERS | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

-- 
2.26.2

