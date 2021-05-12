Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8085237ED4F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386225AbhELUUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 16:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382121AbhELTmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 15:42:44 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAA5C061760
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 12:36:59 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id g14so28466652edy.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 12:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UzMdo+nN2fnEnfB6hqcQBSXolFrNVcEOldHC0HIPrN8=;
        b=S77lUiExgdKl8KxQYov/j/qbWGAuxFD8kAsFHAMt6b4L+OQ8yH+ggcnD2w9sBPMCq+
         Uh9AFhYl1bYhvchEpbf6VEVoMfM7qBxQB3RCLk5Xfw5Qcsn33FxwCDzHRdx064daqAPM
         ebuoFrXjaaqfNTVlIPnTpM4gTmpXWXF7aSmYxjuzrFELk+kR6/6UyT91cpNWRPmA/jez
         OXbPmfbpG+eASM8jr5CzbMmjC3j+I/zwYuFI5GomyoUjTHh4DnE/ZfWARjFgRHK/45jf
         1/X/eRiAAeCGlVTi+r/qvWA8gA+D9hooKGJkb1IlgaFN64saSgy17r+3I9O4148JDvsU
         6uNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=UzMdo+nN2fnEnfB6hqcQBSXolFrNVcEOldHC0HIPrN8=;
        b=UQTflENFaA8MydrPfckx75bKORngSG7CWyFFIrorYmkxjW7EmXCsqNp/x2B8GF8xcI
         Z1o771tBCdLgLV/2GYYncxtafOqNCokeUphKU82pqzC2r2fh3w5A4rOitEz5QF+8HzLt
         kuH6Sjhv7lqFB7vEsf4z5T6HJiLXIOd+AsS4IZ41YBz+lSk9hxhuL6zQgt76xQ11lKN+
         6rVOmZlve8ItHF8wg8yOtUpVCHb/+aTz4Lebygo5iMStMOTG+JktFwpbeiYwCE71mEdP
         jByhFtoTO5sVaHC1jKgwbKhnss6UHpHKzZ3B4r+2vySRg+Hvdcn7Z3O0w3Y7WfJ7KSn9
         x6GA==
X-Gm-Message-State: AOAM532zivSfgB1BiMwt/MGvmIqGyd2lIJxfLqk415IsjOxJ/9OLPOu6
        FcfB4N7uDqdPFuVDSyeElykiT0dmENE=
X-Google-Smtp-Source: ABdhPJziy/U7Uql6sUXKX9WM7taqKtaFD41sOV/jusEgIlHmwD54U5nrxLF0w65tBf2Ch2hl2NsV5w==
X-Received: by 2002:a05:6402:19a7:: with SMTP id o7mr6592439edz.22.1620848218236;
        Wed, 12 May 2021 12:36:58 -0700 (PDT)
Received: from gmail.com (0526E777.dsl.pool.telekom.hu. [5.38.231.119])
        by smtp.gmail.com with ESMTPSA id j14sm464033eja.49.2021.05.12.12.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 12:36:57 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 12 May 2021 21:36:56 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] sched: make multiple runqueue task counters 32-bit
Message-ID: <YJwuWMLW5Lw+Y7Rv@gmail.com>
References: <20210422200228.1423391-1-adobriyan@gmail.com>
 <20210422200228.1423391-4-adobriyan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422200228.1423391-4-adobriyan@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Alexey Dobriyan <adobriyan@gmail.com> wrote:

> Make
> 
> 	struct dl_rq::dl_nr_migratory
> 	struct dl_rq::dl_nr_running
> 
> 	struct rt_rq::rt_nr_boosted
> 	struct rt_rq::rt_nr_migratory
> 	struct rt_rq::rt_nr_total
> 
> 	struct rq::nr_uninterruptible
> 
> 32-bit.
> 
> If total number of tasks can't exceed 2**32 (and less due to futex pid
> limits), then per-runqueue counters can't as well.

Applied to tip:sched/core, thanks!

There was a bit of a conflict with recent changes in 
drivers/cpuidle/governors/menu.c, but I fixed it up, hopefully correctly.

> This patchset has been sponsored by REX Prefix Eradication Society.

A patchset with such an impeccable recommendation letter is impossible to 
resist.

Thanks,

	Ingo
