Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B69E3E8728
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 02:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235798AbhHKASk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 20:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235678AbhHKASb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 20:18:31 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C40C06179B
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 17:18:05 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id r19-20020a0568301353b029050aa53c3801so1312767otq.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 17:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tC3Mrv9dp9wt6xL+7sHY8TagV0MgWFNV+pJOGnVORVo=;
        b=FDn7/X54nL1aG3m/4vDJtAKvaaviRB7169EeCZwuzP0shJzDftJhls7H32FjLkR4tK
         TY0MO1Z+yupNXglfBUjzGPkdnNUoM9reDecGvC2JBQ2aUKhIZBhJf2yC9FksyUUsC8Rq
         i5GRR3+HOtcJ+Znq6y8W95C/6oqcPcBxeVQZLrF8nQIOI/lWu/0GlgBMh/o/DQujQvMt
         orLScabv/n3cpxDica+yDQ+iJXHXdMYutH2DCv3IR82bgKnpfMCBjBEkKLWYNyR6cm8s
         wCnGf+ducxIz14qCU7uLIoawYJIRAcDS+BddSJ7VLsN1rTB5lCozGt2merKrzy5YNmX9
         fOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tC3Mrv9dp9wt6xL+7sHY8TagV0MgWFNV+pJOGnVORVo=;
        b=FvnBLkyVBHX2HTiBEcaBOZSOMUNa/SSjUnTpxt3TJUbouhdXA6ri55z8EVJbZaLCPK
         WXcdSIru1vjMyN0uaUseg7YqReW+dPwfQ6j1SJ3HbfbucLZ4SUKidQGP0s7Q36Jwx3zw
         H3mZvUfCN9NNHhmm0yndzjtqOw8jI/nwIxQj7yk89zQ4vi6fCkdBYmIVEb+d+qgDy3H4
         y1bstHG/f4p07IIOiJrw+qvO/NvjagsVSAc3Ns+405t7HeIWTzoS0Y+TG4v1qZVzDW/E
         rUKV78uwxEMi6p7g6Pe3QoGFy3Gwefj0ALuHwKT/Z9tvhLdwb225fzLTkZmGlOGKrJgA
         Si5Q==
X-Gm-Message-State: AOAM532F8DfXfYoFeH9A/ueB6y9L9dkjVJHbMSxV9CKQHQJkzr+nH8bm
        i/8jUCd1WAM8KG08WOX2576ucA==
X-Google-Smtp-Source: ABdhPJwkyONF/aUoE8sR15S4yNOA7sm6WRXOMuaxwi+kTEm/PcLMaps34StDjqMYdEhwRL4FwUMRSg==
X-Received: by 2002:a9d:2609:: with SMTP id a9mr6767199otb.365.1628641084446;
        Tue, 10 Aug 2021 17:18:04 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 12sm4176912otg.14.2021.08.10.17.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 17:18:04 -0700 (PDT)
Date:   Tue, 10 Aug 2021 19:18:02 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Mike Tipton <mdtipton@codeaurora.org>, djakov@kernel.org,
        agross@kernel.org, saravanak@google.com, okukatla@codeaurora.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Alex Elder <elder@linaro.org>
Subject: Re: [PATCH v2 4/4] interconnect: qcom: icc-rpmh: Add BCMs to commit
 list in pre_aggregate
Message-ID: <YRMXOlA5a98BwT3i@builder.lan>
References: <20210721175432.2119-1-mdtipton@codeaurora.org>
 <20210721175432.2119-5-mdtipton@codeaurora.org>
 <CAE-0n52iVgX0JjjnYi=NDg49xP961p=+W5R2bmO+2xwRceFhfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n52iVgX0JjjnYi=NDg49xP961p=+W5R2bmO+2xwRceFhfA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10 Aug 18:31 CDT 2021, Stephen Boyd wrote:

> Quoting Mike Tipton (2021-07-21 10:54:32)
> > We're only adding BCMs to the commit list in aggregate(), but there are
> > cases where pre_aggregate() is called without subsequently calling
> > aggregate(). In particular, in icc_sync_state() when a node with initial
> > BW has zero requests. Since BCMs aren't added to the commit list in
> > these cases, we don't actually send the zero BW request to HW. So the
> > resources remain on unnecessarily.
> >
> > Add BCMs to the commit list in pre_aggregate() instead, which is always
> > called even when there are no requests.
> >
> > Fixes: 976daac4a1c5 ("interconnect: qcom: Consolidate interconnect RPMh support")
> > Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>
> > ---
> 
> This patch breaks reboot for me on sc7180 Lazor
> 

FWIW, it prevents at least SM8150 from booting (need to check my other
boards as well), because its no longer okay to have the interconnect
providers defined without having all client paths specified.

Regards,
Bjorn
