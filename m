Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0CF73AD829
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 08:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbhFSGkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 02:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbhFSGkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 02:40:52 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A214DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 23:38:41 -0700 (PDT)
Received: from zn.tnic (p200300ec2f246700fd06b376b270bc91.dip0.t-ipconnect.de [IPv6:2003:ec:2f24:6700:fd06:b376:b270:bc91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 52DED1EC0598;
        Sat, 19 Jun 2021 08:38:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1624084717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=VddUBuoes3XOSU2mW20xa4pvFao5Caqu6cazeuMucSM=;
        b=bjWZ+EnNw/BT8j1PHqoQ68XDpbUgbuXR13oYuCQY4JIMYjICEEGfd8PUSaV+Se8rAQi+xt
        XaTUIcau4lunH+9PPh+KMK4v/F3ODG5IlITvU5ji9sB4JM1hGu+K8etSkMqb/TG7/pWIXj
        YYDIFEakjTSvSv/sK7hzTEtXiZxJKN0=
Date:   Sat, 19 Jun 2021 08:38:27 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/11] x86/cpufeatures: Add TDX Guest CPU feature
Message-ID: <YM2Q46fcNobyobek@zn.tnic>
References: <20210618225755.662725-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210618225755.662725-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YM0uoTnAi7TpU5fF@zn.tnic>
 <6b68dc50-4d4c-f724-8ab8-0a12a07d42aa@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6b68dc50-4d4c-f724-8ab8-0a12a07d42aa@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 05:13:39PM -0700, Kuppuswamy, Sathyanarayanan wrote:
> On 6/18/21 4:39 PM, Borislav Petkov wrote:
> >  From Documentation/process/submitting-patches.rst:
> > 
> > "Both Tested-by and Reviewed-by tags, once received on mailing list from tester
> > or reviewer, should be added by author to the applicable patches when sending
> > next versions.  However if the patch has changed substantially in following
> > version, these tags might not be applicable anymore and thus should be removed.
> > Usually removal of someone's Tested-by or Reviewed-by tags should be mentioned
> > in the patch changelog (after the '---' separator)."
> > 
> > IOW, for the next revisions of your patchsets, you should drop
> > Reviewed-by: tags on patches when they've changed more than trivially
> > because otherwise those tags have no meaning at all.
> > 
> > Also, please take the time to peruse the above document on the kernel
> > process while waiting.
> 
> I will make sure to remove the Reviewed-by/Tested-by tags for the changed patches
> in the next submission. But, IMO, changes made in this patch is minimal. Nothing
> changed functionally. So, do we still need to remove the tags for this patch?

My note was more of a general reminder: "for the next revisions of
your patchsets" above. I simply replied to the first mail with a patch
changelog.

Also, maybe our documentation text is not really clear. It says "changed
substantially", you understood that as "changed functionally" and I've
seen people complain about smaller things. But ok, let's agree on
functional changes here.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
