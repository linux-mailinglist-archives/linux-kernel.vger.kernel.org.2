Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 203B236F98D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 13:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbhD3Lr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 07:47:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:33088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231766AbhD3LrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 07:47:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BDBDC613E8;
        Fri, 30 Apr 2021 11:46:35 +0000 (UTC)
Date:   Fri, 30 Apr 2021 12:46:32 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-arm-kernel@lists.infradead.org'" 
        <linux-arm-kernel@lists.infradead.org>,
        'James Morse' <james.morse@arm.com>,
        "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>
Subject: Re: About add an A64FX cache control function into resctrl
Message-ID: <YIvuGLmcJcw2jLT7@arm.com>
References: <OSAPR01MB214600C7923AEF7C35B02E648B739@OSAPR01MB2146.jpnprd01.prod.outlook.com>
 <OSAPR01MB214657641D532FB8D112DD528B479@OSAPR01MB2146.jpnprd01.prod.outlook.com>
 <bb0967c0-5b88-c6c2-0242-1e3928189a04@intel.com>
 <OSAPR01MB2146D42FC04779268BA231878B409@OSAPR01MB2146.jpnprd01.prod.outlook.com>
 <14ddf86b-89e1-ba26-b684-f3d5d5f8ade7@intel.com>
 <49cdd0b707194148915e2efe2ab5d707@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49cdd0b707194148915e2efe2ab5d707@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 05:50:20PM +0000, Luck, Tony wrote:
> >>>> [Sector cache function]
> >>>> The sector cache function split cache into multiple sectors and
> >>>> control them separately. It is implemented on the L1D cache and
> >>>> L2 cache in the A64FX processor and can be controlled individually
> >>>> for L1D cache and L2 cache. A64FX has no L3 cache. Each L1D cache and
> >>>> L2 cache has 4 sectors. Which L1D sector is used is specified by the
> >>>> value of [57:56] bits of address, how many ways of sector are
> >>>> specified by the value of register (IMP_SCCR_L1_EL0).
> >>>> Which L2 sector is used is specified by the value of [56] bits of
> >>>> address, and how many ways of sector are specified by value of
> >>>> register (IMP_SCCR_ASSIGN_EL1, IMP_SCCR_SET0_L2_EL1,
> >>>> IMP_SCCR_SET1_L2_EL1).
> 
> Are A64FX binaries position independent?  I.e. could the OS reassign
> a running task to a different sector by remapping it to different virtual
> addresses during a context switch?

Arm64 supports a maximum of 52-bit of virtual or physical addresses. The
maximum the MMU would produce would be a 52-bit output address. I
presume bits 56, 57 of the address bus are used for some cache affinity
(sector selection) but they don't influence the memory addressing, nor
could the MMU set them.

-- 
Catalin
