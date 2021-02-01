Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09E230AA96
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 16:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhBAPE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 10:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhBAPDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 10:03:07 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E797C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 07:03:09 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id r20so8848277qtm.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 07:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=deHU/5f8PHajyLyDJIlNQ5zcVqSMCB9/wLe3/c8jJXE=;
        b=dvJDb0s1OHO+4t3bduSXi+DeahxISuRTO4AM/J9z7G6iGl4J3NK70ZfzCNiLodS63j
         SfFlrv9cc/5O7HmPnx/VQ6hjoOXIVln3U76ix4g0APjNSS4CCqYQC497F5sRyLVqgizL
         mr8+vdpLtOr/PRUGgXoyXc7nJpVfwarFc7Im2NYbVvxYcPdLgcWH7wb+Uv1lJk43XHb4
         eP+fJLhQY/Li27LfjSNtDIzGEkjMPUZVe0QJnFxTatI29KLqfI5YFOc8R7ztFV5HF0J4
         Ug30h0y/XcmBiXDVBKktka4TstZI/1ps7cmn8Bqus+gnexfbOuZNowpcXSyVYqnooNrc
         guhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=deHU/5f8PHajyLyDJIlNQ5zcVqSMCB9/wLe3/c8jJXE=;
        b=RRPt/kKH3MyJOu/rr27rU4XYOvEcBUEvmJofix/ojbj7DhmCuz7kgO0XPL0AQzy7cm
         7doMvbCH7gnQAQdZcmvX966tqP/wzsmNxEqK6LkrEzPHcLiIhecCAokLoVClsxc2RZLc
         mGU78ln4rGuEI5cJ0Tq2Na9crHys7FozXo/u0Vsa5iLu/SEQxg5GhzlZ7n9Es5JBkDc4
         WlO0057cYzNXOrUL3kVSZM9cnfOiNSp6iSuWA5w1Dfv5LGnxQdQVJU11jdOadTcbl9OO
         ZGrBZ7POGd+GWFtBiqy+HNYPusb/+zOy3Tf+tUNnw8nvnrYvCeNw3PA0ApQD5HAfvy6L
         oVDQ==
X-Gm-Message-State: AOAM530o8NmlpJVtSQX8d9YGSnkJvkO70LzJpoflFTHtPCcBBOmN7thP
        6V1KoI+pQZcvFEw/cRr/qIjwHw==
X-Google-Smtp-Source: ABdhPJzAr78t2E5klmuyx8MGl3LU9tNADQKmasms3UUqO3mX7dyoDGGV3/WKNW2WmMfduzQZxk6p8Q==
X-Received: by 2002:a05:622a:10f:: with SMTP id u15mr15343934qtw.198.1612191788498;
        Mon, 01 Feb 2021 07:03:08 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id b16sm6970160qkh.21.2021.02.01.07.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 07:03:07 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, mark.rutland@arm.com, steve.capper@arm.com,
        rfontana@redhat.com, selindag@gmail.com,
        tyhicks@linux.microsoft.com
Subject: [PATCH 0/1] arm64/hibernate: sparse warnings fix
Date:   Mon,  1 Feb 2021 10:03:05 -0500
Message-Id: <20210201150306.54099-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is against for-next/kexec, fix for sparse warning that was reported by
kernel test robot [1].

[1] https://lore.kernel.org/linux-arm-kernel/202101292143.C6TcKvvX-lkp@intel.com

Pavel Tatashin (1):
  arm64: hibernate: add __force attribute to gfp_t casting

 arch/arm64/kernel/hibernate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.25.1

