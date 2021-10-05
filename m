Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4DE342225E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 11:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbhJEJf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 05:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233455AbhJEJfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 05:35:25 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D99C061753
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 02:33:34 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id s24so15807072wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 02:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=84i4+SzL9tiQo/SOSLeEzwo8g6Lg9b2B2s8GHO0rn9o=;
        b=WaWK+vO3GHH71aqMogJcK7UAKifrVXNE9OzaJrTvObEyqj74YLfbafdzDVMQL0coEu
         CuNwRzCsT1pVdmPLSvb4NBANiT41zxtJI/SZc5EkT941+DLJJyiDYjAU6StNuECZ33K8
         UrZluNpRWi00T6c6c4EaouBbA9mcnyzrkZgctEJrBrB8Nke/hS1CXTY1pSMh7lwQF7p7
         yXXoS1QvI5knJ31FblmsHibRFJO1PkYCaZiAzVVeV9rqDo1asr/fVvHsMuwQczohxNNk
         77assjsCcZsguQ5DbAWzKSTtiYb3ovZVTa34BZSleiF8LlfWIek22ADi0zk9ZvLtaLNn
         cS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=84i4+SzL9tiQo/SOSLeEzwo8g6Lg9b2B2s8GHO0rn9o=;
        b=4XqovTCHN8Bf7Qxcr60XdHuqdsZxgOMVD9e4TVBFDZzbekE3Ji4cDpDKqDeqgHTt8g
         EitSnV7z2AQexTrpuZaf5XiSyFk3BeR3l0l+f1aD4Jw/rUYIwXRULyC9WuKWapq7WWzy
         XqHyJSZkHL1sY9KaLHUQ6je+pvtntB9Ep13Y0rpo/3ByR8yOQrG3T927kNwgilDxHcz9
         4odTVsRCQ1napW94ZAAXZg9ksHZS59SSlPHJdcDre1FUJsCgZh5MK8/kwmZg0ztaogr/
         QC58li99w5iweBQgI3weRSqmXmT+11F0vGaXvST3cI3kQ+sGRGShCAZGKPp0XCU/jkJt
         gNhQ==
X-Gm-Message-State: AOAM5308S9eWb+8CS9vVkSlqNAFy0dR89ZlOmo26j+1d7BZJazyHR4pS
        s9kcnCTCCDhDqdwjlgoZzTqvvA==
X-Google-Smtp-Source: ABdhPJw0zjXOLhlcSRooceJ4ayxqpv13Rbw1Of426+AbhSJDGcM2mvcDifH9KLoqa9i1dBz8lo0OzA==
X-Received: by 2002:a1c:4e0f:: with SMTP id g15mr2276144wmh.74.1633426413360;
        Tue, 05 Oct 2021 02:33:33 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id r9sm17065679wru.2.2021.10.05.02.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 02:33:32 -0700 (PDT)
Date:   Tue, 5 Oct 2021 10:33:31 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Pavel Dubrova <pashadubrova@gmail.com>,
        Kiran Gunda <kgunda@codeaurora.org>,
        Courtney Cavin <courtney.cavin@sonymobile.com>,
        Bryan Wu <cooloney@gmail.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/10] backlight: qcom-wled: Consistently use
 enabled-strings in set_brightness
Message-ID: <20211005093331.4houxsc5b6lfzmbz@maple.lan>
References: <20211004192741.621870-1-marijn.suijten@somainline.org>
 <20211004192741.621870-10-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004192741.621870-10-marijn.suijten@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 09:27:40PM +0200, Marijn Suijten wrote:
> The hardware is capable of controlling any non-contiguous sequence of
> LEDs specified in the DT using qcom,enabled-strings as u32
> array, and this also follows from the DT-bindings documentation.  The
> numbers specified in this array represent indices of the LED strings
> that are to be enabled and disabled.
> 
> Its value is appropriately used to setup and enable string modules, but
> completely disregarded in the set_brightness paths which only iterate
> over the number of strings linearly.
> Take an example where only string 2 is enabled with
> qcom,enabled_strings=<2>: this string is appropriately enabled but
> subsequent brightness changes would have only touched the zero'th
> brightness register because num_strings is 1 here.  This is simply
> addressed by looking up the string for this index in the enabled_strings
> array just like the other codepaths that iterate over num_strings.

This isn't true until patch 10 is applied!

Given both patches fix the same issue in different functions I'd prefer
these to be squashed together (and doubly so because the autodetect code
uses set_brightness() as a helper function).


Daniel.
