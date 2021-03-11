Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE3E3337B68
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 18:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbhCKRyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 12:54:24 -0500
Received: from mga05.intel.com ([192.55.52.43]:20914 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229674AbhCKRyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 12:54:00 -0500
IronPort-SDR: /tQoLqy82EHVZ1aa+ZF7r3tfSe1j0/6A4IiRgc2F2RkFZWREIyXJyskTfKpLVkuQcJ5LL5mwkE
 ZnSkE+FOMgUQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9920"; a="273750296"
X-IronPort-AV: E=Sophos;i="5.81,241,1610438400"; 
   d="scan'208";a="273750296"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 09:54:00 -0800
IronPort-SDR: 64UgRSIX4VMgkrugPuGUiNFfz65Vn36pTUWZBx0bo0JzBCa9B1V/q/xrnmk7Gqtm3C7BIrUqEa
 V90yKouwSvAg==
X-IronPort-AV: E=Sophos;i="5.81,241,1610438400"; 
   d="scan'208";a="521159112"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 09:54:00 -0800
Date:   Thu, 11 Mar 2021 09:53:58 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kan.liang@linux.intel.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, acme@kernel.org, tglx@linutronix.de,
        bp@alien8.de, namhyung@kernel.org, jolsa@redhat.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com
Subject: Re: [PATCH V2 16/25] perf/x86: Register hybrid PMUs
Message-ID: <20210311175358.GF203350@tassilo.jf.intel.com>
References: <1615394281-68214-1-git-send-email-kan.liang@linux.intel.com>
 <1615394281-68214-17-git-send-email-kan.liang@linux.intel.com>
 <YEoOVTVhN3DpQXl2@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEoOVTVhN3DpQXl2@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> AFAICT we could register them all here. That instantly fixes that
> CPU_STARTING / CPU_DEAD fail elsewhere in this patch.

This would mean a system that only has Atoms or only has big cores
would still show the other CPU's PMU. We expect those to exist.

-Andi
