Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07073DF52C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 21:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239454AbhHCTN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 15:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239440AbhHCTN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 15:13:56 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FF8C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 12:13:45 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d1so274131pll.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 12:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=51jbt1FVT8IlO6u6Cwrs29BEgDlHbe6XQ3u3nFa/JfM=;
        b=ad2Yhve4zPtnMlQA1kQYZvgF/VOj4cc3VR6lgNzpoTCOSNd8h91YOig3aVFrlNOlba
         dQD4tBLo15gSXN6IpWWIGkJh+xMc947AR/PbIe6sv+qGLnv8n0DwTiQsNfgHeVdGTxYj
         dn/MeQ1UbBT14RiwYG82GP70rlJwO7Y54T0Xw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=51jbt1FVT8IlO6u6Cwrs29BEgDlHbe6XQ3u3nFa/JfM=;
        b=ndAThyxNZldmUuCb44Ug9Nt6zNeEboZlaCJUevS/ChGfj83B6UoKcZbAUrYPl3leaK
         F0iehg579IY83H2LCbhmyO0TkliXlhANVVhKHoSR76Z4mlDzihoGC68c7xBJ0pEOp8mA
         3t7l0DY3sXuN2XsXDcLB5KcOKHNVD+zPUsZ94LQtSfvB9ZyvG5yh/WI7OqA7xekoSGOz
         8lYzkZYvES1HhQ7kRmdFbHAduGCPPnUtcr7bQB24N5aBRK/weolZFGcT64ZDd58V2ueb
         0UGzcST0aNOJ+UFDkZzr08IEhGTy89luigKaNT0eTOStmsw8DdHEHESlCKwyFWc64RMT
         6AxA==
X-Gm-Message-State: AOAM533JFHciuY8YiAthD+ThnCenPt5gJHyGiqYRyPJIGotp46n+HbsF
        giJiVDEM/R4i+ngrywNQbwT2gQ==
X-Google-Smtp-Source: ABdhPJwEEsxEiREkDX7Q13hRVmVm5y2g4E2WGMU7w7iJxiCZoPqfwWG/qUn0MjYFfkB6dhrzfE2h7A==
X-Received: by 2002:a63:d104:: with SMTP id k4mr1253803pgg.196.1628018024608;
        Tue, 03 Aug 2021 12:13:44 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:9afe:3b52:1da2:825d])
        by smtp.gmail.com with UTF8SMTPSA id q14sm16600910pfn.73.2021.08.03.12.13.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Aug 2021 12:13:44 -0700 (PDT)
Date:   Tue, 3 Aug 2021 12:13:42 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sandeep Maheswaram <sanm@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pratham Pratap <prathampratap@codeaurora.org>
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Add interconnect properties
 for USB
Message-ID: <YQmVZk42Fq+7GMST@google.com>
References: <1627880576-22391-1-git-send-email-sanm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1627880576-22391-1-git-send-email-sanm@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2021 at 10:32:56AM +0530, Sandeep Maheswaram wrote:
> Add interconnect properties in USB DT nodes for sc7280.
> 
> Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
