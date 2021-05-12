Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F026337C2EE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 17:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbhELPQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 11:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbhELPHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 11:07:17 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD6EC061760;
        Wed, 12 May 2021 08:00:02 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id c3so22455383oic.8;
        Wed, 12 May 2021 08:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wAw2wQB4eQHn6TDwpGJK9D3eOJ6qhU0f1KoS9QvzkWM=;
        b=loF0pyMBQRqwDEvT7rYJtv4geglNOLVoskIvxa2FNrVpO6yh141PcdytI9szrSfwey
         NCPI0JXldCm1xdKJkvs+EMOqPOkxAKkkDLid9HXujR3z/uZXl+ytWem68OKayxMK44Wj
         r49klWLflnYXQbGE9YTknEBgQ8tGmEnmG4nu8p+onCvSzORtAu9xuX0vGBEDR4XV+J6V
         ycseUzZzYh4E4rFs59HMcd6G0Q4HVWH65WeFT1aN0bG4y1qoEFRwAhAE0H3EWmQxPLp7
         ANgiAje+NgLqt74hFxWMNSSR2jkx8nmW99vIxAYuPad+vUSTuGfLfNNXC7HWyjj4n/W4
         FV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wAw2wQB4eQHn6TDwpGJK9D3eOJ6qhU0f1KoS9QvzkWM=;
        b=WvSY+ryLGkvvIbK8HOLmyfRN/zxhbPdxrC4jnQrworIo+GBhU9ZTUUA7M5qACanTtR
         pnXpm7vMNlWs7suRxrZWY9tRBz9/VjKfyGIKHGWd/9pz4u1dYuMg20TYr2Kpe1gtI5yO
         l+9JGV6RvehksdF34a0wogVdN8x+wqE6sdpdeueHzEZ+2Ot7wai1UofItcA/ESdEG/VS
         RPtYluI7yy/mMvvPXBTk0TagdpJcgS4MzlxtPKGun4OXr+G4xTPZva0ChzdOMUi+huLc
         EAQulQG1BhlY7ghwTY0ZfNbrnzUEHk3nQEl7EiGK+9vaL+0JJ+mptfpsF+KegZ+rr6OT
         KauQ==
X-Gm-Message-State: AOAM530jGx2Ru09D4/18oNGozW9oPR3JSI4Br7LCo8+R0UrhwIMNHCZc
        h3E/kGuGdJvIhAFaLq/d95k46Llando=
X-Google-Smtp-Source: ABdhPJz2ZIDSm8cD7EYMyfJiRk9PCaJLERgRQLj7veh6dDLN/mEn8xKYLB8FEo5gpWsqLM+ZGuN6Mw==
X-Received: by 2002:aca:db41:: with SMTP id s62mr7719836oig.167.1620831601894;
        Wed, 12 May 2021 08:00:01 -0700 (PDT)
Received: from ceres ([2603:300b:7b5:c800:1cf6:4c9f:4e7:d116])
        by smtp.gmail.com with ESMTPSA id j16sm1975523otn.55.2021.05.12.08.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 08:00:01 -0700 (PDT)
Date:   Wed, 12 May 2021 08:59:59 -0600
From:   Connor Davis <connojdavis@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        xen-devel@lists.xenproject.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] usb: xhci: Notify xen when DbC is unsafe to use
Message-ID: <20210512145959.h6boyhrh2bvgx5iz@ceres>
References: <cover.1620776161.git.connojdavis@gmail.com>
 <2af7e7b8d569e94ab9c48039040ca69a8d52c89d.1620776161.git.connojdavis@gmail.com>
 <YJt9su1k67KEFh6K@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJt9su1k67KEFh6K@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 12, 21, Greg Kroah-Hartman wrote:
> On Tue, May 11, 2021 at 06:18:21PM -0600, Connor Davis wrote:
> > When running as a dom0 guest on Xen, check if the USB3 debug
> > capability is enabled before xHCI reset, suspend, and resume. If it
> > is, call xen_dbgp_reset_prep() to notify Xen that it is unsafe to touch
> > MMIO registers until the next xen_dbgp_external_startup().
> >
> > This notification allows Xen to avoid undefined behavior resulting
> > from MMIO access when the host controller's CNR bit is set or when
> > the device transitions to D3hot.
> >
> > Signed-off-by: Connor Davis <connojdavis@gmail.com>
> > ---
> >  drivers/usb/host/xhci-dbgcap.h |  6 ++++
> >  drivers/usb/host/xhci.c        | 57 ++++++++++++++++++++++++++++++++++
> >  drivers/usb/host/xhci.h        |  1 +
> >  3 files changed, 64 insertions(+)
> >
> > diff --git a/drivers/usb/host/xhci-dbgcap.h b/drivers/usb/host/xhci-dbgcap.h
> > index c70b78d504eb..24784b82a840 100644
> > --- a/drivers/usb/host/xhci-dbgcap.h
> > +++ b/drivers/usb/host/xhci-dbgcap.h
> > @@ -227,4 +227,10 @@ static inline int xhci_dbc_resume(struct xhci_hcd *xhci)
> >  	return 0;
> >  }
> >  #endif /* CONFIG_USB_XHCI_DBGCAP */
> > +
> > +#ifdef CONFIG_XEN_DOM0
> > +int xen_dbgp_reset_prep(struct usb_hcd *hcd);
> > +int xen_dbgp_external_startup(struct usb_hcd *hcd);
> > +#endif /* CONFIG_XEN_DOM0 */
> > +
> >  #endif /* __LINUX_XHCI_DBGCAP_H */
> > diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> > index ca9385d22f68..afe44169183f 100644
> > --- a/drivers/usb/host/xhci.c
> > +++ b/drivers/usb/host/xhci.c
> > @@ -37,6 +37,57 @@ static unsigned long long quirks;
> >  module_param(quirks, ullong, S_IRUGO);
> >  MODULE_PARM_DESC(quirks, "Bit flags for quirks to be enabled as default");
> >
> > +#ifdef CONFIG_XEN_DOM0
> > +#include <xen/xen.h>
>
> <snip>
>
> Can't this #ifdef stuff go into a .h file?
>

Yep, will clean that up in v2.

> thanks,
>
> greg k-h

Thanks,
Connor
