Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10864222AA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 11:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbhJEJvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 05:51:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49732 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbhJEJvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 05:51:00 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633427346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oRXnYL4+s1LYc72XdqgEFipmb2VWxMXqdFbyDd4Q3xo=;
        b=mbRIAUI56Wj6og9zzMdtTHRo9KCD4GvJlNV7RvRrAHpehj8c3PjXaKcVQyNz5gTWaTpSob
        lBUZzBY/vQmgXL2BlCeIbLHbKmZCyj6kYQlDRuDqeOkhHUAKlb3dA78eihTiTIGGrsveYs
        GgL59RjSmD2L8keSYVktK5CZgtd0XRnT+NhxNz2mEJc+tQDYN3LCw7NzVCQaV3i7zh/VgE
        NRkSQESMGUr9uNFcyuKf1O3J394IMdxkef4NOkYaWvoiqNGsdWMxKMgrKImLtWmXT7k4Q1
        r+BZggfPSXkE5ihM3qdp1iSaj0cTWhFu+UVrhV2XKyo/7475oJw6/BfoUT4Oww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633427346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oRXnYL4+s1LYc72XdqgEFipmb2VWxMXqdFbyDd4Q3xo=;
        b=oxGhmJ973iF47rglsSA+08stwkok24Vfag0LhUHyYl5XNmGmoWLBFD/4VnL3zP+z9UBpjM
        uIvZTc6jlizybVDQ==
To:     "Chang S. Bae" <chang.seok.bae@intel.com>, bp@suse.de,
        luto@kernel.org, mingo@kernel.org, x86@kernel.org
Cc:     len.brown@intel.com, lenb@kernel.org, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: Re: [PATCH v11 15/29] x86/arch_prctl: Create
 ARCH_SET_STATE_ENABLE/ARCH_GET_STATE_ENABLE
In-Reply-To: <87o884fh3g.ffs@tglx>
References: <20211001223728.9309-1-chang.seok.bae@intel.com>
 <20211001223728.9309-16-chang.seok.bae@intel.com> <87o884fh3g.ffs@tglx>
Date:   Tue, 05 Oct 2021 11:49:05 +0200
Message-ID: <87ilybg5ta.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05 2021 at 02:30, Thomas Gleixner wrote:
> On Fri, Oct 01 2021 at 15:37, Chang S. Bae wrote:
>> +		if (state_perm & ~features_mask)
>> +			return -EINVAL;
>> +
>> +		state_perm &= xfeatures_mask_user_perm();
>> +		if (!state_perm)
>> +			return 0;
>
> I really do not get the semantics of this prctl at all.
>
> GET stores _all_ permitted bits in the user space variable which makes
> sense.
>
> SET is just accepting everything except not supported bits, but as it
> takes a feature bitmask it suggests that this sets the xfeature bits
> which are available for the task or the process.
>
> How does prctl(..., SET, 0) make sense?
>
> It does not make any sense at all. There is no support for downgrading
> the permitted features:
>
>     1) Default features up to AVX512 cannot be disabled
>     
>     2) Once AMX (or any upcoming state) is enabled there is not way back.
>
> So no. This really want's to be
>
>    prctl(SET, xfeature_number)
>
> and not something which is semanticaly ill defined.

So of course this is odd at all ends because AMX requires two feature
bits to be enabled (17 and 18).

Now with the above bitmap based thing prctl(SET, 1 << 17) is valid
because it's supported and of course there is no sanity check at all.

With a feature number based interface it's even worse. Duh, should have
thought about that.

So this gives us two options:

   1) Bitmap with proper sanity checks

      reject (1 << 17) and (1 << 18)
      grant (1 << 17 | 1 << 18)

      but for sanity sake and also for ease of filtering, we want to
      restrict a permission request to one functional block at a time.

      #define X86_XCOMP_AMX	(1 << 17 | 1 << 18)
      #define X86_XCOMP_XYZ1    (1 << 19)

      But that gets a bit odd when there is a component which depends on
      others:

      #define X86_XCOMP_XYZ2    (1 << 19 | 1 << 20)

   2) Facility based numerical interface, i.e.

      #define X86_XCOMP_AMX	1
      #define X86_XCOMP_XYZ1    2
      #define X86_XCOMP_XYZ2    3

      is way simpler to understand IMO.

Thanks,

        tglx
