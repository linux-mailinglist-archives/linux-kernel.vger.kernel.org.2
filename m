Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF843519FB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234943AbhDAR5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 13:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234365AbhDARmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:42:15 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C8BC08E750;
        Thu,  1 Apr 2021 06:19:09 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id r12so2848198ejr.5;
        Thu, 01 Apr 2021 06:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=VBkSNIu9jBA5fHU0Y3NWECYXpRzyBbvDWGafRk7gPpc=;
        b=lDMMOIL14l7ufUNV6xs2UXcYTPSgFU8h2wjQriVcS2+u/77N67wZRjQT7FyV14XZZX
         Vux7T+oSU2IBjynezw66qsucvl8LCudYt4kVtj7d/MhvU+9M1RHbFteRJnbPKK9savWX
         TZ7Fxz0SZVhpokqQDQ9UayzUwX67BwAJ7jAkGTPMP2UDpoYx4zKsVqceBL5OGkNvKOD3
         0nLBCS+X6SysnRGEbJKpSuPi2UyBPHD+iafNpad9mdqffyDnlkPEGkjTySN1Z/lwDCKM
         FnT8+TMM7et/+H9Kj/T5wn8Bed6rojmWZbi8vv2j7EoBHAhqtJ1Kc9dEbGHDs4CZPmja
         BH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VBkSNIu9jBA5fHU0Y3NWECYXpRzyBbvDWGafRk7gPpc=;
        b=C81xjxLVtzQ41pH8DrgmT30/R0lL2n6ZN4BcwhZVRbbH4oUex+VDosnvZhW2zBfEmM
         n2qgm+tBZ6eO3r4+aGFMG6esNR9KtNMVmur5cMZNhrHfDTUbD7WoXgTZAhDGdrLvBiXj
         nhiY5xj/yBczfribgoLs5cDlmZCayLmWY/zIPGXEZahlB8OShQkpaSTkyQVjWRJNc49R
         AxvDiuBNG6TstDx/MjOsuG53R0CaLDGGp4kLSe2iK+G/ertLvoPPSdytpdQbyqahRGTD
         A9BEKdkSAbOB+IpBS1OIgL7yMGyhkaTsWfzLpH3gXRcTjsnePZYqZBLxhL3HTzeZD75l
         QsDw==
X-Gm-Message-State: AOAM530hrYF12RF03WAn2ZuCxlNOTuodZIVg0Bl3xk0iX0R0S+JHt3NF
        lKlXeKRecRu3ucXvcJtkCrE=
X-Google-Smtp-Source: ABdhPJxtVHhpwFKWAYnXpm2TJ6lXr751fh1nwggvs/oXsM+PTB9DFxC/IoGnBlNEJZovlhan+BixSQ==
X-Received: by 2002:a17:906:4146:: with SMTP id l6mr9231494ejk.295.1617283148011;
        Thu, 01 Apr 2021 06:19:08 -0700 (PDT)
Received: from BV030612LT ([188.24.140.160])
        by smtp.gmail.com with ESMTPSA id jv19sm2751559ejc.74.2021.04.01.06.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 06:19:07 -0700 (PDT)
Date:   Thu, 1 Apr 2021 16:19:05 +0300
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        matheus@castello.eng.br
Subject: Re: [PATCH v2 0/6] Add support for Actions Semi Owl socinfo
Message-ID: <20210401131905.GA2001688@BV030612LT>
References: <cover.1617110420.git.cristian.ciocaltea@gmail.com>
 <20210401052438.GB14052@work>
 <20210401094041.GA1993499@BV030612LT>
 <20210401102717.GF14052@work>
 <252dd954-c8f1-fa2a-c37a-ede386fc9d43@suse.de>
 <20210401105805.GA1998829@BV030612LT>
 <20210401110752.GG14052@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210401110752.GG14052@work>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 04:37:52PM +0530, Manivannan Sadhasivam wrote:
