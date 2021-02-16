Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED3531CC93
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 16:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhBPPEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 10:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbhBPPEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 10:04:34 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07FAC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 07:03:54 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id c1so7259636qtc.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 07:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nlIjDNwciuLZerl/8KMONEqRooC3ce2GyvtFs6F4uM4=;
        b=P1tfOetut2I2vGuRsUKhLDELRY/NzRBZQxkQX1Ao+vkgFWiyG9YY+qr9ELeKuwaTxG
         aTSaaRybuoY6kMpmZwSgvG7WMstkZ76HrGR0prajouzqodZt7EqyyiXcOgCHLc3uqWhq
         YfiQKKqvetgRothSFf4Ye+tKYmpwTv6E1uPKadXRX6QOCOF7GlGpuBmQ5S4F79g+HeSn
         W/xyt0A0bLSF1t1eAOWhAUwbIrntQ/vA5ygdkpZJhU2QqFNCMJElApwFgmJKJocGpLWw
         /BAYG/2p3vVaeFikeTJ8bL2J5rf5o41pVgnVRflLTXhi1BAqNfEQKJyvMJG1jepugJoH
         /QSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nlIjDNwciuLZerl/8KMONEqRooC3ce2GyvtFs6F4uM4=;
        b=BfSb7b2OfDBpZB+IvU0Vj7CSo3s8IA31v+ue2X80Vh2ak0LjK6sIjlXFA9gazAz2Vl
         PcYFavvzmqXR/4BPTqIbGGvUY6Sx4/uH4b7qo15lxl+SogugejofKuGM9SrRD0Qahdwp
         XDPm0HEm0N/iUwFYctLa16jBYfq7u6u18d9mQ0PhpLBJAYauiDwB3mV73XmlqCLq1QCg
         OoxGICtf/BR0yq6ULpBPo/w4yxDpC606Umfd2KuYYZaWmhaU0oS4fniowd9ne17Cy0Z7
         F68b0aJ0NM4YBB3aZmwDqNQ0NwaxoCc7UtDOxs/3VKRMXwIL0+VntpXBIeBfCd8iaHG8
         DHpA==
X-Gm-Message-State: AOAM5332ZzN9rutDUXhS2dFh/ULO11P8Idnq0pX8L+5tzZ0TdPz4OIYu
        5m2AJGT75lsILRuSZb3yzmuH5Q==
X-Google-Smtp-Source: ABdhPJwMh/Z5O55xxWEmoIiSjHCE6yEstHKMQGgxQ/3H13B7Iy838arwlkSGi/GCtdewYjPehohTxQ==
X-Received: by 2002:ac8:5bc4:: with SMTP id b4mr19105609qtb.240.1613487833590;
        Tue, 16 Feb 2021 07:03:53 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id t19sm14974271qke.109.2021.02.16.07.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 07:03:52 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, tyhicks@linux.microsoft.com,
        jmorris@namei.org, catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        rppt@kernel.org, logang@deltatee.com, ardb@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mhocko@suse.com, linux-mm@kvack.org
Subject: [PATCH v3 0/1] correct the inside linear map range during hotplug check
Date:   Tue, 16 Feb 2021 10:03:50 -0500
Message-Id: <20210216150351.129018-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3:	- Sync with linux-next where arch_get_mappable_range() was
	  introduced.
v2:	- Added test-by Tyler Hicks
	- Addressed comments from Anshuman Khandual: moved check under
	  IS_ENABLED(CONFIG_RANDOMIZE_BASE), added 
	  WARN_ON(start_linear_pa > end_linear_pa);

Fixes a hotplug error that may occur on systems with CONFIG_RANDOMIZE_BASE
enabled.

Applies against linux-next.

v1:
https://lore.kernel.org/lkml/20210213012316.1525419-1-pasha.tatashin@soleen.com
v2:
https://lore.kernel.org/lkml/20210215192237.362706-1-pasha.tatashin@soleen.com

Pavel Tatashin (1):
  arm64: mm: correct the inside linear map range during hotplug check

 arch/arm64/mm/mmu.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

-- 
2.25.1

