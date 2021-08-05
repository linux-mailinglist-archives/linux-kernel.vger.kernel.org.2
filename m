Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 490433E1E72
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 00:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbhHEWKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 18:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbhHEWKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 18:10:22 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A048C0613D5
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 15:10:07 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id z4so8445214wrv.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 15:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fiLt4knuszJi0AGnyks6GFha2NM/LBLCGr2yZG7PLZc=;
        b=QopFxdYMwrIphWHRC2OxXF2hOHHEDleVcGIdW/oP47nz5YXCRRSrLNU+ErhToe2eYB
         QvKysinjKPztu/B8j1str6fTDnp0pDrcRgBj6nMVGchLde0X76CdsxCcaeW0TnRfVawX
         mtZ9F8M7FRtCP391J6BBk3EeSPUvOfoKNjApJQZ/ybgkNT/IfSBJ0j8jUNB225KzL2t8
         hHLEn6u6v0nC7RGYKuHqXfxpjx6tETmAU+Deu4R4S2ppHI3/jYJAk4uNgZtf4lFmMeBm
         Cl9w25mbG7T0xCfi73SyyUjWhKytqe9WMkm3454rtng/F2Ggqhw0K/3N5KjoutDgE9vp
         7QKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fiLt4knuszJi0AGnyks6GFha2NM/LBLCGr2yZG7PLZc=;
        b=Z8qhZvJYQLCIoaNrZpJ7o3u0sEUHt+u5DLRGabs0XiF19R3c/oYVlRAoE7vAu+39jR
         r9ZXdG3stDgO8Tdc9/CpLpkhM0NPVWtptptPSw2/rdswf1pj4m4GDywVXKANAUd1wA1G
         ySVVcI3TsPKupQulyUdMOEMHwr7tH6uhMDG6DubgIKTA41uRWjNjvaro7TPnFV0eux4H
         G/R9H7Pcmq/Of3914ngXMlTa8pWnD7o3n6/5I9jBwkaixOan92aruz9zxS40GROb0D50
         CQyOeEL3upETyR9aj8rFr7LbYATa3LWZQfLbJnP2/tfXF4/AMxwLD/9GwFMrIl81x5O6
         SFQA==
X-Gm-Message-State: AOAM533bwxw9g9rwmfcqFUEWOshvhJj9+ZDuZFEW+2I1pmc25A/C/FE2
        RoXwR60igjId5h5hOWL6oP176bUKxSc=
X-Google-Smtp-Source: ABdhPJyQGXQ7jpiazanEdeYHoN0HVNRFH76WQGbUbblTBIgPHcGSOMTzwY3ONp06PyYVvqTSfERGOQ==
X-Received: by 2002:a5d:6447:: with SMTP id d7mr7662959wrw.72.1628201405640;
        Thu, 05 Aug 2021 15:10:05 -0700 (PDT)
Received: from localhost.localdomain (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id q64sm6573055wma.8.2021.08.05.15.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 15:10:05 -0700 (PDT)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com,
        laurent.pinchart@ideasonboard.com
Subject: [PATCH v3 0/2] Check for endpoints in fwnode->secondary more sensibly
Date:   Thu,  5 Aug 2021 23:08:48 +0100
Message-Id: <20210805220850.131545-1-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all

A while ago I patched fwnode_graph_get_endpoint_by_id() to check for endpoints
against fwnode->secondary if none was found against the primary. It's actually
better to do this in fwnode_graph_get_next_endpoint() instead, since that
function is called by fwnode_graph_get_endpoint_by_id() and also directly called
in a bunch of other places (primarily sensor drivers checking that they have
endpoints connected during probe). This small series just adds the equivalent
functionality to fwnode_graph_get_next_endpoint() and reverts the earlier
commit.

Thanks
Dan


Daniel Scally (2):
  device property: Check fwnode->secondary in
    fwnode_graph_get_next_endpoint()
  Revert "media: device property: Call fwnode_graph_get_endpoint_by_id()
    for fwnode->secondary"

 drivers/base/property.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

-- 
2.25.1

