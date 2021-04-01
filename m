Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 534BC35128C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbhDAJku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233527AbhDAJkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:40:46 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89E9C0613E6;
        Thu,  1 Apr 2021 02:40:45 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a7so1930748ejs.3;
        Thu, 01 Apr 2021 02:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fZmQYEP/6uDQvDVxt6cb6vxDGnrh+P52fxUkAoEa5gA=;
        b=hKPb3zzQUgcTpcda46PTiWKjDSRgecNDjjezIGnmdNnx5QKvZYeO7dLttj1qEpFKrI
         TU6QjzuAlATJDXpUvmCESIhYm8I1jt+DNaZceLnykSGmZ+u62trnCkJROoxtC5/QtrUm
         vEv6h6ac1n/5PTnx/lfwiHmCtV2RVkSqQLKEzyOhgU98xCyhOnjDluqOGJG2ZwFSMQPX
         ePtFowu6uH/FpqMyvX7tCR0xRiIXmCqomw/AcV1SRGSCqZMpyd3Cxmq54m7Hz4BEn8Rf
         RIr/iiG5uj/xFU1elx3S7eSezsUFSxROi4cEq1syeVb1dqRC7m61YcafQDrEtfXxs9uq
         8Uow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fZmQYEP/6uDQvDVxt6cb6vxDGnrh+P52fxUkAoEa5gA=;
        b=Ma9O3lVLtlHDnK3gvkNxHs1OtBMcNwp2kS2dHaBGb1vnuTBs6yUsNqBoxU4gegreFz
         x4SdtjCVBxTSb6CL2d7ov7Fg4Ig0NzvdjR5+czg8ouVXN0NZZkKWo5HhjB/fY0QCre2W
         qNn8TUdZGa3Z/m9g5Ehegf5zPxfcgswOCLE9ZrQDytSNAK4MmgS+FyCLMOf1Oakt2j10
         j6kQyxAgWOYYh0SIevgpBQ2yr8Arznoxeho39WUSugYtQZVD8yozDg8097sC5s7Uq7iy
         +C8sNNMBEmyzYGqeRWo5hn55E5Ireiuj9+TmKHba/9OqAWo5OqP40txTgrpNSLh1HP+U
         VCtA==
X-Gm-Message-State: AOAM5311Lae+rEO56EZGMSyA21fuUMOQwMgcs09yhSIY8JAHXW3bXSAf
        Mw2Qeba60NJnWhPbO7dm9BZVIcozCyM=
X-Google-Smtp-Source: ABdhPJwu/Ydwj7Y2X33MOvvJpAkNpoja+icLlUKmfRFSjO9Ewbe9R3XUf8mdIn/tuQuRwZMlKrO/GA==
X-Received: by 2002:a17:906:801:: with SMTP id e1mr7933219ejd.465.1617270044613;
        Thu, 01 Apr 2021 02:40:44 -0700 (PDT)
Received: from BV030612LT ([188.24.140.160])
        by smtp.gmail.com with ESMTPSA id jj15sm2525032ejc.99.2021.04.01.02.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 02:40:44 -0700 (PDT)
Date:   Thu, 1 Apr 2021 12:40:41 +0300
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Add support for Actions Semi Owl socinfo
Message-ID: <20210401094041.GA1993499@BV030612LT>
References: <cover.1617110420.git.cristian.ciocaltea@gmail.com>
 <20210401052438.GB14052@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401052438.GB14052@work>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mani,

On Thu, Apr 01, 2021 at 10:54:38AM +0530, Manivannan Sadhasivam wrote:
> On Tue, Mar 30, 2021 at 04:48:15PM +0300, Cristian Ciocaltea wrote:
> > This patchset adds a socinfo driver which provides information about
> > Actions Semi Owl SoCs to user space via sysfs: machine, family, soc_id,
> > serial_number.
> > 
> > Please note the serial number is currently available only for the S500
> > SoC variant.
> > 
> > This has been tested on the S500 SoC based RoseapplePi SBC.
> > 
> 
> Is this the soc_id provided by the vendor bootloader (uboot)? If so, under
> what basis it provides? I don't think the SoC has the provision for
> soc_id based on HW parameters.

No, the soc_id is not provided by the bootloader, or at least I couldn't
identify any related implementation. Instead, I provided this via the
driver itself, since I've encountered this approach in some other soc
drivers as well (e.g. imx/soc-imx.c, versatile/soc-integrator.c). 

Thanks,
Cristi

> Thanks,
> Mani
 
[...]
