Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412AF344828
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbhCVOwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:52:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:58180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231415AbhCVOuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:50:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2EAD96198B;
        Mon, 22 Mar 2021 14:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616424620;
        bh=0SF0KO5Kry00j5ygkfYySAeJ4cijAmCF74RG4JU426E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TFxB1EOHQj4T1GlljZzPBmls8JGY3vf/VfjGwEqXtxHWu9WFP7QveIDnc2DrjyU8a
         yuJ3xBcqyMAps8f+G721IAX3Ws62Mtqia3UC0vnU7LsT89AZqdp+p2Wum/Ti9BjsS/
         2N5zQF53nlixNQ3BqcqAdmL3aGN18K0+zQb24Cew5PwKgNRLfyesOpPKOdeT41mwm9
         4kwp2UzJSzovUXGgobXm+ZrVYVBoafQVXcESlXDMoLPCtGVv6ils4520INQ8Vfd0EL
         aoQETABMi8in2n02McC4+A4ToRUbTdTY1J22G38xf74gBmkjWqnlYqrVWnO/UZdH3T
         T3UCgEzF0Op0A==
Date:   Mon, 22 Mar 2021 15:50:14 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        jbaron@akamai.com, ardb@kernel.org, linux-kernel@vger.kernel.org,
        sumit.garg@linaro.org, oliver.sang@intel.com, jarkko@kernel.org
Subject: Re: [PATCH 3/3] static_call: Fix static_call_update() sanity check
Message-ID: <YFiuphGw0RKehWsQ@gunter>
References: <20210318113156.407406787@infradead.org>
 <20210318113610.739542434@infradead.org>
 <20210318161308.vu3dhezp2lczch6f@treble>
 <YFOGvmWiJUDOHy7D@hirez.programming.kicks-ass.net>
 <YFSfwimq/VLmo1Lw@hirez.programming.kicks-ass.net>
 <20210319140005.7ececb11@gandalf.local.home>
 <YFT8wDrWvfpQoIWw@hirez.programming.kicks-ass.net>
 <20210319165749.0f3c8281@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210319165749.0f3c8281@gandalf.local.home>
X-OS:   Linux gunter 5.11.2-1-default x86_64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Steven Rostedt [19/03/21 16:57 -0400]:
>On Fri, 19 Mar 2021 20:34:24 +0100
>Peter Zijlstra <peterz@infradead.org> wrote:
>
>> On Fri, Mar 19, 2021 at 02:00:05PM -0400, Steven Rostedt wrote:
>> > Would making __exit code the same as init code work? That is, load it just
>> > like module init code is loaded, and free it when the init code is freed
>>
>> As stated, yes. But it must then also identify as init through
>> within_module_init().
>
>I think that's doable. Since the usecases for that appear to be mostly
>about "think code may no longer exist after it is used". Thus, having exit
>code act just like init code when UNLOAD is not set, appears appropriate.
>
>Jessica, please correct me if I'm wrong.

It should be doable. If you want the exit sections to be treated the same as
module init, the following patch should stuff any exit sections into the module
init "region" (completely untested). Hence it should be freed together with the
init sections and it would identify as init through within_module_init(). Let
me know if this works for you.

---

diff --git a/kernel/module.c b/kernel/module.c
index 30479355ab85..1c3396a9dd8b 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2802,7 +2802,11 @@ void * __weak module_alloc(unsigned long size)

  bool __weak module_init_section(const char *name)
  {
-       return strstarts(name, ".init");
+#ifndef CONFIG_UNLOAD_MODULE
+       return strstarts(name, ".init") || module_exit_section(name);
+#else
+       return strstarts(name, ".init")
+#endif
  }

  bool __weak module_exit_section(const char *name)
@@ -3116,11 +3120,6 @@ static int rewrite_section_headers(struct load_info *info, int flags)
                  */
                 shdr->sh_addr = (size_t)info->hdr + shdr->sh_offset;

-#ifndef CONFIG_MODULE_UNLOAD
-               /* Don't load .exit sections */
-               if (module_exit_section(info->secstrings+shdr->sh_name))
-                       shdr->sh_flags &= ~(unsigned long)SHF_ALLOC;
-#endif
         }

         /* Track but don't keep modinfo and version sections. */

