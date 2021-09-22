Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3E9414A60
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 15:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbhIVNU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 09:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbhIVNUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 09:20:25 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6099C061756
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 06:18:54 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q26so6701342wrc.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 06:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LcVJLt934n5u6sb3CzNd7M99xvjn2wNjEhplbhBzduo=;
        b=J33QZszTxAj3AA4kso/CTXKndJpFdYkcF0Iw2gnOEJJd6M4Jg7SyYNo8Ids0fI8Jml
         DvfDQv/+FLtexBHBdV9G78+UBGpP9LcO/uEMVP8lK6uBxsC6UQTy5Kcas+NCDYTLk+fL
         Q0hUTFe8gCN1Moe+rMWyn9viHEJwaco3q5SmpMPAtubK3zgYZFnNIOhu4apN8Yk5Y0AT
         sCDdgpBKLC5CQIjR8eJX/ykC+mfkiq0qMFK2OIflXyo+eqIQZVxzsZF+1alOPBysVv/w
         jaV2EUD0Fic9wzU0AjzgUYjhXoqzQ7+2h9wpjl6vqvmgkO62IZmSJ9C1/HNefdQQ8hHA
         yDew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LcVJLt934n5u6sb3CzNd7M99xvjn2wNjEhplbhBzduo=;
        b=rA2UchXYJXnvX8jq2gM3zMM2tO/l5oY352NZRXXX3Zl7e45S4aKaEBcfbWS/dh4VlP
         iJzceqgl5u9/f2HiwWNyohJ8S1P1FzhtyncP5I5XXntTKrJed/1tjC30R0q7OnotouEy
         pDDmtBtEQwZlW3flOFzNf29eGb8WvYlhOGSQ2dmiqubxvhEKaIT/nzcGJ/BAn4rtEEWO
         YZz2Z4BNSHczxb8U5HdP5MsThOsqiBhTYtZlVQ85T500VXnGCXNTRh3SkJP/DlfBF3ee
         Pr6SXfkAF4yxlCHNv++KWxizwlfGR5NtdoWVb1lQbhfvp5K3AR43gTXgjepLnyvfZHwc
         1lZg==
X-Gm-Message-State: AOAM5316ZkLrPGl3yxFkmdiihyvNSBAolEf1GjsT4Yl6F+IdF4FZuQnT
        tGOQKRfRZPO8ygCfp1cnbYn9CQ==
X-Google-Smtp-Source: ABdhPJy5HIqGviidfA335pge7DjJTH5zScPJPflYWOVPTSVLTD0MjDccDQyOeiaj4qqolHDCljm+Ng==
X-Received: by 2002:a05:6000:c3:: with SMTP id q3mr41385246wrx.361.1632316733467;
        Wed, 22 Sep 2021 06:18:53 -0700 (PDT)
Received: from google.com ([95.148.6.233])
        by smtp.gmail.com with ESMTPSA id q10sm2006509wmq.12.2021.09.22.06.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 06:18:52 -0700 (PDT)
Date:   Wed, 22 Sep 2021 14:18:51 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        "David E . Box" <david.e.box@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] mfd: intel_pmt: Only compile on x86
Message-ID: <YUstO2C11qigkUnu@google.com>
References: <20210825125735.621799-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210825125735.621799-1-prarit@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Aug 2021, Prarit Bhargava wrote:

> The intel_pmt driver shows up as a compile option for all arches but is
> 32-bit and 64-bit x86 specific.
> 
> Add a CONFIG dependency on X86 for intel_pmt.
> 
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: David E. Box <david.e.box@linux.intel.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/mfd/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
