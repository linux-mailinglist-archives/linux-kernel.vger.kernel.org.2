Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B8F3B0254
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 13:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhFVLIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 07:08:11 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47892 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbhFVLII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 07:08:08 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8C5C02198C;
        Tue, 22 Jun 2021 11:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624359952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=be8Wp7HXTg0x3ObMaO6S3zaSJe0x3x3lqTsbkDllRlY=;
        b=WY9UxJ2iB//tjJElgacinkbiIh6Ditrf81DZ2mh8a32r/S/xOoXvaMkICd/m07sNpOOSGt
        Q6DcmLIH9j+LX3j/heDJZhpRPic5UVRWhXTEzZyW/i44UvhQWzDs/DqAGtx8a3XR8QNxjh
        u8Ked22eXLnXSdGxelI3inH73R5KR5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624359952;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=be8Wp7HXTg0x3ObMaO6S3zaSJe0x3x3lqTsbkDllRlY=;
        b=vMLwNcEZJcLvwWhamg28+05oQRwBJ0iN7/hXX+8NUx1Yjv392eUfkjFIWq3f9yMyJ3zK9O
        JsmTnheTfuT7UYDA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 793DD118DD;
        Tue, 22 Jun 2021 11:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624359952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=be8Wp7HXTg0x3ObMaO6S3zaSJe0x3x3lqTsbkDllRlY=;
        b=WY9UxJ2iB//tjJElgacinkbiIh6Ditrf81DZ2mh8a32r/S/xOoXvaMkICd/m07sNpOOSGt
        Q6DcmLIH9j+LX3j/heDJZhpRPic5UVRWhXTEzZyW/i44UvhQWzDs/DqAGtx8a3XR8QNxjh
        u8Ked22eXLnXSdGxelI3inH73R5KR5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624359952;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=be8Wp7HXTg0x3ObMaO6S3zaSJe0x3x3lqTsbkDllRlY=;
        b=vMLwNcEZJcLvwWhamg28+05oQRwBJ0iN7/hXX+8NUx1Yjv392eUfkjFIWq3f9yMyJ3zK9O
        JsmTnheTfuT7UYDA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id sTOFHBDE0WDIYgAALh3uQQ
        (envelope-from <bp@suse.de>); Tue, 22 Jun 2021 11:05:52 +0000
Date:   Tue, 22 Jun 2021 13:05:41 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [patch V3 37/66] x86/fpu: Rename "dynamic" XSTATEs to
 "independent"
Message-ID: <YNHEBbaJlMzxFLAA@zn.tnic>
References: <20210618141823.161158090@linutronix.de>
 <20210618143448.635748676@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210618143448.635748676@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 04:19:00PM +0200, Thomas Gleixner wrote:
> --- a/arch/x86/include/asm/fpu/xstate.h
> +++ b/arch/x86/include/asm/fpu/xstate.h
> @@ -56,7 +56,7 @@
>   * - Don't set the bit corresponding to the dynamic supervisor feature in
>   *   IA32_XSS at run time, since it has been set at boot time.
>   */
> -#define XFEATURE_MASK_DYNAMIC (XFEATURE_MASK_LBR)
> +#define XFEATURE_MASK_INDEPENDENT (XFEATURE_MASK_LBR)

Yah, you kinda missed all those "dynamic" in the comment here explaining
what this mask means.

Do a

$ git grep dynamic arch/x86/

after renaming to make sure you've caught them all.

> @@ -1199,34 +1199,34 @@ void copy_dynamic_supervisor_to_kernel(s
>  }
>  
>  /**
> - * copy_kernel_to_dynamic_supervisor() - Restore dynamic supervisor states from
> - *                                       an xsave area
> + * copy_kernel_to_independent_supervisor() - Restore independent supervisor states from
> + *                                           an xsave area
>   * @xstate: A pointer to an xsave area
> - * @mask: Represent the dynamic supervisor features restored from the xsave area
> + * @mask: Represent the independent supervisor features restored from the xsave area
>   *
> - * Only the dynamic supervisor states sets in the mask are restored from the
> - * xsave area (See the comment in XFEATURE_MASK_DYNAMIC for the details of
> - * dynamic supervisor feature). Besides the dynamic supervisor states, the
> + * Only the independent supervisor states sets in the mask are restored from the
> + * xsave area (See the comment in XFEATURE_MASK_INDEPENDENT for the details of
> + * independent supervisor feature). Besides the independent supervisor states, the
>   * legacy region and XSAVE header are also restored from the xsave area. The
>   * supervisor features in the XFEATURE_MASK_SUPERVISOR_SUPPORTED and
>   * XFEATURE_MASK_SUPERVISOR_UNSUPPORTED are not restored.
>   *
>   * The xsave area must be 64-bytes aligned.
>   */
> -void copy_kernel_to_dynamic_supervisor(struct xregs_state *xstate, u64 mask)
> +void copy_kernel_to_independent_supervisor(struct xregs_state *xstate, u64 mask)

Well, can't say I'm crazy about the naming which is a mouthful and
reminds me of an "independent supervisor", i.e., like some United
Nations thing.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
