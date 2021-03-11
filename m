Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5863371AB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 12:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbhCKLs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 06:48:56 -0500
Received: from mail.skyhub.de ([5.9.137.197]:49380 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232519AbhCKLsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 06:48:23 -0500
Received: from zn.tnic (p200300ec2f0e1f0084acfb80b2ea2480.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:1f00:84ac:fb80:b2ea:2480])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 203261EC0402;
        Thu, 11 Mar 2021 12:48:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1615463302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+T8jHdTHhTXNJ17K47mZybeuko0jgRMbn4SbH0sUdkg=;
        b=FRJ8cjgMaYtJEx1iTnulsaiaw7JRmDcl3bj7NpXHGkJa9VO6SX6482xP7lTZVYnwFqFMa4
        qLLphuvhe0nTUJceNI9a9lVHnVXqyWE0ClqR+Tx2VsWiu1tSSZEnq9Rsa+f+o11NaJtkCP
        DD3GQbDidxWavPnaFxswc0lI3O27zZg=
Date:   Thu, 11 Mar 2021 12:48:14 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     kan.liang@linux.intel.com
Cc:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, acme@kernel.org, tglx@linutronix.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH V2 2/25] x86/cpu: Add helper functions to get parameters
 of hybrid CPUs
Message-ID: <20210311114814.GA5829@zn.tnic>
References: <1615394281-68214-1-git-send-email-kan.liang@linux.intel.com>
 <1615394281-68214-3-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1615394281-68214-3-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 08:37:38AM -0800, kan.liang@linux.intel.com wrote:
> From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> 
> On processors with Intel Hybrid Technology (i.e., one having more than one
> type of CPU in the same package), all CPUs support the same instruction
> set and enumerate the same features on CPUID. Thus, all software can run
> on any CPU without restrictions. However, there may be model-specific
> differences among types of CPUs. For instance, each type of CPU may support
> a different number of performance counters. Also, machine check error banks
> may be wired differently. Even though most software will not care about
> these differences, kernel subsystems dealing with these differences must
> know. Add a new member to cpuinfo_x86 that subsystems can query to know
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

That is not the case anymore.

And it looks like the IPIing is going away too, which is good.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
