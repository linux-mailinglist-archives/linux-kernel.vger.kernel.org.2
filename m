Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 880A23101BD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 01:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbhBEAlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 19:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbhBEAlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 19:41:39 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F7CC061786
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 16:40:59 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id z6so5665324wrq.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 16:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DUZi2bTfy11l+UEZp8Mba5c7avH04XQB0vRN2ZYNQmk=;
        b=K9tE4mFU3BLsSxI1V2AXkjuvskB3tJ18kV+HRZihuX1+H1EdM+TRsaacDL1so2THx1
         d/Mi+ipR3Os6ky7VMogMQf2sNnZ6EP2cdgAIHXUak+yMSYae/iXPjsMJmAh/PPj1JFYU
         GFxMCj64xKWuLD7wG0VeACaRwISb6RPSYm2+dvBFfLB6+9qCHUtg9HvME++UrMU/eCqI
         Xr3AFTUX26u6isiFu88LP0PRznl4DLu879/PcNlG89GckYeH9fKGbjGKjRWptKHyj3e3
         rpqEOaTL3eMrOok0bXPGNO7w2jkkQKNalUDU/7gocnMatqhRA+6peYDUGWk120IXFI+3
         Z+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DUZi2bTfy11l+UEZp8Mba5c7avH04XQB0vRN2ZYNQmk=;
        b=hPMUv77wVZNKarTeSVAZ4+ZxzEVvOpYsbiUAEkhs0aVRghLdtMwxVRIFfXznMRsKoK
         xXmJjYqFucg9X1pCYLdN0l7mhI37ljONcnHgz/YHspKuHCUP7bNBcFUSIa1Mar7G8YYH
         5grEzWms+Zwm7rVRhF35htOh3Ah6fTj/vGhPCAPUxOS+CRZAC9/E9I7I9ndGVTFzvOCP
         YS1hmg0IEj1C3Dn++P17IBmIpP6S5G1/+yEsWrKu3RgmsCX6lutfbmNWWV8p0ihhZ3uZ
         Uz8JzXnNdRZnnCZATU4tF1XmbDG488cFyUYzCJ3pcV74rGgiWHHz3FKqjINJISofC9KL
         5yXQ==
X-Gm-Message-State: AOAM531+e6nTaqYycKb3tEEb7sD33cnjcOzC9KfYrNBCqguX4z4ogAJg
        h3dZUV2bgRKv9v6U4gxtQt4=
X-Google-Smtp-Source: ABdhPJx6msIudNiBk4YjLEkzTDLhc93tgqv4KYCwjRMjKkTr8TvQy4L4rpv/Ga/5p2i8nmI9j1FRwA==
X-Received: by 2002:a5d:4d0b:: with SMTP id z11mr2018935wrt.388.1612485657870;
        Thu, 04 Feb 2021 16:40:57 -0800 (PST)
Received: from p4 ([151.44.37.244])
        by smtp.gmail.com with ESMTPSA id d30sm11649255wrc.92.2021.02.04.16.40.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2021 16:40:57 -0800 (PST)
Date:   Fri, 5 Feb 2021 00:40:54 +0000
From:   Giancarlo Ferrari <giancarlo.ferrari89@gmail.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        penberg@kernel.org, geert@linux-m68k.org, rppt@kernel.org,
        akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org,
        giancarlo.ferrari@nokia.com
Subject: Re: [PATCH] ARM: kexec: Fix panic after TLB are invalidated
Message-ID: <20210205004050.GA3319@p4>
References: <1612140296-12546-1-git-send-email-giancarlo.ferrari89@gmail.com>
 <20210201124720.GA66060@C02TD0UTHF1T.local>
 <20210201130344.GF1463@shell.armlinux.org.uk>
 <20210201135714.GB66060@C02TD0UTHF1T.local>
 <20210201160838.GH1463@shell.armlinux.org.uk>
 <20210201200734.GC15399@p4>
 <20210201201633.GJ1463@shell.armlinux.org.uk>
 <20210201202742.GA17243@p4>
 <20210204234841.GA19339@p4>
 <20210205001833.GE1463@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205001833.GE1463@shell.armlinux.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Russell,

On Fri, Feb 05, 2021 at 12:18:33AM +0000, Russell King - ARM Linux admin wrote:
> On Thu, Feb 04, 2021 at 11:48:42PM +0000, Giancarlo Ferrari wrote:
> > Can I ask about having it integrated ?
> 
> Thanks for testing. Are you willing for me to add:
> 
> Tested-by: Giancarlo Ferrari <giancarlo.ferrari89@gmail.com>
> 
> to the commit log?
> 

Sure.

I have a question regarding the patch. I saw that the structure start at
the end of the relocation code:

data = reboot_code_buffer + relocate_new_kernel_size;

which means it overlap with the global symbol relocate_new_kernel_size.
I think is minor comment as the variable is only used in the fncpy()
then thrown away. Something like:

data = reboot_code_buffer + relocate_new_kernel_size + sizeof(long);

and accordingly in the instruction (arch/arm/kernel/relocate_kernel.S):

adr	r7, relocate_new_kernel_end

> I can move it into the fixes branch which I want to send to Linus by
> Saturday at the very latest.
> 

I am not used with all the merging process. However it sounds great !

> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!

Thanks in advance,


GF
