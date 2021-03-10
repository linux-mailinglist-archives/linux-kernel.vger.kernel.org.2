Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F73334889
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 21:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbhCJUCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 15:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbhCJUBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 15:01:55 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266AFC061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 12:01:55 -0800 (PST)
Received: from zn.tnic (p200300ec2f0a99003f1bbc95990cb77c.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:9900:3f1b:bc95:990c:b77c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7A7DD1EC04D6;
        Wed, 10 Mar 2021 21:01:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1615406513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=7O2nTbrjL/Gk1GuNLbOK8bARbxQ+F5j/WXtPImSmulQ=;
        b=d1h4fkrDuaqf9JyaBpKBWxBZ9q4NFeZpJP7lNyFDOb3hBCAQJAV5GWB/JdoTzxsS6KCgXA
        FyT2oE5sg9BEXMnACZQCIsxRBqKetF/ESyx0yyyEhnfLeHVEnlIk9Yx6mGbFU7HsmiGS6P
        fea9MFXReerxEoL6CA+YmxQErRSf6+0=
Date:   Wed, 10 Mar 2021 21:01:47 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     kan.liang@linux.intel.com, peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, acme@kernel.org, tglx@linutronix.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH V2 1/25] x86/cpufeatures: Enumerate Intel Hybrid
 Technology feature bit
Message-ID: <20210310200147.GJ23521@zn.tnic>
References: <1615394281-68214-1-git-send-email-kan.liang@linux.intel.com>
 <1615394281-68214-2-git-send-email-kan.liang@linux.intel.com>
 <20210310165358.GI23521@zn.tnic>
 <20210310194644.GA1218@ranerica-svr.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210310194644.GA1218@ranerica-svr.sc.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 11:46:44AM -0800, Ricardo Neri wrote:
> But this series provides the use case, right? Kan's patches handle PMU counters
> that may differ cross types of CPUs. In patch 2, get_hybrid_params()
> needs to check first if X86_FEATURE_HYBRID_CPU is enabled before
> querying the hybrid parameters. Otherwise, we would need to rely on the
> maximum level of CPUID, which may not be reliable.

On Wed, Mar 10, 2021 at 11:33:54AM -0800, Srinivas Pandruvada wrote:
> We are working on changes to P-State driver for hybrid CPUs using this
> define. They are still work in progress.
> But this patch can be submitted later with our set of changes.

Answering to both with a single mail:

I don't have a problem with X86_FEATURE_HYBRID_CPU - I simply don't want
to show "hybrid_cpu" in /proc/cpuinfo unless there's a valid use case
for userspace to know that it is running on a hybrid CPU.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
