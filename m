Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 469F63D04E6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 00:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbhGTWPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 18:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbhGTWOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 18:14:09 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90F3C061574
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 15:54:46 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n4so266938wms.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 15:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Kvm5iVMKs6Bc2xOWkXNZgQqGwr6UQKNKEeig/K8uEgw=;
        b=xyzo7Nwb74nTk+5QTy7d05iXOf2j8sLack4BbGqzmJUifpUzzqktCFm/eH4T3jZ0aN
         u9Jok6QBVmS5mEToLV5sOt0onwWOe6cEAdUkWWJUn3IXG9jfNOxpAmRK+raEqiTEwsWz
         zqdRF0gXhdvJz9cHJibYjFe0IfGX4g+xgvN2hQ8LWQSUW4eOcuF7K8JF0OplkshXbuWe
         VQ1GApo38ReDauqETDoWtm7MKgYhf6zRG0RM7pij0n6sTo5sleDYPmSWbJGIBo9SUTGw
         Mj8z6Lx7OLJBzwOws4oNXFWaf4/odRNtumXmYo40Jpw0NF93Oq7X0T6oukCSfXB8M43W
         aEmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kvm5iVMKs6Bc2xOWkXNZgQqGwr6UQKNKEeig/K8uEgw=;
        b=QHSKpgZwGK4ynVCi4QQDQDQquhnHy5hTRsvNm0b/JtiAWQtdouUcmbIkPlN0B3BQeO
         GgKqGiD5m12TgR7tIAKUA7jLyxfomiCEiiQdqRaFe2hGVQrMwgHYWTChMSisxq1rhX9D
         4zBh3JHIOvdbP1h5IuQLBLEZQFUqWGAb2fEu2+V0hoeMEQEagvMtrngQ81cxWjr1BHsJ
         eO+rC3t32YHI/HzGzL89mojL4+UJ84eklTO5fhAjGRqGPlabSl9v7nbr6c+iZSwJM5JU
         1yAZKTbWKf+gVt5l33Uz9U8b+LtUFQ3GTvx1Vq3GRtHAORWyU0edOVfk1F+Sn9S7UMDP
         dwFA==
X-Gm-Message-State: AOAM531KnYkJp4QOOop8O8KrLgUYHx/dv+grlBiEr2v2QGmCEZDfYF6U
        Fuj4HGwLZtqZbAu2pil4IbT0mQ==
X-Google-Smtp-Source: ABdhPJzjmpzw0e57pvM62s7qo/bPi1F2Ch1wlcjH1kb1puw7t0JOjQh8JxkNkQ1AaUalsP7TE7JLOA==
X-Received: by 2002:a05:600c:190a:: with SMTP id j10mr762019wmq.109.1626821685417;
        Tue, 20 Jul 2021 15:54:45 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id b16sm25198803wrw.46.2021.07.20.15.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 15:54:44 -0700 (PDT)
Date:   Tue, 20 Jul 2021 23:54:43 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     gregkh@linuxfoundation.org, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Larry.Finger@lwfinger.net
Subject: Re: [PATCH resend] staging: rtl8188eu: move all source files from
 core subdirectory
Message-ID: <YPdUM2Gi+tPKoJII@equinox>
References: <20210719224601.255364-1-phil@philpotter.co.uk>
 <7bc43fb0-2dab-190b-c480-9e77cff863d4@lwfinger.net>
 <20210720090035.GB1406@agape.jhs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720090035.GB1406@agape.jhs>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2021 at 11:00:36AM +0200, Fabio Aiuto wrote:
> Hi all,
> 
> On Mon, Jul 19, 2021 at 06:46:16PM -0500, Larry Finger wrote:
> > On 7/19/21 5:46 PM, Phillip Potter wrote:
> > > Move all C source files from the core subdirectory to the root
> > > folder of the driver, and adjust Makefile accordingly. The ultmate
> > > goal is to remove hal layer and fold its functionalty into the main
> > > sources. At this point, the distinction between hal and core will be
> > > meaningless, so this is the first step towards simplifying the file
> > > layout.
> > > 
> > > Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> > > ---
> > >   drivers/staging/rtl8188eu/Makefile            | 34 +++++++++----------
> > >   drivers/staging/rtl8188eu/{core => }/rtw_ap.c |  0
> > >   .../staging/rtl8188eu/{core => }/rtw_cmd.c    |  0
> > >   .../staging/rtl8188eu/{core => }/rtw_efuse.c  |  0
> > >   .../rtl8188eu/{core => }/rtw_ieee80211.c      |  0
> > >   .../rtl8188eu/{core => }/rtw_ioctl_set.c      |  0
> > >   .../staging/rtl8188eu/{core => }/rtw_iol.c    |  0
>  > 
> > 
> > I think this is just source churning. The current setup with include. core.
> > hal and os_dep subdirectories are not opressive.
> > 
> > Larry
> > 
> > 
> 
> maybe the information we will need one day is:
> 
> will the core/-os_dep/-hal/-include/-directory-structure be
> welcomed in mainline wireless subsystem, when an rtl* driver
> will be perfectly tuned?
> 
> At the moment I can't see such a directory organization
> in any of the realtek wireless driver.
> 
> Sure there's time for that ;),
> 
> Thank you,
> 
> fabio
> 
> 
Dear Fabio,

Certainly a good start is removing this 'hal' layer so for now I'll
focus on that as much as I can. Perhaps the path forwards will become
clearer without it there :-) Thank you for your feedback.

Regards,
Phil
