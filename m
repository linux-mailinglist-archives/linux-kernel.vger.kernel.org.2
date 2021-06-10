Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87F13A3444
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 21:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhFJTtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 15:49:08 -0400
Received: from mail-pj1-f43.google.com ([209.85.216.43]:56010 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhFJTtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 15:49:07 -0400
Received: by mail-pj1-f43.google.com with SMTP id k7so4297411pjf.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 12:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bs/WmMN5632krMB2nShrOk+Myfd0/sOpyYJ8a4S0bbQ=;
        b=FlNEQ8yUasqg+h9VdKTBDcPUjpjxJpncBacEOu8EQmkRlSDloaxGxCp236cXks6zxw
         bQG5E84jSl2yxthGrbGw6MDPopFPPoKJLnp3aQI4NQx8IXi9phaEcvX+g+LKeeML8GmC
         uQY6JEFZVKHTV60zA3q8CueYpK5trGWqhatNuhK4405bKkYIrA5oRmiDVsI9uC4eBCaa
         urysgjckSvunJTxc+7+xPq3QuBeW8LhVO4l6+4VDZ/E5Pd790s6SL2PS82l2hyqipNod
         s1QnNLhyNOYJBiMut8gdfsVtAoZf+jwPZuhXo7GLoDU4wwEdTqVvsdy59ZhSUpi67yS4
         djkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bs/WmMN5632krMB2nShrOk+Myfd0/sOpyYJ8a4S0bbQ=;
        b=ZC/IrXcfpB7M6F1AtUuu+CKPFURJXjtgc7o4E5e7Khg1udZGih6/gHghWBQiTclM20
         AdqKqoVfbsM9oRRh4bHs3wv5+oDMmVWpESkgE0496nBMkCpVDxdR/xs1nUujOFJWpuvx
         nP/FN0tzpBCw1qp+nQkWKwh1eNzLq/S53bGXy/No1iO+SZzCMQOQpAWDtX6cdARTEpdc
         Otjtu0PsFQsJNi4qGxXZcGbqd/vIXdnUii0MdyPohTHUP7ge72dB4HxiAEWqdrBTXkoO
         fVG98+1nMT2ix52Rqg8cXPERq+o0uRR56QbHdQNQC1UkE5EfokDxn4HlBsQCby5ITHzC
         jREg==
X-Gm-Message-State: AOAM530r3Fn9z3YCZ6HRsYd1diZbB2GAMWUi+HRQdkwzQg5snuJr8X6c
        TxIvvnteub/0TaVuv9JGI+Q=
X-Google-Smtp-Source: ABdhPJxUTARKGjhU9auy+XJt4V4WbdmdfT1zZgkTSVNnVGLi7Uj5oAbLUd8zFHHeFE5Q/Ky/YvBjig==
X-Received: by 2002:a17:902:db0b:b029:111:7dac:2789 with SMTP id m11-20020a170902db0bb02901117dac2789mr338223plx.45.1623354357064;
        Thu, 10 Jun 2021 12:45:57 -0700 (PDT)
Received: from localhost (g151.115-65-219.ppp.wakwak.ne.jp. [115.65.219.151])
        by smtp.gmail.com with ESMTPSA id y6sm3199768pjf.40.2021.06.10.12.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 12:45:56 -0700 (PDT)
Date:   Fri, 11 Jun 2021 04:45:48 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     "Gabriel L. Somlo" <gsomlo@gmail.com>
Cc:     Joel Stanley <joel@jms.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        pczarnecki@internships.antmicro.com,
        David Gow <davidgow@google.com>,
        Florent Kermarrec <florent@enjoy-digital.fr>
Subject: Re: [PATCH v2] drivers/soc/litex: remove 8-bit subregister option
Message-ID: <YMJr7DdTZevH/E8K@antec>
References: <20210526105126.463931-1-gsomlo@gmail.com>
 <CACPK8XeHkQP+6hn0hgq4dKwXG8zXHSOYUdOwoOSO=aFOZ8faXA@mail.gmail.com>
 <20210527031736.GA491539@crash.ini.cmu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527031736.GA491539@crash.ini.cmu.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 11:17:36PM -0400, Gabriel L. Somlo wrote:
> On Thu, May 27, 2021 at 02:12:40AM +0000, Joel Stanley wrote:
> > On Wed, 26 May 2021 at 10:55, Gabriel Somlo <gsomlo@gmail.com> wrote:
> > >
> > > Since upstream LiteX recommends that Linux support be limited to
> > > designs configured with 32-bit CSR subregisters (see commit a2b71fde
> > > in upstream LiteX, https://github.com/enjoy-digital/litex), remove
> > > the option to select 8-bit subregisters, significantly reducing the
> > > complexity of LiteX CSR (MMIO register) accessor methods.
> > >
> > > NOTE: for details on the underlying mechanics of LiteX CSR registers,
> > > see https://github.com/enjoy-digital/litex/wiki/CSR-Bus or the original
> > > LiteX accessors (litex/soc/software/include/hw/common.h in the upstream
> > > repository).
> > >
> > > Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> > 
> > I like how this simplifies things.
> > 
> > Reviewed-by: Joel Stanley <joel@jms.id.au>
> 
> Thanks!
>  
> > With this change, is there any need to keep the litex acessors around?
> > 
> > There's the 64 bit case, but we don't have any 64 bit CSR registers do we?
>  
> Off the top of my head, the LiteSDcard driver uses 64-bit CSR writes:
> https://github.com/litex-hub/linux/blob/litex-rebase/drivers/mmc/host/litex_mmc.c#L403
> and
> https://github.com/litex-hub/linux/blob/litex-rebase/drivers/mmc/host/litex_mmc.c#L421
> 
> These are both DMA base-address registers that support rv64*.
> 

I have pushed version to to for-next which should show up in linux-next today or
next week.

-Stafford
