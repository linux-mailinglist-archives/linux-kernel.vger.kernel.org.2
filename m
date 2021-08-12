Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63EE63EA77E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 17:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237966AbhHLP0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 11:26:17 -0400
Received: from mga09.intel.com ([134.134.136.24]:17063 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232854AbhHLP0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 11:26:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10074"; a="215364362"
X-IronPort-AV: E=Sophos;i="5.84,316,1620716400"; 
   d="scan'208";a="215364362"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2021 08:25:50 -0700
X-IronPort-AV: E=Sophos;i="5.84,316,1620716400"; 
   d="scan'208";a="517494570"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2021 08:25:49 -0700
Date:   Thu, 12 Aug 2021 08:25:48 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+j44CA55u05LmfKQ==?= 
        <naoya.horiguchi@nec.com>
Cc:     Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 1/2] mm,hwpoison: fix race with hugetlb page allocation
Message-ID: <20210812152548.GA1579021@agluck-desk2.amr.corp.intel.com>
References: <20210603233632.2964832-1-nao.horiguchi@gmail.com>
 <20210603233632.2964832-2-nao.horiguchi@gmail.com>
 <20210812042813.GA1576603@agluck-desk2.amr.corp.intel.com>
 <20210812090303.GA153531@hori.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210812090303.GA153531@hori.linux.bs1.fc.nec.co.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021 at 09:03:04AM +0000, HORIGUCHI NAOYA(堀口 直也) wrote:
> Sorry for the failures. I think that the following patch (and dependencies)
> should solve the issue.
> https://lore.kernel.org/linux-mm/20210614021212.223326-6-nao.horiguchi@gmail.com/.
> I'll submit the update (maybe the patchset will be smaller by feedbacks)
> later soon.

I was uncertain about which dependencies you meant. So I followed
the advice in the cover letter for the patch series containing that
patch and did:

$ git fetch https://github.com/nhoriguchi/linux hwpoison

This kernel still has some odd issues and the poison page
did not get unmapped from my test user application.

See git://git.kernel.org/pub/scm/linux/kernel/git/aegl/ras-tools.git
for my test program. In this case I was just running with default settings
to inject an error into a user data page and then consume it.

Here's the dmesg output. There are multiple calls to memory_failure()
because the poison address is signalled both by the memory controller
(CMCI with UCNA signature) and the DCU (#MC with SRAR signature).

Note that the first message says: "recovery action for unknown page: Ignored"

[   70.331253] EINJ: Error INJection is initialized.
[   76.949490] process '/aegl/ras-tools/einj_mem_uc' started with executable stack
[   77.481846] Disabling lock debugging due to kernel taint
[   77.482004] mce: [Hardware Error]: Machine check events logged
[   77.487176] mce: Uncorrected hardware memory error in user-access at 7e025e400
[   77.493225] {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 0
[   77.508704] {1}[Hardware Error]: event severity: recoverable
[   77.514361] {1}[Hardware Error]:  Error 0, type: recoverable
[   77.520011] {1}[Hardware Error]:  fru_text: Card01, ChnG, DIMM0
[   77.525921] {1}[Hardware Error]:   section_type: memory error
[   77.531659] {1}[Hardware Error]:   error_status: 0x0000000000000400
[   77.537914] {1}[Hardware Error]:   physical_address: 0x00000007e025e400
[   77.544518] {1}[Hardware Error]:   node: 0 card: 6 module: 0 rank: 1 bank: 8 device: 0 row: 15105 column: 896
[   77.554503] {1}[Hardware Error]:   error_type: 4, single-symbol chipkill ECC
[   77.561548] {1}[Hardware Error]:   DIMM location: NODE 3 CPU0_DIMM_G1
[   77.568135] Memory failure: 0x7e025e: recovery action for unknown page: Ignored
[   77.575445] Memory failure: 0x7e025e: already hardware poisoned
[   77.627894] EDAC skx MC3: HANDLING MCE MEMORY ERROR
[   77.633600] EDAC skx MC3: CPU 0: Machine Check Event: 0x0 Bank 25: 0xac00000200a00090
[   77.633601] EDAC skx MC3: TSC 0x18d57ce28f4f25
[   77.633602] EDAC skx MC3: ADDR 0x7e025e400
[   77.633603] EDAC skx MC3: MISC 0x9000201d809c086
[   77.633603] EDAC skx MC3: PROCESSOR 0:0x606a6 TIME 1628780833 SOCKET 0 APIC 0x0
[   77.633608] EDAC MC3: 1 UE memory read error on CPU_SrcID#0_MC#3_Chan#0_DIMM#0 (channel:0 slot:0 page:0x7e025e offset:0x400 grain:32 -  err_code:0x00a0:0x0090  SystemAddress:0x7e025e400 ProcessorSocketId:0x0 MemoryControllerId:0x3 ChannelAddress:0xec04bc00 ChannelId:0x0 RankAddress:0x76025c00 PhysicalRankId:0x1 DimmSlotId:0x0 Row:0x3b01 Column:0x380 Bank:0x0 BankGroup:0x2 ChipSelect:0x1 ChipId:0x0)
[   77.633611] Memory failure: 0x7e025e: Sending SIGBUS to einj_mem_uc:12283 due to hardware memory corruption
[   77.668827] mce: [Hardware Error]: Machine check events logged
[   77.678605] Memory failure: 0x7e025e: already hardware poisoned
[   77.736685] EDAC skx MC3: HANDLING MCE MEMORY ERROR
[   77.742392] EDAC skx MC3: CPU 0: Machine Check Event: 0x0 Bank 255: 0xb40000000000009f
[   77.742394] EDAC skx MC3: TSC 0x0
[   77.742394] EDAC skx MC3: ADDR 0x7e025e400
[   77.742395] EDAC skx MC3: MISC 0x0
[   77.742395] EDAC skx MC3: PROCESSOR 0:0x606a6 TIME 1628780833 SOCKET 0 APIC 0x0
[   77.742397] EDAC MC3: 1 UE memory read error on CPU_SrcID#0_MC#3_Chan#0_DIMM#0 (channel:0 slot:0 page:0x7e025e offset:0x400 grain:32 -  err_code:0x0000:0x009f  SystemAddress:0x7e025e400 ProcessorSocketId:0x0 MemoryControllerId:0x3 ChannelAddress:0xec04bc00 ChannelId:0x0 RankAddress:0x76025c00 PhysicalRankId:0x1 DimmSlotId:0x0 Row:0x3b01 Column:0x380 Bank:0x0 BankGroup:0x2 ChipSelect:0x1 ChipId:0x0)
[   77.777612] Memory failure: 0x7e025e: already hardware poisoned

-Tony
