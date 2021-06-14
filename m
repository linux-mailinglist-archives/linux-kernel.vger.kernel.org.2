Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84DC3A664E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 14:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbhFNMPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 08:15:09 -0400
Received: from mail-ej1-f47.google.com ([209.85.218.47]:34752 "EHLO
        mail-ej1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbhFNMPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 08:15:07 -0400
Received: by mail-ej1-f47.google.com with SMTP id g8so16323077ejx.1;
        Mon, 14 Jun 2021 05:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QLUxngfo3tVRsn8lxTbb2M+pKAJYV8dDKHPOOPKoTaQ=;
        b=Bj60gfN//81FbKFsw8vmSYFyf9l4j9EcZ0FHlmCCiJcTgaPTWPvMz3ngEb9cFeox2L
         J83g7X5gNn3rMiZorcToT8ihZhR+lKo5lAd4MFbFK9oidU39PP++s1KJSFjYh+W0KFYM
         vzQhA2si4N0QYZYCurTZQwmm62tpOiJciqqQdyWcTprMZB9bEgalOVS4DhGUi9WIWxVg
         JPySx84ag9rRTknbLwUECGucgre11bGerEFYkvHuBSMftO+UnGBuzZBd60mZVBX7COMW
         VD1v7uyuqhxwYz58bE8GJKcENz3JsTvSJGQ9guFMp6e8tjylv3ZSCu6vONo+BxS04h1X
         yqeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QLUxngfo3tVRsn8lxTbb2M+pKAJYV8dDKHPOOPKoTaQ=;
        b=q+4PiH6EVKSWoTL2MAWKIL/OtfDTsTGQ+J1c8z0TU45i8ksLZFqngy2ShtH80NcMGL
         kgf8mqTTyUEVM0JSf4IozyVrpg2FcUWUUaQg37pSZg+Acs7y92mDgXBjgcuHk6zSq8BT
         4oAN4aTGld4++vGEuZwU0HOmEogzsgtZMRQ9iOKGdZqc2OzOSS9jUaMdvzEij3gBSUc8
         2uHbkH/T5ntxxuemjhj+tOzGKCgCpVlQLiOcu35QI2aobDTZawrO42WS8e06esSI28bz
         SQxmr/ryYh5MKQMi39dUUkcM78MuaSa9AN9VyzzfJRDVCYtTUxM4dp1OgCwO5tIE+hW1
         1SLg==
X-Gm-Message-State: AOAM533n4ggDpq/3YJtqvaL0xP+1QXK3zH6wYpatetdMQT34JkEN9b8P
        6G3FDsNwPdgEykHL7g1lL7k=
X-Google-Smtp-Source: ABdhPJy07Ww7kdGvvKtp/A8GhghbKQudQ2gRCkoXtVyIPHcVKEBxj97capoDt0Od0XC0i+mtJmK6XA==
X-Received: by 2002:a17:906:3b99:: with SMTP id u25mr15017293ejf.539.1623672710305;
        Mon, 14 Jun 2021 05:11:50 -0700 (PDT)
Received: from BV030612LT ([188.24.178.25])
        by smtp.gmail.com with ESMTPSA id o26sm8687476edi.15.2021.06.14.05.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 05:11:49 -0700 (PDT)
Date:   Mon, 14 Jun 2021 15:11:47 +0300
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Add Ethernet DTS for Actions Semi Owl S500 SoCs
Message-ID: <20210614121147.GA1876517@BV030612LT>
References: <cover.1623401998.git.cristian.ciocaltea@gmail.com>
 <20210614112831.GB38584@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614112831.GB38584@thinkpad>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 04:58:31PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Jun 11, 2021 at 12:11:31PM +0300, Cristian Ciocaltea wrote:
> > This patchset adds the required DTS changes for providing the ethernet
> > functionality on the Actions S500 SoCs family.
> > 
> > For the moment I have been able to test the Ethernet MAC on the RoseaplePi
> > SBC only.
> > 
> > Also, please note the patches depend on some clock changes that are
> > currently under review:
> > https://lore.kernel.org/lkml/cover.1623354574.git.cristian.ciocaltea@gmail.com/
> > 
> 
> Waiting for the clk patches to be merged...

Thanks, Mani!

Hopefully Stephen is going to pick them up in time..

Kind regards,
Cristi

> Thanks,
> Mani
> 
> > Thanks,
> > Cristi
> > 
> > Changes in v2:
> > - Added Reviewed-by tag from Mani in patch 1/2
> > - Joined the groups sharing common function "eth_rmii" and switch the
> >   order of "ref_clk-pinconf" and "phy_clk-pinmux", per Mani's review,
> >   in patch 2/2
> > 
> > Cristian Ciocaltea (2):
> >   ARM: dts: owl-s500: Add ethernet support
> >   ARM: dts: owl-s500-roseapplepi: Add ethernet support
> > 
> >  arch/arm/boot/dts/owl-s500-roseapplepi.dts | 45 ++++++++++++++++++++++
> >  arch/arm/boot/dts/owl-s500.dtsi            | 10 +++++
> >  2 files changed, 55 insertions(+)
> > 
> > -- 
> > 2.32.0
> > 
