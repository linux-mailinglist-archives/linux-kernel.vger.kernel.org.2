Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C99415252
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 23:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237787AbhIVVFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 17:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237739AbhIVVFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 17:05:36 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C512AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 14:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/BsW4+kiX1t3eRyjco/t1BsfDHbZ3KbRhyDVWS+Vt7I=; b=ql0xsTOqfRkR2KMVRyT4j9GQnH
        xBbRjyKytCZUSUJ+9HKAZMqdSGbSfRC9O5UDt/L3Jp1Vhn6snjiEwO5KsILa51CaoOwysWfK+EUPv
        h3FZ/tSwtYWgkt/zUKRmVCfDu7f5880ZDl3/dYYvGq5BJi1Jq3GjjuegL2u199vbn+3gCBfgX3RxG
        hwPs2GQpD15j/fEfI9MYn86gD/5u4aothiVCyqd9WEHPv2vW/BCK6/ur9LSLm1bJ3jGREeuWsi4Tt
        iXkLkTNMLP0Gu1vYRXLBlCcAnC2SUtLDbi/f11t+XqQwiyNgy/b6XF8oZux90f6FmRQHN2MkpAynG
        RQ4XwaZg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mT9P7-0054sN-5g; Wed, 22 Sep 2021 21:03:47 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id C3C3D9811F0; Wed, 22 Sep 2021 23:03:43 +0200 (CEST)
Date:   Wed, 22 Sep 2021 23:03:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        iommu@lists.linux-foundation.org, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/8] tools/objtool: Check for use of the ENQCMD
 instruction in the kernel
Message-ID: <20210922210343.GU4323@worktop.programming.kicks-ass.net>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-8-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920192349.2602141-8-fenghua.yu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 07:23:48PM +0000, Fenghua Yu wrote:


> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index e5947fbb9e7a..91d13521d9d6 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -3133,6 +3133,21 @@ static int validate_reachable_instructions(struct objtool_file *file)
>  	return 0;
>  }
>  
> +static int validate_enqcmd(struct objtool_file *file)
> +{
> +	struct instruction *insn;
> +
> +	for_each_insn(file, insn) {
> +		if (insn->type == INSN_ENQCMD) {
> +			WARN_FUNC("enqcmd instruction", insn->sec,
> +				  insn->offset);
> +			return 1;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  int check(struct objtool_file *file)
>  {
>  	int ret, warnings = 0;
> @@ -3147,6 +3162,11 @@ int check(struct objtool_file *file)
>  	if (list_empty(&file->insn_list))
>  		goto out;
>  
> +	ret = validate_enqcmd(file);
> +	if (ret < 0)
> +		goto out;
> +	warnings += ret;
> +
>  	if (vmlinux && !validate_dup) {
>  		ret = validate_vmlinux_functions(file);
>  		if (ret < 0)

Since you're making it a fatal error, before doing much of anything
else, you might at well fail decode and keep it all in the x86/decode.c
file, no need to spread this 'knowledge' any further.

There's no actual state associated with it, you just want to avoid the
instruction being present.

Much simpler patch too.
