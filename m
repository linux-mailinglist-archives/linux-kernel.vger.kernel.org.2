Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C25913CFB84
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 16:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238735AbhGTNVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 09:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239241AbhGTNKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 09:10:45 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CABFC0613E0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 06:50:24 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id y17so22509676pgf.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 06:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w9tzWc4cuRtL5/SDfkMsY+rJuu4FmkQeC/JQ/ChPQyo=;
        b=E3iZHOHVKygZ1iuwEQf9ppmPHHIPHtdNuR248sgFH84F7LPJ3GKjhP3VkJ8Y4zMtZ+
         MeRnTEM27O/JM4qV/hYXnU3jF3R/s7rg2omvz7FCZHPkDI2/hyKGI3VR1M0oT2ykFKuZ
         5L5e96YKTFxRYCWTuseqlp4gDzFtNr7aIWwxhgRxrKvVG8YNcnddja0o0e5Hs10izyVp
         +FPpW4M489eVxHk9ngfSjRBG08OEXXX7wNtXh5JDV4Wizhp9JPy79d7vEoCw2n2In0Oy
         rX2aMOclUQAUHszMERpGq1Sws7a45iiLo/8xfn7y8gOoG5hq/DJQ20TH48m7awBumv1Q
         QEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w9tzWc4cuRtL5/SDfkMsY+rJuu4FmkQeC/JQ/ChPQyo=;
        b=mEE/ZLSy49Ob4+oca7dXnZGu10tZS8/p+HP7LrZNGSUTq7HN1WQscJsEdro6vfB6fX
         5jenSk8UzH3BhbEihRYfF9bID3GuOOuSYE3Zccv5z4BMYrDqqVT+I/4tYNsiteGL4jlk
         6y4wOcgBS1CM9D+LpbOyKvRl6H1dR0Fvrqr1aXiDFvi3ti2Rht/nkPIKLZ4w4RNXDJEs
         m7fl5OSQtTNsrd/y5WS7G0co7wyqYm01ayITpwGyzQhjlJ7SOABKKW1/yWxAtTQrz/eX
         e45kzr26HCBipmhqZkxuDk+PGyfwypx5gNfth5aLtwdMPfzsSnt3HfItMAeNGFA/oCxb
         5oqQ==
X-Gm-Message-State: AOAM5300WB2KNvoM8cEuUvXsdInS75hKdsupXpuMnmmvv73YmcPjPJ6x
        2LBYGx8w6J0DRF/tDrs3XdeQrg==
X-Google-Smtp-Source: ABdhPJweF07hfcnBV+2zVLFrqK0tH2nUGyGzIJuBtAPLzIpvaLVXbqUT6CBXTYhK7B58+wPcICjPiA==
X-Received: by 2002:a63:5652:: with SMTP id g18mr30574919pgm.178.1626789024014;
        Tue, 20 Jul 2021 06:50:24 -0700 (PDT)
Received: from localhost ([106.201.108.2])
        by smtp.gmail.com with ESMTPSA id a21sm2960260pjq.2.2021.07.20.06.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 06:50:23 -0700 (PDT)
Date:   Tue, 20 Jul 2021 19:20:21 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] dt-bindings: opp: Convert to DT schema
Message-ID: <20210720135021.u2qopsgrhu5eybp7@vireshk-i7>
References: <20210719202732.2490287-1-robh@kernel.org>
 <20210720043108.bmoydy3a2r3gqhnq@vireshk-i7>
 <20210720133454.GA4147058@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720133454.GA4147058@robh.at.kernel.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-07-21, 07:34, Rob Herring wrote:
> On Tue, Jul 20, 2021 at 10:01:08AM +0530, Viresh Kumar wrote:
> > On 19-07-21, 14:27, Rob Herring wrote:
> > > Convert the OPP v1 and v2 bindings to DT schema format. As the OPPv2 binding
> > > can be extended by vendors, we need to split the common part out from the
> > > "operating-points-v2" conforming compatible.
> > > 
> > > Cc: Yangtao Li <tiny.windzz@gmail.com>
> > > Cc: Nishanth Menon <nm@ti.com>
> > > Cc: Stephen Boyd <sboyd@kernel.org>
> > > Cc: Maxime Ripard <mripard@kernel.org>
> > > Cc: Chen-Yu Tsai <wens@csie.org>
> > > Cc: linux-pm@vger.kernel.org
> > > Cc: linux-arm-kernel@lists.infradead.org
> > > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > > v2:
> > > - move opp-peak-kBps next to opp-avg-kBps. Also add a dependency schema.
> > > - Correct the opp-microamp schemas. It's always a single value for each
> > >   regulator.
> > > - Add missing type for '^opp-microamp-'
> > 
> > Applied. Thanks.
> 
> I found some issues with it, can you drop it? 

Sure.

-- 
viresh
