Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7EBF383CE2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 21:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbhEQTGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 15:06:35 -0400
Received: from mga07.intel.com ([134.134.136.100]:57963 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229535AbhEQTGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 15:06:34 -0400
IronPort-SDR: iLNQIz7gFZFXpMF1AfRD1TQbjfyMu9XpjCAorCIvGuHbx6vHed82j6/DTYgvgFCuszOALrk5KI
 6G8/WnmHFwnQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="264455305"
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="264455305"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 12:05:16 -0700
IronPort-SDR: Z9v9o8DbrVLe0FRxxLc+ZUfyNPJSk0zqwXQr4rZcJL68wEgUTlTZdFrvJzl6uYTLO20ZF1JBt7
 MVIn65zEPP3w==
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="410948020"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 12:05:16 -0700
Date:   Mon, 17 May 2021 19:05:10 +0000
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH 0/4] x86/bus_lock: Set rate limit for bus lock
Message-ID: <YKK+Zi/Q7e+eiePc@otcwcpicx3.sc.intel.com>
References: <20210419214958.4035512-1-fenghua.yu@intel.com>
 <YKK5/fgD4w+TVinx@otcwcpicx3.sc.intel.com>
 <877djxfal6.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877djxfal6.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 09:01:57PM +0200, Thomas Gleixner wrote:
> On Mon, May 17 2021 at 18:46, Fenghua Yu wrote:
> > On Mon, Apr 19, 2021 at 09:49:54PM +0000, Fenghua Yu wrote:
> >> Bus lock warn and fatal handling is in tip. This series sets system
> It's on my todo list already.

Thank you very much, Thomas!

-Fenghua
