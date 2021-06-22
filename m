Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910303B0637
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 15:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhFVNyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 09:54:24 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60564 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhFVNyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 09:54:22 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 93C001FD69;
        Tue, 22 Jun 2021 13:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624369925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tyljBHQhfbYGn3IWWrnnSPuwRSN3DRvmx9sRgokz/IE=;
        b=L9ykUiFUP+Rce7f7tXbToWOgiX0Huac/vD83SRl1CdaG1YBiy8CKnb/074w8ty3LYzy7Td
        EhMYZT+GxdU9AICvWOJrttMg1KwMwCrgC7gg2WdC7VbNc0QBfsb+YoyMC9QAlFfLIhLMbx
        cboRwwNHTrjb4ZtUhxhwALXW0S8S1/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624369925;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tyljBHQhfbYGn3IWWrnnSPuwRSN3DRvmx9sRgokz/IE=;
        b=OpRvooTXy2O6C33U+9RY2ZLL6ao7HWjnFq+uD6WFHDtDWhGW73PZPnNqIRTl+vVjsFzSy+
        S1wSEna5oynuFGCg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 7D9B7118DD;
        Tue, 22 Jun 2021 13:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624369925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tyljBHQhfbYGn3IWWrnnSPuwRSN3DRvmx9sRgokz/IE=;
        b=L9ykUiFUP+Rce7f7tXbToWOgiX0Huac/vD83SRl1CdaG1YBiy8CKnb/074w8ty3LYzy7Td
        EhMYZT+GxdU9AICvWOJrttMg1KwMwCrgC7gg2WdC7VbNc0QBfsb+YoyMC9QAlFfLIhLMbx
        cboRwwNHTrjb4ZtUhxhwALXW0S8S1/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624369925;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tyljBHQhfbYGn3IWWrnnSPuwRSN3DRvmx9sRgokz/IE=;
        b=OpRvooTXy2O6C33U+9RY2ZLL6ao7HWjnFq+uD6WFHDtDWhGW73PZPnNqIRTl+vVjsFzSy+
        S1wSEna5oynuFGCg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id FjoWHgXr0WD7RQAALh3uQQ
        (envelope-from <bp@suse.de>); Tue, 22 Jun 2021 13:52:05 +0000
Date:   Tue, 22 Jun 2021 15:51:53 +0200
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
Subject: Re: [patch V3 40/66] x86/fpu: Rename and sanitize fpu__save/copy()
Message-ID: <YNHq+TNrlDzxarFj@zn.tnic>
References: <20210618141823.161158090@linutronix.de>
 <20210618143448.953929649@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210618143448.953929649@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 04:19:03PM +0200, Thomas Gleixner wrote:
> Both functions are misnomed.

"Both function names are a misnomer." or simply
"Both function are not named optimally."

> -int fpu__copy(struct task_struct *dst, struct task_struct *src)
> +/* Clone current's FPU state on fork */
> +int fpu_clone(struct task_struct *dst)
>  {
> +	struct fpu *src_fpu = &current->thread.fpu;
>  	struct fpu *dst_fpu = &dst->thread.fpu;
> -	struct fpu *src_fpu = &src->thread.fpu;
>  
> +	/* The new task's FPU state cannot be valid in the hardware. */
>  	dst_fpu->last_cpu = -1;
>  
>  	if (!static_cpu_has(X86_FEATURE_FPU))

cpu_feature_enabled

while at it.

Regardless, looks nice.

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
