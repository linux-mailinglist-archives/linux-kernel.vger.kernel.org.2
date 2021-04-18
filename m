Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD0E363310
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 04:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237112AbhDRCCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 22:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbhDRCCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 22:02:00 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B62C06174A
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 19:01:31 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id q10so21806125pgj.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 19:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=i4Imu1BWQcVXCSFxSDgujcaZlKZQa09CIGJSA8XI6n8=;
        b=X59zLpjGlnVrlAO5JfGiDZgy2DpgfUYqN8dLWpdETj496vsoWMBYFFGGhFOF/qnGGe
         dVRbYwQMItuxncY/0wGC4EekKebQqxtVnvhT/TiaqkAuq+H1jRQxVAP3j8ZOwy1xIWVi
         oOsjKt2eaQltWPwrZ/uET5n2QEfA3sFQlYG6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=i4Imu1BWQcVXCSFxSDgujcaZlKZQa09CIGJSA8XI6n8=;
        b=XWlOM0p0jDchnqCGx5ZGahU10wxaaYc1Nrpm6iFolbE6V3Fe1uY6gWwgC/LnMpCKcY
         NMG6SzHONrFoOlQId830f40tjAK5KSdWntYUakSpb0WzG+xRWnJaEKi8bir7rVZt3a4S
         sIX+HyZE2VusZNwCnxRguq/jiQTEqiwJnanYhxJxqqPnpuD9+upXy9ugbD34yx9b0lsV
         MmYPC9B2DBN3vxcv8idghGX8WTrBKosctVGuv6RtRmkUEI9s71acBy3myYfBqvSIwR4d
         s6rICNtxSLKCqHoCa2SymnpfP8U3szsud0RHWACeFB3RkDCAi2SC41GXKI1oVbx9HyjD
         tXNw==
X-Gm-Message-State: AOAM532V8sqm2k3ico4eLxPzm4jvheHP3BMNhEuas/ECBBGDMimHSVXH
        pu0QMdRlcXZb1Prldr+8q66Pkg==
X-Google-Smtp-Source: ABdhPJzAdwltw1IP+RvqACSQEreS0ffDS1/TO98GarUdLLwEbkGdWuQXzrR67TZBjugLS5/wVS68HA==
X-Received: by 2002:a05:6a00:883:b029:247:562:f8f9 with SMTP id q3-20020a056a000883b02902470562f8f9mr13810564pfj.34.1618711291160;
        Sat, 17 Apr 2021 19:01:31 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:e47c:5232:82d9:6d3f])
        by smtp.gmail.com with ESMTPSA id c21sm7955644pfc.165.2021.04.17.19.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Apr 2021 19:01:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1618574638-5117-3-git-send-email-sibis@codeaurora.org>
References: <1618574638-5117-1-git-send-email-sibis@codeaurora.org> <1618574638-5117-3-git-send-email-sibis@codeaurora.org>
Subject: Re: [PATCH 02/12] soc: qcom: aoss: Drop power domain support
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     rjw@rjwysocki.net, agross@kernel.org, ohad@wizery.com,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, rishabhb@codeaurora.org,
        sidgup@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
To:     Sibi Sankar <sibis@codeaurora.org>, bjorn.andersson@linaro.org,
        mathieu.poirier@linaro.org, robh+dt@kernel.org,
        ulf.hansson@linaro.org
Date:   Sat, 17 Apr 2021 19:01:29 -0700
Message-ID: <161871128938.46595.8658084266884500136@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sibi Sankar (2021-04-16 05:03:48)
> The load state resources are expected to follow the life cycle of the
> remote processor it tracks. However, modeling load state resources as
> power-domains result in them getting turned off during system suspend
> and thereby falling out of sync with the remote processors that are still
> on. Fix this by replacing load state resource control through the generic
> qmp message send interface instead.
>=20
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---

Is it possible to keep this code around for a cycle so that there isn't
the chance that someone is using the deprecated DT bindings with a new
kernel? I worry that ripping the code out will cause them angst.
Certainly we have to keep the code in place until DT is updated, so this
patch should come last?
