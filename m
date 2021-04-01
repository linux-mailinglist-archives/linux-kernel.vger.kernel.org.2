Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28218351405
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 12:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbhDAK6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 06:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233744AbhDAK6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 06:58:10 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD104C0613E6;
        Thu,  1 Apr 2021 03:58:09 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id e14so2202915ejz.11;
        Thu, 01 Apr 2021 03:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=B/H4PVsHcd0yRRzaDgLhkxe1doZE87KfKxYYYpPPtY0=;
        b=BJqXu8Du3ysJ9hXdn+JT7Jt3nKsoYB7ltmKdCRGysQgvwwVr0JAw5CSKOtwTuC0mtW
         jsanmbTcVp9P3OT7OtEJOO4mLEpS+DT6/8mnhde0nGn+aya6EzhVbq4IN9itXIwIcfAh
         daNfrzrg/jQ9Xu0e+4/3uWSwJa8cu7Bn7gVTYKktG9om+VDuLVmWZNBmtoJmQr1eKmMw
         /wJRte2d6POBGKjpq37jclevckJXL9FNkERZA8jZQUkXcpT2Zl8R0p3gITeXT2ngnPNG
         yjJtjq09jjFD09bo/3MOZNKnxc1iN3g+oY8yUhBx4P7IpSJdacMYcajLu7lj1I4TQGzs
         Cm3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=B/H4PVsHcd0yRRzaDgLhkxe1doZE87KfKxYYYpPPtY0=;
        b=a6zntK0ylqnKKb8kMxbdjdgE0mzusncl+Fa7Ikq5crmGwujyK02p9ya2F+Su71xhEp
         igtZGLDDjFaf2KOutoNrZrlR0QkB9I8eA/CxpbZuJbY4gOVPItfL6cKP7e5osYNwP34D
         CFNOiEJcv4JzQsI27YBGdshkrQQ/kgVqnya7l2Rna0PYMfmw+JBETqiYpgGGq3HyiFOt
         gEDTCq826yah6EJ5QlnWjcVGextq/zySaVHjF0xw9rw//x0b0EonocCQZO/sUBrgGM0P
         C7HZu68TeS9eyaodDil4g4mYCfEaWwC++L3ugvngGGjmSYLeIG9Wr3wRkUHr79AxWx2j
         BViA==
X-Gm-Message-State: AOAM530EkzUgQpsJ1ZsRnYRQTKKE7rfiTb5VU4dEdQie1rL8mvEB1zbL
        XoxlcIr8XBYpzOHUyKNcrAu69HSWanc=
X-Google-Smtp-Source: ABdhPJwEhWMeZi8yeGpZ3tBAsX7Ch/lleGPJpoYfGuUBtBxT2Dw/LnqSKfHLNbmGJhaebb/jKSA4+g==
X-Received: by 2002:a17:906:f891:: with SMTP id lg17mr8494127ejb.69.1617274688696;
        Thu, 01 Apr 2021 03:58:08 -0700 (PDT)
Received: from BV030612LT ([188.24.140.160])
        by smtp.gmail.com with ESMTPSA id c17sm3797493edw.32.2021.04.01.03.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 03:58:08 -0700 (PDT)
Date:   Thu, 1 Apr 2021 13:58:05 +0300
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Add support for Actions Semi Owl socinfo
Message-ID: <20210401105805.GA1998829@BV030612LT>
References: <cover.1617110420.git.cristian.ciocaltea@gmail.com>
 <20210401052438.GB14052@work>
 <20210401094041.GA1993499@BV030612LT>
 <20210401102717.GF14052@work>
 <252dd954-c8f1-fa2a-c37a-ede386fc9d43@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <252dd954-c8f1-fa2a-c37a-ede386fc9d43@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mani, Andreas,

On Thu, Apr 01, 2021 at 12:49:37PM +0200, Andreas F�rber wrote:
> Hi,
> 
> On 01.04.21 12:27, Manivannan Sadhasivam wrote:
> > On Thu, Apr 01, 2021 at 12:40:41PM +0300, Cristian Ciocaltea wrote:
> >> On Thu, Apr 01, 2021 at 10:54:38AM +0530, Manivannan Sadhasivam wrote:
> >>> On Tue, Mar 30, 2021 at 04:48:15PM +0300, Cristian Ciocaltea wrote:
> >>>> This patchset adds a socinfo driver which provides information about
> >>>> Actions Semi Owl SoCs to user space via sysfs: machine, family, soc_id,
> >>>> serial_number.
> >>>>
> >>>> Please note the serial number is currently available only for the S500
> >>>> SoC variant.
> >>>>
> >>>> This has been tested on the S500 SoC based RoseapplePi SBC.
> >>>>
> >>>
> >>> Is this the soc_id provided by the vendor bootloader (uboot)? If so, under
> >>> what basis it provides? I don't think the SoC has the provision for
> >>> soc_id based on HW parameters.
> >>
> >> No, the soc_id is not provided by the bootloader, or at least I couldn't
> >> identify any related implementation. Instead, I provided this via the
> >> driver itself, since I've encountered this approach in some other soc
> >> drivers as well (e.g. imx/soc-imx.c, versatile/soc-integrator.c). 
> >>
> > 
> > Sorry, I was referring to serial_number. Since your comment says so, can
> > you point to the corresponding code?
> 
> Seconded that this needs to be better understood. If this is just a
> convention of some downstream U-Boot that's not implemented in mainline
> (and maybe not even for Guitar or Labrador? tested on RoseapplePi only),
> it might not be worth its own reserved-memory based kernel driver?

The serial number is actually provided by the s500-bootloader for which
Actions did not provide the source code, at least it is not available
in the xapp github repo. I did not find anything related to this in
downstream U-Boot.

Kind regards,
Cristi

> Implementing a standard interface such as DMI tables or a DT property in
> mainline U-Boot may be more useful then. Is it still Mani's S900 only?
> 
> Regards,
> Andreas
> 
> -- 
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 N�rnberg, Germany
> GF: Felix Imend�rffer
> HRB 36809 (AG N�rnberg)
