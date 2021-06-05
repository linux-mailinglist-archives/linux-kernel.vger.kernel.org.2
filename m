Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE4E539CAF2
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 22:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhFEUkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 16:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbhFEUkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 16:40:04 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9CEC061766;
        Sat,  5 Jun 2021 13:38:16 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id a4so16319234ljd.5;
        Sat, 05 Jun 2021 13:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+SYsnPD+PSGWr1k+73rbBaEQQXCW1mzbtajnIfZKK7Y=;
        b=N/O08SB0WPG4EDIqHvwZd03MzezXE6LNC0RJ04kuzBgGq6Evymc28iUVqYIApmHOAZ
         BYF3fOyvMEMzWy36ZNsIXkUiGmLJ0DdS7ADzThydBT9U92L7pyRmqv+o1E+68sPOiU9X
         TQELW/I0mBi1lUB2uwfa8eeD/VAipdTLkdBKlB4y1olot8gp2RfZMVzyxP/rv5BsQTdu
         ueBM+G+YgXSVxSg+SAvhUHHnbQI/DPBBi+xZpLfLrlVY/F7kr3+BdiQn0v1a4HvGYOXn
         zsObICll5YEZOi80m1l6uOV+mNI7SHBwKaQ4/YV764VpKn6nL0VnIneDEHYNUOZRUmYb
         YJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+SYsnPD+PSGWr1k+73rbBaEQQXCW1mzbtajnIfZKK7Y=;
        b=LA0fbCwNogM/QZJaHt5MT7+RA5Mu25OX5fLw0PT4i2vB4+ZlQ84z3n4oUMlI22jKw1
         vTJsx+1qzqtHudZ5fyEztQXk3z12/7pyXbp2gKtnyr9nNks+0cmYzI/uGK2XbbcJwIxz
         wuDTF63Y8ysuFZZX7E4aIHpI5WfFYXYzXgeYa+DHHySlsfAvSuCH2pmbUSValdtrNx3p
         GEFoIxeKnrKKJTLOBHGOXHxBELluZHjOgs21hY8xTmXtFl6raddC6iA8rHfOQp2i7Xnk
         zowWw+IOg5FtO1fxdF4JkMm4BYHUrzZlBNvz0W7I4SpB/ucWdRk+BZdjxLxYQ4ARnQR9
         40wg==
X-Gm-Message-State: AOAM53099u3Nc43PxIslSimkkWDupQj9aUARTaDLxsEDHGaFw876bucI
        uENBLxLN4/bj/wM9AJBFI/A=
X-Google-Smtp-Source: ABdhPJxkWHKu6l60+QINDe697Qn10ogavq7v7L/sG4EZWHZC0dKSemwuTKQEdT239fAxX8IM+7FlOA==
X-Received: by 2002:a2e:bf14:: with SMTP id c20mr8595860ljr.57.1622925494713;
        Sat, 05 Jun 2021 13:38:14 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-228-193.NA.cust.bahnhof.se. [98.128.228.193])
        by smtp.gmail.com with ESMTPSA id k24sm1170063ljg.43.2021.06.05.13.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 13:38:14 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Frank Seidel <frank@f-seidel.de>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Justin Ernst <justin.ernst@hpe.com>
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Travis <mike.travis@hpe.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 0/4] platform/x86: Constify static attribute_group structs
Date:   Sat,  5 Jun 2021 22:38:03 +0200
Message-Id: <20210605203807.60547-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Constify a couple of static attribute_group structs which are never
modified to allow the compiler to put them in read-only memory.

Rikard Falkeborn (4):
  platform/x86: hdaps: Constify static attribute_group struct
  platform/x86: intel_pmt_crashlog: Constify static attribute_group
    struct
  platform/x86: tc1100-wmi: Constify static attribute_group struct
  x86/platform/uv: Constify static attribute_group struct

 drivers/platform/x86/hdaps.c              | 2 +-
 drivers/platform/x86/intel_pmt_crashlog.c | 2 +-
 drivers/platform/x86/tc1100-wmi.c         | 2 +-
 drivers/platform/x86/uv_sysfs.c           | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.31.1

