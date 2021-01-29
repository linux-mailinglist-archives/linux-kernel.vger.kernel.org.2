Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53015309055
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 23:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbhA2W4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 17:56:18 -0500
Received: from mga14.intel.com ([192.55.52.115]:28781 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231388AbhA2W4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 17:56:12 -0500
IronPort-SDR: bWyRo2SOqlmdvVNRaWOFJd0jOYAWKR/5UgMJyhWaEWbv1Rrdwv/sp14cJN+RZuCCn6CpdKIP3t
 l6BizDPZORkw==
X-IronPort-AV: E=McAfee;i="6000,8403,9879"; a="179715426"
X-IronPort-AV: E=Sophos;i="5.79,386,1602572400"; 
   d="scan'208";a="179715426"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 14:55:31 -0800
IronPort-SDR: oWkJrKyr8/3tj4MBmSXFZ09RJd1uiVPCtGphBHHP6lK7WrTAe42T199htzu1bomke11bMLkDaa
 BwZn8fYtORpQ==
X-IronPort-AV: E=Sophos;i="5.79,386,1602572400"; 
   d="scan'208";a="370568754"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 14:55:30 -0800
Date:   Fri, 29 Jan 2021 14:55:29 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Aili Yao <yaoaili@kingsoft.com>
Cc:     x86@kernel.org, naoya.horiguchi@nec.com,
        linux-kernel@vger.kernel.org, yangfeng1@kingsoft.com
Subject: Re: [PATCH] x86/fault: Send SIGBUS to user process always for
 hwpoison page access.
Message-ID: <20210129225529.GA42172@agluck-desk2.amr.corp.intel.com>
References: <20210128194326.71895e92.yaoaili@kingsoft.com>
 <20210128174352.GA33283@agluck-desk2.amr.corp.intel.com>
 <20210129113334.344377ac.yaoaili@kingsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129113334.344377ac.yaoaili@kingsoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the explanation and test code. I think I see better what
is going on here.

[I took your idea for using madvise(...MADV_HWPOISON) and added a new "-S"
option to my einj_mem_uc test program to use madvise instead of ACPI/EINJ
for injections. Update pushed here:
	git://git.kernel.org/pub/scm/linux/kernel/git/aegl/ras-tools.git ]

There have been some small changes to arch/x86/mm/fault.c since you wrote
the patch.  Can you rebase to v5.11-rc5?

Also maybe this might be a case to use IS_ENABLED() instead of #ifdef to
make the code a little less ugly. At least for the 2nd hunk in your patch
this would work well:

	if (IS_ENABLED(CONFIG_MEMORY_FAILURE) &&
	    (fault & (VM_FAULT_HWPOISON|VM_FAULT_HWPOISON_LARGE)))
		no_context(regs, error_code, address, SIGBUS, BUS_MCEERR_AR);
	else
		no_context(regs, error_code, address, SIGBUS, BUS_ADRERR);

The first hunk might need a bit more thought.

-Tony
