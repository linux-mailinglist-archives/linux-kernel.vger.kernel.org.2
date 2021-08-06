Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 369FD3E2ABA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 14:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243783AbhHFMm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 08:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236860AbhHFMmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 08:42:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B70C061798
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 05:42:38 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628253756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BL6YlCbDsEAPs5DxI2P6UUekxLwuhdaTTldWOudLzxk=;
        b=Plmi6EgMBRKNKCY/J/6RABCCHGJxeYDbPVIYfj9AZQLMpE33fuD8BxbUHJ3nh1OPiiPmy8
        jUcl/quDEV0IV9B3m+RaEmkcWhn711Z3YLab2aYcEr82i7cnk1vTRe5iA6Nx+ldm8rHAZ4
        A0ogla4fHGxhg8QtRrePvxh3vql+ocKsd1y3/X51taOq4ZG77Xzw7c+555JK3GDvRH8H1C
        rGHfUXzWLsoEi/yR6akbVlpgtfso9p/lwb3E3U7q53bEhRuQ/drDSVr4ehTMkiqeUE9u9s
        TWxWO0SJuZcD7MTHVTDyD3eqdt6haWzpZz8n0zVN0P4hZxQBds3djquF9u9Flg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628253756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BL6YlCbDsEAPs5DxI2P6UUekxLwuhdaTTldWOudLzxk=;
        b=JiGJMbqH2M8Bl14Nv4Ka8ofDarNV4zT1AuEIHfZvIxcI/409xVneh6FtNmFe16czxBw5GJ
        bHdFAXRrjsjopaDw==
To:     "Chen, Rong A" <rong.a.chen@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        kernel test robot <lkp@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [kbuild-all] Re: sparc64-linux-gcc: error: unrecognized
 command-line option '-mxsave'
In-Reply-To: <8bee8632-9129-bb02-ab94-f65786e65268@intel.com>
References: <202107271153.7QWf3g6F-lkp@intel.com>
 <efd7ab16-ed45-0ab0-a123-4e8e45c100d0@intel.com>
 <8bee8632-9129-bb02-ab94-f65786e65268@intel.com>
Date:   Fri, 06 Aug 2021 14:42:36 +0200
Message-ID: <87a6lu68xv.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04 2021 at 17:04, Rong A. Chen wrote:
> On 7/27/2021 10:52 PM, Dave Hansen wrote:
>> On 7/26/21 8:11 PM, kernel test robot wrote:
>>>>> sparc64-linux-gcc: error: unrecognized command-line option '-mxsave'
>> 
>> Is there something else funky going on here?  All of the "-mxsave" flags
>> that I can find are under checks for x86 builds, like:
>> 
>> 	ifeq ($(CAN_BUILD_I386),1)
>> 	$(BINARIES_32): CFLAGS += -m32 -mxsave
>> 	..
>> 
>> I'm confused how we could have a sparc64 compiler (and only a sparc64
>> compiler) that would end up with "-mxsave" in CFLAGS.
>
> Hi Dave,
>
> We can reproduce the error and have no idea too, but we have disabled
> the test for selftests on non-x86 arch.

This smells like a host/target compiler mixup. Can you please make the
kernel build verbose with 'V=1' and provide the full build output?

Thanks,

        tglx
