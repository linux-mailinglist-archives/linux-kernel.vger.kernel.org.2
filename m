Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4C042AAE5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 19:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbhJLRig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 13:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbhJLRif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 13:38:35 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EFBC061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 10:36:31 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id k2-20020a056830168200b0054e523d242aso280932otr.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 10:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=2BypScO76h55G7PPwXnggV0DBtGQ8bEd9vyWr6bUXKE=;
        b=Wk+QXyGeOJld76njFrWWdXYkW3GKfTQ/CyXWZkUGzuyWPJX+Pi+MoN3lO8gWfd27YA
         XEPw4irp+IJnOtcZz29Vo+/QPkJ65ex8DejKLsHs3fsas3yab01i91K14MykMq+BJyb+
         qrZxf95YrZgFCXZtjSdsJwzrWfJKTTJPnuGOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=2BypScO76h55G7PPwXnggV0DBtGQ8bEd9vyWr6bUXKE=;
        b=BHPmlL8VNFbBj49cnz6PbtJEfvHaXXB2Fy/n2CRsTI4rGo7PRaimZH2BvCVIZTGNC5
         FBA6cdVGr1gm+Qq5yJPmeAdAIeP5R7NoeYrarOi/iuw5xFY5O9kPl/7UCOlW5fh/tXdX
         sH58Wb0HPgwLPBwpCwOuYBMQ0oRw9C26aawB+ls3Ph7if/jT+Bfhe7U+6YJee6BUd4fJ
         ysaDcTuXKr9xB17/LSh4QozbKCU8phJdcAU/DW8zwwO4dOfAY/UsUAG1RLG5borTsAtW
         rxM5DvsI0LjPIXT9XwXgjGUHJts0tZdbhWmk5ctkU3r+RsTPqnb1EarxKEvO7mL91xRs
         tKTQ==
X-Gm-Message-State: AOAM532D/73UzHQilJAB10Ldp5VQ+tdZkmuSiS/QySSXNjus0mUlZAw4
        KDD/4J0YH3so/SeCMvFztpaTNsFNqWxU87IOF1iJ4A==
X-Google-Smtp-Source: ABdhPJxNOhgeqTAMjp5PAp6NyMFEPhaSaElT5ghTzkghPyWvKz0oqRQxrlR4ntBvFAX5KBLIMoaGbJbsJGSY5ELjd44=
X-Received: by 2002:a05:6830:2317:: with SMTP id u23mr12874222ote.126.1634060190606;
 Tue, 12 Oct 2021 10:36:30 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 12 Oct 2021 10:36:30 -0700
MIME-Version: 1.0
In-Reply-To: <20211010030435.4000642-1-bjorn.andersson@linaro.org>
References: <20211010030435.4000642-1-bjorn.andersson@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 12 Oct 2021 10:36:30 -0700
Message-ID: <CAE-0n51CoX131DsDWZUxWoCu6c+HEm4HbK=SrKraqhDqFkc6ww@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dp: Use the connector passed to dp_debug_get()
To:     Abhinav Kumar <abhinavk@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kuogee Hsieh <khsieh@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>
Cc:     Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2021-10-09 20:04:35)
> The debugfs code is provided an array of a single drm_connector. Then to
> access the connector, the list of all connectors of the DRM device is
> traversed and all non-DisplayPort connectors are skipped, to find the
> one and only DisplayPort connector.
>
> But as we move to support multiple DisplayPort controllers this will now
> find multiple connectors and has no way to distinguish them.
>
> Pass the single connector to dp_debug_get() and use this in the debugfs
> functions instead, both to simplify the code and the support the

s/the support the/to support the/

> multiple instances.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
