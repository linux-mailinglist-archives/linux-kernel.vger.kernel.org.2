Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B0342257F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 13:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbhJELpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 07:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbhJELpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 07:45:38 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B926C061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 04:43:48 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id j11-20020a9d190b000000b00546fac94456so25473527ota.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 04:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=gEdE0klzvgQxsIJ5Hf+HcoOlaL0XAmAJnEjKCBQ9e/0=;
        b=a2GsYDffeyImUGMgFmEG//Nsixk4Ap6rE6897JAAptPD7MT5F77nroysOhj2jjTnse
         tQw999N7Zyl9fzoS7rTVY4C+5hk2TicUQfdVFX5lJhbM022ymsghFrWRobjbiq3ag6yE
         XErLOsg0qaEHApVDMFZGhVyo+k8XMybNQSfAUs/lGf9x/8m4qqJ7C9L2DgDJoK5uucAV
         0UzJphGW7cibdEDPGvYETut9cidFWGx7Xw+yOzt3G8CUQU6w/7v4SaPrsuG0H/DCYtcP
         LbNsUInl7syucKjDbyZWoihvQKpIN3YF7VnjA1RKre/w4IjOChMs3hzN09cAyKLtb9mB
         2pPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=gEdE0klzvgQxsIJ5Hf+HcoOlaL0XAmAJnEjKCBQ9e/0=;
        b=GdzZYCLkL6Iue7W/NuVjNOFktv/BMcfsPzD2lqg/b4IqKILi5Yw3Pa0pbVJdtg5XFk
         h/a8+zaK/lWIsuIYKaHZ/oN+LoEVTwTcIatnyFp6u5lSpiZtt1pHsmsd/mAk5MouIG8j
         xdbUgPrAb0qNvkcUsaIkV2HMcHn+sIQcq47A+RzwNP1I532oL7obl8ktcS3IvmSCJB8e
         trjMzzWPkzFdf8orhxOr0iBc7gdTmVPnqopkfezh3EoEHJS2hM6miz9xurzm0kvqo6+n
         nt0to2do/HhNQNJue0/UoOQAJIj6vD935j7/+BG/6MHl45U7TeBK6KOuC1kbYRKCz6Vc
         QFXw==
X-Gm-Message-State: AOAM530eZ6hRPCk15GJdP6ueZOlxYAfrD9C0BTveEL9n4ep3S0wqw7z5
        MjtvCnPMbq+Ud0bqUsDr/A==
X-Google-Smtp-Source: ABdhPJxa15ezc9zlGo6dbdopkaaVzd3J+Jh7ny1BvLkLvlIqaUu+6+JtyOm9VEC0pAQzkU4l9urjXQ==
X-Received: by 2002:a05:6830:246f:: with SMTP id x47mr14055511otr.287.1633434227583;
        Tue, 05 Oct 2021 04:43:47 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id e64sm2963134otb.14.2021.10.05.04.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 04:43:47 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:1ce5:3fb4:8fe9:30d1])
        by serve.minyard.net (Postfix) with ESMTPSA id 1C5671800ED;
        Tue,  5 Oct 2021 11:43:46 +0000 (UTC)
Date:   Tue, 5 Oct 2021 06:43:44 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     openipmi-developer@lists.sourceforge.net,
        Andrew Manley <andrew.manley@sealingtech.com>,
        linux-kernel@vger.kernel.org, Corey Minyard <cminyard@mvista.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/5] ipmi:ipmb: Add initial support for IPMI over IPMB
Message-ID: <20211005114344.GC5381@minyard.net>
Reply-To: minyard@acm.org
References: <20211005004019.2670691-1-minyard@acm.org>
 <20211005004019.2670691-4-minyard@acm.org>
 <1d2c2c50-8f79-03ec-5c5c-e1cd8ce07b3d@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d2c2c50-8f79-03ec-5c5c-e1cd8ce07b3d@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 06:27:34PM -0700, Randy Dunlap wrote:
