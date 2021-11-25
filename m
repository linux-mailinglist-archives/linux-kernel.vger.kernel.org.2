Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D9F45DF4B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 18:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbhKYRDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 12:03:45 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53162 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242271AbhKYRBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 12:01:17 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637859483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WOKypu9+YuWWJOAfm6+J+ei1DcpdTnJhN0LbMq3CSG0=;
        b=vzJLcT7uiJpS9vreHdlK/D2976quDuf9ti4wYxxqLNMj0h2wetfIAt5Zf+5DUpe/zUpWF1
        NdcwlJFBRbknKy/FagWVQ+LA+h1M1QOrhCRpSrmIQsl0A9J9h9s3q+TSCz4Gm+q2zzRtDX
        tGLQq0xK/BENKSMb2770BKX1FMCV3EuJvQoymF+FVRQnyynJypPiiz11/MKAzZIervk1/6
        0yJLhEa9/CUWWMOXQ5WGX2gXor75vjWY79lRQaEaGUBcOW7+OyU69SrUi3vpXaA2tOjdVP
        hD2BHdX66V7Ogyg1B6Wy6eENRlW8/zxmCxDkQgPWLy3HYbOQAsgU8m52jk2Pxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637859483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WOKypu9+YuWWJOAfm6+J+ei1DcpdTnJhN0LbMq3CSG0=;
        b=RzQUjc8ysGU6e5x/jPEHv9T7bdnrbH5ffoiBIQ0jhjIfpPpoaA4PLwyjc1ZzcY9ADpL6mj
        yF3FqyOv487lLODQ==
To:     ira.weiny@intel.com, Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-mm@kvack.org
Subject: Re: [PATCH V7 03/18] x86/pks: Add additional PKEY helper macros
In-Reply-To: <87lf1cl3cq.ffs@tglx>
References: <20210804043231.2655537-1-ira.weiny@intel.com>
 <20210804043231.2655537-4-ira.weiny@intel.com> <87lf1cl3cq.ffs@tglx>
Date:   Thu, 25 Nov 2021 17:58:02 +0100
Message-ID: <87czmokw9x.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25 2021 at 15:25, Thomas Gleixner wrote:
> On Tue, Aug 03 2021 at 21:32, ira weiny wrote:
>> @@ -200,16 +200,14 @@ __setup("init_pkru=", setup_init_pkru);
>>   */
>>  u32 update_pkey_val(u32 pk_reg, int pkey, unsigned int flags)
>>  {
>> -	int pkey_shift = pkey * PKR_BITS_PER_PKEY;
>> -
>>  	/*  Mask out old bit values */
>> -	pk_reg &= ~(((1 << PKR_BITS_PER_PKEY) - 1) << pkey_shift);
>> +	pk_reg &= ~PKR_PKEY_MASK(pkey);
>>  
>>  	/*  Or in new values */
>>  	if (flags & PKEY_DISABLE_ACCESS)
>> -		pk_reg |= PKR_AD_BIT << pkey_shift;
>> +		pk_reg |= PKR_AD_KEY(pkey);
>>  	if (flags & PKEY_DISABLE_WRITE)
>> -		pk_reg |= PKR_WD_BIT << pkey_shift;
>> +		pk_reg |= PKR_WD_KEY(pkey);
>
> I'm not seeing how this is improving that code. Quite the contrary.

Aside of that why are you ordering it the wrong way around, i.e.

   1) implement turd
   2) polish turd

instead of implementing the required helpers first if they are really
providing value.

Thanks,

        tglx


