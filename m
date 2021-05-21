Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF24038C024
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 08:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234514AbhEUG7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 02:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbhEUG7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 02:59:48 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75C6C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 23:58:25 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id f75-20020a1c1f4e0000b0290171001e7329so6527536wmf.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 23:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZW5/iNaO6W6odBCX7nfGezrTMUSd2JvBSBFQHc528eg=;
        b=NCrHgxuI1JngyICIRjACo6qn4pXBhYG8Zv+/Ur47IcDzLgAYOynHoPp1DWnbhsUXAJ
         N2oNYigXigiYC7FVbmvk9Yhboag80AZ9tEw0XWbjN4ewv+wvUIXyDPs8+VqYDMzJlc4s
         cwiBmzL7n0H1kx6QzPRYyTD3LvI/uwVVtbaiFA1n/TjAGnZhUlWvN3ped/jMQdJ8q3fc
         tx8AlLM6+wkpH+CJpIU0fEuuHm3D4XL1zw4zGXHzMpL2kYcv1ICg2M3G8os4oXtfVoHg
         YErHK+4zLJi23gLkD4LdOVsl/pkxvaxQCKfj6Ar0YJDe5wPxAOo3h2FT5VStPdXZLlUF
         Aakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZW5/iNaO6W6odBCX7nfGezrTMUSd2JvBSBFQHc528eg=;
        b=p8Dks2Epnn4D8zrWh6COsaJljleGnqFmEpnUx7qGnX++RFFjqhdxbJ6EYm8Yb37QFA
         na3u5wT3g9pZQLEviL5bdp91Sc+f0+0TAEf7wIJ0POd5FKnQbYlXxEQwL/5Shk++L1Iy
         ifJ6ip/wvcGvX/J+cEWt5T31LwNRaaktH+ifOWlYoXIpiwGQRkkiUeW5JttC0c7RGVWK
         FuII4dhe/EB3Y2K/h4PD+3K6Cu792pl6zwtLxPtixKjyKGrtSqGJxk5p1V1Ll7gbLu2+
         fAntBTuyZLdp0VUY57R8TAThkWEzRPd9Q03K69qFUsqcCaPaYZn+8dBQjd23RLrl6XR4
         7/Fg==
X-Gm-Message-State: AOAM531hOPs6n9f0k0Pn62zL/vDcYemh35eBlth/fHnTS78WwwfIbSuQ
        owbucB7O3y6VaVxwB3M7UfeYIkr822FNwIm5
X-Google-Smtp-Source: ABdhPJzfq8PHDwVuWKkaoEi/S4jGHfUdKwKFFtn21R+z4N/KjrGLrmznw97NWFsMNKCjFb/YJJ75nA==
X-Received: by 2002:a05:600c:290b:: with SMTP id i11mr7732339wmd.34.1621580304421;
        Thu, 20 May 2021 23:58:24 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id f12sm957661wre.88.2021.05.20.23.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 23:58:24 -0700 (PDT)
Date:   Fri, 21 May 2021 07:58:22 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Peterson <rpeterso@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>
Subject: Re: [PATCH 02/15] fs: gfs2: glock: Fix some deficient kernel-doc
 headers and demote non-conformant ones
Message-ID: <20210521065822.GP2549456@dell>
References: <20210520120043.3462759-1-lee.jones@linaro.org>
 <20210520120043.3462759-3-lee.jones@linaro.org>
 <CAHc6FU429=1Hzoghqo3=hqkSSmja3+ujna=mE_-Ro=KOMTPecg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHc6FU429=1Hzoghqo3=hqkSSmja3+ujna=mE_-Ro=KOMTPecg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 May 2021, Andreas Gruenbacher wrote:

> On Thu, May 20, 2021 at 2:00 PM Lee Jones <lee.jones@linaro.org> wrote:
> > Fixes the following W=1 kernel build warning(s):
> >
> >  fs/gfs2/glock.c:365: warning: Function parameter or member 'gl' not described in 'do_error'
> >  fs/gfs2/glock.c:365: warning: Function parameter or member 'ret' not described in 'do_error'
> >  fs/gfs2/glock.c:461: warning: Function parameter or member 'new_state' not described in 'state_change'
> >  fs/gfs2/glock.c:1277: warning: Function parameter or member 'delay' not described in 'handle_callback'
> >  fs/gfs2/glock.c:1277: warning: Function parameter or member 'remote' not described in 'handle_callback'
> >  fs/gfs2/glock.c:1578: warning: Function parameter or member 'p' not described in 'nq_m_sync'
> >  fs/gfs2/glock.c:1993: warning: Excess function parameter 'wait' description in 'gfs2_gl_hash_clear'
> 
> What's that? Those warnings don't exist in mainline, and the two
> warnings we have in mainline are fixed in for-next:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git/commit/?h=for-next&id=75069590915f2

Thanks for the heads-up Andreas.

This is a rebased set that was authored last cycle.

It's great that someone has been through and fixed these already.

Tell me, is that just the case for this patch, or the whole set?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
