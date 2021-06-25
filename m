Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096583B4A3F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 23:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhFYVhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 17:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbhFYVhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 17:37:50 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9713C061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 14:35:27 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id v13so5372500ple.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 14:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uHfokonYY4IsHJIZe45nbhfdfmpS+hT7ERJ530OGkgA=;
        b=c+swM+bTpTsn863tPWig6yNcflU00kaWoBe6ho4se3LIMJM64/3IrVmVF9n9wy1RRn
         Ody/OPTuiky+oBUK/GTgcEgj1XJ70DzUow5zcjpMzFUFxEdCu+huRS2+Id3aJFAziRQd
         nBm7o+8j9nU0A3w/4ShYqeCY/g0MPAdehbDHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uHfokonYY4IsHJIZe45nbhfdfmpS+hT7ERJ530OGkgA=;
        b=cDzbOtIB9V8WeUmtd2IIfxEMb4yTniuu6nZZZOmBcetp5hDs2FeQLbPCbTQgH9MLNS
         z7UY443kiTsoNMqxh9uYlYgwtb4nQM960eqaamNbQmc9Kj14RRAFhtCbNqZYjeJGIQCe
         cz+dcR92ty+qf2Gm8yRt3ovESHCCVfK6dPn6KpNa/kDB+YFox0Y6CGx4I/ce83BxhCt2
         pKqqh7suH/9bDMfmuVm8C8njReXKL88RyOQFJJ8+f5aUp5yNilgC/MQbBbh55rvqwmnp
         qdy/xN9evdmaXYduwZzN+F9dPmQveh0Ki7vTZWtFhzxP1znSG42aJp7Sr+3kaCtEe8Cm
         HgwQ==
X-Gm-Message-State: AOAM531cGhbtN8sSzSpSM/cw22TdUEMqAXtSVa2zQyHx7CNgIYH7IGV6
        HeqhQc1XB2FKAulpxHfuTmvagA==
X-Google-Smtp-Source: ABdhPJwVJBb+HmRxybcQnH4mKaYXB5HATNb3IfW8BKVznv3WmHh4gQSSYZGN81p1sygiIjJPYlUqMw==
X-Received: by 2002:a17:902:6b04:b029:10d:8c9e:5f56 with SMTP id o4-20020a1709026b04b029010d8c9e5f56mr11270840plk.8.1624656927332;
        Fri, 25 Jun 2021 14:35:27 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:cc13:a7dd:f4b5:2160])
        by smtp.gmail.com with UTF8SMTPSA id z6sm6313346pgs.24.2021.06.25.14.35.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jun 2021 14:35:26 -0700 (PDT)
Date:   Fri, 25 Jun 2021 14:35:24 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        swboyd@chromium.org, ulf.hansson@linaro.org, rjw@rjwysocki.net,
        agross@kernel.org, ohad@wizery.com, mathieu.poirier@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, rishabhb@codeaurora.org,
        sidgup@codeaurora.org
Subject: Re: [PATCH v3 05/13] arm64: dts: qcom: sc7180: Use QMP binding to
 control load state
Message-ID: <YNZMHGYTXV5oJLI7@google.com>
References: <1624560727-6870-1-git-send-email-sibis@codeaurora.org>
 <1624560727-6870-6-git-send-email-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1624560727-6870-6-git-send-email-sibis@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 12:21:59AM +0530, Sibi Sankar wrote:
> Subject: arm64: dts: qcom: sc7180: Use QMP binding to control load state

nit: s/binding //

> Use the Qualcomm Mailbox Protocol (QMP) binding to control the load

ditto

same for other DT patches if you re-spin

> state resources on SC7180 SoCs and drop deprecated power-domains exposed
> by AOSS QMP node.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
