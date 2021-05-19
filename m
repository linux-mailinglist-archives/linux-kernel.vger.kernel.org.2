Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5F03889F6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 10:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241465AbhESI5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 04:57:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51161 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235189AbhESI5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 04:57:48 -0400
Received: from mail-ed1-f70.google.com ([209.85.208.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <juerg.haefliger@canonical.com>)
        id 1ljI0C-00042O-3h
        for linux-kernel@vger.kernel.org; Wed, 19 May 2021 08:56:28 +0000
Received: by mail-ed1-f70.google.com with SMTP id cn20-20020a0564020cb4b029038d0b0e183fso7286556edb.22
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 01:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1OkZMVyIQ2WOlWNtNqHDsNx22TsqpoXEJAz21DvSQeI=;
        b=TyR7IUHm/NhVlI7vRRHQHWfsHrzyKAI+aQv3pQW7x7ORS7w8Wms4WDZVLzz/hX5cbv
         NuSpfnHmSNg+MCl/Ot5Bv+03P7Vn+89dqTwfSLm2Tt6l5uvIPn4NApGoFHonkWjMq6x9
         cdY+DC/rI6TFzx28cQPhfxUzCH5h2616CI+NlUKWnvBounLYYeTZXs9OsjeV1ywwuQ/v
         nniDfJq4CGd6QCh4EC5nOt+ceF9hzQ/0peSRooBrGTaiOhdjNm9KR60ka0f+v8oCc5LP
         kFBWIuZa3UzZ9auw7k5h0YDZNAXHdh8ffXes0LiiJa1oUwSLlhrotxxxVOQXOsCQ47OX
         TUdQ==
X-Gm-Message-State: AOAM5322kqKSRnxz7GmiwsmJ6PqW/p5GLfS+Lg+XzTeI73/wIpPcAw7t
        rW0EIqwfJLhIHCZSxNHte/AaMZoLjKGNLMfGFuhDjbvgZHKMk7rekr3YztJBBGuYqoTLUIwfKme
        1YPTDwYeZrtveM8fvPotU/esAkmqeLUAsxDdTvH241Q==
X-Received: by 2002:a05:6402:54e:: with SMTP id i14mr13083493edx.289.1621414587903;
        Wed, 19 May 2021 01:56:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzeYj2vl0hXB1PffsjwF3w9SjOcnrL7e5EIu40SnqdTjjE0LlWM8FyO34chxeBRqF6tY1VHw==
X-Received: by 2002:a05:6402:54e:: with SMTP id i14mr13083486edx.289.1621414587762;
        Wed, 19 May 2021 01:56:27 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id l28sm1364816edc.29.2021.05.19.01.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 01:56:27 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH v2 0/3] block: Cleanup Kconfigs
Date:   Wed, 19 May 2021 10:56:12 +0200
Message-Id: <20210519085615.12101-1-juergh@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move BLK_CGROUP from init/Kconfig to block/Kconfig per Christoph Hellwig's
request and cleanup various whitespace issues:
  - Replace multi spaces with a tab
  - Make the help text indentation 1 tab + 2 spaces

v2:
  - Move BLK_CGROUP from init/ to block/.
  - Cleanup the other block Kconfig files.

v1: https://lore.kernel.org/lkml/20210516145731.61253-1-juergh@canonical.com/

Juerg Haefliger (3):
  init/Kconfig: Move BLK_CGROUP to block/Kconfig
  block/Kconfig: Whitespace and indentation cleanups
  block/Kconfig.iosched: Whitespace and indentation cleanups

 block/Kconfig         | 155 ++++++++++++++++++++++++------------------
 block/Kconfig.iosched |  27 ++++----
 init/Kconfig          |  22 ------
 3 files changed, 102 insertions(+), 102 deletions(-)

-- 
2.27.0

