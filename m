Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F111543D811
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 02:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbhJ1AZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 20:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhJ1AZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 20:25:32 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5784C061570;
        Wed, 27 Oct 2021 17:23:05 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id s1so17458964edd.3;
        Wed, 27 Oct 2021 17:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DjjqSH69oC8cg0hQ1i4eeW5boZhzpHPAKqQHgkqSM40=;
        b=BZaF8jnvOph44VTBcgU0GwKZUEKTErcivkRShSXAiBrZlDT/MjytdQZcWPCUxon0hh
         GTNPs6Sq9zzOJNQ6GsBz+ko7mWjUoJw0UdQktNKdO3MHMhjboKv/71OFsybq+PfXPhj6
         7X2abD+LBpbtJ88xN+ATWOKJT2GMKWaL4+P2ZjOGRS4gcadYcDj4mfBNOhNIM43SUlPr
         qCONOGgKL2paDWTn4ht8mXFRs2nuUIMKgxB2Ru1YKSCe3ze01NyDLWJQb3r169Q2smQb
         mSmg/CuknCY5hL2Y+lMvFkFix86fYxcSZWAdr/DCdepdwd2qM4XWO0NQvPDkwcokWBYR
         nxnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DjjqSH69oC8cg0hQ1i4eeW5boZhzpHPAKqQHgkqSM40=;
        b=OM8YIdL+vd/Q9ejddWPpO+O/pYDrfVxo47S+hKQOt7SdlgYCy6YZzy6cGnoaB8iB6+
         Yzhz2jSZ5JYQhQwVOwdZUaZUw5R4ECOaqB3PAV73k+JW6YKAWlYvn/0FVia1dGr6/kgv
         j0dcvzRET3dvYzb84eaY+b5oKGiJTlo+wsAWCq6UGHBmBOU2A1A2awtGI1C+qdqXhANz
         wTWHPZ3cB/fj7ZIx9DenneCuO4Pas16rKOO25RNMPA84Dex9T8sjI+ZmNDUdcS9LT3X0
         flbn4W/ZdQugSNeEd4zobG3c7zELHeg2vp5XNPml6e2c9QfRkHm3bHtFY2MP2mE0HIFs
         7TIg==
X-Gm-Message-State: AOAM5339A8PtXSX+upWzf0JVt+u0roMwy1hf53YXw2IKuEDP+Gh9NBgv
        SxBZpxOBzn2yQuAOXu5KHgbPIURsHQo=
X-Google-Smtp-Source: ABdhPJz22H0uIcxVEu9LGZPrXfdO+bXbzZGKkJgv51RhQvK0CcQLQJd3wv52GYXfF2S6psAZxMO3LA==
X-Received: by 2002:a05:6402:5189:: with SMTP id q9mr1511621edd.94.1635380584048;
        Wed, 27 Oct 2021 17:23:04 -0700 (PDT)
Received: from xws.localdomain ([37.120.217.83])
        by smtp.gmail.com with ESMTPSA id i22sm753801edu.93.2021.10.27.17.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 17:23:03 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] platform/surface: aggregator: Clean up client device removal
Date:   Thu, 28 Oct 2021 02:22:40 +0200
Message-Id: <20211028002243.1586083-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some duplicate code for Surface Aggregator client device removal and
rename a function for consistency.

Maximilian Luz (3):
  platform/surface: aggregator: Make client device removal more generic
  platform/surface: aggregator_registry: Use generic client removal
    function
  platform/surface: aggregator_registry: Rename device registration
    function

 drivers/platform/surface/aggregator/bus.c     | 24 +++++---------
 drivers/platform/surface/aggregator/bus.h     |  3 --
 drivers/platform/surface/aggregator/core.c    |  3 +-
 .../surface/surface_aggregator_registry.c     | 32 ++++++-------------
 include/linux/surface_aggregator/device.h     |  9 ++++++
 5 files changed, 28 insertions(+), 43 deletions(-)

-- 
2.33.1

