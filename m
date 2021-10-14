Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660ED42D40F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 09:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhJNHxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 03:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbhJNHxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 03:53:04 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66499C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 00:50:59 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id i24so22565689lfj.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 00:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RooZ5eoba+oXLkBGPbwUHBPuClbthLKLvnxYPQXohMk=;
        b=FEKnyGyCwlbBalVAvc+mEfhAa7h3OML4gx+nqy8kRNBiK6EA1u3Zf/ZOGcLv5qkMFA
         hGOz+R4o6d8lO/r42yKvLdLsVLLOkcIfe+LsyusnIhVRxd2wyYI9WgHEAzZsiUQDNA1Q
         +98mtguOfOSEFUgLnZ/OmGUVbBUTSpVjm3sRunkR6ZeIquwel5aR+It+eF62j+BrvxXm
         FVUdmWnoEzL5v/2yHS2T9kXKdp7Mb3yaqc4M924Evc6J+UT1e/MhgDU6rSUx62DUWrXs
         vre9++Me3m8lcE9yaKvPXmG+ZQIUTah8IE2HFtBdBt+J5BhKEttmsEeJzYNBLGG8UYQs
         AJdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RooZ5eoba+oXLkBGPbwUHBPuClbthLKLvnxYPQXohMk=;
        b=ghCTMaQ05M4w7U29yK+EzefFffXMVgT6a2fOkJ/zvSfa3jmRGJ9h3jZsoYE8LDXdks
         vP5VmfeHQ0+RC/AryoRDVuIGPT95XGgJS+ELJSe5UECnBYxiVb8mvlcC2Yp07w2xZ1zC
         y4ECz5AJkpaKuf1hqMvttCpdMjsivgaNJUsKp7md7Fn7fVrdV9H+f2yIX9AjlsS/Gwms
         mblYjytTwOqAim9tGQmNPTNQInqo/5eZB6IpF3GpPOEA8Rq2/aT4asqvc2Mrqj+6+Xff
         tPNmLMXCw8lzgszUtDv+Wp3kz619u0JuSK8i2jzNb8kKuPSgsv8xA/htz75pDBfP3inF
         7TYw==
X-Gm-Message-State: AOAM531PKYuvBQ7sNjb1z5CXl2K3fkYAvPbF6fHRgVebNhibVJeQVCIO
        LX0Re7jO+GjE+IyT1ZKKJcQ=
X-Google-Smtp-Source: ABdhPJyvO63fd+K2+k9W+rncLMl5j0D2kP4AtW3RWmxBm71jlgXrePyelKff7oeRPYjkJlzRCSnlsw==
X-Received: by 2002:a05:6512:314b:: with SMTP id s11mr3873277lfi.206.1634197857807;
        Thu, 14 Oct 2021 00:50:57 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-5.NA.cust.bahnhof.se. [158.174.22.5])
        by smtp.gmail.com with ESMTPSA id t82sm172281lff.50.2021.10.14.00.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 00:50:57 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 0/2] mm: constify static mm_walk_ops
Date:   Thu, 14 Oct 2021 09:50:40 +0200
Message-Id: <20211014075042.17174-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Constify a few instances of static struct mm_walk_ops that are never
modified. The only usage of them is to pass their address to
walk_page_range() which has a pointer to const struct mm_walk_ops as
argument. Making them const allows the compiler to put them in read-only
memory.

Rikard Falkeborn (2):
  mm/damon/vaddr: constify static mm_walk_ops
  mm/memory_failure: constify static mm_walk_ops

 mm/damon/vaddr.c    | 4 ++--
 mm/memory-failure.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.33.0

