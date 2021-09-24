Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5BD4175DE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 15:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346447AbhIXNeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 09:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346636AbhIXNcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 09:32:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E5BC05BD17
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 06:18:15 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632489492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EkgceDb68aKuyW7Xafy5kre/SZO1C4q0AWs/aSyA1fg=;
        b=38LCLbePDv45bODUZovEnO4nt0pNY7G7jB8ei2tc2xRJ3U6xCgL8Pk7GK2/q1fIk2LE9y1
        5iPxmBzGxqbv9+Szdwp2xLv38MIxT0L/+cEHBwa0ClXSv5S3dndu1wXctu1ziIYzymsc/4
        ug6vEGhBQ+8YZiQbtddsj7OXz2UqAu7W0yfnqqgkl5orPRYXMp8Lpe0kHbexqsRkzmeunw
        RlOIMXcU+BHyBY3k5b1wYDUk++eLgTPPGiK8j/JQ73QFsvbEKsTKB6sNn8eh643c1dcaL2
        85zc79fuqHWPnZpfSPYZO5W78OBQxow9SRiymKhSIydJi51f1kQT/nMdjiU26w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632489492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EkgceDb68aKuyW7Xafy5kre/SZO1C4q0AWs/aSyA1fg=;
        b=lWWFJgrEx65fA/sjl+oaOFAChukib/QmrFTq4ObEcl9f8EWtFXoZmxOQmcwoY+WqszRrBQ
        gh0Tb6cgy8/N7ZBQ==
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        iommu@lists.linux-foundation.org, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/8] x86/mmu: Add mm-based PASID refcounting
In-Reply-To: <87o88jfajo.ffs@tglx>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-6-fenghua.yu@intel.com> <87y27nfjel.ffs@tglx>
 <YUyuEjlrcOeCp4qQ@agluck-desk2.amr.corp.intel.com> <87o88jfajo.ffs@tglx>
Date:   Fri, 24 Sep 2021 15:18:12 +0200
Message-ID: <87k0j6dsdn.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23 2021 at 19:48, Thomas Gleixner wrote:
> On Thu, Sep 23 2021 at 09:40, Tony Luck wrote:
>
> fpu_write_task_pasid() can just grab the pasid from current->mm->pasid
> and be done with it.
>
> The task exit code can just call iommu_pasid_put_task_ref() from the
> generic code and not from within x86.

But OTOH why do you need a per task reference count on the PASID at all?

The PASID is fundamentaly tied to the mm and the mm can't go away before
the threads have gone away unless this magically changed after I checked
that ~20 years ago.

Thanks,

        tglx

