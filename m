Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3901A39C635
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 08:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbhFEGZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 02:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhFEGZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 02:25:36 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920D1C061766;
        Fri,  4 Jun 2021 23:23:49 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id pi6-20020a17090b1e46b029015cec51d7cdso7046893pjb.5;
        Fri, 04 Jun 2021 23:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wBcNqXrLG82ETe+gtsLBiERjJoskwcerbb67uZK7IJg=;
        b=DO/wE/9aBH6zl70XS5bNB2tYgJDrPp6L2kIZJ/Ym7FlTj/s2wwW6zzUJP28HKRZLpS
         pm71TYfWs5RONuRETyM0b4/CnRnxmcDl7IzVEvvmuK2nLFAniJg4trCNjbvmP0mIxJ58
         tFJTOFbno7l48bxbMJ3FwsU2FovzFu+7xPOPEK38DcyS/SbhUQ6nlG9Bkr+XgJPPkWWQ
         VwxGzv/1ehCicTGc2zEQfKBnS43hE1QQnd+feayf9gUjSeZ9+wyp9bHWuy4FlhPZuh8H
         55sXNui6JWAvfoAb58vDqa+5qYygYVzQ4gat6sMLQhPjxKFthgw/yDO1XTcKSN9enBOr
         ltyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wBcNqXrLG82ETe+gtsLBiERjJoskwcerbb67uZK7IJg=;
        b=gAWMXo8Ocp5lhMPVFA2jwdXLl/bw94jDNCQ0JsxcDDuiudmz5soO6N9QVNDIrEjieP
         pMr5D5YBlufK45HsLa4WmdC7rfpaCwT/QHRBluwhSs0fQU1ffKhtd4rHXjOqw45SPUJR
         Ss7cTJ6+83ccRLmRd/ZdqWtu4EHCNiARBmJFYKd80+mMIdA2p5FmSZDjKYFn/rkqXNa1
         gy/nLFoqF8Dt8Pll7VzWXrccEIB5I5iuYBMQ3qlveFBsaB5Cmml/g9JwmY5bFx7UfVJZ
         eIWd/rHzOud9GctSeMylQSaPhXOuEZm7gtmMcRWSd+39tPDkz0fXqJN1QoDUx1VjSexS
         f2ng==
X-Gm-Message-State: AOAM531ZFyCwWvmYyRRuwXvBUjPM9lj2QVBOLI+QkycxcXMW1TUjN0CG
        iSRVDlOyJ7sz0R80UcLrIUY=
X-Google-Smtp-Source: ABdhPJx167H1fAgL/KmXy1rENYzktplaGGUYU4gAvdGnsSMNHZcY0XH6zGUWkiCZLwfScLf3roysbg==
X-Received: by 2002:a17:90a:549:: with SMTP id h9mr21590806pjf.158.1622874229119;
        Fri, 04 Jun 2021 23:23:49 -0700 (PDT)
Received: from localhost.localdomain (199.19.111.227.16clouds.com. [199.19.111.227])
        by smtp.gmail.com with ESMTPSA id v14sm2800870pgo.89.2021.06.04.23.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 23:23:48 -0700 (PDT)
From:   xieqinick@gmail.com
To:     robh+dt@kernel.org, narmstrong@baylibre.com, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     nick@khadas.com, artem@khadas.com
Subject: [PATCH 0/6] Add serial and i2c aliases for Khadas VIM boards
Date:   Sat,  5 Jun 2021 14:23:07 +0800
Message-Id: <20210605062313.418343-1-xieqinick@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Xie <nick@khadas.com>

This patch series update / add serial and i2c aliases to
keep the same with 4.9 kernel for Khadas VIM boards
(VIM1, VIM2, VIM3 and VIM3L).

Nick Xie (6):
  arm64: dts: meson: vim3: add serial aliases
  arm64: dts: meson: vim1: update serial aliases
  arm64: dts: meson: vim2: update serial aliases
  arm64: dts: meson: vim3: add i2c aliases
  arm64: dts: meson: vim1: add i2c aliases
  arm64: dts: meson: vim2: add i2c aliases

 .../boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts      | 8 +++++++-
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts    | 7 ++++++-
 arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi       | 9 +++++++++
 3 files changed, 22 insertions(+), 2 deletions(-)

-- 
2.25.1

