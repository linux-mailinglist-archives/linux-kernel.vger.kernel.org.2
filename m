Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC61F4336FD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 15:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235622AbhJSN2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 09:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbhJSN2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 09:28:30 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5E1C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 06:26:17 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id kk10so14746199pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 06:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=or8Ipmp1IuPITyJB/TiRcaMpJVnR5kcP60YFXBqqS1I=;
        b=cu6g7VaBRgn01oP0CdKLJmYNPxNd3Kgi5L/EcqgU37OBmWA6eLNW6m+Hv2oFmpDtEI
         QzJip+Zu7fpPjUg0tXw6yDHZR17UqSfXF/VjmfkKwnqSuTcxjk0RPYAAnR/6Hi+PR+7+
         tQQhIBBQ2J361Hnz9a34IoNxzNymtOBG+reymAWl5Etqw9xkykMNIz4Pze26IiYw0XZJ
         mhA+HLRXSBP3POw44j0ljWh1dTo1wZq++P1MxrOIj0m66pOvQxnb4g5JhYLqj7d17A2y
         McT1ftuwiGB4jzdSxCkafEB4uR4d6KC5GOdarnP7MmgJg88hxgcRadJdHvwAM5NULrwt
         TGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=or8Ipmp1IuPITyJB/TiRcaMpJVnR5kcP60YFXBqqS1I=;
        b=CDwHK4L91iRWMA8qBfKaMvbnSwoQJG+qMEO1vPd6LSRtepOSxOHy6J1xOcxDDLUIOh
         tJUOZnZjELRkQPAfw/D3IMSTt5FoCDbAoHELcrqOnQ5G/HaDF8hoCg1iMyQQ1RhMMUhB
         aXjq6DY/5V3k+fqL4Pz0Vyc6VdHre3IuUaviComTgOGxLyX8XdozfSBZD+hK9fX6lbsj
         kTvQzfKCCtP15516/oQH4sbOHY5++wEARwHDLXCtk8v8wIRC7R8xnEr181ZZ4cMH7tR7
         5r6/32mKLgqTHySQXR8eUSnK/+orV/MaclMX4vhUF0KmxdROLBuRWIUrLx92UFv9cqdw
         nSdw==
X-Gm-Message-State: AOAM5333vZA2B2gC6tMbfN/LLv8IHqDS36MVqSLS201olet7kajnah4t
        3P+wtVm8VxFyVGnfntO+2csz
X-Google-Smtp-Source: ABdhPJyt+9QxKogVBYcrXpPsn8dfe3yEg3R/m+Q+od/qJUlqh62gci/1z6OjYVgpks85+cnyqHC6UQ==
X-Received: by 2002:a17:90b:4c8d:: with SMTP id my13mr6687112pjb.101.1634649976785;
        Tue, 19 Oct 2021 06:26:16 -0700 (PDT)
Received: from workstation ([202.21.43.8])
        by smtp.gmail.com with ESMTPSA id g11sm15993807pgn.41.2021.10.19.06.26.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Oct 2021 06:26:16 -0700 (PDT)
Date:   Tue, 19 Oct 2021 18:56:12 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Hemant Kumar <hemantk@codeaurora.org>, bbhatt@codeaurora.org,
        loic.poulain@linaro.org, wangqing@vivo.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] MAINTAINERS: Update the entry for MHI bus
Message-ID: <20211019132612.GA4851@workstation>
References: <20211016065734.28802-1-manivannan.sadhasivam@linaro.org>
 <20211016065734.28802-2-manivannan.sadhasivam@linaro.org>
 <661c564c-e6cd-cbd4-0b17-a7c230d911b2@codeaurora.org>
 <YW64/hzKom7MiVDV@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW64/hzKom7MiVDV@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 02:24:30PM +0200, Greg KH wrote:
> On Mon, Oct 18, 2021 at 09:19:16PM -0700, Hemant Kumar wrote:
> > 
> > 
> > On 10/15/2021 11:57 PM, Manivannan Sadhasivam wrote:
> > > Since Hemant is not carrying out any maintainership duties let's make
> > > him as a dedicated reviewer. Also add the new mailing lists dedicated
> > > for MHI in subspace mailing list server.
> > > 
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
> 
> Great, Manivannan, can you resend just this patch with this reviewed-by
> so that I can apply it?
> 

Sure, will do. I thought I could also send the modified version of patch 2 of
this series but we ran out of time :/

Thanks,
Mani

> thanks,
> 
> greg k-h
