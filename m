Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 438E237570D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 17:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235760AbhEFP25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 11:28:57 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:33385 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235495AbhEFP1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 11:27:50 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 42165580B72;
        Thu,  6 May 2021 11:26:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 06 May 2021 11:26:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:reply-to:mime-version
        :content-transfer-encoding; s=fm3; bh=idfxFi2niIlXphs1rSRpisMaNe
        RwPzwfRsm8hAUYBvQ=; b=hdYJWH8eNG6Nd+MRc3r283kN9IufmtoATaqfCU96YH
        ZKyLzDOs9mGhZSlD83jeL7H3DOqnFDCXn/VXD229UiHg68Vz+1cHYe64OVsP7fXV
        7i456IoTE2D8mIiUzaHreIvLE4WMfptERGMoBchm/EYEioelxClLvi0cEjk2Z8se
        Arvfi8vRUcvLA33pxjnXxQmlCVsyXNryd5LfhOBp+3pZvqI36t6IK+pdROusiIec
        gXu5SgWTBHSw0qxydioj5F1Ec3AtLzDDc5vIue2gJTGi+JN2UwBs88PaeFZ6CQwn
        7QhhXtghvdNckXVzjjQVUrQkB4SzeptEzI7DHQV/sbdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:reply-to:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=idfxFi
        2niIlXphs1rSRpisMaNeRwPzwfRsm8hAUYBvQ=; b=qf4gh/OodsbTyJHDo4/xMy
        XWnV10CwU190E3R4EbQH9v7/GANI/SHKBnKoNo+YtkMbM4Vnc0BA5STeVvOx5JAk
        QbOEJpYSN6+uvVxGfYHFJ7L3SvqPtmevmMEDxN1/w8HICPWdYg8gr/6WF1OWeC4H
        x2aX6/hzkjEnSGvUlD4WKg8F33YuV3SGpHhpJSiE/1iJqiNVsfPZAdb84Jetu6qY
        XNunEtvZhRhT1qIed+Qn+KrN2qp8++eFknjSTrCea322qDnqF8r0r698iXZ52kMQ
        De9S9QiodAWedpRqKM1DYX+rI3FeGwLbUo0bV5DgW4WFjPJIr4TakXPY/JZ5BjHg
        ==
X-ME-Sender: <xms:uAqUYGrwd9gPeAKsoo4Q35DN0k21ih8YX-F7vzB6dcZOwBTsluMPHA>
    <xme:uAqUYEq1vsKttdYmZns8vQbuUYqZk39i0XwlelX-r-VtyfJ3I2ACSUXUGpHbFA3EP
    wWe297Cea3xOilLwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdegtddgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkfforhgggfestdhqredtredttdenucfhrhhomhepkghiucgjrghn
    uceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepleetvddtvd
    dttdetffdvkeehffdtjefhkedtheffjeehvdejueektedukedufeffnecukfhppeefhedr
    udeigedrvdegiedrfeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:uAqUYLMErIUfUFgMn1Vg0Q8SCoKDDurhsnrKYRq-xtYdzqauGYzLgw>
    <xmx:uAqUYF4-Xkq7P3NYOoeHTxUKG1hdAQ7AhkWafRv4kOcorhVsc6ei9w>
    <xmx:uAqUYF7GFJU0sPIbPhr2222mLMhPSovf0-OhxdVibP6BnVZGPfaFkg>
    <xmx:ugqUYJrOGyYPTPEPpXL4CcsRluA-FRybwYHrtZtKjxQVPTg6ZHctJQ>
Received: from Threadripper.local (ec2-35-164-246-34.us-west-2.compute.amazonaws.com [35.164.246.34])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Thu,  6 May 2021 11:26:44 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH 0/7] Memory hotplug/hotremove at subsection size
Date:   Thu,  6 May 2021 11:26:16 -0400
Message-Id: <20210506152623.178731-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.30.2
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

Hi all,

This patchset tries to remove the restriction on memory hotplug/hotremove
granularity, which is always greater or equal to memory section size[1].
With the patchset, kernel is able to online/offline memory at a size indepe=
ndent
of memory section size, as small as 2MB (the subsection size).

The motivation is to increase MAX_ORDER of the buddy allocator and pageblock
size without increasing memory hotplug/hotremove granularity at the same ti=
me,
so that the kernel can allocator 1GB pages using buddy allocator and utiliz=
es
existing pageblock based anti-fragmentation, paving the road for 1GB THP
support[2].

The patchset utilizes the existing subsection support[3] and changes the
section size alignment checks to subsection size alignment checks. There are
also changes to pageblock code to support partial pageblocks, when pageblock
size is increased along with MAX_ORDER. Increasing pageblock size can enable
kernel to utilize existing anti-fragmentation mechanism for gigantic page
allocations.

The last patch increases SECTION_SIZE_BITS to demonstrate the use of memory
hotplug/hotremove subsection, but is not intended to be merged as is. It is
there in case one wants to try this out and will be removed during the final
submission.

Feel free to give suggestions and comments. I am looking forward to your
feedback.

Thanks.

Zi Yan (7):
  mm: sparse: set/clear subsection bitmap when pages are
    onlined/offlined.
  mm: set pageblock_order to the max of HUGETLB_PAGE_ORDER and
    MAX_ORDER-1
  mm: memory_hotplug: decouple memory_block size with section size.
  mm: pageblock: allow set/unset migratetype for partial pageblock
  mm: memory_hotplug, sparse: enable memory hotplug/hotremove
    subsections
  arch: x86: no MAX_ORDER exceeds SECTION_SIZE check for 32bit vdso.
  [not for merge] mm: increase SECTION_SIZE_BITS to 31

 arch/ia64/Kconfig                |   1 -
 arch/powerpc/Kconfig             |   1 -
 arch/x86/Kconfig                 |  15 +++
 arch/x86/entry/vdso/Makefile     |   1 +
 arch/x86/include/asm/sparsemem.h |   2 +-
 drivers/base/memory.c            | 176 +++++++++++++++----------------
 drivers/base/node.c              |   2 +-
 include/linux/memory.h           |   8 +-
 include/linux/mmzone.h           |   2 +
 include/linux/page-isolation.h   |   8 +-
 include/linux/pageblock-flags.h  |   9 --
 mm/Kconfig                       |   7 --
 mm/memory_hotplug.c              |  22 ++--
 mm/page_alloc.c                  |  40 ++++---
 mm/page_isolation.c              |  30 +++---
 mm/sparse.c                      |  55 ++++++++--
 16 files changed, 219 insertions(+), 160 deletions(-)

--=20
2.30.2

