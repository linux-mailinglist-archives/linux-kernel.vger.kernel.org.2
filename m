Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447CE3DA4A2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 15:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237795AbhG2NsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 09:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237684AbhG2NsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 09:48:07 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E01C061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 06:48:03 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id k1so7013622plt.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 06:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YxDl0EJtEuevrE5fofbeNq+CYZb2RNB0hzvmFi+D3+8=;
        b=VVYQWyDfexTZ8+hbjdrXcso8HsN0LxWI8d3EnEupkmGdjIekJNRNOUnHbFvjHQDSTL
         sZoJ3mohHFdq5D2OsrU4VkIxYb/jwD1NqYsCFKcuiaJsDikdI1VcNWref2GZYaczSIcC
         NOTsJIA8uiNJpcfNMMN1iXroctoHxObztJZabghMQl6xFYmo4Qlzughg4rtXT18uK6KM
         d0aPBsBM8+KsN368qpHnjjYYnNTZzox1aN8Q6rLKlpCpYG9RgA0oDbQHV+KErlpqWAk+
         IA20Mz8OUyk7fSs7EtQl+Hi52so/NY/jNIRcLNuRaTqXyR5Xofhh3dpX1NReIcRUQG2i
         JcQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YxDl0EJtEuevrE5fofbeNq+CYZb2RNB0hzvmFi+D3+8=;
        b=XqMxaPtg6CCbio4cVjGH+gbC0tbg3CM58YP2kX/EsXunEOTCkpjXi5QAIfIPGGiQ5O
         QGXCqxWRyvYyigMLJ5DlZ+tHp3/Sfr7KcF4UkWQF4Xby517+4zhLVMbpgVrLVbELCJSA
         ILSue6L0zo30N9uMti3abby2lEXxx7MOPu58OdDUwA4ns3vAV4Mkua36p6yZtf4f1j5p
         T4TUJBZgfXEtGHhlIbJ7ls9rYx6lHOq/+nfFn5i1f92EwKNmnBkH6UXM75n+r/EcUEl4
         FMXbEqmAN0EpAAIU8wIMBEbhuaveYjw3XjxxjpLZ600QPunBeekwldCGGhFM/llWWS6H
         v7RA==
X-Gm-Message-State: AOAM5322ht5FpIzivhER5MKBl+VAfCSa4X/1ytFgvFsRWj3ZqxFmUaRn
        b7k1Am3qk3uqC4DxkYB3ubU=
X-Google-Smtp-Source: ABdhPJwehJhh8ZtlX4s5039UfLl8M70E/Prup4jVkYNGctW420GGbrH/QI/TZ7Pczmv/94fnJzaTHg==
X-Received: by 2002:a17:90a:b893:: with SMTP id o19mr5325862pjr.114.1627566483247;
        Thu, 29 Jul 2021 06:48:03 -0700 (PDT)
Received: from ojas ([122.161.51.5])
        by smtp.gmail.com with ESMTPSA id f3sm3887725pfe.123.2021.07.29.06.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 06:48:02 -0700 (PDT)
Date:   Thu, 29 Jul 2021 19:17:52 +0530
From:   Ojaswin Mujoo <ojaswin98@gmail.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, nsaenz@kernel.org,
        dan.carpenter@oracle.com, phil@raspberrypi.com,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: vchiq: Add details to $CONFIG_VCHIQ_CDEV
 help text
Message-ID: <20210729134739.GA19228@ojas>
References: <cover.1627495116.git.ojaswin98@gmail.com>
 <9c9c128b41e31d6bebe646e052aa05c44b19eb83.1627495116.git.ojaswin98@gmail.com>
 <YQGmG6nwk+pOyAdu@kroah.com>
 <20210728200039.GA17046@ojas>
 <fa20cb94-ed73-ea6e-d128-cfb930399af6@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa20cb94-ed73-ea6e-d128-cfb930399af6@i2se.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 10:39:38PM +0200, Stefan Wahren wrote:
> Am 28.07.21 um 22:00 schrieb Ojaswin Mujoo:
> > On Wed, Jul 28, 2021 at 08:46:51PM +0200, Greg KH wrote:
> >> On Thu, Jul 29, 2021 at 12:07:17AM +0530, Ojaswin Mujoo wrote:
> >>> Add some details to the Kconfig definition of $CONFIG_VCHIQ_CDEV to help
> >>> make the motive behind it a bit more clear.
> >>>
> >>> Signed-off-by: Ojaswin Mujoo <ojaswin98@gmail.com>
> >>> ---
> >>>  drivers/staging/vc04_services/Kconfig | 8 ++++++--
> >>>  1 file changed, 6 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/staging/vc04_services/Kconfig b/drivers/staging/vc04_services/Kconfig
> >>> index 2b70c37cdd09..cb02d8a4cb74 100644
> >>> --- a/drivers/staging/vc04_services/Kconfig
> >>> +++ b/drivers/staging/vc04_services/Kconfig
> >>> @@ -25,8 +25,12 @@ config VCHIQ_CDEV
> >>>  	bool "VCHIQ Character Driver"
> >>>  	default y
> >>>  	help
> >>> -		Enable the creation of VCHIQ character driver to help
> >>> -		communicate with the Videocore platform.
> >>> +		Enable the creation of VCHIQ character driver to help communicate
> >>> +		with the VideoCore platform. The cdev exposes ioctls used by
> >>> +		userspace libraries and testing tools to interact with VideoCore.
> >>> +		This can be set to 'N' if the VideoCore communication is not needed
> >>> +		by userspace but only by other kernel modules (like bcm2835-audio).
> >>> +		If not sure, set this to 'Y'.
> >> I still do not understand if I need this driver or not, and I have this
> >> hardware!  What functionality does this driver accomplish?  What is
> >> VideoCore?
> > Hey Greg,
> >
> > I believe I can add this under the CONFIG_BCM2835_VCHIQ config option,
> > as that enables the core driver that implements the functions to
> > communicate with VideoCore platform? 
> 
> Sorry, today i'm too tired to give a good explanation. VideoCore is the
> VPU inside the BCM283x SoC. It runs a firmware and VCHIQ provides a way
> to communicate with this firmware / VPU. The VCHIQ driver is required to
> get access to the audio jack and camera interface (see depending drivers).
> 
> Unfortunately i don't have an application list by the hand which uses
> the CDEV interface for VCHIQ, please use this link [1] as a starting point.
> 
> [1] - https://github.com/raspberrypi/userland
> 
Hi Stefan

Thanks for the brief, its good enough to help me get started. I've also
been looking more closely into this driver in my free time lately and I
can try to come up with a small summary to use as the help text. I'll
add it in v2 of this patch.

Regards,
Ojaswin
> >
> > This config option merely adds a cdev which exposes the the core
> > driver's functionality to userspace. 
> >
> > Regards,
> > Ojaswin
> >> thanks,
> >>
> >> greg k-h
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
