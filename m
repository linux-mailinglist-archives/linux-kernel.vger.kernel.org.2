Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFC37311853
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 03:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbhBFCey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 21:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbhBFCch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:32:37 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAFAC08ECB8
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 14:50:10 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id nm1so4430137pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 14:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=gKCMWJy86du3XdDODHHkwDL4EqHeNQp1OLhPf7Jz0/g=;
        b=DeXiiiz5Xu4mcDBbUqmfnVGscCw+wn6NsdbMyjAgmzY0DOwxWhcYOd/PnXNYyBohsH
         kYceKhwQiG+aY1UbhHj+Kxmycp6RYnmrSDn4qOIt132V+xkdfuUzzL1LBYYDUIerwPc1
         txnAFI8K2L0gYegSqTqvFwLAFkxZc02oP87Ok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=gKCMWJy86du3XdDODHHkwDL4EqHeNQp1OLhPf7Jz0/g=;
        b=QeJ8h/ZfefFMK2TF38TfhdysEwaWrJs6eeUlJYutPKkILTnpCJsOzhl1rJOrF1f/9T
         vTZVeo/rAJxppO9Bpq0YLVBQqSBK4pfZ2hvH2beO/ZVoB9x2yCN9PAO+5wiRg5x4WKDi
         Xmt56SKRIj26c8zbf77aPQMtf5iEeh7Bz2EdbxmIQEEyhsNC5/o67iPPEfudTDZboeKh
         97nvZ/mbdE+xE153qYjf06WYaZYNd9UzTqp4X9a8X81w6ZqUse8nqc0sGO6zYSlSVMnk
         gBExi9EkGMLfyZ/qYgoHih2ZC/9i/+u1iIDmaIAaEzwpP89T+Qy+cs+FTIDVz7TylRJw
         q03A==
X-Gm-Message-State: AOAM5323aKMvjWt/VUqZqfl39Oj3nHLUhDtC6OU/u/jcV0xGSyfpkfbd
        F94a2dI7qaXaaZQuXSKoFHEchw==
X-Google-Smtp-Source: ABdhPJwGvnWZVMON25jxMBQujRQW8J9vouiPFt6BaQnmk2Wd20tbSiNga0UjbYPbrvJYFU44SNIh9w==
X-Received: by 2002:a17:90a:8b15:: with SMTP id y21mr5929152pjn.82.1612565409676;
        Fri, 05 Feb 2021 14:50:09 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3d74:5f76:aaaa:6cb8])
        by smtp.gmail.com with ESMTPSA id s126sm6639348pfs.81.2021.02.05.14.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 14:50:09 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1612557878-19743-1-git-send-email-khsieh@codeaurora.org>
References: <1612557878-19743-1-git-send-email-khsieh@codeaurora.org>
Subject: Re: [PATCH] drm/msm/dp: reset dp controller only at boot up and pm_resume
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     tanmay@codeaurora.org, abhinavk@codeaurora.org,
        aravindh@codeaurora.org, khsieh@codeaurora.org, airlied@linux.ie,
        daniel@ffwll.ch, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
To:     Kuogee Hsieh <khsieh@codeaurora.org>, robdclark@gmail.com,
        sean@poorly.run
Date:   Fri, 05 Feb 2021 14:50:07 -0800
Message-ID: <161256540764.76967.2035577896654812758@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2021-02-05 12:44:38)
> DP_SW_RESET is the global SW reset that is used to initialize DP
> controller. If DP_SW_RESET executed during connection setup,
> two HPD related side effects may occurred,
> 1) pending HPD interrupts cleared unexpected
> 2) re start debounce logic which trigger another interrupt
> This patch only issue DP_SW_RESET at boot up and pm_resume.
> This patch also reinit video_comp before configure dp controller
> to avoid missing VIDEO_READY interrupt.
>=20
> Fixes: 9fc418430c65 ("drm/msm/dp: unplug interrupt missed after irq_hpd h=
andler")
> Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
