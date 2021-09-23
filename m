Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD3841683A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 00:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243527AbhIWW4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 18:56:30 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:20815 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243499AbhIWW43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 18:56:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1632437697; x=1663973697;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=e97zNOiwir1aJze+wIByrdjedbkrWs1OwK8P/jZcHPw=;
  b=H+npWXo7fzCPMWx+f5orbIkw+HxEEa5OSlyDiqmyMxgMaGHDVG1fRAqe
   o3m4hvOhPY+Cc+O4+tLhPPtGhw+OIlARGzAlRqSljmG40RccIne/GR9P2
   OsEIXsDFmwMrYYok/EamT61XH5okacc7RKFhi+io42DUGgLoFCzvVADcl
   c=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 23 Sep 2021 15:54:57 -0700
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2021 15:54:56 -0700
Received: from hu-cgoldswo-sd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Thu, 23 Sep 2021 15:54:55 -0700
From:   Chris Goldsworthy <quic_cgoldswo@quicinc.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     David Hildenbrand <david@redhat.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Chris Goldsworthy <quic_cgoldswo@quicinc.com>
Subject: [RFC] arm64: mm: update max_pfn after memory hotplug
Date:   Thu, 23 Sep 2021 15:54:47 -0700
Message-ID: <cover.1632437225.git.quic_cgoldswo@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On arm64 we set max_pfn at boot in arch/arm64/mm/init.c. If you
hotplug in memory after booting up, max_pfn is not updated. This
breaks diagnostic functions executed from user space like
read_page_owner():

https://elixir.bootlin.com/linux/v5.14.7/source/mm/page_owner.c#L472

or kpageflags_read() (see how get_max_dump_pfn() is used):

https://elixir.bootlin.com/linux/v5.14.7/source/fs/proc/page.c#L47

Thus, this patch updates max_pfn and max_low_pfn in arm64's
arch_add_memory() function, mirroring what is updatated during boot:

https://elixir.bootlin.com/linux/v5.14.7/source/arch/arm64/mm/init.c#L448

We would appreciate feedback on any other variables that should be
updated when hotplugging in memory - note that we're mirroring x86, in
that max_pfn is only ever incremented when calling arch_add_memory():

https://elixir.bootlin.com/linux/v5.14.7/source/arch/x86/mm/init_64.c#L958

Sudarshan Rajagopalan (1):
  arm64: mm: update max_pfn after memory hotplug

 arch/arm64/mm/mmu.c | 5 +++++
 1 file changed, 5 insertions(+)

-- 
2.7.4

