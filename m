Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCE4538959F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 20:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbhESSlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 14:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbhESSlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 14:41:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB45C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 11:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=458hhqBv6jVmBU28pifWM9thQWXBek5SMeRXR8tNAn8=; b=LtHYOp+k9uOR4ys5woowV/HyLM
        pvAMx9jcjQruQTa6B93r6zdF1/rcM8DJ52xKyEwfLHsZCobFmGuGn2pmfEMKbI4zF3exGxNvg3AN7
        Udq8E+EdwenF5J3ta/GcqhM31+sIwK2awVI4Xf0CfOtfVrX7s2MWDR67F2Do3eKp0cjd65Y/T8xzd
        uLellQ/t3J37F4cJULlMQuAQY1a1OzQkKe0o3WVzSZGYEXFanPTZ7d8kT2+6f92B0pInCUlee69Ah
        t2+j736F62PdG9hvGPfq/IA6utGKbnzojeX6alLRtPUR/LjGFxobyYRLJkZMG/iwHdCL37bXG8r2+
        WV1Qvarw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1ljR5c-00FCzf-9m; Wed, 19 May 2021 18:38:43 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id CCD01986465; Wed, 19 May 2021 20:38:39 +0200 (CEST)
Date:   Wed, 19 May 2021 20:38:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "zhengjun.xing@intel.com" <zhengjun.xing@intel.com>
Subject: Re: [smp]  a32a4d8a81:  netperf.Throughput_tps -2.1% regression
Message-ID: <20210519183839.GH21560@worktop.programming.kicks-ass.net>
References: <20210519142742.GA5275@xsang-OptiPlex-9020>
 <16A4D949-D82D-4034-B5A4-DE4DADE15884@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <16A4D949-D82D-4034-B5A4-DE4DADE15884@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 06:17:35PM +0000, Nadav Amit wrote:
> >      1287 =B1 42%     +75.3%       2256 =B1 14%  interrupts.CPU111.CAL:=
Function_call_interrupts
> >      1326 =B1 43%     +71.0%       2267 =B1 13%  interrupts.CPU119.CAL:=
Function_call_interrupts
> >      1300 =B1 45%     +75.9%       2287 =B1 37%  interrupts.CPU120.CAL:=
Function_call_interrupts
> >      1299 =B1 45%     +60.1%       2081 =B1 28%  interrupts.CPU128.CAL:=
Function_call_interrupts
> >      1305 =B1 45%     +61.7%       2110 =B1 29%  interrupts.CPU131.CAL:=
Function_call_interrupts
> >      1299 =B1 45%     +61.8%       2102 =B1 28%  interrupts.CPU139.CAL:=
Function_call_interrupts
> >     66.67 =B1133%     -97.2%       1.83 =B1155%  interrupts.CPU14.TLB:T=
LB_shootdowns
> >      1299 =B1 45%    +107.8%       2700 =B1 33%  interrupts.CPU142.CAL:=
Function_call_interrupts
> >    301.83 =B1128%     -95.6%      13.17 =B1140%  interrupts.CPU149.RES:=
Rescheduling_interrupts
> >    389.17 =B1 89%     -73.5%     103.17 =B1 35%  interrupts.CPU164.NMI:=
Non-maskable_interrupts
> >    389.17 =B1 89%     -73.5%     103.17 =B1 35%  interrupts.CPU164.PMI:=
Performance_monitoring_interrupts
> >      1299 =B1 45%     +60.2%       2081 =B1 28%  interrupts.CPU35.CAL:F=
unction_call_interrupts
> >      1244 =B1 50%     +66.8%       2076 =B1 27%  interrupts.CPU45.CAL:F=
unction_call_interrupts
> >      1300 =B1 44%     +59.5%       2075 =B1 28%  interrupts.CPU46.CAL:F=
unction_call_interrupts
> >      1.50 =B1 63%   +1422.2%      22.83 =B1167%  interrupts.CPU47.RES:R=
escheduling_interrupts
> >    467.33 =B1 85%     -64.6%     165.67 =B1 74%  interrupts.CPU58.NMI:N=
on-maskable_interrupts
> >    467.33 =B1 85%     -64.6%     165.67 =B1 74%  interrupts.CPU58.PMI:P=
erformance_monitoring_interrupts
> >    306.67 =B1 75%     -59.9%     122.83 =B1 16%  interrupts.CPU68.NMI:N=
on-maskable_interrupts
> >    306.67 =B1 75%     -59.9%     122.83 =B1 16%  interrupts.CPU68.PMI:P=
erformance_monitoring_interrupts
> >      1131 =B1 27%     +61.2%       1822 =B1 35%  interrupts.CPU85.CAL:F=
unction_call_interrupts
> >      1180 =B1 31%     +79.6%       2119 =B1 24%  interrupts.CPU86.CAL:F=
unction_call_interrupts
> >=20

It looks to be sending *waay* more call IPIs, did we mess up the mask or
loose an optimization somewhere?

I'll go read the commit again...
