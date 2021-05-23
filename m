Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF43938DB4E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 15:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbhEWNrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 09:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbhEWNrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 09:47:40 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4887C061574;
        Sun, 23 May 2021 06:46:12 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id z17so25718154wrq.7;
        Sun, 23 May 2021 06:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aun+rjUfXuSI5MaBYHc3vJ7DzLorNuomgEpIPMJQ/PY=;
        b=cDuhkep3sFM8l3q3bm1DzU0eYUy7uiW38PPhw1Kq15hH9e6zqOZ0KDnIx3Rzh4wQXk
         6+gVKVkv+iNhyuT66Ufsb3EgcfXAu46dOUMO5Cl1iAh97RhGPTFmfslORw2OgCzv+hAn
         ovBtaTfbkPcJPH/NmYDSNaUo1QnE6Xvjf3k4dz4hCpt7E1GBXESInf7fdeXyn5UfMLYr
         OX1CgqatJkOoRe80HSCCYeHpe/3iPbTqdhhvDbgwLy7UiQT8A0CeKOv6aj+jT3/m+I4D
         lxgyQ/RhmDEEUDlv1UjiP7pzt5IOTjw/mDzmV0qvAheS8RgR3EPiTi7qk9lkwPU+FyFf
         nF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aun+rjUfXuSI5MaBYHc3vJ7DzLorNuomgEpIPMJQ/PY=;
        b=qNMuYBcHd6ZrdZnafDZoqSWwbi+IVHSvnJ8PF2rPOXxpgZ+mZDqTYX5QEkrngauCwP
         mJf1sp0n3tuczygR+jylOu1u7DxWCbXZEEScYYFJmqIL3vzS2HKwPQGdU1wGlMccody6
         ABnLGh8vq9F84yL+/+1p2aktnV0We5UWermhGVuSztEbHq62kfvEYCXG+/2DIMFmQqWh
         66ijIKovDyO1rrktVmK4NWucAbiphQVL9+sW39VILnSnsoxuBV/2whtdhOh9Wbxyx3ET
         6w6BNwvsnUnCPO38YC9mhSkOYyu020v20YiKpIeEJcTHYeK4vScFlPZNdDkO9BqxWbnh
         AvqA==
X-Gm-Message-State: AOAM5338shSXpvfRvlg2NEqQ8sKmeI5Nt2kIk57MqlM5SqiWt+IlZZkM
        t4rnb+ocXkHZsfLlth9HN/I=
X-Google-Smtp-Source: ABdhPJwdsxIAaX+kAs7qJ7RIe1HMUMo1jdYmhpeqlvruP0jvuemD7jGok6l7WUV92Zw9Ohr+T/wJmQ==
X-Received: by 2002:a5d:598d:: with SMTP id n13mr18097767wri.38.1621777571533;
        Sun, 23 May 2021 06:46:11 -0700 (PDT)
Received: from xws.localdomain ([37.58.58.229])
        by smtp.gmail.com with ESMTPSA id z188sm5112414wme.38.2021.05.23.06.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 06:46:11 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH 0/3] platform/surface: aggregator_registry: Support for Surface Laptop 4 and cleanup
Date:   Sun, 23 May 2021 15:45:25 +0200
Message-Id: <20210523134528.798887-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this series adds support for the 13" Intel and 15" AMD versions of the
Surface Laptop 4 and does some small cleanup regarding duplicate node
groups in the registry.

Unfortunately I haven't heard anything of the 15" Intel version and 13"
AMD version yet.

Hans, can you apply patches 1 and 2 as fixes for v5.13? That way we'd
have decent support for the SL4 (at least the aforementioned versions)
in v5.13.

Thanks,
Max

Maximilian Luz (3):
  platform/surface: aggregator_registry: Update comments for 15" AMD
    Surface Laptop 4
  platform/surface: aggregator_registry: Add support for 13" Intel
    Surface Laptop 4
  platform/surface: aggregator_registry: Consolidate node groups for
    5th- and 6th-gen devices

 .../surface/surface_aggregator_registry.c     | 54 ++++++-------------
 1 file changed, 17 insertions(+), 37 deletions(-)

-- 
2.31.1

