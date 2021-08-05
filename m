Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE4AA3E155F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 15:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241595AbhHENJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 09:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241574AbhHENJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 09:09:18 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2AFC06179B
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 06:09:04 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id l11-20020a7bcf0b0000b0290253545c2997so3662164wmg.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 06:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=CQG8n1Vveh3PT6KDWBy7fP8k2PzMGv5ajm/RWHnLxd0=;
        b=uBg4z7MW6kEY8UOS0R2VwU9xCMMNAZZOfOS60SWPWPH9eBFQogfIHOdwMYy1RiRQC7
         pKPHxfvbpJmkJIuTn8WfrKA+zPNk6KH9Nt1qEF+JT+1359ZXCWpjbbcMf4fGjXZb2XFd
         ktLg81g8cZ647iRbrWqveZ0sGNwncNpjLbHNrDykAqcrHx+DrgsoMU77fWUCHrN8G7TH
         3VYgdU+8u5HyDj6rFv/BISrkxvT/sTa9WALoCfMex+xZVWFUfWiQI66TyiL2V3Lyv/QY
         8/pVfQS3LF8195SnY3y2px45QC35jUseqhrSW1vYVsOF26QjAyfV/dvM4ji5O40kEatc
         9YSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CQG8n1Vveh3PT6KDWBy7fP8k2PzMGv5ajm/RWHnLxd0=;
        b=AIAfSxpBHMRoh2F50hGPnoNvA9YKBQbVqhzmXG2rC4yo6oPNdzsvLq7ibupgpTxBMS
         Lxa9XipuyaSOqk82rRefX5Oare8ysJoIemdt5z/VQCoCUAf5J1e6fxBQYbTgBdisKMEj
         h/za+mVf+J92KWwyGMeLnRNaMUgDk29AZ00Zfpcm7T+ex53QA+wtBIZPGTQ5qwWpJLhN
         3lUXb9pBiIm1DS8p5kgwP4+VlYyt64GMu44CxjSJjIddHXTsNMY+Gmcdb/2sNldLXfCk
         WBMcsEf8BLpFYy9y86cJpUyXC/LO1Twg2DHHr3B0QAJsXie/td7fToPJDc/wJ7fqquIA
         63mg==
X-Gm-Message-State: AOAM531t63i9TwwDqxlI3XlSNTkPeuA6ilF73OUv10/kq/KydLAKEB53
        GGOCGjSCZXX/YUP2TVRbWbhPgQ==
X-Google-Smtp-Source: ABdhPJx6qy0GiIU70v6nqrqtZ/UFKEEr+z+Kbjcvx860eCnks0MM/tnuxpajFnZrCh2WO8ykYlWt8w==
X-Received: by 2002:a7b:c18f:: with SMTP id y15mr15193497wmi.117.1628168943127;
        Thu, 05 Aug 2021 06:09:03 -0700 (PDT)
Received: from google.com ([109.180.115.228])
        by smtp.gmail.com with ESMTPSA id c10sm9893098wml.44.2021.08.05.06.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 06:09:02 -0700 (PDT)
Date:   Thu, 5 Aug 2021 14:09:00 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxarm@huawei.com, mauro.chehab@huawei.com,
        Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: hisilicon,hi6421-spmi-pmic.yaml: make some
 rules stricter
Message-ID: <YQvi7DgVDhQl688S@google.com>
References: <b7a775808d9c3a87fbe1c5a6dd71f8f18be7e649.1627116034.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b7a775808d9c3a87fbe1c5a6dd71f8f18be7e649.1627116034.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Jul 2021, Mauro Carvalho Chehab wrote:

> Define maxItems for interrupts and accept only "ldo" in lower case.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
> Greg,
> 
> Please apply this patch on your staging tree. It addresses the remaining
> bits from Rob's review.
> 
> I'll submit the DTS patches via HiSilicon tree, c/c you and Rob.
> 
>  .../mfd/hisilicon,hi6421-spmi-pmic.yaml       | 21 ++++++++++---------
>  1 file changed, 11 insertions(+), 10 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
