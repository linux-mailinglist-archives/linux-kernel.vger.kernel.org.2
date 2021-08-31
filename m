Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFDE03FC7F0
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 15:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbhHaNOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 09:14:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:51756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232209AbhHaNON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 09:14:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 63A5B60F3A;
        Tue, 31 Aug 2021 13:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630415598;
        bh=syr4ALXQaGPBfav03TaiEXTWcXBCM+WsL0Six+TkBsU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PcqbQdUrrNtpLV95QHhuN7I7BG0URhPaTB04B6baZPN5pTaAhMSWSTeryRLSXRoYk
         dfWuXa17rlSdnnOss6ITSC4N8Ord2USqpM68nBoaH/f4DI0hBL9a1Odyb0rhDX8hd7
         4PiP/zJyP1NY4JG1MPqhVb+EjI1eWzuKdixwMgFptY/ulGxa2uJOTk2vHS8kUjMn++
         WnuZ32oUJWRVoiXvX5Sky96InQvU4c6cAzkGVX8a3MrelAxJhBM730HoWoTipc+qLM
         PJVwGbEOH8iYG81HU+bMnGQEzrLWVwi0ll2SoFOQGBpV4WBMIqYfeOpnqYxpB0FlFS
         xLhH+NVMu/0ew==
Date:   Tue, 31 Aug 2021 14:13:14 +0100
From:   Will Deacon <will@kernel.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     kernel test robot <oliver.sang@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, elver@google.com
Subject: Re: [mm]  f9ce0be71d:
 BUG:KCSAN:data-race_in_next_uptodate_page/next_uptodate_page
Message-ID: <20210831131313.GC31712@willie-the-truck>
References: <20210826144157.GA26950@xsang-OptiPlex-9020>
 <20210827154232.rrpetqsh5xxklkej@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827154232.rrpetqsh5xxklkej@box.shutemov.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Marco]

On Fri, Aug 27, 2021 at 06:42:32PM +0300, Kirill A. Shutemov wrote:
> On Thu, Aug 26, 2021 at 10:41:57PM +0800, kernel test robot wrote:
> > commit: f9ce0be71d1fbb038ada15ced83474b0e63f264d ("mm: Cleanup faultaround and finish_fault() codepaths")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > in testcase: trinity
> > version: 
> > with following parameters:
> > 
> > 	number: 99999
> > 	group: group-04
> > 
> > test-description: Trinity is a linux system call fuzz tester.
> > test-url: http://codemonkey.org.uk/projects/trinity/
> > 
> > 
> > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > 
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > 
> > +------------------------------------------------------------------------+-----------+------------+
> > |                                                                        | v5.11-rc4 | f9ce0be71d |
> > +------------------------------------------------------------------------+-----------+------------+
> > | BUG:KCSAN:data-race_in_next_uptodate_page/next_uptodate_page           | 0         | 19         |
> > | BUG:KCSAN:data-race_in_mark_page_accessed/next_uptodate_page           | 0         | 17         |
> > | BUG:KCSAN:data-race_in_next_uptodate_page/page_memcg                   | 0         | 13         |
> > | BUG:KCSAN:data-race_in_next_uptodate_page/unlock_page                  | 0         | 13         |
> > +------------------------------------------------------------------------+-----------+------------+
> > 
> > [  184.717904][ T1873] ==================================================================
> > [  184.718938][ T1873] BUG: KCSAN: data-race in next_uptodate_page / unlock_page
> > [  184.719828][ T1873]
> > [  184.720103][ T1873] write (marked) to 0xffffea00050f37c0 of 8 bytes by task 1872 on cpu 1:
> > [  184.721024][ T1873]  unlock_page+0x102/0x1b0
> > [  184.721533][ T1873]  filemap_map_pages+0x6c6/0x890
> > [  184.722102][ T1873]  handle_mm_fault+0x179c/0x27f0
> > [  184.722672][ T1873]  do_user_addr_fault+0x3fb/0x830
> > [  184.723263][ T1873]  exc_page_fault+0xc3/0x1a0
> > [  184.723845][ T1873]  asm_exc_page_fault+0x1e/0x30
> > [  184.724427][ T1873]
> > [  184.724720][ T1873] read to 0xffffea00050f37c0 of 8 bytes by task 1873 on cpu 0:
> > [  184.725575][ T1873]  next_uptodate_page+0x456/0x830
> > [  184.726161][ T1873]  filemap_map_pages+0x728/0x890
> > [  184.726747][ T1873]  handle_mm_fault+0x179c/0x27f0
> > [  184.727332][ T1873]  do_user_addr_fault+0x3fb/0x830
> > [  184.727905][ T1873]  exc_page_fault+0xc3/0x1a0
> > [  184.728440][ T1873]  asm_exc_page_fault+0x1e/0x30
> > [  184.729027][ T1873]
> > [  184.729313][ T1873] Reported by Kernel Concurrency Sanitizer on:
> > [  184.730019][ T1873] CPU: 0 PID: 1873 Comm: systemd-udevd Not tainted 5.11.0-rc4-00001-gf9ce0be71d1f #1
> > [  184.731103][ T1873] ==================================================================
> 
> Line annotation would be helpful.

Agreed.

> And I'm not very familiar with KCSAN. My guess it reports PageLock() vs.
> clearing PG_locked. In this context it looks safe, unless I miss
> something.

The access in clear_bit_unlock() is annotated as a full sizeof(long) atomic
write, so we could be racing with a non-atomic read of another bit in the
page flags but I can't spot where that happens before the trylock_page() in
next_uptodate_page().

> Do we need some annotation to help KCSAN?

clear_bit_unlock() is already instrumented and _most_ of the helpers in
page-flags.h look they should be as well by virtue of using test_bit().

Will
