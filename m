Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 226AB319163
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 18:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbhBKRpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 12:45:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:41486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230258AbhBKQ6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 11:58:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3BE0664E15;
        Thu, 11 Feb 2021 16:57:52 +0000 (UTC)
Date:   Thu, 11 Feb 2021 16:57:49 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Will Deacon <will@kernel.org>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/9] mm, arm64: Update PR_SET/GET_TAGGED_ADDR_CTRL interface
Message-ID: <20210211165748.GA5238@arm.com>
References: <20210205151631.43511-1-kirill.shutemov@linux.intel.com>
 <20210205151631.43511-2-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205151631.43511-2-kirill.shutemov@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kirill,

On Fri, Feb 05, 2021 at 06:16:21PM +0300, Kirill A. Shutemov wrote:
> The interface for enabling tagged addresses is very inflexible. It
> implies tag size and tag shift implemented by ARM TBI.
> 
> Rework the interface to accommodate different shifts and tag sizes.
> 
> PR_SET_TAGGED_ADDR_CTRL now accepts two new arguments:
> 
>  - nr_bits is pointer to int. The caller specifies the tag size it
>    wants. Kernel updates the value of actual tag size that can be
>    larger.
> 
>  - offset is pointer to int. Kernel returns there a shift of tag in the
>    address.

OK, so the expectation is that it's not always the top nr_bits (with
offset 64 - nr_bits). We can, for example, have a 4-bit tag with a 56
offset (arm64 MTE is kind like this in terms of meaningful bits but bits
60-63 are also ignored, so it doesn't make a difference from the tagged
address ABI perspective).

Does the offset also need to be validated?

> The change doesn't break existing users of the interface: if any of
> these pointers are NULL (as we had before the change), the user expects
> ARM TBI implementation: nr_bits == 8 && offset == 56 as it was implied
> before.
> 
> The initial implementation checked that these argument are NULL and the
> change wouldn't not break any legacy users.
> 
> If tagging is enabled, GET_TAGGED_ADDR_CTRL would return size of tags
> and offset in the additional arguments.
> 
> If tagging is disable, GET_TAGGED_ADDR_CTRL would return the maximum tag
> size in nr_bits.

Why not the offset as well? I guess I should read a bit on the x86
feature.

> The selftest is updated accordingly and moved out of arm64-specific
> directory as we going to enable the interface on x86.
> 
> As alternative to this approach we could introduce a totally new API and
> leave the legacy one as is. But it would slow down adoption: new
> prctl(2) flag wound need to propogate to the userspace headers.

Sharing the same prctl() is fine by me. We helped ourselves to lots of
bits in the first argument already for MTE but I don't think it matters
much. If x86 would need any, they can overlap with the arm64 bits as
they are interpreted in the arch code anyway.

The patch looks fine, though with a couple of nits/questions below:

> @@ -646,25 +652,41 @@ long set_tagged_addr_ctrl(struct task_struct *task, unsigned long arg)
>  	if (system_supports_mte())
>  		valid_mask |= PR_MTE_TCF_MASK | PR_MTE_TAG_MASK;
>  
> -	if (arg & ~valid_mask)
> +	if (flags & ~valid_mask)
>  		return -EINVAL;
>  
> +	if (nr_bits) {
> +		if (get_user(val, nr_bits))
> +			return -EFAULT;
> +		if (val > TBI_TAG_BITS || val < 1)
> +			return -EINVAL;
> +	}

Do we need to validate the offset as well?

> +
>  	/*
>  	 * Do not allow the enabling of the tagged address ABI if globally
>  	 * disabled via sysctl abi.tagged_addr_disabled.
>  	 */
> -	if (arg & PR_TAGGED_ADDR_ENABLE && tagged_addr_disabled)
> +	if (flags & PR_TAGGED_ADDR_ENABLE && tagged_addr_disabled)
>  		return -EINVAL;
>  
> -	if (set_mte_ctrl(task, arg) != 0)
> +	if (set_mte_ctrl(task, flags) != 0)
>  		return -EINVAL;
>  
> -	update_ti_thread_flag(ti, TIF_TAGGED_ADDR, arg & PR_TAGGED_ADDR_ENABLE);
> +	if (flags & PR_TAGGED_ADDR_ENABLE) {
> +		if (nr_bits && put_user(TBI_TAG_BITS, nr_bits))
> +			return -EFAULT;
> +		if (offset && put_user(TBI_TAG_SHIFT, offset))
> +			return -EFAULT;
> +	}
> +
> +	update_ti_thread_flag(ti, TIF_TAGGED_ADDR,
> +			      flags & PR_TAGGED_ADDR_ENABLE);
>  
>  	return 0;
>  }
>  
> -long get_tagged_addr_ctrl(struct task_struct *task)
> +long get_tagged_addr_ctrl(struct task_struct *task,
> +			  int __user *nr_bits, int __user *offset)
>  {
>  	long ret = 0;
>  	struct thread_info *ti = task_thread_info(task);
> @@ -672,8 +694,17 @@ long get_tagged_addr_ctrl(struct task_struct *task)
>  	if (is_compat_thread(ti))
>  		return -EINVAL;
>  
> -	if (test_ti_thread_flag(ti, TIF_TAGGED_ADDR))
> +	if (test_ti_thread_flag(ti, TIF_TAGGED_ADDR)) {
>  		ret = PR_TAGGED_ADDR_ENABLE;
> +		if (nr_bits && put_user(TBI_TAG_BITS, nr_bits))
> +			return -EFAULT;
> +		if (offset && put_user(TBI_TAG_SHIFT, offset))
> +			return -EFAULT;
> +	} else {
> +		/* Report maximum tag size */
> +		if (nr_bits && put_user(TBI_TAG_BITS, nr_bits))
> +		    return -EFAULT;
> +	}

Should this also populate the minimum offset allowed?

-- 
Catalin
