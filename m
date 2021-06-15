Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE5E73A7DF4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 14:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhFOMRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 08:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhFOMRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 08:17:05 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8D7C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 05:15:01 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id y7so18066877wrh.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 05:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Rdzz7xWojrMyCCGqCmZSALbWRDi1+euSRVbevdeJrug=;
        b=BtWz9PQGfG1cHcv296o6tSKeKGQhMiBVxR9pzuSHZSQPJi8s371/BhLlyretX45TDT
         M53OsqnnQLafG5CburdDdK4A0yEstkDd7s+Cw9waHcJEVMOzDeDLo7tkIqTTPnAkSpN2
         5QecazyvevtXtLHi8R+3Vt4bAVzjWUQAAabsLgQIz8D97L6vdWGYPhYeREdMUGkhcFAT
         rqVOb0n3N4i9c+qE9X9IJ1PvjkBMTOUJA7HBgQvLmNbSd3TIcC4Gew+AZYINejJ3owqK
         JVRT5eZjA9EC6pUoGmZJKyam/RqSTfJm1oVNjLhWsvh7fhJ1ZdgFXlkf8lhQ/R9Jdzmu
         OTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Rdzz7xWojrMyCCGqCmZSALbWRDi1+euSRVbevdeJrug=;
        b=m7LXdpiRdHXpY5aL5hKy/iHz3X86fSsw4A+Yj+2NopRoC02M52B8+B3kyr61wBZpgG
         gMCmSy1jSPg1vg/TFItEJm9rAnBF/YzRmvCDtW6nyNA4q4OW+cuGl5bwn2WtOJXU5ITG
         cLBLBCKpiO+jGp5yk3uTqlbbOkeyZIfHeaXb4NUGd05c7SiG/E0iT4Vsx4SV2fHruxAm
         UwqQn2ah9duROte2+kYJp7HaA/aMIMSZ/Pcl/W5cQeEUZU9oxC0ZtPF538LrSK2QjCmK
         jLehPLaYormh//AOcUIU5DCVPxzzSvRBsj4I3w1XpXEWNxEDj+ZJO4BC84trFdIZDuTW
         +Y5w==
X-Gm-Message-State: AOAM531IfXOqb53ptC2dpxkzkEmyWKXF6UEFYuwDJslag5fUxNNh1XSy
        1GjRxwsGrQvFv1fVPFE9U9J1jg==
X-Google-Smtp-Source: ABdhPJw3XE4RRcZB4ihC2po9za96z8DS0ndf/vWs/3rdbTd7OXQw8ontq00/0venPspI/SUaQTZ++w==
X-Received: by 2002:adf:f382:: with SMTP id m2mr24961383wro.394.1623759299714;
        Tue, 15 Jun 2021 05:14:59 -0700 (PDT)
Received: from dell ([91.110.221.170])
        by smtp.gmail.com with ESMTPSA id k12sm2109748wmr.2.2021.06.15.05.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 05:14:59 -0700 (PDT)
Date:   Tue, 15 Jun 2021 13:14:57 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     patches <patches@opensource.cirrus.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 8/9] mfd: intel_soc_pmic_bxtwc: use DEVICE_ATTR_ADMIN_RW
 macro
Message-ID: <YMiZwa39q4f5qXto@dell>
References: <20210602114339.11223-1-thunder.leizhen@huawei.com>
 <20210602114339.11223-9-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210602114339.11223-9-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Jun 2021, Zhen Lei wrote:

> Use DEVICE_ATTR_ADMIN_RW macro helper instead of plain DEVICE_ATTR, which
> makes the code a bit shorter and easier to read.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/mfd/intel_soc_pmic_bxtwc.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
