Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7429F344D80
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 18:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbhCVRg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 13:36:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:48158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230177AbhCVRgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 13:36:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64EA961930;
        Mon, 22 Mar 2021 17:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616434592;
        bh=nsiN0ccJDMcIaK2Y/72J2a7a9Rr7WSaIOkvhW+vl9iE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OpDSRZwWLECkjWk+rbp6M4kwjOfTHiiv52IsuESLLqislGir6dLUjg+vgNL3CvxoN
         U1ypg2lLX+0O2EQ/2K9A4Rh8YXKnEAOiBYOkh12KsyBUMJpIuzRsbK5UkHoFXFonQf
         C3JDGTXgFj+ZlhxjfIiOHjnU6jh6bl/jYnZwryIymwgtqiG1KyMhTWBj4wP6ekQkZv
         W1MxGF/2kR0sGCWT+15l7oq5jQtZ7FP50rk2ieWX/fHIzDXXKh+NiT2m9ek0iBpUVf
         KoTgyZbpMyerR+Y2fWFITlNMSR2CGV8DwvQXS3aTXnpdcTJW+PU2X18A4DM8K7Fche
         AiFeHkJFPb53A==
Date:   Mon, 22 Mar 2021 18:36:24 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        jbaron@akamai.com, ardb@kernel.org, linux-kernel@vger.kernel.org,
        sumit.garg@linaro.org, oliver.sang@intel.com, jarkko@kernel.org
Subject: Re: [PATCH 3/3] static_call: Fix static_call_update() sanity check
Message-ID: <YFjVmFgXdsIIkGRV@gunter>
References: <20210318113156.407406787@infradead.org>
 <20210318113610.739542434@infradead.org>
 <20210318161308.vu3dhezp2lczch6f@treble>
 <YFOGvmWiJUDOHy7D@hirez.programming.kicks-ass.net>
 <YFSfwimq/VLmo1Lw@hirez.programming.kicks-ass.net>
 <20210319140005.7ececb11@gandalf.local.home>
 <YFT8wDrWvfpQoIWw@hirez.programming.kicks-ass.net>
 <20210319165749.0f3c8281@gandalf.local.home>
 <YFiuphGw0RKehWsQ@gunter>
 <YFjLqKV9GxGSXcAr@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YFjLqKV9GxGSXcAr@hirez.programming.kicks-ass.net>
X-OS:   Linux gunter 5.11.2-1-default x86_64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Peter Zijlstra [22/03/21 17:54 +0100]:
>On Mon, Mar 22, 2021 at 03:50:14PM +0100, Jessica Yu wrote:
>
>> It should be doable. If you want the exit sections to be treated the same as
>> module init, the following patch should stuff any exit sections into the module
>> init "region" (completely untested). Hence it should be freed together with the
>> init sections and it would identify as init through within_module_init(). Let
>> me know if this works for you.
>
>That does indeed seem to DTRT from a quick scan of module.c. Very nice
>tidy patch. I was afraid it'd be much worse.
>
>Assuming it actually works; for your Changelog:
>
>"Dynamic code patching (alternatives, jump_label and static_call) can
>have sites in __exit code, even it __exit is never executed. Therefore
>__exit must be present at runtime, at least for as long as __init code
>is.
>
>Additionally, for jump_label and static_call, the __exit sites must also
>identify as within_module_init(), such that the infrastructure is aware
>to never touch them after module init -- alternatives are only ran once
>at init and hence don't have this particular constraint.
>
>By making __exit identify as __init for UNLOAD_MODULE, the above is
>satisfied."

Thanks a lot for the changelog :-) I'll turn this into a formal patch
after some testing tomorrow.

Jessica
