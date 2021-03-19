Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75366342753
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 22:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhCSVBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 17:01:00 -0400
Received: from mga17.intel.com ([192.55.52.151]:9529 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231136AbhCSVAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 17:00:46 -0400
IronPort-SDR: aHzW9bhQipc9hNzzeInWZlqPynN1vHuixz4OVeZAGsXK6qf9JRdPUMoGnPR0Q4Ziy59Rc17RLC
 IBTfb49+05oA==
X-IronPort-AV: E=McAfee;i="6000,8403,9928"; a="169902284"
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="169902284"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 14:00:45 -0700
IronPort-SDR: gxmIQULOVcqooQHk7e0b9w0C/LmhVNefk/UJ4QKlXOHDTwzcV1PkQ2nHwNxTpV+mqqDYujWCZJ
 jSDrupOGAv4w==
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="413657275"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 14:00:45 -0700
Date:   Fri, 19 Mar 2021 21:00:37 +0000
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v5 1/3] x86/cpufeatures: Enumerate #DB for bus lock
 detection
Message-ID: <YFUQ9fNQc1IPZd5z@otcwcpicx3.sc.intel.com>
References: <20210313054910.2503968-1-fenghua.yu@intel.com>
 <20210313054910.2503968-2-fenghua.yu@intel.com>
 <877dm26fvo.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dm26fvo.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 09:35:39PM +0100, Thomas Gleixner wrote:
> On Sat, Mar 13 2021 at 05:49, Fenghua Yu wrote:
> > A bus lock is acquired though either split locked access to
> 
> s/though/through/
> either a 
> > Some CPUs have ability to notify the kernel by an #DB trap after a user
> 
> the ability

Thank you for your review, Thomas! Will fix the issues.

-Fenghua
