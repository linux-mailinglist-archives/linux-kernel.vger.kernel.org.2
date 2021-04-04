Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F096353904
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 19:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbhDDRUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 13:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbhDDRUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 13:20:44 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE228C061756
        for <linux-kernel@vger.kernel.org>; Sun,  4 Apr 2021 10:20:39 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id s1-20020a4ac1010000b02901cfd9170ce2so2395625oop.12
        for <linux-kernel@vger.kernel.org>; Sun, 04 Apr 2021 10:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VXtcsMHNhwe+DVWvnO28yCAjs3uDsZfXK7wJO5SsYu0=;
        b=oIEUyW6/LMXcWTeJ0Lp+zssNy06KzKsLrLhboHb3iPJESxZW4LUjnc6QhulLM9vWha
         Izyjdvxl++DW90B7Ji1nU5+wLXBNGGsEkhx6nRJTFmF9V9XdR9D4VR6mpkr6EDqKJg5S
         6yV7nRSxGd9TPOXFJDPnfoMlxJd1uJYqA3RKGdF7psQzc/qmSW2PeR3YHaNqvBshWh6W
         mN5J6XUs8+01JW6u/KzMshNad7k4eVciW6IAxNjXUq0erWgSv2Lq59J3qmemjUXgdYSb
         e1yMy/NO0VGiR2fKvHxWmM+EdUnOyzfd2u+FtiFCGlg38ycL4aFNFLngqPjN+GEHzNUj
         99xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VXtcsMHNhwe+DVWvnO28yCAjs3uDsZfXK7wJO5SsYu0=;
        b=U66aobznYGXSiOPPg6JxE0ouddQobps0LO66S4KP3JZYvRw7A2u036lql8UPOzyzfk
         z24Yua/pxxbV2k8XRyzFZXpr4WmAaIQTjHsYO1Ewsryrb4fhK66A3w1IhMGohYT+vDnk
         pe56YfiobJhCRjRDtb7P/tewxQ2yBhlghE8BAWwm53kR5YUxNV7oSU9ofVn7k/S4tbqY
         OKkP1ob2dJuR2rNPZAvHPfPYGFgNiNMBGSifHY/x4xAqS1qg1Rotk2/YpBlhkPDqLYui
         CHWedkHB7VXNsimDTzvkU6veq3J7AjlaXRRc+8TS02d1B03cPcZcYhHMMWFKDyaGTcwu
         SJ7g==
X-Gm-Message-State: AOAM533lluwYYWv2X9eUczGKIJGytb+RT83+Qb0jRm0Kx3DSJyw3OIIl
        LsJoJNr0VU3vwVMNQRSKE4pbbwZZ+Banjg==
X-Google-Smtp-Source: ABdhPJyy9fEwwBWOsR7NFOdeDfPPYeE4bhPGo7Chb9gFcAp+JQlbAEL9aOtlMz3l2T2iZLKJY90xsA==
X-Received: by 2002:a4a:dd14:: with SMTP id m20mr19183701oou.47.1617556839119;
        Sun, 04 Apr 2021 10:20:39 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id x2sm3500140ote.47.2021.04.04.10.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 10:20:38 -0700 (PDT)
Date:   Sun, 4 Apr 2021 12:20:37 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Deepak Kumar Singh <deesin@codeaurora.org>
Cc:     clew@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH V1 0/2] soc: qcom: aoss: Expose send for generic usecase
Message-ID: <YGn1ZXihsTyk4sIW@builder.lan>
References: <1617344238-12137-1-git-send-email-deesin@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617344238-12137-1-git-send-email-deesin@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 02 Apr 01:17 CDT 2021, Deepak Kumar Singh wrote:

> [Change from V0]

It's typical that the first patchset, without a version specified, is
considered "version 1", and as such the second submission would be
"v2".

> Update qmp_get to parse qmp handle with binding qcom,qmp
> 

I won't be able to merge this until we have a user of the API, so would
it be possible to get at least one consumer introduced?

Regards,
Bjorn

> Deepak Kumar Singh (2):
>   soc: qcom: aoss: Expose send for generic usecase
>   soc: qcom: aoss: Add debugfs entry
> 
>  drivers/soc/qcom/qcom_aoss.c | 77 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 76 insertions(+), 1 deletion(-)
> 
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
