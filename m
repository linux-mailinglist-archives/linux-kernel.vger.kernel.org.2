Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E53357CFE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 09:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhDHHI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 03:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhDHHIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 03:08:25 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B8CC061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 00:08:12 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id n2so1218586ejy.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 00:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hfAmus6TWiwBnXL5L3HgxGP1F8Ce1x0ODIQtTctWHkQ=;
        b=LO0orNJADVJWnxoDwKyAX/AqWnQ745rPWe5gcZ7NWt+SHnWaQjXLMtr0E1RbUsSiH9
         F1gke3V1iXASFuDUE0iPnGFhNCY/u+b5OSDFG1CjTCLKZURqlqvKUJuatpNqSuEwapie
         QGXQ+bJ7B2pXrIVtszK0ocaFg1wJxHyZ44n6fKuBUCVGj8hZPy6mMlaCrptVV1nf3GAP
         8e8E8Qs4MM6zwasCfKjQVnsv1XgumjXMYlkrP6GBav50PR+j2TFHmDXmj+PFQmADaniV
         v5deOYTuiYoZKzLNlWzF3RNaOKb0eGwWnJP5jMFQeFWZEQOcHYZZhV+JfeK0VlFSCdqR
         PSbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hfAmus6TWiwBnXL5L3HgxGP1F8Ce1x0ODIQtTctWHkQ=;
        b=Hf0apNOml9mHmgJEh2pX0ZYlyPFp9GwcIGqJuP+92EgldhXh6vOfhFBEk2op1/heu/
         Vf0NyN0Zzcn5SSHORY7nG8Xon9NAGKdZLFPLrBbs9N98koQJRN50HixMb0q7SGBhU0CO
         Qpf5XjcPJopCmBTCAMG3YqjXHDiYrpUHG6I7m3/+bvIDUociWoreFyOID5rStB/qpMQo
         gn0vzT9zxn7lMPo1D1/w0ODsZyRIuukDifPHGCIgpantnihYsRfFsZoD1AjkZfWuFA8D
         u7WDTNn3jK5irjO8N84uQGjolj5QCq76IiuIMJXT1iH1j+wf+uUUkYJmhj1sSUJHStDr
         p7Xw==
X-Gm-Message-State: AOAM533cG0bBMm0sgWf+VUpQC48jEYtyx+sqI1Qsaqd6kjABFKLZBpFc
        Uwtegu1WdMXZlzdL+EnCWngPSA==
X-Google-Smtp-Source: ABdhPJzeyF8iZV44XKA5itF4RZkDXlSu3aZjqgBSrDOC9fP7i5h6pitBJqoRYCY5PcBOgHzqDXj11A==
X-Received: by 2002:a17:906:64f:: with SMTP id t15mr5515645ejb.411.1617865691549;
        Thu, 08 Apr 2021 00:08:11 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id lk12sm13987421ejb.14.2021.04.08.00.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 00:08:10 -0700 (PDT)
Date:   Thu, 8 Apr 2021 08:08:09 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     min.li.xe@renesas.com
Cc:     derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/2] mfd: Add Renesas Synchronization
 Management Unit (SMU) support
Message-ID: <20210408070809.GD2961413@dell>
References: <1617846650-10058-1-git-send-email-min.li.xe@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1617846650-10058-1-git-send-email-min.li.xe@renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Apr 2021, min.li.xe@renesas.com wrote:

> From: Min Li <min.li.xe@renesas.com>
> 
> Add support for ClockMatrix(TM) and 82P33xxx families of timing
> and synchronization devices. The access interface can be either
> SPI or I2C. Currently, it will create 2 types of MFD devices,
> which are to be used by the corresponding rsmu character device
> driver and the PTP hardware clock driver, respectively.
> 
> Signed-off-by: Min Li <min.li.xe@renesas.com>
> ---

If this is v3, there should be a changelog here.

>  drivers/mfd/Kconfig              |  28 ++
>  drivers/mfd/Makefile             |   3 +
>  drivers/mfd/rsmu_i2c.c           | 349 +++++++++++++++++
>  drivers/mfd/rsmu_private.h       |  32 ++
>  drivers/mfd/rsmu_spi.c           | 376 ++++++++++++++++++
>  include/linux/mfd/idt82p33_reg.h | 116 ++++++
>  include/linux/mfd/idt8a340_reg.h | 817 +++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/rsmu.h         |  54 +++
>  8 files changed, 1775 insertions(+)
>  create mode 100644 drivers/mfd/rsmu_i2c.c
>  create mode 100644 drivers/mfd/rsmu_private.h
>  create mode 100644 drivers/mfd/rsmu_spi.c
>  create mode 100644 include/linux/mfd/idt82p33_reg.h
>  create mode 100644 include/linux/mfd/idt8a340_reg.h
>  create mode 100644 include/linux/mfd/rsmu.h

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
