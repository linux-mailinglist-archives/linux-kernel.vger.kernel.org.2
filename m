Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2F838911D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 16:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348154AbhESOh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 10:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354159AbhESOht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 10:37:49 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04009C061760
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 07:36:29 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id i17so14256187wrq.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 07:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=M5Mj/q68nMI7d0iAWTGDRrSYU2EvCS/GtIe5veoy1Rk=;
        b=CqUZh0vFLy04TzvZIQdQRMtVxE3f818YqPv7hYY/uGGe4rJq1ARHwx+oEBPI34pBRD
         uLyxxHxOCl42jZZ+Wwn1CQi3ibaYo9jFBmc8PY4VVR3MHauxgdTbzf2e9yL5aLEnbdfq
         2SHEX31z/+KqSiBskVKrczSUHU5UveK8YaOCOO5OLy4RZ+ONMCVXGgh/EncittmhjKAQ
         eWDAD7dHD9gCtvZWHvQcc+qqGceRLkRh3AwiCVbIReV3sOWZsvT10GkVJp/d8zCVdmPC
         ohkj0+a7dQMjeupWcwX5sslJuKagcw7UixkCk4MEB4FFEx+R7Z9oHEGm/0F6DLbblPv0
         njAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=M5Mj/q68nMI7d0iAWTGDRrSYU2EvCS/GtIe5veoy1Rk=;
        b=OqibW+k4wBn78wwjUcJAkIVtVISam0z24/afqBrei/de3vCwxcMuq0fGR+1bq3NA1E
         ubb6rh6vkEg++MkwD8I5MKEKteBEQ8M4M8ac5dSkGirfaya422LadWPsWGwJeDnVeu21
         zuyRKVeFEppowObUFE02JINqnBzwknyP4QptmsEl0K2ywus3Y0KsnYcijeH/u9tZoV+K
         meAO3/1dJvVAARdKT/W5orBr/0HaFH5KTxTt8OoTMbtY7zjVvCa2lqoVw4uXg5xc0ziy
         Gdl6J4MNZQ4nQVPD3GOA69kp8cHpqR8mjsxRb88skRYdXMCrDQYCLmjp54ihIpINE+38
         RbOg==
X-Gm-Message-State: AOAM533CuwKTcgIbyqHdMrMfnPPfErwJNG10N8xys7QuzqdC5aNUVI+w
        RW/h7uMZYSobbKexKHnTuBH+nQ==
X-Google-Smtp-Source: ABdhPJwFP4BxWJmo+xGubLR3tjiuliRMSY7leYjq7klIyaRXnQMl3XapwDvv/dPn/diA1Hq0V2T5+A==
X-Received: by 2002:a5d:6c61:: with SMTP id r1mr9096664wrz.309.1621434987666;
        Wed, 19 May 2021 07:36:27 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id y14sm26329317wrr.82.2021.05.19.07.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 07:36:27 -0700 (PDT)
Date:   Wed, 19 May 2021 15:36:25 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: max8907: move to use request_irq by IRQF_NO_AUTOEN
 flag
Message-ID: <20210519143625.GF2415519@dell>
References: <1620909145-21744-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1620909145-21744-1-git-send-email-tiantao6@hisilicon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 May 2021, Tian Tao wrote:

> This change is just to simplify the code, no actual functional changes.
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
>  drivers/mfd/max8907.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
