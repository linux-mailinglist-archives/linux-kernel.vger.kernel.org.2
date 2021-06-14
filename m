Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 093EC3A695D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 16:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbhFNOyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 10:54:46 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:43653 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbhFNOyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 10:54:45 -0400
Received: by mail-ed1-f47.google.com with SMTP id s6so46866580edu.10;
        Mon, 14 Jun 2021 07:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iPS/AZ5OVoA17Ep2xDFclnfOIRqkv3Pi1b98SldC/nc=;
        b=Pgr6MjSK54xlCpS0V58dbIdvJLsSQi+8s+UK24Rah/l48O4cX4Xahlo3bWMXZBgDFW
         ht3GbcZ3Oetq6O8MnXEUdgUHLQY3QbVWEVRMh+R4Q+iFa2fwSUU+svZj8FWg8S7HUPU4
         o5T+RHhw3q7PYNBcxVHW5WOr1dL7G/OsXLNZZbII42h9k190QI2uY2TaHxWLAbINBaGX
         uRcdk0bTyrXcY171uA5q98Pn5S1w5Fn59SiUrY8x8Pzrd7+gUX3MCt0NXhDyxy08lJFa
         QW/k92iWisJVfaKnoY9SkCE0+Q7B6pkMfI/gzhpGSPMQ4oggD5xRJziEgsU+vnVqAC2B
         o0tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iPS/AZ5OVoA17Ep2xDFclnfOIRqkv3Pi1b98SldC/nc=;
        b=cZWSmIQUQvIycB4T1XZB8M/PqThVz2424iFiBja+Vz4Yy200D4SsFPapkaGkjD5QiI
         anZFmqfs848khbMTiJHdILcxlz15HWXOQw3oEopp01AxRiSDmijcShni5uOynhoM7adm
         ZgTcBSbHRDKbLxxhH+BkDUmImuQ0pj1XPaRsUUJCIU/o4jD1sPFXyxhvRQvNcVjyKYRe
         wtvFAX1cfYYRM/dvsBPXw5hPvuHPvS+w7BTZH8dfitZwXQO3A7nYGH59miKpqGy3D8Vn
         gUmAsbpQJT+RTlxRmH0FzGstD0+UijowPjKdPt+5OVDMbomVtlDnqQkmSgTbs2PIe8GI
         8Syw==
X-Gm-Message-State: AOAM533HY6TQ5rJ/UKju4w10ZfNUdxplrKBpZ8WAtnJ89nlreMvv/+YW
        yMMS+z12tBGTzXZ4+apUoeI=
X-Google-Smtp-Source: ABdhPJwfKM0u0TkINVJk4m3DvxL3a5aUgoF3SVA1nBk1jtYk2IQ9CWeZo4M/BYdRIYOu6BpxLVM2kQ==
X-Received: by 2002:a05:6402:35d1:: with SMTP id z17mr17701920edc.159.1623682291063;
        Mon, 14 Jun 2021 07:51:31 -0700 (PDT)
Received: from skbuf ([188.26.224.68])
        by smtp.gmail.com with ESMTPSA id q5sm4929313ejc.117.2021.06.14.07.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 07:51:30 -0700 (PDT)
Date:   Mon, 14 Jun 2021 17:51:29 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     devicetree@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH] arm64: dts: fix node name for the sysclk
Message-ID: <20210614145129.63v2tau6ly6wtqbm@skbuf>
References: <20210608112658.4087235-1-olteanv@gmail.com>
 <20210612075346.GZ29138@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210612075346.GZ29138@dragon>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Shawn,

On Sat, Jun 12, 2021 at 03:53:47PM +0800, Shawn Guo wrote:
> On Tue, Jun 08, 2021 at 02:26:58PM +0300, Vladimir Oltean wrote:
> > From: Vladimir Oltean <vladimir.oltean@nxp.com>
> >
> > U-Boot attempts to fix up the "clock-frequency" property of the "/sysclk" node:
> > https://elixir.bootlin.com/u-boot/v2021.04/source/arch/arm/cpu/armv8/fsl-layerscape/fdt.c#L512
> >
> > but fails to do so:
> >
> >   ## Booting kernel from Legacy Image at a1000000 ...
> >      Image Name:
> >      Created:      2021-06-08  10:31:38 UTC
> >      Image Type:   AArch64 Linux Kernel Image (gzip compressed)
> >      Data Size:    15431370 Bytes = 14.7 MiB
> >      Load Address: 80080000
> >      Entry Point:  80080000
> >      Verifying Checksum ... OK
> >   ## Flattened Device Tree blob at a0000000
> >      Booting using the fdt blob at 0xa0000000
> >      Uncompressing Kernel Image
> >      Loading Device Tree to 00000000fbb19000, end 00000000fbb22717 ... OK
> >   Unable to update property /sysclk:clock-frequency, err=FDT_ERR_NOTFOUND
> >
> >   Starting kernel ...
> >
> > All Layerscape SoCs except LS1028A use "sysclk" as the node name, and
> > not "clock-sysclk". So change the node name of LS1028A accordingly.
>
> Wouldn't it more flexible to use alias/label for finding the node?
> Using node name/path looks fragile.

Thank you for the advice, I will keep it in mind next time when I design
my own bootloader device tree fixup scheme. However, in this case I did
not create it, and implementing your suggestion to find the sysclk node
through /aliases would require changes not only to the bootloader, but
to the Linux device tree still (and if we're modifying the Linux DT, why
not just go with this patch). So yes, the existing mechanism is more
fragile, but I am not sure if we gain anything by artificially creating
an additional dependency in the process.
