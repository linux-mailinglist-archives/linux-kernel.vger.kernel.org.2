Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C5A41B6B3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 20:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242306AbhI1Sxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 14:53:38 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:40652 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbhI1Sxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 14:53:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1632855117; x=1664391117;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=i7LKpC2fde133igJaoJ2gVd1E/F2FN0XTx3T9Dr3+Dw=;
  b=aP0bzvjc5Y21uUiYRrTaW8Kofu5Tq58ucs82DeT3lZ7TYbc+1avbGwIU
   Tavchfir8GJgWwsXWCTelSlkxN5hBCEMoiQzdd+XkOBW3/ky0kwMEcp8x
   PM2p49URcmEckIABdNZ2AY83rsYO2yLxfc2ISHc5nqPukfJvyXtdIj5li
   s=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 28 Sep 2021 11:51:57 -0700
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 11:51:56 -0700
Received: from hu-cgoldswo-sd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Tue, 28 Sep 2021 11:51:55 -0700
From:   Chris Goldsworthy <quic_cgoldswo@quicinc.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Sudarshan Rajagopalan" <quic_sudaraja@quicinc.com>,
        Georgi Djakov <quic_c_gdjako@quicinc.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Chris Goldsworthy <quic_cgoldswo@quicinc.com>
Subject: arm64: mm: update max_pfn after memory hotplug
Date:   Tue, 28 Sep 2021 11:51:48 -0700
Message-ID: <cover.1632853776.git.quic_cgoldswo@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow up of RFC patch:

https://lore.kernel.org/linux-mm/a3bf84c4-8f35-f273-145c-55928a06f332@quicinc.com/T/#m219937b1acdd40318bbe90ab39f187804775eb74

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

Quick reference for David's Acked-by, with a follow-up discussion on
max_low_pfn:

https://lore.kernel.org/linux-mm/a3bf84c4-8f35-f273-145c-55928a06f332@quicinc.com/T/#m7d30b3afa632a4fa836f5fe55f4ee8e7bbc83e5d
https://lore.kernel.org/linux-mm/a3bf84c4-8f35-f273-145c-55928a06f332@quicinc.com/T/#m0d0e509375af1504d25451d079c5cbd6e7aa513b

Sudarshan Rajagopalan (1):
  arm64: mm: update max_pfn after memory hotplug

 arch/arm64/mm/mmu.c | 5 +++++
 1 file changed, 5 insertions(+)

-- 
2.7.4

