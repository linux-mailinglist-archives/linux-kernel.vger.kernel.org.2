Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0339541E601
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 04:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351578AbhJAC30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 22:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhJAC3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 22:29:20 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C32C06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 19:27:34 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id m26so6651148pff.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 19:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5Gsu3s/cPFpx5tYAdo48WldJH7gJHFENlkBX3ettNaE=;
        b=psZGAQbVmgnf6dmiIuFC+UvrGGv5BfchgcavgYaFajyp6xHhTTaKLxiTIxwf2KrIHo
         3Hu1uPpZZyzYL3Na1yT1oHWHPUY76RJOhUP2kp3UKIrEtSNgLd/tWGXYlvrStK0aty4o
         y0d6Cy8+zjfuh0Tsde0lU0BzOGsuxflqbJ0wDuq1xyt4rIQlfll3BHN9JVDSIFoAPZQ1
         pB1SsyShMXcVEcFyHPIYM6dCIZxCKTIGtRd/0N3X4SO/I5KqpuSGjGfBgamRpj/dOREU
         Kj80mHaOnmHjIvhaXqt6c6dgLPwrYoMMXmgk1tmAMxCOgMsv5Oet56gohdwPqXcGh7Ja
         Y4Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5Gsu3s/cPFpx5tYAdo48WldJH7gJHFENlkBX3ettNaE=;
        b=D9KKTCRKcJx5qZ3FbD7HNj9DQdvWq/SLdWpWTaWTyMzlQmYfufiyfYFxhWKUwOIx/X
         nNuxElA4i9bzJxjZTKDiD9n/c2gxySoJpUtgMEDAqYjyf9tct7T9KHS9xejdNTjIju14
         qppckuYLNSEoFFKQ0dKEFqZdq+ucDw2BSQu5msVDb5SL4mheGlSl/Ft3EETvbpNmuU0u
         v24U5V9t3MdDHGkLR4ETQZ6P1AqZ5yO7XNWr0iwESNAJ2+4o7G9Vk89aGR9JOiFrpyGi
         C95bOmrXRAbwlCTdQ+9dqXb2qBYnr3LkaEzUln9funpVd9DpkpK+qHdpu7XUesyOMUxI
         TRxg==
X-Gm-Message-State: AOAM5318X+SruGt3RyL9pWnZe7snT51fncCwvvP4HLUFe2SAuU9odC2b
        Lzct9bTw1DcaCETdzq1wyQAwSGXmMw==
X-Google-Smtp-Source: ABdhPJyMiCGNbtba0w/oYo9BAwgO8IzYD70Y1GaFdsq4wYzPZ4/2MrelTIeazLfzj+Ez4IzJzBeB1w==
X-Received: by 2002:a63:555d:: with SMTP id f29mr7792019pgm.33.1633055253779;
        Thu, 30 Sep 2021 19:27:33 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y13sm3890061pjm.5.2021.09.30.19.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 19:27:31 -0700 (PDT)
Date:   Fri, 1 Oct 2021 10:27:24 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Joey Gouly <joey.gouly@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yuichi Ito <ito-yuichi@fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 2/3] arm64: entry: refactor EL1 interrupt entry logic
Message-ID: <YVZyDIRnIMaxQjg9@piliu.users.ipa.redhat.com>
References: <20210930131708.35328-1-kernelfans@gmail.com>
 <20210930131708.35328-3-kernelfans@gmail.com>
 <20210930140058.GD18258@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930140058.GD18258@lakrids.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 03:00:59PM +0100, Mark Rutland wrote:
> On Thu, Sep 30, 2021 at 09:17:07PM +0800, Pingfan Liu wrote:
> > From: Mark Rutland <mark.rutland@arm.com>
> > 
> > Currently we distinguish IRQ and definitely-PNMI at entry/exit time
> > via the enter_el1_irq_or_nmi() and enter_el1_irq_or_nmi() helpers. In
> > subsequent patches we'll need to handle the two cases more distinctly
> > in the body of the exception handler.
> > 
> > To make this possible, this patch refactors el1_interrupt to be a
> > top-level dispatcher to separate handlers for the IRQ and PNMI cases,
> > removing the need for the enter_el1_irq_or_nmi() and
> > exit_el1_irq_or_nmi() helpers.
> > 
> > Note that since arm64_enter_nmi() calls __nmi_enter(), which
> > increments the preemt_count, we could never preempt when handling a
> > PNMI. We now only check for preemption in the IRQ case, which makes
> > this clearer.
> > 
> > There should be no functional change as a result of this patch.
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Joey Gouly <joey.gouly@arm.com>
> > Cc: Sami Tolvanen <samitolvanen@google.com>
> > Cc: Julien Thierry <julien.thierry@arm.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Yuichi Ito <ito-yuichi@fujitsu.com>
> > Cc: Pingfan Liu <kernelfans@gmail.com>
> > Cc: linux-kernel@vger.kernel.org
> > To: linux-arm-kernel@lists.infradead.org
> 
> As a heads-up, you need to add your Signed-off-by tag when you post
> patches from other people, even if you make no changes. See:
> 
> https://www.kernel.org/doc/html/v5.14/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin
> 
Oh, thanks and I realize it is a serious license issue. 

> Other than that, this looks fine to me.
> 
Thank you very much.


Regards,

	Pingfan
