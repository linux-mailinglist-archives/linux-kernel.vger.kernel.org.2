Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94CD83424BC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 19:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbhCSSeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 14:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhCSSdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 14:33:51 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F90C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 11:33:51 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id y6so11929489eds.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 11:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=bycvntijRgRiI3QRCBWQvQ/5YR890C79HV80RFlDCGQ=;
        b=CD3WTaRJsFjMaWegdKT53akuFfdXmj2PjTntawt6F8+gK88ZuyUb+q2Vw8xlDJUVcE
         pXyNBKpzOdBbXMVOaT4IVost7DVRT5nmq0mb+uFBnbzEcT0oIqfKKS08NLACAU8OQDXT
         u05eLGwLez6AfB9fTecKWF3kvhhfls7Jdfyx0vuipXRsyvkKG2g4bmvTHDKM6cAbOgkG
         uHxUYBiC4cxSpow5cqxX7dE+pzM79DfZD63UAuG9l9FlGpm86p7ipICQ7Oe1XgTmHg/V
         aangB9qWsmLMZTPEdWmKc+fUm4OF45XvzZb7NpfoExBUdZoxkEpysd4Zoso5LEmDqBgF
         GSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bycvntijRgRiI3QRCBWQvQ/5YR890C79HV80RFlDCGQ=;
        b=s1iq6tPlhiZt1DhB9a6somI1vNEkfuIGWGIiOFr7skMzvBIlWCKwch2kSmmGVFsSf1
         4MKUQP1BuoQPfwAT9Nchqh/NJQ9XiuouQZZHJ8/UaGdEhpunDRvSGE2cCoqpaWGpnU0V
         zUD5m+xCXTsoghtdptk+anYc2W7eHvs7JTdSj0lIz+Y71StruEEw+IJiAcx81L0ZkHdW
         7o+DdvbC3xaZFWSqvdF4TwPn79WaGs2t3ECRo2G1uNY9zr8MWO9UCBgVn3Y80XIkFuh8
         XkZ8GFGHv0dthUUMDAPTLWcZ/SuV0inHGV4xxwyHorqPqec4Zhd8PhBRYltNCLx4a0ul
         VuMA==
X-Gm-Message-State: AOAM531ulzXDBSHtLs2j23iVwbFy3m+HfwwXjmWA3ltYGKOgKrLKh2tl
        YV2Vbn5ZBFZ2x+yt+xwxm6c=
X-Google-Smtp-Source: ABdhPJykXREKU8oPa76vxImHGdD27uQ++kFDZq8/qylK9+cqWHHs06PxKm52/VKr7qIS2ewH1J1fXw==
X-Received: by 2002:a05:6402:17d6:: with SMTP id s22mr11137215edy.232.1616178829792;
        Fri, 19 Mar 2021 11:33:49 -0700 (PDT)
Received: from BV030612LT ([188.24.140.160])
        by smtp.gmail.com with ESMTPSA id j7sm4411033edv.40.2021.03.19.11.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 11:33:49 -0700 (PDT)
Date:   Fri, 19 Mar 2021 20:33:47 +0200
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH 1/1] ARM: owl: Add Actions Semi Owl S500 SoC machine
Message-ID: <20210319183347.GA1364151@BV030612LT>
References: <c560f4c188e39c4100e330ed4bc2d277c5ad6905.1615490186.git.cristian.ciocaltea@gmail.com>
 <47295735-2792-a517-b96a-a00a68496846@suse.de>
 <20210312092853.GA931435@BV030612LT>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210312092853.GA931435@BV030612LT>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 11:28:53AM +0200, Cristian Ciocaltea wrote:
> Hi Andreas,
> 
> On Fri, Mar 12, 2021 at 09:39:31AM +0100, Andreas Färber wrote:
> > Hi Cristian,
> > 
> > On 11.03.21 20:19, Cristian Ciocaltea wrote:
> > > Add machine entry for the S500 variant of the Actions Semi Owl SoCs
> > > family.
> > > 
> > > For the moment the only purpose is to provide the system serial
> > > information which will be used by the Owl Ethernet MAC driver to
> > > generate a stable MAC address.
> > 
> > Can't that be done in either a sys_soc driver or U-Boot?
> 
> I will look first at the sys_soc driver approach.

I have just submitted a socinfo driver:

https://lore.kernel.org/lkml/cover.1616178258.git.cristian.ciocaltea@gmail.com/

Thanks,
Cristi
