Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663A23A9AB3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 14:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbhFPMrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 08:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbhFPMrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 08:47:04 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416D6C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 05:44:57 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id q5so2565548wrm.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 05:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=KWFIDbO9gwXQ/mMB/0JJPgWhYELOyQcv+XcpVlj6SnY=;
        b=goq7sNHrXIp1FWN7CltEzC8KrHUIW8wRgdHvigPBiuDWVMIbVy4Mxsjh82x22cR6WQ
         5QNFjLdpdvZuN5NwYK1kXMO3EI/ylqld+wJlgZ+U7NQp8NdkM7d3JwyCojQttJLD7Ndw
         xEhE1vTqm1qxPTdzmCZdLa0I/ApPk+qon3aTIQerZnRrp+JH76wpS+/74EoaPm726C1U
         sIanRXyTf0Y61z5NJG3ew6xzI92fkR2eexwsi/ApWjvo04l/78ii8iV2uoC8i5ZuWLBj
         ATDnO6SkJhjq0NMzwAsjl6ApYR/5wJrT+BTOHEw9KqJ0yBKlPm+TRvigaiRHMcExAlgt
         gQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=KWFIDbO9gwXQ/mMB/0JJPgWhYELOyQcv+XcpVlj6SnY=;
        b=inohtxe9/BzVYTwmYbzUPapNUnBTzax/b8FRtIlxPxIAzhZNT0w9bMW4Kgs6a8pAQN
         RTd94+hRIl63ErNdy3HBUpOwmWaj5OcwMZtnuuBBD5YXdg8WfczI25rbCrwN9MUIKNRi
         M5o518FZGmaSa6BhmZgDPDasSyt6K7kGax8lN6vhv6jcqhkHYzNz7arpdq4yHjYOyZ3C
         FeeAxpzuEeT94nRBnBuIPzf3J0v7gtyg3WUbtRGiZh22pbbKXB7JMK91CKenj3jIE+UJ
         kGnWiq+g6E38RD9z4fgEz4wI9kVvsJ0/sxLhtOatSeBSwXgdfH2AGZR93h4TR4xWYf5Q
         XU/g==
X-Gm-Message-State: AOAM5329U2w19KQ6A1LB5MsdueX4ea2K581Pyl/VLnYssvBHZPjddau0
        GS2nKQFFBJovkGKNcxXPvDP/wgUjz9Wv1w==
X-Google-Smtp-Source: ABdhPJx2jU8OKnb1C4tfWT1YOBveCxNKS83MGFS5bK2YDlctw5LuIMUmZZeL2W84Y4MPgMYLCzKm2A==
X-Received: by 2002:a5d:6482:: with SMTP id o2mr5022830wri.79.1623847495571;
        Wed, 16 Jun 2021 05:44:55 -0700 (PDT)
Received: from dell ([91.110.221.170])
        by smtp.gmail.com with ESMTPSA id l16sm4727884wmq.28.2021.06.16.05.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 05:44:55 -0700 (PDT)
Date:   Wed, 16 Jun 2021 13:44:52 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        ALWAYS copy <linux-ide@vger.kernel.org>,
        Andre Hedrick <andre@linux-ide.org>, ATI Inc <hyu@ati.com>,
        benh@kernel.crashing.org, Jens Axboe <axboe@kernel.dk>,
        Mark Lord <mlord@pobox.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 00/11] Rid W=1 warnings from ATA
Message-ID: <YMnyRHxKKRebIIYI@dell>
References: <20210528090502.1799866-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210528090502.1799866-1-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 May 2021, Lee Jones wrote:

> This set is part of a larger effort attempting to clean-up W=1
> kernel builds, which are currently overwhelmingly riddled with
> niggly little warnings.
> 
> Lee Jones (11):
>   ata: include: libata: Move fields commonly over-written to separate
>     MACRO
>   ata: ahci: Ensure initialised fields are not overwritten in AHCI_SHT()
>   ata: sata_sil24: Do not over-write initialise fields in 'sil24_sht'
>   ata: sata_mv: Do not over-write initialise fields in 'mv6_sht'
>   ata: sata_nv: Do not over-write initialise fields in 'nv_adma_sht' and
>     'nv_swncq_sht'
>   ata: pata_atiixp: Avoid overwriting initialised field in 'atiixp_sht'
>   ata: pata_cs5520: Avoid overwriting initialised field in 'cs5520_sht'
>   ata: pata_cs5530: Avoid overwriting initialised field in 'cs5530_sht'
>   ata: pata_sc1200: sc1200_sht'Avoid overwriting initialised field in '
>   ata: pata_serverworks: Avoid overwriting initialised field in
>     'serverworks_osb4_sht
>   ata: pata_macio: Avoid overwriting initialised field in
>     'pata_macio_sht'
> 
>  drivers/ata/ahci.h             |  7 +++++--
>  drivers/ata/pata_atiixp.c      |  3 ++-
>  drivers/ata/pata_cs5520.c      |  3 ++-
>  drivers/ata/pata_cs5530.c      |  3 ++-
>  drivers/ata/pata_macio.c       |  5 ++++-
>  drivers/ata/pata_sc1200.c      |  3 ++-
>  drivers/ata/pata_serverworks.c |  3 ++-
>  drivers/ata/sata_mv.c          |  6 +++++-
>  drivers/ata/sata_nv.c          | 10 ++++++++--
>  drivers/ata/sata_sil24.c       |  5 ++++-
>  include/linux/libata.h         | 13 ++++++++-----
>  11 files changed, 44 insertions(+), 17 deletions(-)
> 
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Cc: ALWAYS copy <linux-ide@vger.kernel.org>
> Cc: Andre Hedrick <andre@linux-ide.org>
> Cc: ATI Inc <hyu@ati.com>
> Cc: benh@kernel.crashing.org
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: linux-ide@vger.kernel.org
> Cc: Mark Lord <mlord@pobox.com>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Tejun Heo <tj@kernel.org>

These have been on the list for just about 3 weeks now.

Is anyone planning on reviewing/merging these please?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