> + Matheus
> 
> On Thu, Apr 01, 2021 at 01:58:05PM +0300, Cristian Ciocaltea wrote:
> > Hi Mani, Andreas,
> > 
> > On Thu, Apr 01, 2021 at 12:49:37PM +0200, Andreas Färber wrote:
> > > Hi,
> > > 
> > > On 01.04.21 12:27, Manivannan Sadhasivam wrote:
> > > > On Thu, Apr 01, 2021 at 12:40:41PM +0300, Cristian Ciocaltea wrote:
> > > >> On Thu, Apr 01, 2021 at 10:54:38AM +0530, Manivannan Sadhasivam wrote:
> > > >>> On Tue, Mar 30, 2021 at 04:48:15PM +0300, Cristian Ciocaltea wrote:
> > > >>>> This patchset adds a socinfo driver which provides information about
> > > >>>> Actions Semi Owl SoCs to user space via sysfs: machine, family, soc_id,
> > > >>>> serial_number.
> > > >>>>
> > > >>>> Please note the serial number is currently available only for the S500
> > > >>>> SoC variant.
> > > >>>>
> > > >>>> This has been tested on the S500 SoC based RoseapplePi SBC.
> > > >>>>
> > > >>>
> > > >>> Is this the soc_id provided by the vendor bootloader (uboot)? If so, under
> > > >>> what basis it provides? I don't think the SoC has the provision for
> > > >>> soc_id based on HW parameters.
> > > >>
> > > >> No, the soc_id is not provided by the bootloader, or at least I couldn't
> > > >> identify any related implementation. Instead, I provided this via the
> > > >> driver itself, since I've encountered this approach in some other soc
> > > >> drivers as well (e.g. imx/soc-imx.c, versatile/soc-integrator.c). 
> > > >>
> > > > 
> > > > Sorry, I was referring to serial_number. Since your comment says so, can
> > > > you point to the corresponding code?
> > > 
> > > Seconded that this needs to be better understood. If this is just a
> > > convention of some downstream U-Boot that's not implemented in mainline
> > > (and maybe not even for Guitar or Labrador? tested on RoseapplePi only),
> > > it might not be worth its own reserved-memory based kernel driver?
> > 
> > The serial number is actually provided by the s500-bootloader for which
> > Actions did not provide the source code, at least it is not available
> > in the xapp github repo. I did not find anything related to this in
> > downstream U-Boot.
> > 
> 
> Hmm, then we can consider this as the firmware dependent property. But
> can we get consensus that this is common for all S500 SoCs?

This should work on all S500 SoCs, as the downstream Linux kernel doesn't
use any conditional logic around reading those memory locations.
Please see "owl_check_revision()" in arch/arm/mach-owl/board-owl.c, from
any of the following repos:

* https://github.com/xapp-le/kernel
* https://github.com/LeMaker/linux-actions

> Maybe,
> Matheus can verify it on Labrador?

The verification is pretty straightforward: the serial number is dumped
on the serial console by the s500 bootloader right before starting
U-boot:

  load uboot: load address is 0x8000000, entry point is 0x8000040
  in fourth
  chip serial no = 9d,4b,f,6d,31,46,e,8,
  [...]
  U-Boot 2015.04 (Apr 23 2020 - 23:01:25)Actions-Semi

The socinfo driver should provide the equivalent information, but in
reversed order (due to integer representation on LE arch):

  $ cat /sys/devices/soc0/serial_number
  080e46316d0f4b9d

> I don't think adding a SOCINFO driver for a single board is a good idea.

The driver could be used for all Owl SoC variants, including S700 and
S900, even though accessing the serial number is currently supported
only on S500.

Unfortunately I do only have this S500 SoC based SBC to experiment with,
therefore I cannot enable new features for the hardware I'm not able to
validate.

Btw, do you know where I could get an S700 or S900 board from? I
couldn't find any so far..

Thanks,
Cristi

> Thanks,
> Mani
> 
> > Kind regards,
> > Cristi
> > 
> > > Implementing a standard interface such as DMI tables or a DT property in
> > > mainline U-Boot may be more useful then. Is it still Mani's S900 only?
> > > 
> > > Regards,
> > > Andreas
> > > 
> > > -- 
> > > SUSE Software Solutions Germany GmbH
> > > Maxfeldstr. 5, 90409 Nürnberg, Germany
> > > GF: Felix Imendörffer
> > > HRB 36809 (AG Nürnberg)
