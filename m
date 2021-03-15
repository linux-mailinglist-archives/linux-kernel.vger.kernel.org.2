Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E12EE33C12F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 17:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbhCOQFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 12:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbhCOQFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 12:05:03 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7020C06174A;
        Mon, 15 Mar 2021 09:05:02 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ci14so67003868ejc.7;
        Mon, 15 Mar 2021 09:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=iTN15QOmjZC4ZxIPSp9uAnRcwTL7uX2dN8RBpC7no10=;
        b=h5t2n2hctg+YpumjNtWRMx3N9tyn5e/T68EzWoBq+RMJ/qpov94ODOu+Kyqx/mME4K
         pA7qA2aaihEtATr/I/NA3w6uR1ife8AOcEnFQC7F6vJexUjSzIcZ9DS0MsgUr5aOJF9N
         N+z9QgO/06+zYJHNriysM0VHUAQkKcgFw75WpnLUPQ2jmbs1nH4KWvxE8Fqws2a+qLUa
         g5YR7fg9iBq67CYiBPzv4AZwaJfeyx3aUDsT53ZDX7O970Yo5vRiRk5VBV5OS3E0W/uD
         SvSnJjndDILJBHZMRJQklJOcpjTvcCaHT8jnTRplnZogm3TFlwx2Nc//x5gIdzIaWUWo
         8/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iTN15QOmjZC4ZxIPSp9uAnRcwTL7uX2dN8RBpC7no10=;
        b=eIMwZacYTQ68dDlCCW/xBkDh3LFMsvZwXD2f/QZiwYO+1DEpU661YnNZfyKuJdfzyG
         MmuQ5bU0WdLxmFxt1hW7CscElwkEWhGe//q8pjBJFCwar8TF2aIeQiIK5jcQVQO4lkJi
         LGmq/BVv4kbsJBlPvUgHNKCdQQ+Yj1Hv3DXA12oGXLF8d+KE6oY8IkqrCuu5GS1d27yd
         ICHqDA20J5M4IUcEi1uwsIgKtZ1PLA5Lo4pI98tp6xBtP858ve+mSi/BDpmEV671zocf
         9okCHTFIPtCvKLax5w81NvbFUgQ4s2ZYz1dj7n9JUe9yRjfrAUapezo+tvQ3EUfpZv2u
         mTHw==
X-Gm-Message-State: AOAM533lwEIQl3HmlUBUo/4P3Xk0EVr4LnAbQFfhDyPesBsrh6xIsFRb
        2hcHkke99Bup+Qe363aHyI8=
X-Google-Smtp-Source: ABdhPJyip3DfIUvk4XF6M2+1Qr+fHdi8j4USy2CBep19ai87e4UOTyv1FytpAa+pg/thVRFyp6sCNQ==
X-Received: by 2002:a17:907:3e8c:: with SMTP id hs12mr24546527ejc.105.1615824301533;
        Mon, 15 Mar 2021 09:05:01 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d28:c000:5c39:c910:15c8:a935])
        by smtp.gmail.com with ESMTPSA id z17sm7748510eju.27.2021.03.15.09.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 09:05:01 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Yu Chen <chenyu56@huawei.com>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Joe Perches <joe@perches.com>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 0/5] Rectify file references for dt-bindings in MAINTAINERS
Date:   Mon, 15 Mar 2021 17:04:46 +0100
Message-Id: <20210315160451.7469-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

here is a patch series that cleans up all file references for dt-bindings
in MAINTAINERS. It applies cleanly on next-20210315.

With this patch series and another patch (already accepted elsewhere)
[see Link], ./scripts/get_maintainers.pl --self-test=patterns reports no
further warning on next-20210315.

Could you pick this series for your devicetree bindings tree?

No functional change, just cleaning up MAINTAINERS.

Lukas

Link: https://lore.kernel.org/lkml/20210208071619.3234-1-lukas.bulwahn@gmail.com/

Lukas Bulwahn (5):
  MAINTAINERS: rectify some references automatically
  MAINTAINERS: rectify entry for ARM/TOSHIBA VISCONTI ARCHITECTURE
  MAINTAINERS: rectify entry for HIKEY960 ONBOARD USB GPIO HUB DRIVER
  MAINTAINERS: rectify entry for INTEL KEEM BAY DRM DRIVER
  MAINTAINERS: rectify entries for dt-bindings

 MAINTAINERS | 46 ++++++++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

-- 
2.17.1

