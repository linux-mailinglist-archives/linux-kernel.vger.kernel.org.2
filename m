Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F62449FFB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 01:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236022AbhKIAyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 19:54:18 -0500
Received: from mga18.intel.com ([134.134.136.126]:26937 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235850AbhKIAyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 19:54:17 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10162"; a="219252035"
X-IronPort-AV: E=Sophos;i="5.87,218,1631602800"; 
   d="scan'208";a="219252035"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 16:51:32 -0800
X-IronPort-AV: E=Sophos;i="5.87,218,1631602800"; 
   d="scan'208";a="500127625"
Received: from yangzhon-virtual.bj.intel.com (HELO yangzhon-Virtual) ([10.238.144.101])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 08 Nov 2021 16:51:29 -0800
Date:   Tue, 9 Nov 2021 08:36:56 +0800
From:   Yang Zhong <yang.zhong@intel.com>
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        bp@suse.de, dave.hansen@intel.com, jing2.liu@intel.com,
        yang.zhong@intel.com
Subject: Re: [PATCH] x86/fpu: Set the corret permission value for
 perm.__state_perm
Message-ID: <20211109003656.GA642@yangzhon-Virtual>
References: <20211108222815.4078-1-yang.zhong@intel.com>
 <045FEB79-B7AE-421F-A7F1-1ABC86E0E19F@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <045FEB79-B7AE-421F-A7F1-1ABC86E0E19F@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2021 at 12:13:58AM +0800, Bae, Chang Seok wrote:
> On Nov 8, 2021, at 14:28, Zhong, Yang <yang.zhong@intel.com> wrote:
> >
> > The perm.__state_perm is default xsave set features, when we request
> > AMX permission from application, the requested value(bit18) should be
> > replaced with mask value(requested | permitted), which can keep default
> > features there.
> >
> > Without this change, the below prctl syscall:
> > (1). ARCH_GET_XCOMP_PERM, the bitmask=0x202e7
> > (2). set ARCH_REQ_XCOMP_PERM with XFEATURE_XTILEDATA
> > (3). ARCH_GET_XCOMP_PERM, the bitmask=0x40000, the correct value
> >     should be 0x602e7 here.
> 
> Oh, bad.
> 
> > diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> > index d28829403ed0..fc1ab0116f4e 100644
> > --- a/arch/x86/kernel/fpu/xstate.c
> > +++ b/arch/x86/kernel/fpu/xstate.c
> > @@ -1626,7 +1626,7 @@ static int __xstate_request_perm(u64 permitted, u64 requested)
> >               return ret;
> >
> >       /* Pairs with the READ_ONCE() in xstate_get_group_perm() */
> > -     WRITE_ONCE(fpu->perm.__state_perm, requested);
> > +     WRITE_ONCE(fpu->perm.__state_perm, mask);
> 
> I think this has to update the group leader’s like:
>     WRITE_ONCE(current->group_leader->thread.fpu.perm.__state_perm, mask);
>

  I think this is no need to change with group leader here, the fpu pointer has defined as below: 
  
  struct fpu *fpu = &current->group_leader->thread.fpu;

  Please check Thomas's changes for KVM, the WRITE_ONCE(fpu->perm.__state_perm, mask) is more reasonable
  here.

  https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git/commit/?h=x86/fpu-kvm&id=62016e4cc41716b33da890ad43145b646f9db51d

  I also verified this changes from host and guest side, all work well.

  Regards,

  Yang
   


> Thanks,
> Chang
> 
> 
> 
