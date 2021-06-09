Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1DA3A12B3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239098AbhFIL2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbhFIL2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:28:38 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734E6C061574;
        Wed,  9 Jun 2021 04:26:28 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id o127so3772950wmo.4;
        Wed, 09 Jun 2021 04:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ON9AjQaN9VS2MyE303YJDSdvJreLw9WxnIrOlBoYNkA=;
        b=eIBNkvNgKHDSO/5qEv4rQ3oMRcX1kUtzDX4ODn6Ijmh7lN62xI9T4HQyV55kiYbebQ
         Ws2ZGDzkF1dn34UAfpCvj2MFgVswG6uDusFS5oG6Qmg8UkYLDCIwNWm8PsbWT8uDXX3L
         AQkEQeUddVdgXrSTCjo8iyh+il36MG4d5WOOg7y6KCya7u4doNN30K1IYr7lFqUzU0Z+
         pvvLUbF1bdB6rCWR6IpUzIH7+LxZqfp0qzCvUUyxPEXXCIL1Q/vB6OCOs/4KmvUA5PAH
         qavYaALySIcoRZzg4yqLoKHukmkklAjHwNekrWOaJlThC/KTCtu8vOuPRqZe3g95+vQ+
         +KSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ON9AjQaN9VS2MyE303YJDSdvJreLw9WxnIrOlBoYNkA=;
        b=oeNyXl3Y7I0EPuzGBiGk8SSp3XWNimV/bMeHmSKQzOyG4QNLa+K3gijWyM5kqYWP+g
         atl4lvXD+XBq2g8yXGIV3U7KMMruJkUEnpjdxQ0JcPZ08rCpw/SUxjiwW06JqlQEjpIZ
         ZZ5YlXdWI7JmU56JBNoFBHdfKGfXfl4R7nMok2qp/f5DEV2f3cH/O8uPvtFgddbkI64A
         nLYBji9WZBbips7ZTecUM5RcsxXdiSWovIvkuE9G/7LExfml1Ox+MIOxA0T48WqPu0jj
         D22RoE4XV+6ZAUPPLL8CM2Ant6kRCSRCwx/c1/ylMzZOBK2LoXK8gygiVzkiaO74kpL2
         d2Ew==
X-Gm-Message-State: AOAM530ED34cBbTMQTBA84qDS8OAnVHxZr+slBR5BQA+qQv08InQiRyd
        yPwVjwkn572H4M6TW0BZ730=
X-Google-Smtp-Source: ABdhPJwLu6FBK18vtwlKATXll8aWLAJDRweaiF/+xsomo1MdmCSOl4M57XHtQPbKhQMVqowSbHf6CA==
X-Received: by 2002:a7b:cbd2:: with SMTP id n18mr3305063wmi.112.1623237987048;
        Wed, 09 Jun 2021 04:26:27 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id l13sm15823719wrz.34.2021.06.09.04.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 04:26:26 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] memory: tegra: Fixes for COMPILE_TEST
Date:   Wed,  9 Jun 2021 13:28:04 +0200
Message-Id: <20210609112806.3565057-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

After COMPILE_TEST was enabled for the Tegra MC driver, Krzysztof
reported that this can fail to build on x86 configurations because some
dependencies are not explicitly pulled in.

Fix this by adding missing dependencies for OF_RESERVED_MEM and by
providing compile-test stubs for reset controller registration API.

Note that I was initially trying to fix the reset controller problem by
selecting RESET_CONTROLLER. This works but is discouraged because it can
create circular dependencies. And sure enough, changing that "select" to
a "depends on" triggered a circular dependency because there are already
quite a few drivers that select RESET_CONTROLLER. I suppose that's fine
as long as everybody uses "select" rather than "depends on", but it is
not a very robust solution.

Dmitry and Krzysztof were both in favour of adding the reset controller
stubs, so that's what I went with.

Thierry

Thierry Reding (2):
  memory: tegra: Add missing dependencies
  reset: Add compile-test stubs

 drivers/memory/tegra/Kconfig     |  2 ++
 include/linux/reset-controller.h | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+)

-- 
2.31.1

