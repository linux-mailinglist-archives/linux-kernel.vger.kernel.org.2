Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12A003AA2EF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 20:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbhFPSOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 14:14:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:59242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230248AbhFPSOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 14:14:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59C7A613B9;
        Wed, 16 Jun 2021 18:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623867148;
        bh=98Lc1HPaOiBbFB9udzTrRD0fEYkR9HM93QQUAPWcTj8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=g15kAm2783eIVI0ZqI0BT9nOG9gm7YtQP99xuOZ+kxVz1yYCQjYy5RrMFEDY2ok4O
         3rK6gdxGPhHkjB3MFM4Dyj8vF3wyXT8A6MzsMbd2ekkA8CQ9Gicge32hgLbRrg06g8
         1QH8d+S14s7tnBbTfZHcansk5oDKIS6oVaAhzahKseCG+nISx1KdpW3oMteiJo7239
         6IVgXAzCbxu6AclIuhtC2q6T6huQkJqdRoQK5kha8pwmsSrvbb/EAACia2gFpNp8/Y
         pqtp5E8NIlILyHAlbQw0dJQ0+2a6N8AQCqE0eP4flVU2LhXqjPKbSs2nIYGezDHazg
         w14tLxu6FpyAw==
Subject: Re: [PATCH v5 14/28] x86/fpu/xstate: Prevent unauthorised use of
 dynamic user state
To:     Dave Hansen <dave.hansen@intel.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>, bp@suse.de,
        tglx@linutronix.de, mingo@kernel.org, x86@kernel.org
Cc:     len.brown@intel.com, jing2.liu@intel.com, ravi.v.shankar@intel.com,
        linux-kernel@vger.kernel.org
References: <20210523193259.26200-1-chang.seok.bae@intel.com>
 <20210523193259.26200-15-chang.seok.bae@intel.com>
 <af093744-6f68-ff51-f40b-4db234b363d8@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <872cb0a2-3659-2e6c-52a8-33f1a2f0a2cd@kernel.org>
Date:   Wed, 16 Jun 2021 11:12:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <af093744-6f68-ff51-f40b-4db234b363d8@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/21 9:27 AM, Dave Hansen wrote:
> On 5/23/21 12:32 PM, Chang S. Bae wrote:
>> @@ -571,6 +612,8 @@ static inline void switch_fpu_finish(struct fpu *new_fpu)
>>  
>>  	set_thread_flag(TIF_NEED_FPU_LOAD);
>>  
>> +	xfd_switch(old_fpu, new_fpu);
> 
> This seems fragile.
> 
> XSAVE* will decline to write out state for feature i when XFD[i]=1 and
> will instead write out the init state.  That means that, at this point,
> we switch XFD and yet leave state for feature i in place.
> 
> That means this *MUST* come before any copy_fpregs_to_fpstate() occurs.
> 
> Could we please add some FPU_WARN_ON() checks to ensure that no XSAVE*
> is ever performed with XINUSE=1 *and* XFD armed?
> 

Wait, really?  I somehow thought that XSAVE* would write out the actual
state even if XFD=1.

This seems like it's asking for some kind of bug.
