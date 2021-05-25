Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5812738F8C3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 05:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhEYD3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 23:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbhEYD3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 23:29:43 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE28C061756
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 20:28:13 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id u11so29012235oiv.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 20:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yd7WNrW5RgCRq69GG/t641RhzJb1+O9rCNuKEDYZ+UQ=;
        b=Qihz9q4ulhPC5+jW95HZeqBMuDCzCUu5BXI2aHGC/4iIT85jOP8Merwq+BoCPrrNFl
         MlvM+x81c5n+TIyIs8D1H+nQNU4q7QNzAI9dT25HByHl0DudUzzbP+m5k87rrr5Q9E2V
         v5XqwFV+m63TDEQPDv/hWb6ymRQnjJEmWX8UxwOq4fEA9/YflwcPI6/SYvL1XfI9wKyu
         MX7xrQyiZQxJU57vhRcGOGin7qf+2ErXPVy3Bvl/TmpmCk08rHdDvK3HHWdT5SKcFbKm
         Ngd5FveLSInfBtCMCRZDjCg1lBKeJGBrXkut5dcay1LhdzWu9x3oZnPqKeQ4HaT3Jee2
         3LvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yd7WNrW5RgCRq69GG/t641RhzJb1+O9rCNuKEDYZ+UQ=;
        b=OGgueSbLZwSOakJQTBJrS00L1tcnmW6GDTLo95g4dJl5os/3gS7SNl5gB/Yyqirtam
         e3V4fkK1QQ/kj7T2nD6JGLoO3qW20bfvKk46o0R6uEqjnXbHvuK8j6bdD+PJh5SVTJ/C
         NO9RnQn1k4RdpXe3W+akS7lHM6Fm7LdDQfUeAN+yN/tH69DXbdZSK5H5rrx7QUWsnKyI
         /EhYzVUQT93emBDC9v8OtYutwCokYmRL1udwcavF/NBEtF6hGBl5SwzQYfbjnYaSOORB
         XdnCD4YZdXeXXQcgJwbN4IPoWQKHZlEtafCMUgq6R06q/EZ9a339Djfjl/N5/OoMMlFa
         5Gqg==
X-Gm-Message-State: AOAM530yn0Dn2SUDl6pC01Vi6zMYLEefPRUJTmlNaUNfBCi8Lbt1zTM9
        bL+oqTDt3yyACswO9PhhvqpREw==
X-Google-Smtp-Source: ABdhPJwKviMyrxlplBS0akvECPGFTv+lWWT2whiGwA05wk4Af21kzQrXyzWmMbn4Mo/QH1n2F7KL+Q==
X-Received: by 2002:aca:4e8c:: with SMTP id c134mr1436989oib.169.1621913292614;
        Mon, 24 May 2021 20:28:12 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id c19sm2990438oiw.7.2021.05.24.20.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 20:28:12 -0700 (PDT)
Date:   Mon, 24 May 2021 22:28:10 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu@lists.linux-foundation.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Patrick Daly <pdaly@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>,
        Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH 0/3] iommu/arm-smmu: Qualcomm bootsplash/efifb
Message-ID: <YKxuynamQBTrNksO@yoga>
References: <20191226221709.3844244-1-bjorn.andersson@linaro.org>
 <20200108091641.GA15147@willie-the-truck>
 <CAF2Aj3iKk2LSA5XC76pNiLV8a76BkibUitof-dix8rqkc0qiow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF2Aj3iKk2LSA5XC76pNiLV8a76BkibUitof-dix8rqkc0qiow@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 24 May 07:03 CDT 2021, Lee Jones wrote:

> On Wed, 8 Jan 2020 at 09:16, Will Deacon <will@kernel.org> wrote:
> 
> > On Thu, Dec 26, 2019 at 02:17:06PM -0800, Bjorn Andersson wrote:
> > > These patches implements the stream mapping inheritance that's necessary
> > in
> > > order to not hit a security violation as the display hardware looses its
> > stream
> > > mapping during initialization of arm-smmu in various Qualcomm platforms.
> > >
> > > This was previously posted as an RFC [1], changes since then involves the
> > > rebase and migration of the read-back code to the Qualcomm specific
> > > implementation, the mapping is maintained indefinitely - to handle probe
> > > deferring clients - and rewritten commit messages.
> >
> > I don't think we should solve this in a Qualcomm-specific manner. Please
> > can
> > you take a look at the proposal from Thierry [1] and see whether or not it
> > works for you?
> >
> 
> Did this or Thierry's solution ever gain traction?
> 

There was a few pieces that landed in the common code which allowed us
to deal with the quirks of the Qualcomm platform (turned out that just
reading back the settings wasn't the only piece necessary).

The "generic" solution is essentially the second half of
qcom_smmu_cfg_probe(), which ensures that as the SMMU is reset it will
do so with bypass mappings for all stream mappings the boot loader left
us.

> Or are all the parties still 'solving' this downstream?
> 

I believe that Qualcomm has adopted the upstream solution in their
downstream kernel.

Regards,
Bjorn
