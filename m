Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A03D3B6BE0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 02:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbhF2A56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 20:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhF2A55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 20:57:57 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A73C061760
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 17:55:30 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id b17-20020a4aba110000b029024c219a3d83so4081492oop.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 17:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GDhA1ihXWrT4DgsTvJJQ3a7lYOW9rbnfSnG4YreGVeA=;
        b=oj8e2pcBK60S1TBtvC+t9Py/HxixcDr5zIkEvVVua+LBcfEh3p0ocIUFRdUp0E2Qza
         fnZbyiuoR6KtpkLTuL/7qnIi/6sx6oSwrCBi5ldGJS1JtdIW29twE5NpBy/+l6w1RhQo
         2H3ld3K4i/3r3cCUzIXiBQKYm2OogciGNKcAu/nN/dBkG9ZLzAc49BPK0SOknXYuB8iu
         mz1VhrGlkpu3pTHMfGvjE9MfrVJ76wDpePIbMhdJBCaLLhXqEx1S2GTvPIlmglrFWnAJ
         XUfaX6fNDxaXt1FxVdsMvYIiNWWuyrsH/p7kmUEbTqAEq9hz7fqCx+AY7JSt/dBjoJXc
         NL0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GDhA1ihXWrT4DgsTvJJQ3a7lYOW9rbnfSnG4YreGVeA=;
        b=g3/W25o78jMy+sPl4r/lK+hDN6Gko4TYxGNsQH4BF7Dw4C51SGz3031aiYg+13E9PD
         36ZnQxNBtoAxemP3RzGLdFfzlyQiU9mffISCe3nscoL1Lv7r/lOg2RrS2h1s3RENFPOc
         sLLOR/wyyQ3bg9GE8WEuEnjXoMiZ6uv1YV9vScoHtyC8GxioXicZCTApU9pTJFht3yCB
         dEnfJwRp1kP91M58BAGYKtN13gt7d5TpVhs/6a7MYj/Oa7mL/fa9keyex6rD6upm8tuv
         P1uhz/S5JKYEWSQf2JSzPEBgw9fk92/n0fJxjPOlxZqI3549mgV1FbdF3jEMBLzgkCqc
         vfPg==
X-Gm-Message-State: AOAM531SwID5FkE1Ud8HzdHVbD2J6O8G079kvY3bxRebGiewKwpp7Yrl
        ReUGgQ7DltFP53GHx5bizVLhMl5+Xv0/Ew==
X-Google-Smtp-Source: ABdhPJz6ly6okfXaVt6HoXYOoXONv648Lesu9RQtGl+S+aWBxk4UTveKkdgkK3EHC9sVwo5TBEpovA==
X-Received: by 2002:a4a:8241:: with SMTP id t1mr1748528oog.13.1624928130174;
        Mon, 28 Jun 2021 17:55:30 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id j13sm3501831oie.27.2021.06.28.17.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 17:55:29 -0700 (PDT)
Date:   Mon, 28 Jun 2021 19:55:27 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     abhinavk@codeaurora.org
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dp: Make it possible to enable the test pattern
Message-ID: <YNpvf8rpWoMFTcBt@yoga>
References: <20210629002234.1787149-1-bjorn.andersson@linaro.org>
 <b3456d3e4376ae1e9776f03e14513a35@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3456d3e4376ae1e9776f03e14513a35@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 28 Jun 19:31 CDT 2021, abhinavk@codeaurora.org wrote:

> Hi Bjorn
> 
> On 2021-06-28 17:22, Bjorn Andersson wrote:
> > The debugfs interface contains the knobs to make the DisplayPort
> > controller output a test pattern, unfortunately there's nothing
> > currently that actually enables the defined test pattern.
> > 
> > Fixes: de3ee25473ba ("drm/msm/dp: add debugfs nodes for video pattern
> > tests")
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> This is not how this debugfs node works. This is meant to be used while
> running
> DP compliance video pattern test.
> 
> https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/blob/master/tools/msm_dp_compliance.c
> 
> While the compliance test is being run with this msm_dp_compliance app
> running,
> it will draw the test pattern when it gets the "test_active" from the
> driver.
> 
> The test pattern which this app draws is as per the requirements of the
> compliance test
> as the test equipment will match the CRC of the pattern which is drawn.
> 
> The API dp_panel_tpg_config() which you are trying to call here draws the DP
> test pattern
> from the DP controller hardware but not the pattern which the compliance
> test expects.
> 

So clearly not an oversight, but rather me not understanding how to use
the test pattern.

You say that I should run msm_dp_compliance while the test is running,
so how do I run the test?

> Its just a debug API to call when required during bringup/debug purposes.
> 

Yes, I was trying to isolate the DP code from some misconfiguration in
the DPU during bringup and with this fix the debugfs interface became
useful.

Regards,
Bjorn

> Hence this is not the place to call it as it will end up breaking CTS.
> 
> Thanks
> 
> Abhinav
> 
> > ---
> >  drivers/gpu/drm/msm/dp/dp_debug.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/msm/dp/dp_debug.c
> > b/drivers/gpu/drm/msm/dp/dp_debug.c
> > index 2f6247e80e9d..82911af44905 100644
> > --- a/drivers/gpu/drm/msm/dp/dp_debug.c
> > +++ b/drivers/gpu/drm/msm/dp/dp_debug.c
> > @@ -305,6 +305,8 @@ static ssize_t dp_test_active_write(struct file
> > *file,
> >  				debug->panel->video_test = true;
> >  			else
> >  				debug->panel->video_test = false;
> > +
> > +			dp_panel_tpg_config(debug->panel, debug->panel->video_test);
> >  		}
> >  	}
> >  	drm_connector_list_iter_end(&conn_iter);
