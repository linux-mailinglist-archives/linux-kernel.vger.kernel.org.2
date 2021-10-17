Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799AC430A40
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 17:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237957AbhJQPju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 11:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbhJQPjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 11:39:49 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BD8C06161C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 08:37:39 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id d21-20020a9d4f15000000b0054e677e0ac5so478440otl.11
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 08:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rhJ3MYQxq7jBWrI9qP0fXJvJ7nX/eTAbsnjrRWMMFSk=;
        b=GCtnrjiizXGVQMZOGAeOU0DNHpUUeMzYqWIJgqJFXZilHvYermpet4Oe9/jxnwO/iM
         4AgFbFnGJgxGQrpM7uMVA7pcW3n1CuvoeMXHkG88JRLEceU/B3oYL/oW3AmFLDlz5prj
         D8+xbpnJUEAFBp17G9Tkg5RfTvbgkAKzlbkg8HqpTiTY4UTUd6X80mzqa/TiqLo8AorA
         h5Cy5X2Ud8IwTR4zH1E6bQdLrOJ9v0/ISUK+G+0RPz4lSiDa4hodJ8GhxshaqkOF7GS/
         5t1GsAKrm78wm0P7jvhXir9dNQ1veHeLvZDcWzcNL1UobHtrRlKjdmymivH38WPtiRqB
         wBZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rhJ3MYQxq7jBWrI9qP0fXJvJ7nX/eTAbsnjrRWMMFSk=;
        b=7qPT1Ope+gn91YwfTGX0FOTnp1fDeEtGCcU9sKpEabUzaonCT54ijyRhzYElwRhNwl
         AlsluvpnMO9LDDcad2b7+cZjSXCWfcaO3tqr9e4BCy9tuy6LpRbIZH3eeqKrbv7n6vnI
         UgMcl7WeLCOlscuU44rLkotOdgvo2End/l93ZMonNle+ENuQI/xzPVOflPL/tla4oeze
         r51H2xv+Kutr9l8TLsV8WajNiGuJ0+dq1Ni9kZRQiRBaW7tkGA5ybbN+f+d2HoNylY2Z
         oukM27tbnTOhllPYRRA64MReBgONumkjthGimxK8bIdy8J7vjLanQCgkw6miOBe1pt97
         WvBw==
X-Gm-Message-State: AOAM5323axYIVJLVengE2d8w25m8arYqzEG46ECyhUkqvObCaNlgoccc
        Gf3e3PQB0+oWBxYiarolARUi4w==
X-Google-Smtp-Source: ABdhPJwjycxtRcae2uuxEEliyOr1THEo6rI+dgHveXyCqMO2SaAU+kA94jDbKXV5kLu7kDuNKnwebw==
X-Received: by 2002:a05:6830:95:: with SMTP id a21mr18534612oto.43.1634485059006;
        Sun, 17 Oct 2021 08:37:39 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id bp21sm2290370oib.31.2021.10.17.08.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 08:37:38 -0700 (PDT)
Date:   Sun, 17 Oct 2021 10:37:36 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>
Cc:     Abhinav Kumar <abhinavk@codeaurora.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        Kuogee Hsieh <khsieh@codeaurora.org>,
        Sean Paul <sean@poorly.run>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 7/7] drm/msm/dp: Add sc8180x DP controllers
Message-ID: <YWxDQInQD8ZDa1IB@builder.lan>
References: <20211016221843.2167329-1-bjorn.andersson@linaro.org>
 <20211016221843.2167329-8-bjorn.andersson@linaro.org>
 <CAE-0n53R79HOoBsuLXVkVhYotFam8k4mWZqWnaiJcqcr7w522w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n53R79HOoBsuLXVkVhYotFam8k4mWZqWnaiJcqcr7w522w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 16 Oct 20:32 CDT 2021, Stephen Boyd wrote:

> Quoting Bjorn Andersson (2021-10-16 15:18:43)
> > The sc8180x has 2 DP and 1 eDP controllers, add support for these to the
> > DP driver.
> >
> > Link: https://lore.kernel.org/linux-arm-msm/20210725042436.3967173-7-bjorn.andersson@linaro.org/
> 
> BTW, was the link intentional?

No, I didn't intend for this Link to go upstream, just forgot to clean
it out as I was sending out the patches.

@Rob, @Dmitry, can you drop this as you apply the patch, or would you
prefer a resend?

Thanks,
Bjorn
