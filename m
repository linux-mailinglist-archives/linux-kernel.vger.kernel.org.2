Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1C536B534
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 16:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbhDZOsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 10:48:42 -0400
Received: from mga11.intel.com ([192.55.52.93]:21599 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233674AbhDZOsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 10:48:40 -0400
IronPort-SDR: b5KYK9gnilesX9UMsHsQ3a5bUbMKkc5t9uRTMnVMz8c6xqqRsxmfMNB9vV712P34KRNU34XhUT
 Reg6WaI+hMXg==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="193159143"
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="193159143"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 07:47:58 -0700
IronPort-SDR: xAF0ReojVZp4G56c5x8ZDV+dz2jcspJFkZOmrFZ1WT3kd5A1Em0Zew7sknO5kSKO2voScgOOY0
 gkQxkXWzuMHg==
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="604228256"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 07:47:58 -0700
Date:   Mon, 26 Apr 2021 07:47:57 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     jpoimboe@redhat.com, jbaron@akamai.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] static_call: Use single copy of static_call_return0
Message-ID: <20210426144757.GV1401198@tassilo.jf.intel.com>
References: <20210425211140.3157580-1-ak@linux.intel.com>
 <YIZ2/2H4W1U5DNBm@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIZ2/2H4W1U5DNBm@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This is ARCH=i386 only afaict, why do we care?

Well I'm trying to make LTO build even for 32bit.

Besides the bug with self test is real everywhere.

But looks like the patch didn't apply (I had some earlier
patches which were apparently needed). I'll rebase and repost.

-Andi
