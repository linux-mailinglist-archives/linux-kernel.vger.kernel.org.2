Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54380413525
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 16:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbhIUOSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 10:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233518AbhIUOS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 10:18:29 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B785C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 07:17:01 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id i23so39698242wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 07:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t27UBeNeZ46z47trHe6C/kUtzdkeAs77rtej/Zct0KM=;
        b=6F8kk7DUEYUE2AS3dlH3zJ3wQuB2abbnqWqGzzVElW5aS2RqR3RO8E2xxwvOBeq6Ht
         AplG7+P7wobCv91ueMRQncCJ6RQq6l7UBsokCs37mD/lBAaI05Rv/j89q30+Ib0yz76v
         0HU3Tka4JGBFF8OsT1kSUPgAy5irFChF3G2VnFo/frOo4mrez96R7d6wfWjgMVlIz2mc
         7xqYjl7CD3jX1HbaDXKGTM/r5ax3iGPwxkzN+ZPITKn5KBq6WFW4MYW/DDGf0EJb2+cs
         ApGNN947LYLmn19rvayuvWyRdb9Q92ysBkstIo/XkRNAIy8ieqPv3S4+0hkDjSL+6M1p
         Fsig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t27UBeNeZ46z47trHe6C/kUtzdkeAs77rtej/Zct0KM=;
        b=RcyTkmjCW7O3dxHt/6gyzoX0dkeBmZoRki09kWRB2uM0S2Rn7XbiGLhsG9CItojyVd
         EXerpUvAUwly5EHcetrmb9QdeufD7a6aoXeoYGXHGa/iDzjseIINZP/nFhc1mGnkxr+v
         02rIs1yWdmiwYgRwDEAvEdnasaDagMGWczpuc3U+RC1WszRs+N25j02AjmCvL+YTuMqT
         ECXQpovy/hidYgFxRYxtF9BNlA+ouM0xAQ9AB4qlQgdk9L4QVW0aQ430u05ymTmkZRiM
         i00xjomYdPmsIP22TEnYWhNWy6y1WKHcwZsZbEhSx7HBanRfMhyR9O0ueM99ob5jqoaA
         0rOg==
X-Gm-Message-State: AOAM530JwE0Ewl3qS/XHX17SzBOFbPXs8JU6ILXbjqx7dyh1QCPuhaDQ
        MBESqefqXDRQVNPOZTTKKJJKLIlRvh28//9S
X-Google-Smtp-Source: ABdhPJygzCwRTfMO2e23YeOXYbQpseUMvc0R48pLdVWKsJV7zQopiF9Za+iPvLlEi+NEIFdiUH0W0Q==
X-Received: by 2002:a1c:4d05:: with SMTP id o5mr4887820wmh.193.1632233819507;
        Tue, 21 Sep 2021 07:16:59 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:19bb:c937:2c91:f02])
        by smtp.gmail.com with ESMTPSA id c15sm20573379wrc.83.2021.09.21.07.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 07:16:58 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     tomba@kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 0/3] drm/omap: add crtc properties
Date:   Tue, 21 Sep 2021 16:16:51 +0200
Message-Id: <20210921141654.66550-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=624; h=from:subject; bh=mvrGRdkaoJYpOZu1XeJF7MJFA2giFEtEEgzFltpD0mo=; b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBhSeii4NH3qoxETCaBsiF4ZvuMom2V983kAyhtM+Iu zbBNytaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCYUnoogAKCRB33NvayMhJ0RQRD/ 9fL1s12PBPdDvEfoD5OZl/6Xgj4Wurc12XnZPZK6HKtc/Rkm+PGbWk9y0MkVW3S0JlBlUM3LV8JVbK wnJe5PU5vJjb3m3YnDTkldfSP1DyEvuS8JZ5wGS5HiELbIboeTMY1aWL82abL3TjHCI3/awJdilxJQ 04XWEvPWG8TFgs0Uj9pq0xJLnR4beZVXTlHiOBVQ6j+fYO/f/s39iLSCn9RosumO5BgQky+DdOP56V 64w2roTqOfEFZeRgIO5RCDQbucXkirUIOuhzgW/3BlXCwe9R6ABsUt6IGPpzeggkaVf9pXOvRuc4Ty Hn3in9j5AT2F1MDbVW9a6H20mrXl9r6HWSUSoEa3srcDjpXN/vFDOkkHMX3udGsWeGEjbfMyRRw6c9 h8F/BrsFATBLT/CE9+xRxgixV81Q/XaCwiYDzCHEC6rtoAkq/aB/PxftnL+z9oNHwlv5Z2AvbatSUR hozEQ7OhsISY7c4uN96slCmLMSJPFM3RHNT9EgTEyh+3nkEdD3+eky8fbHrYDx7iKOriyeP+m7EEAP 0UTfZfhX0kq+MB51l9OvjqiIL+D1Hzf6qZdSXqB3GjnRb0SPcSJBwdRLnBlN4XQXcf2IGxz3Iw4kLZ WtIjd5vF3DZZ1GjFdpCldvKdZQvqLLvWXTEIhfedfKA104foXMhZduLL6xLA==
X-Developer-Key: i=narmstrong@baylibre.com; a=openpgp; fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds the following CRTC properties:
- background color
- transparency keying property
- alpha blender on DSS3

Tomi Valkeinen (3):
  drm/omap: add crtc background property
  drm/omap: add crtc transparency key property
  drm/omap: add alpha blender property

 drivers/gpu/drm/omapdrm/dss/dispc.c   |  4 +-
 drivers/gpu/drm/omapdrm/dss/omapdss.h |  2 +-
 drivers/gpu/drm/omapdrm/omap_crtc.c   | 85 ++++++++++++++++++++++++++-
 drivers/gpu/drm/omapdrm/omap_drv.c    | 30 ++++++++++
 drivers/gpu/drm/omapdrm/omap_drv.h    |  6 ++
 5 files changed, 121 insertions(+), 6 deletions(-)

-- 
2.25.1

