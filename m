Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437D14008D8
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 03:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350672AbhIDAsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 20:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236127AbhIDAsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 20:48:10 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCBBC061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 17:47:09 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id j16so793706pfc.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 17:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Er1Ccxu+Rnkt9kGZBKmyF7wALF5P+Lrrm4DOKExBARU=;
        b=Cd1RlXZUSQOaIVqkGxNYzfWVfCBeK6oO2NQc3IpES1NYmj6+iJUMGjEEJkAjzUjtOJ
         ipYgYmu/4NjK3Pt6ZVdn5JnMdXpqEJsNYCETuczxJxmSFYC5UQz3HMcbRj1Qrt97vTJd
         VgQk1hNxHxxeGsiS/LhQStlzbgi0dVCZ1fxsbveUa62XGsyS+jES1+mXN9CJXWGwunmv
         RhaA89ZEw++F1nvFkc/Fpju+ZdncZYwSMhtMhHPfDxgXbDAzm6+irpXBlEN6DIB4MSxS
         jFhTYXilRwkSAhElaGcOXK3WM/cG17cl6RbY8sTA6lDlwmK476G1LNSqREHN+xh00sI2
         Gicw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Er1Ccxu+Rnkt9kGZBKmyF7wALF5P+Lrrm4DOKExBARU=;
        b=Ag0Rt0USEwU/2wtbdHJdfOA+7g8/8H374IUS/3ajZ2l59cOyvUWrX74rmsyxLJVQj5
         TKrFtEdO6bwwExAdqhIAIEE1e6YEho9JeNJ/nlpDTXp1o5LsHRTiYNMuX0jMgNWrpYjG
         JDGxlnNfPOlNB3Nftl6Kxsri/QS/dKzsYX/FbNjC7iAzqV+AqE0VmzVzIvKz3rFLR7/Q
         LY5UQ2A2RniwdeB8+Ar+bqsEEPx/QPNr0Ry57/jA0TSR/Ayw3z2otqymj4fOc9MmcHAr
         Y5QDq+9tAgEUX+7i7eK7WktaowDmjmmgxT74bm/6YVT83gyWfsoLisAqF/4GpLmQOFnk
         a19Q==
X-Gm-Message-State: AOAM533YnrTMt0b4WmCy+siidZVFC7cwQ3IQF82oxu7s3PBliAFNerIt
        jPtv7GwEuHhkGAWwX5mvkZ0WBGxHIyJfTQ==
X-Google-Smtp-Source: ABdhPJxVJGlqdckRXwQH589bKWS7W1Q57EFllmVu7qkb5QyRpouyV6h9CLuhcCGVDAo2DcqfLPahww==
X-Received: by 2002:aa7:9250:0:b0:3f9:2b90:b34f with SMTP id 16-20020aa79250000000b003f92b90b34fmr5607928pfp.7.1630716428526;
        Fri, 03 Sep 2021 17:47:08 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id g3sm455532pfi.197.2021.09.03.17.47.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 17:47:08 -0700 (PDT)
Subject: Re: [PATCH] cdrom: update uniform CD-ROM maintainership in
 MAINTAINERS file
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-kernel@vger.kernel.org
References: <20210903213011.1319-1-phil@philpotter.co.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ad204ccc-74ee-8d0d-4663-0a92cbd8f145@kernel.dk>
Date:   Fri, 3 Sep 2021 18:47:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210903213011.1319-1-phil@philpotter.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/21 3:30 PM, Phillip Potter wrote:
> Update maintainership for the uniform CD-ROM driver from Jens Axboe to
> Phillip Potter in MAINTAINERS file, to reflect the attempt to pass on
> maintainership of this driver to a different individual.
> 
> Suggested-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fa87db67a249..ccd518e15e0a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19142,7 +19142,7 @@ W:	http://dotat.at/prog/unifdef
>  F:	scripts/unifdef.c
>  
>  UNIFORM CDROM DRIVER
> -M:	Jens Axboe <axboe@kernel.dk>
> +M:	Phillip Potter <phil@philpotter.co.uk>
>  S:	Maintained
>  W:	http://www.kernel.dk
>  F:	Documentation/cdrom/

We should remove the URL too, that site hasn't been active in at least a
decade and a half :-)

-- 
Jens Axboe