> Hi,

Thanks, all issues addressed.

-corey

> 
> On 10/4/21 5:40 PM, minyard@acm.org wrote:
> > From: Corey Minyard <cminyard@mvista.com>
> > 
> > This provides access to the management controllers on an IPMB bus to a
> > device sitting on the IPMB bus.  It also provides slave capability to
> > respond to received messages on the bus.
> > 
> > Signed-off-by: Corey Minyard <minyard@acm.org>
> > Tested-by: Andrew Manley <andrew.manley@sealingtech.com>
> > Reviewed-by: Andrew Manley <andrew.manley@sealingtech.com>
> > ---
> >   drivers/char/ipmi/Kconfig     |   9 +
> >   drivers/char/ipmi/Makefile    |   1 +
> >   drivers/char/ipmi/ipmi_ipmb.c | 510 ++++++++++++++++++++++++++++++++++
> >   3 files changed, 520 insertions(+)
> >   create mode 100644 drivers/char/ipmi/ipmi_ipmb.c
> > 
> > diff --git a/drivers/char/ipmi/Kconfig b/drivers/char/ipmi/Kconfig
> > index 249b31197eea..1c92209f023b 100644
> > --- a/drivers/char/ipmi/Kconfig
> > +++ b/drivers/char/ipmi/Kconfig
> > @@ -75,6 +75,15 @@ config IPMI_SSIF
> >   	  have a driver that must be accessed over an I2C bus instead of a
> >   	  standard interface.  This module requires I2C support.
> > +config IPMI_IPMB
> > +       tristate 'IPMI IPMB interface'
> > +       select I2C
> 
> How can this select I2C unconditionally? At this point we don't
> even know if this platform has/supports I2C.
> 
> Ditto for IPMI_SSIF in the current Kconfig file, while
> IPMB_DEVICE_INTERFACE depends on I2C (as it should IMO).
> 
> 
> 
> > +       help
> > +	 Provides a driver for a system running right on the IPMB bus.
> > +	 It supports normal system interface messages to a BMC on the IPMB
> > +	 bus, and it also supports direct messaging on the bus using
> > +	 IPMB direct messages.  This module requires I2C support.
> 
> <form-letter-bot>
> 
> Please follow coding-style for Kconfig files:
> 
> (from Documentation/process/coding-style.rst, section 10):
> 
> For all of the Kconfig* configuration files throughout the source tree,
> the indentation is somewhat different.  Lines under a ``config`` definition
> are indented with one tab, while help text is indented an additional two
> spaces.
> 
> > +
> >   config IPMI_POWERNV
> >   	depends on PPC_POWERNV
> >   	tristate 'POWERNV (OPAL firmware) IPMI interface'
> 
> 
> > diff --git a/drivers/char/ipmi/ipmi_ipmb.c b/drivers/char/ipmi/ipmi_ipmb.c
> > new file mode 100644
> > index 000000000000..b10a1fd9c563
> > --- /dev/null
> > +++ b/drivers/char/ipmi/ipmi_ipmb.c
> > @@ -0,0 +1,510 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/*
> > + * Driver to talk to a remote management controller on IPMB.
> > + */
> > +
> 
> [...]
> 
> > +
> > +static int ipmi_ipmb_start_processing(void            *send_info,
> 
> Odd spacing/formatting above.
> 
> > +				      struct ipmi_smi *new_intf)
> > +{
> > +	struct ipmi_ipmb_dev *iidev = send_info;
> > +
> > +	iidev->intf = new_intf;
> > +	iidev->ready = true;
> > +	return 0;
> > +}
> > +
> > +
> > +static void ipmi_ipmb_sender(void                *send_info,
> 
> Ditto.
> 
> > +			     struct ipmi_smi_msg *msg)
> > +{
> 
> 
> -- 
> ~Randy
