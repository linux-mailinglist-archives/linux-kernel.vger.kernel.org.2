Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C876630B2AF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 23:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhBAWTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 17:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhBAWTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 17:19:11 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C33C061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 14:18:30 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id y8so5589152ede.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 14:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ObygprHSjf/mIe84ziGq1dLJAyK92YoMohD2S+3eR34=;
        b=KmhoERdkRrIhw8VIgPTNi1wxuN2QvfeFJkT89hQLTk063kH6JKSTkov/x6PhqAfAHs
         kKmDuDTurcFq7c9KTqI2qv36oHP5jmYRCwwQTuOdOcvKKwqQnMDZLoyPHwfwkOAEf0lH
         0SuArRJydaifldIgpxYQJB9yf9h06H+mY4AkD02kunkBawh6OJozD+/LWq5qiiN3x29v
         5INCW09cNAVOX07SYp6gDFYG9jFCS/3cT4hXuY5Ed5/9tufFYY9PQ0G5pigzOO052PuX
         grVwCEfzpX1XESxcRMGPMVn07rA0lcVc3QBw/DOZPjtSx34fw2xBPXFw9OnYquTH3oKK
         91rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ObygprHSjf/mIe84ziGq1dLJAyK92YoMohD2S+3eR34=;
        b=WmkF9S97O9ICL4hkU9VnPRDQFRa375egehbaPWtW19EoBUt91mS0LnJMbNbXwBR1Zk
         aztRSciwU1ZKWtRcjZsmW9032t1msb2heaP2JuWhDQWpGnKbicV53mXcAygrGIIbenRk
         2zf2jQMUK89oTVZGPhaMEua+9D+aSzNiUqJR4nDuWW0aVU8hQbCXHHFbEri7B1zxm571
         5w7oqAlqAoj7fVh/1D7aoaOAVHmoBRe2RN/5xcu5V2V1s43Qe5PI4UOa75L8JbpYDaTI
         r86yVb4mIcqYfErmJTT6qiRCpV3Q3htU72brrVFQ7FAxM4/7Q6HyCL4TGsLRUW3o2Jpr
         Mh4A==
X-Gm-Message-State: AOAM533DRjgJXvPhxwFOqWI0CDY3emVO9gngUYlqHxVB1yZkU8IfyBww
        5bHIGhIt5riGfy3S3vaaUaIoEpp/XZc=
X-Google-Smtp-Source: ABdhPJy+5xW4wxQia6EkqUJgNHiZ5LDVelO5J0rP1HSdolWpInTt3ufU/RP/2hppv62cI3SAENN1tg==
X-Received: by 2002:a05:6402:2683:: with SMTP id w3mr20808726edd.378.1612217909472;
        Mon, 01 Feb 2021 14:18:29 -0800 (PST)
Received: from p4 (net-93-70-85-165.cust.vodafonedsl.it. [93.70.85.165])
        by smtp.gmail.com with ESMTPSA id i90sm1400549edi.52.2021.02.01.14.18.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Feb 2021 14:18:29 -0800 (PST)
Date:   Mon, 1 Feb 2021 22:18:26 +0000
From:   Giancarlo Ferrari <giancarlo.ferrari89@gmail.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        penberg@kernel.org, geert@linux-m68k.org,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        rppt@kernel.org, giancarlo.ferrari@nokia.com
Subject: Re: [PATCH] ARM: kexec: Fix panic after TLB are invalidated
Message-ID: <20210201202742.GA17243@p4>
References: <1612140296-12546-1-git-send-email-giancarlo.ferrari89@gmail.com>
 <20210201124720.GA66060@C02TD0UTHF1T.local>
 <20210201130344.GF1463@shell.armlinux.org.uk>
 <20210201135714.GB66060@C02TD0UTHF1T.local>
 <20210201160838.GH1463@shell.armlinux.org.uk>
 <20210201200734.GC15399@p4>
 <20210201201633.GJ1463@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201201633.GJ1463@shell.armlinux.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Russell,

On Mon, Feb 01, 2021 at 08:16:33PM +0000, Russell King - ARM Linux admin wrote:
> On Mon, Feb 01, 2021 at 08:07:37PM +0000, Giancarlo Ferrari wrote:
> > Hi,
> 
> Hi,
> 
> > Why we should align 3 ? For the fncpy I suppose.
> 
> Slightly arbitary really - it gives a nice 8-byte alignment to the data.
> .align 2 would also be sufficient.
> 
> > I don't know now how to proceed now, as you (Mark and you) do completely
> > the patch.
> 
> Please can you test my patch and let us know if it solves your problem
> (or even if it works! I haven't tested it beyond build-testing.)
>

sure, unfortunately due to restriction, I hope to test it by the end of the
week. I hope there will be no rush. Otherwise, please let me know.

> > You see is my first kernel patch submission :) .
> 
> Yay. Sorry for giving you a different patch - Mark is quite right that
> there's a better solution to this problem, which is eliminating the
> set_kernel_text_rw() call. The only reason I cooked up the patch was
> doing that would be more in-depth (as you can see from the increased
> size of the patch.)
> 

I definitely agree with you.

> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!

Thanks again,


GF
