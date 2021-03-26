Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F296034AB07
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 16:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhCZPLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 11:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbhCZPL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 11:11:27 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD39C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:11:27 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id d2so5271690ilm.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pPbyh2/n0MvOIkXLJmahFB/CN/U6m46NpyC/vQAi3ec=;
        b=sse2O1nQL88L0N2KQLGe1gWwkY7/c3qUljkhRzNM/IIWE2lGFSjpeAUIHxJo1zWwZ7
         PmLQ1TzjSu4iR4oZlPTVF8cW19/1VhLvyRWpSzFzfRkPm4Yix1jD5mPvDA/9u37QY64w
         hDG5W8Ql+qLqrKOwrTthAdTR0tLbGeYfujB9Ic7ZPjGxIhhXZ9THuIYsKBj0XdbdhnSf
         DWoSccnBvNDQbs5MyUCxc5RH/6zfDJMhwe0Fh7yIs3eZv7cDGO48W9GybNIn6AuBmBTQ
         7Yru96OOElFze4h4bUynoXcIakTPaKAox5gmgIx1QqrTNkeNTK0DP6JnZ4GjbOMJHDiH
         Xh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pPbyh2/n0MvOIkXLJmahFB/CN/U6m46NpyC/vQAi3ec=;
        b=hMvR4fVk0qlT30McNrSZRfOnRhpilcO9S85fcn52tq1P78lotQ/mp1QCS4TOiARqi5
         VRtToRMx4TDNeADWyKdD7m4WKU+Yd0V7dr+UYkknQcKVbH9r1nmX3cmvLeUhdfaOOcV5
         OfZ5AzlV/wVtpocsnVhQ2Ci54OP5yYeNZLTVeAzJuIbcF1Rgt57E3phi/aWP+NxBeC2o
         /qtGk01vXP4u7JtrhVteKy4boy/b8SvFBG202qXy+JcXYn0664v8yyH777Hr+uH+hGfa
         srX1Ib9ZRLouNMTj2HhSaCEsMC0ozFMpoZjEKagwTgixfyuRMRwoC9tJqtuuJYID2tPy
         IA5A==
X-Gm-Message-State: AOAM532um3EsDLqiZ3pJovDHXyYG3O0kJD7QWd9wkgUv97umOvLZBLS7
        AyvAgACJA7yK/Hwt9wsKr7SB4g==
X-Google-Smtp-Source: ABdhPJxL1LXPdpJ7rzASPAykCISa+3I5DfV2Z1/Y0hkdZZEXpgG187/GjHx8eNwatrGiTFU+MQfPog==
X-Received: by 2002:a92:db43:: with SMTP id w3mr5702334ilq.150.1616771486507;
        Fri, 26 Mar 2021 08:11:26 -0700 (PDT)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id j17sm4537706iok.37.2021.03.26.08.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 08:11:26 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 00/12] net: ipa: rework resource programming
Date:   Fri, 26 Mar 2021 10:11:10 -0500
Message-Id: <20210326151122.3121383-1-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series reworks the way IPA resources are defined and
programmed.  It is a little long--and I apologize for that--but
I think the patches are best taken together as a single unit.

The IPA hardware operates with a set of distinct "resources."  Each
hardware instance has a fixed number of each resource type available.  
Available resources are divided into smaller pools, with each pool
shared by endpoints in a "resource group."  Each endpoint is thus
assigned to a resource group that determines which pools supply
resources the IPA hardware uses to handle the endpoint's processing.

The exact set of resources used can differ for each version of IPA.
Except for IPA v3.0 and v3.1, there are 5 source and 2 destination
resource types, but there's no reason to assume this won't change.

The number of resource groups used *does* typically change based on
the hardware version.  For example, some versions target reduced
functionality and support fewer resource groups.

With that as background...

The net result of this series is to improve the flexibility with
which IPA resources and resource groups are defined, permitting each
version of IPA to define its own set of resources and groups.  Along
the way it isolates the resource-related code, and fixes a few bugs
related to resource handling.

The first patch moves resource-related code to a new C file (and
header).  It generates a checkpatch warning about updating
MAINTAINERS, which can be ignored.  The second patch fixes a bug,
but the bug does not affect SDM845 or SC7180.

The third patch defines an enumerated type whose members provide
symbolic names for resource groups.

The fourth defines some resource limits for SDM845 that were not
previously being programmed.  That platform "works" without this,
but to be correct, these limits should really be programmed.

The fifth patch uses a single enumerated type to define both source
and destination resource type IDs, and the sixth uses those IDs to
index the resource limit arrays.  The seventh moves the definition
of that enumerated type into the platform data files, allowing each
platform to define its own set of resource types.

The eighth and ninth are fairly trivial changes.  One replaces two
"max" symbols having the same value with a single symbol.  And the
other replaces two distinct but otherwise identical structure types
with a single common one.

The 10th is a small preparatory patch for the 11th, passing a
different argument to a function that programs resource values.
The 11th allows the actual number of source and destination resource
groups for a platform to be specified in its configuration data.
That way the number is based on the actual number of groups defined.
This removes the need for a sort of clunky pair of functions that
defined that information previously.

Finally, the last patch just increases the number of resource groups
that can be defined to 8.

					-Alex

Alex Elder (12):
  net: ipa: introduce ipa_resource.c
  net: ipa: fix bug in resource group limit programming
  net: ipa: identify resource groups
  net: ipa: add some missing resource limits
  net: ipa: combine resource type definitions
  net: ipa: index resource limits with type
  net: ipa: move ipa_resource_type definition
  net: ipa: combine source and destination group limits
  net: ipa: combine source and destation resource types
  net: ipa: pass data for source and dest resource config
  net: ipa: record number of groups in data
  net: ipa: support more than 6 resource groups

 drivers/net/ipa/Makefile          |   2 +-
 drivers/net/ipa/ipa_data-sc7180.c | 102 +++++++++--------
 drivers/net/ipa/ipa_data-sdm845.c | 169 ++++++++++++++++-----------
 drivers/net/ipa/ipa_data.h        |  62 ++++------
 drivers/net/ipa/ipa_main.c        | 148 +-----------------------
 drivers/net/ipa/ipa_reg.h         |  46 +-------
 drivers/net/ipa/ipa_resource.c    | 182 ++++++++++++++++++++++++++++++
 drivers/net/ipa/ipa_resource.h    |  27 +++++
 8 files changed, 393 insertions(+), 345 deletions(-)
 create mode 100644 drivers/net/ipa/ipa_resource.c
 create mode 100644 drivers/net/ipa/ipa_resource.h

-- 
2.27.0

