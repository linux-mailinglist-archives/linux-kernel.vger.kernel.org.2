Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADABD30AA13
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 15:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbhBAOmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 09:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbhBAOlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 09:41:09 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB47C061797
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 06:39:51 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id z6so16775567wrq.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 06:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b+vMwmkWUJjaj+TgGQx4IfyQcf4QX6ABMPeENh1qYYc=;
        b=Jp7zN4K6VvzvUN68FSmA9L668KpFR1i/FFujyHS9g7Z874L2MRY7WNhQ2Ti2CLVyI0
         CXsMgnMhu7OVtwrqF0OZU+F3f7d5Deq8kwxVfizR8Pn/5IWvg3LR0aZcxzQR88dKXSTV
         3iC9lcrOCZZwZFXND3zAW7+G0f9583Xnfc8s5TiWll5zefCRhAlhyp1SoZ2DND7zYCcv
         wAyCjyEN2y5FY/QdJhKyRghoEAuDUeVlRuV7onEz66v8VS3+RQZSjz6HbqKS+bHB5yMx
         ahfC0jNLrYtywK9cxBYurMQCtJWsRFIRhKNvO0LrB3MEFdDW0/r4oDAmW2+ek5GJbSKw
         rW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b+vMwmkWUJjaj+TgGQx4IfyQcf4QX6ABMPeENh1qYYc=;
        b=HKTa14jf9prO5s3uM9ZlM5I+DsO9LdIRPCWSEMzDHrToEkOE4ifTqjS3marennj7Am
         VXiuLniGnkNUChjKLlEG5eNXgSEQ53bPlKOD2HYrcTFvDqUzRAc4pdjYRjru7gBkbJe+
         XSecrsx2ZL/qyCyX8+h1X1fw5X57Fgc7qUdVOr/qehI+Ft7qCaahysFboQbsXBS0wfyo
         oZu0cSiSNYbVJzTac01BQhaZ9Fnm9TBy5nbPfxcbzAvYcZkRyDKltsNEU80QAXxTlnXj
         tBZAQj32np7+5qp5mrYfmO08M+OXAJdhIGhwd6bVbMAvMatkVcul/SQ/kzHMUQ1y1YVg
         61ew==
X-Gm-Message-State: AOAM5329P5VovfYKvaUgb1NWIypLkQNpzZEWqpDJJT9SxZYzb62Mfsgj
        hlQHkYQt9ryOhNUw1qFFZTc=
X-Google-Smtp-Source: ABdhPJxyxUEjlwLDIJDRbBZJqsSGQLUnS1iu3XnDm9EPTJnMTpxjA/oPPbzS/+pRdVxTAGJj6Cth+g==
X-Received: by 2002:adf:f782:: with SMTP id q2mr18530058wrp.181.1612190390193;
        Mon, 01 Feb 2021 06:39:50 -0800 (PST)
Received: from p4 (net-93-70-85-165.cust.vodafonedsl.it. [93.70.85.165])
        by smtp.gmail.com with ESMTPSA id y17sm16050wmi.21.2021.02.01.06.39.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Feb 2021 06:39:49 -0800 (PST)
Date:   Mon, 1 Feb 2021 14:39:46 +0000
From:   Giancarlo Ferrari <giancarlo.ferrari89@gmail.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        rppt@kernel.org, penberg@kernel.org, geert@linux-m68k.org,
        giancarlo.ferrari@nokia.com
Subject: Re: [PATCH] ARM: kexec: Fix panic after TLB are invalidated
Message-ID: <20210201143943.GA15399@p4>
References: <1612140296-12546-1-git-send-email-giancarlo.ferrari89@gmail.com>
 <20210201124720.GA66060@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201124720.GA66060@C02TD0UTHF1T.local>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Feb 01, 2021 at 12:47:20PM +0000, Mark Rutland wrote:
> On Mon, Feb 01, 2021 at 12:44:56AM +0000, Giancarlo Ferrari wrote:
> > machine_kexec() need to set rw permission in text and rodata sections
> > to assign some variables (e.g. kexec_start_address). To do that at
> > the end (after flushing pdm in memory, etc.) it needs to invalidate
> > TLB [section] entries.
> 
> It'd be worth noting explicitly that set_kernel_text_rw() alters
> current->active_mm...
> 
> > If during the TLB invalidation an interrupt occours, which might cause
> > a context switch, there is the risk to inject invalid TLBs, with ro
> > permissions.
> 
> ... which is why if there's a context switch things can go wrong, since
> active_mm isn't stable, and so it's possible that set_kernel_text_rw()
> updates multiple tables, none of which might be the active table at the
> point we try to make an access.
> 

Maybe the behaviour causing issue is not completely clear to me, and I do
apologize for that (moreover I haven't eougth debug capabilities).
However, current-active_mm is switched among context switches. Correct ?
So, in principle, the invalidation, if stopped, is carried on where it
left.

I thought the issue was that the PageTable entry for the section 0x8010_0000
is global, thus not indexed by ASID (Address Space ID). By the fact that each
process has its own version of that entry, is the cause of the issue, as the
schedule process might bringing a spurious entry (with ro permission) in the
MMU cache.

If the entry is not global holds the ASID, and the issue cannot happen.

Please note that this behaviour was tested on a armv7 arch board.

> It would be nice to spell that out rather than saying "invalid TLBs".
> 
> We could disable preemption to prevent that, which is possibly better
> than disabling interrupts.
> 
> Overall, it would be much better to avoid having to mess with the kernel
> page tables. So rather than going:
> 
> 1. mark kernel RW
> 2. alter variables in reloc code
> 3. copy reloc code into buffer
> 4. branch to buffer
> 
> ... we should be able to go:
> 
> 1. copy reloc code into buffer
> 2. alter variables in copy of reloc code
> 3. branch to buffer
> 
> ... which would avoid this class of problem too.
> 
> Thanks,
> Mark.

Thanks,


GF
