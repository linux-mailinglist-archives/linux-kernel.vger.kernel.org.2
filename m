Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C9C325A9C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 01:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbhBZAPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 19:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbhBZAPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 19:15:07 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019BBC061756
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 16:14:26 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id w18so4165333plc.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 16:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t5Tx8qzAGRdcQ2gmkEYPbKCMvJxAeBL6qgOAKP9fKGU=;
        b=cWRh7XlrmQoiEK9V35F5Sighdgg1B6ZWBMYb8WOTqp6u/6ES+cWSpw45foFT/oC+SX
         kRb5uLTxKYWP5m1B3Dl4LYFkggl6hXU6jYw8UmIy6f+BX0qYTyn+A19MSX3hAzAQIqt7
         w0LPAXgsDksKAVS3WygptduHByMspBlf9TfCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t5Tx8qzAGRdcQ2gmkEYPbKCMvJxAeBL6qgOAKP9fKGU=;
        b=WOZ0ZeRqGVVr7ZmXlHlND6kR49LTItyR1axhrqRZt6a2mefhni2VDQV8LQIlpHA+ab
         PWU7Wz3r67KjG1Z/EKAhMwpUJtlpoukBbGMKoGjgn7YbGg9pgMbNcPBJ81ztDHALfhi0
         xNkBvQzfv/O2Hb9UOtwBGxKHMC0XHY8wguOjdIA62wTLtBB+oU8J3I8fci6aA9MJWN8p
         yc+VRX14Tgh+bTO0NP9rC/FuB5NzgjoRitQvNwqS1P2lxfGVpmVdLnW3TBTTbBOgrOIT
         A+iOmFSbK+YJPvsJmY+MaV+Bo76US08FGA8HqBjkDi6T8lUhNUnij7D354JZQDJc9V0r
         ndcw==
X-Gm-Message-State: AOAM533H1u3hOojnUE1Ee1j2wFD/Nb4ofG+rXe835FeFxST88ygEVdpR
        SgNm3P8xhF1X54u5JnEykB3yLw==
X-Google-Smtp-Source: ABdhPJx+9YFltAfwB23VYZRClbAzTjGptdp7e24cW6OWDX163Sic4V2g7sD4eTerWoNSlJVpseHqBA==
X-Received: by 2002:a17:90a:3f10:: with SMTP id l16mr437327pjc.131.1614298466387;
        Thu, 25 Feb 2021 16:14:26 -0800 (PST)
Received: from localhost ([2620:15c:202:1:1d8:8d0c:f75e:edd8])
        by smtp.gmail.com with UTF8SMTPSA id n4sm7360801pgg.68.2021.02.25.16.14.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Feb 2021 16:14:26 -0800 (PST)
Date:   Thu, 25 Feb 2021 16:14:24 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        Craig Hesling <hesling@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/13] arm64: dts: qcom: sc7180-trogdor: Remove fp
 control pins in prep for coachz
Message-ID: <YDg9YDMWSywwM5aS@google.com>
References: <20210225221310.1939599-1-dianders@chromium.org>
 <20210225141022.7.Ifd7b86f826b18410eada75758a7bca1eebfa336d@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210225141022.7.Ifd7b86f826b18410eada75758a7bca1eebfa336d@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 02:13:04PM -0800, Douglas Anderson wrote:
> From: Alexandru M Stan <amstan@chromium.org>
> 
> Removed the pinctrl and pin{mux,conf} for the control pins because:
> 1. The only need for them is for userspace control via flash_fp_mcu
> 2. cros-ec doesn't know what to do with them, and even if it did,
>    it would interfere with flash_fp_mcu at the most inopportune times
> 
> Since we're not using hogs, we rely on AP firmware to set all the
> control pins correctly.
> 
> Cc: Stephen Boyd <swboyd@chromium.org>
> Cc: Craig Hesling <hesling@chromium.org>
> Signed-off-by: Alexandru M Stan <amstan@chromium.org>
> [dianders: adjusted since coachz isn't upstream yet]
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

We have essentially the same patch downstream, so I suppose the AP FW
indeed takes care of configuring the FP pins as needed :)

Reviewed-by; Matthias Kaehlcke <mka@chromium.org>
