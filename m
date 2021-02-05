Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160C73101CB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 01:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbhBEAqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 19:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbhBEAqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 19:46:21 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA20C0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 16:45:40 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id c4so5673390wru.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 16:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=REVZpx90iqiGcxdwIIANHFgXNhTdlHWM4M03a6aW3pg=;
        b=jNS9xyz6J6LHfex72n5FtIBvoRHe2YNTukdbmFNcSoLp2IV7c1p6yufgiXG2zOv1Ny
         ur73yRvMztaTZU8RfeQ9pM7SKlkCAU+1wx1iTU9auoTrizO9Ej5sTNUKsdFrO1UAyjND
         NvXWBwTxnIfWN3On1tZcxczHLYRFB8aEunpm8vSmvgfnA/bDTgjxUlf+NTKQwHGjL7z3
         3aBh6Tpsz6rCwXfvUwNJ7zuLF6mV5td4k4L5ZQ3iTjAqa8s/VRm3OInN3MJSZisLvG8B
         Q4XsjVKCv0YymbwP8SsdJgKT2lZohF5YHkiimrkNqlq1nnuZoiAXQNDASSdBKFsPxjMg
         wp/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=REVZpx90iqiGcxdwIIANHFgXNhTdlHWM4M03a6aW3pg=;
        b=FM3eQrToGpBGQRFdbxpT2nFrZmTu3jNlVy2l5nDcPk0F9KKtOnvP9yuWQyZTzThGZL
         MmdaQb8afnbZKCpNVq/hALyQV6D7IrxIirjRdC0gNpf08cDT3liT/l8mIEnPhSmCQ04L
         oGYPiB+Z0zzLtSal1e9gxF2b5aJFG0HrE5X+I7gFbfVp0SHH43M6CoJ1X44h618WrbMr
         axcyyMWqGFKFlyMGL0i3ttiJ3ZaHshWR3jkXY4Bw/AT7AasVQmJjV2o9G8JiTQ0r7bZq
         KLUIMdm3dAZlf7rL/PCuu6+rpoaG+gBllSR+UUUqDl8XIjs0XL+A0YTEOxIkeOXmLL1F
         Lqtw==
X-Gm-Message-State: AOAM530MtWb5R2KjpsO0JKSslgIp1Xkakl8FEPwS3pXsTbaDTGwOt7JT
        Dzod7/6TiqHH7m1s8HTaoKk=
X-Google-Smtp-Source: ABdhPJwLQw5uxZjV3SDix6beEfHZO1s6+ZZ0lygWhMNiHfPgDYo/6t2F6TxYmbv/4cT/sP6vYOJhEQ==
X-Received: by 2002:adf:cd10:: with SMTP id w16mr2034905wrm.90.1612485939769;
        Thu, 04 Feb 2021 16:45:39 -0800 (PST)
Received: from p4 ([151.44.37.244])
        by smtp.gmail.com with ESMTPSA id w14sm10476563wro.86.2021.02.04.16.45.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2021 16:45:39 -0800 (PST)
Date:   Fri, 5 Feb 2021 00:45:36 +0000
From:   Giancarlo Ferrari <giancarlo.ferrari89@gmail.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        penberg@kernel.org, geert@linux-m68k.org, rppt@kernel.org,
        akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org,
        giancarlo.ferrari@nokia.com
Subject: Re: [PATCH] ARM: kexec: Fix panic after TLB are invalidated
Message-ID: <20210205004535.GB3319@p4>
References: <20210201124720.GA66060@C02TD0UTHF1T.local>
 <20210201130344.GF1463@shell.armlinux.org.uk>
 <20210201135714.GB66060@C02TD0UTHF1T.local>
 <20210201160838.GH1463@shell.armlinux.org.uk>
 <20210201200734.GC15399@p4>
 <20210201201633.GJ1463@shell.armlinux.org.uk>
 <20210201202742.GA17243@p4>
 <20210204234841.GA19339@p4>
 <20210205001833.GE1463@shell.armlinux.org.uk>
 <20210205004050.GA3319@p4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205004050.GA3319@p4>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for polluting,

On Fri, Feb 05, 2021 at 12:40:54AM +0000, Giancarlo Ferrari wrote:
> Russell,
> 
> On Fri, Feb 05, 2021 at 12:18:33AM +0000, Russell King - ARM Linux admin wrote:
> > On Thu, Feb 04, 2021 at 11:48:42PM +0000, Giancarlo Ferrari wrote:
> > > Can I ask about having it integrated ?
> > 
> > Thanks for testing. Are you willing for me to add:
> > 
> > Tested-by: Giancarlo Ferrari <giancarlo.ferrari89@gmail.com>
> > 
> > to the commit log?
> > 
> 
> Sure.
> 
> I have a question regarding the patch. I saw that the structure start at
> the end of the relocation code:
> 
> data = reboot_code_buffer + relocate_new_kernel_size;
> 
> which means it overlap with the global symbol relocate_new_kernel_size.
> I think is minor comment as the variable is only used in the fncpy()
> then thrown away. Something like:
> 
> data = reboot_code_buffer + relocate_new_kernel_size + sizeof(long);
> 
> and accordingly in the instruction (arch/arm/kernel/relocate_kernel.S):
> 
> adr	r7, relocate_new_kernel_end
> 

my fault. Do as I didn't talk... one is in virtual memory the other in the
initial code.

> > I can move it into the fixes branch which I want to send to Linus by
> > Saturday at the very latest.
> > 
> 
> I am not used with all the merging process. However it sounds great !
> 
> > -- 
> > RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> > FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
> 
> Thanks in advance,
> 
> 
> GF

Thanks,


GF
