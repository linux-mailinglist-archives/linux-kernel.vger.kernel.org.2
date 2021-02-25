Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A69325A74
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 00:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbhBYXzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 18:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbhBYXzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 18:55:09 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D93C061756
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 15:54:29 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id a24so4105934plm.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 15:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UQRIGCJK5x7ySU3vx8Tp0a7FyRJZhibSQ4iPFDuTP+U=;
        b=nkSfKKn0KnJgtZOKoWyDau4D0wlh84SMf+eKx1ewJT9hFNJPqETdVZBlyFe3qwtsyZ
         Gx0BRgxrSr8VKhHbuBqLLmIN6/6L9870rLfCVpw/VwqW8I12ptSkMihBFtNbH/H4EDYJ
         YvDIvpfm1XO+NiEsYODy/Ncw1yOHGeiQaavLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UQRIGCJK5x7ySU3vx8Tp0a7FyRJZhibSQ4iPFDuTP+U=;
        b=PeqOeMF9AlFHvhMxMyKhEhP+zqI/bWbyh51t6qjVOgPpBG46lylL7sDpwFQsoncszB
         hDWe7HhEDdTRKxucFNSIdPSJDf4n8qrpB3AuOj27qvdL+dvJfNktzURsmj71uzf65YiB
         XmEVAPQ06aP/HCByL56IusmTZu+9qLyYndFy4h8vTsEEIorUdQcM6JNEBU48jv3s7V/7
         +YLCrDPylIQ6o7iFpU0PUh91FSBgo2FrhH84ljCBpVGynp47ziFavSTQL+oGL5zoVSaK
         mDs0IRbT0/ia3h4YnePw+ERRo7f0SdngZKihw0jInxx6hzEyW8e2AY4cELRJCpEIoegm
         /2xA==
X-Gm-Message-State: AOAM533BlNDhQ9a8sfptwRFa56g6RVx5Z/+zbX6SQjyBwTl84zv0kEbr
        vXCNwBvFjmCRHj8QNR977QPMog==
X-Google-Smtp-Source: ABdhPJyIbNkDyhS1zfCtYup+R53d86/NmhS/YrsWhF9FEPjKa9goIXV/1rKlXw3yL+6b8KU216GM3A==
X-Received: by 2002:a17:90a:f987:: with SMTP id cq7mr405575pjb.47.1614297269263;
        Thu, 25 Feb 2021 15:54:29 -0800 (PST)
Received: from localhost ([2620:15c:202:1:1d8:8d0c:f75e:edd8])
        by smtp.gmail.com with UTF8SMTPSA id nl9sm6848124pjb.52.2021.02.25.15.54.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Feb 2021 15:54:28 -0800 (PST)
Date:   Thu, 25 Feb 2021 15:54:27 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/13] arm64: dts: qcom: Prep sc7180-trogdor trackpad IRQ
 for new boards
Message-ID: <YDg4s6QuIIVe1oGR@google.com>
References: <20210225221310.1939599-1-dianders@chromium.org>
 <20210225141022.3.Iddf6dc8102aa4fbc3847936226fc7bf2e2cd315c@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210225141022.3.Iddf6dc8102aa4fbc3847936226fc7bf2e2cd315c@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 02:13:00PM -0800, Douglas Anderson wrote:
> The trackpad interrupt got renamed and also moved to a new GPIO on
> newer boards.  Let's do the move in the "trogdor.dtsi" file and then
> undo it in the two old boards.
> 
> NOTE: since none of the new boards have device trees yet, this change
> looks silly on its own but it will make sense after more boards are
> supported.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
