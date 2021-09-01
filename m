Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D023FD152
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 04:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241535AbhIAC2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 22:28:41 -0400
Received: from mga02.intel.com ([134.134.136.20]:51686 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241128AbhIAC2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 22:28:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10093"; a="205830241"
X-IronPort-AV: E=Sophos;i="5.84,368,1620716400"; 
   d="scan'208";a="205830241"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2021 19:27:43 -0700
X-IronPort-AV: E=Sophos;i="5.84,368,1620716400"; 
   d="scan'208";a="460497806"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.41])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2021 19:27:41 -0700
Date:   Wed, 1 Sep 2021 10:45:18 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Will Deacon <will@kernel.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, elver@google.com
Subject: Re: [mm]  f9ce0be71d:
 BUG:KCSAN:data-race_in_next_uptodate_page/next_uptodate_page
Message-ID: <20210901024518.GB14661@xsang-OptiPlex-9020>
References: <20210826144157.GA26950@xsang-OptiPlex-9020>
 <20210827154232.rrpetqsh5xxklkej@box.shutemov.name>
 <20210831131313.GC31712@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210831131313.GC31712@willie-the-truck>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Will,

On Tue, Aug 31, 2021 at 02:13:14PM +0100, Will Deacon wrote:
> [+Marco]
> 
> On Fri, Aug 27, 2021 at 06:42:32PM +0300, Kirill A. Shutemov wrote:
> > On Thu, Aug 26, 2021 at 10:41:57PM +0800, kernel test robot wrote:
> > > commit: f9ce0be71d1fbb038ada15ced83474b0e63f264d ("mm: Cleanup faultaround and finish_fault() codepaths")
> > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > 
> > > in testcase: trinity
> > > version: 
> > > with following parameters:
> > > 
> > > 	number: 99999
> > > 	group: group-04
> > > 
> > > test-description: Trinity is a linux system call fuzz tester.
> > > test-url: http://codemonkey.org.uk/projects/trinity/
> > > 
> > > 
> > > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > > 
> > > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > > 
> > > +------------------------------------------------------------------------+-----------+------------+
> > > |                                                                        | v5.11-rc4 | f9ce0be71d |
> > > +------------------------------------------------------------------------+-----------+------------+
> > > | BUG:KCSAN:data-race_in_next_uptodate_page/next_uptodate_page           | 0         | 19         |
> > > | BUG:KCSAN:data-race_in_mark_page_accessed/next_uptodate_page           | 0         | 17         |
> > > | BUG:KCSAN:data-race_in_next_uptodate_page/page_memcg                   | 0         | 13         |
> > > | BUG:KCSAN:data-race_in_next_uptodate_page/unlock_page                  | 0         | 13         |
> > > +------------------------------------------------------------------------+-----------+------------+
> > > 
> > > [  184.717904][ T1873] ==================================================================
> > > [  184.718938][ T1873] BUG: KCSAN: data-race in next_uptodate_page / unlock_page
> > > [  184.719828][ T1873]
> > > [  184.720103][ T1873] write (marked) to 0xffffea00050f37c0 of 8 bytes by task 1872 on cpu 1:
> > > [  184.721024][ T1873]  unlock_page+0x102/0x1b0
> > > [  184.721533][ T1873]  filemap_map_pages+0x6c6/0x890
> > > [  184.722102][ T1873]  handle_mm_fault+0x179c/0x27f0
> > > [  184.722672][ T1873]  do_user_addr_fault+0x3fb/0x830
> > > [  184.723263][ T1873]  exc_page_fault+0xc3/0x1a0
> > > [  184.723845][ T1873]  asm_exc_page_fault+0x1e/0x30
> > > [  184.724427][ T1873]
> > > [  184.724720][ T1873] read to 0xffffea00050f37c0 of 8 bytes by task 1873 on cpu 0:
> > > [  184.725575][ T1873]  next_uptodate_page+0x456/0x830
> > > [  184.726161][ T1873]  filemap_map_pages+0x728/0x890
> > > [  184.726747][ T1873]  handle_mm_fault+0x179c/0x27f0
> > > [  184.727332][ T1873]  do_user_addr_fault+0x3fb/0x830
> > > [  184.727905][ T1873]  exc_page_fault+0xc3/0x1a0
> > > [  184.728440][ T1873]  asm_exc_page_fault+0x1e/0x30
> > > [  184.729027][ T1873]
> > > [  184.729313][ T1873] Reported by Kernel Concurrency Sanitizer on:
> > > [  184.730019][ T1873] CPU: 0 PID: 1873 Comm: systemd-udevd Not tainted 5.11.0-rc4-00001-gf9ce0be71d1f #1
> > > [  184.731103][ T1873] ==================================================================
> > 
> > Line annotation would be helpful.
> 
> Agreed.

Thanks a lot for suggestion! we will add line annotation.

> 
> > And I'm not very familiar with KCSAN. My guess it reports PageLock() vs.
> > clearing PG_locked. In this context it looks safe, unless I miss
> > something.
> 
> The access in clear_bit_unlock() is annotated as a full sizeof(long) atomic
> write, so we could be racing with a non-atomic read of another bit in the
> page flags but I can't spot where that happens before the trylock_page() in
> next_uptodate_page().
> 
> > Do we need some annotation to help KCSAN?
> 
> clear_bit_unlock() is already instrumented and _most_ of the helpers in
> page-flags.h look they should be as well by virtue of using test_bit().
> 
> Will
