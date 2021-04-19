Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10DB9364E82
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 01:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbhDSXRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 19:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhDSXRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 19:17:09 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C5BC061763
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 16:16:37 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso21273636pji.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 16:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2Nn+bx3z3IH/fvn/wdBQFxz9EywfufvNV/uaVoGNRIs=;
        b=H/ehNs8JBaw6VgbwkwwqUfO7KAnsmnSe+T79rwAaqAy7lVvc+ugoSklGAn9LnOuRbR
         GItdwdDsjaFI0sxhBKzdl384oHBZ2yyyuxKTMlFd/LMopfTjJGjefwqZeWvKw+cEs18c
         jClmRszon64YIFYl3LkQ8tXvrJInJ03xZps1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2Nn+bx3z3IH/fvn/wdBQFxz9EywfufvNV/uaVoGNRIs=;
        b=Z8+K8ddnHSyE9letZ2POYwhZCA2Fpwr40Un3lxw4X3ukbjsJXDHOQ9m8IWhPzV18Sz
         FoVSXqNNRy0YiMbuus7U6BRWwcA3She6vf/o89p0Mc/5jSVmYhOlT6MOi0aiRRuWS8YL
         ebb8HrF3NwYbFw69r3bdI1EcoE9fS4nRcf5aaC31Rtu/So6tUTqAQX0uXvh6xtc2zG0L
         T+Aoz0/8suVUBV5LYg6C+8dnK21etYkJCWTAP+At3fymTHTzMBnjE7Enk7lNIG8EiJT4
         /LxRAmq5WLREGCbZ7m4unVU3oDXmJ6/CLoSdtyGrQ5gcnpEnCXQrQvOPM2d2TBZDY0kf
         G52A==
X-Gm-Message-State: AOAM531MZbDZH2fL6P5ocCJI4aid+70su94KR741H/voRPNRXP7lS25G
        fqoAj3ADvMtRUHS1bsBuFiMERA==
X-Google-Smtp-Source: ABdhPJy2CnJJSicWFXTdXMyqLIe+s0lBqamEvdEG3F0hrjwV4vfCNPKV37k1j8mvY/cJ3ks6pPR1/g==
X-Received: by 2002:a17:902:8202:b029:ec:b398:6d73 with SMTP id x2-20020a1709028202b02900ecb3986d73mr2322459pln.37.1618874197230;
        Mon, 19 Apr 2021 16:16:37 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7401:678f:e510:6700])
        by smtp.gmail.com with UTF8SMTPSA id n39sm10545601pfv.51.2021.04.19.16.16.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 16:16:36 -0700 (PDT)
Date:   Mon, 19 Apr 2021 16:16:35 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sandeep Maheswaram <sanm@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Manu Gautam <mgautam@codeaurora.org>
Subject: Re: [PATCH v6 2/5] usb: dwc3: core: Host wake up support from system
 suspend
Message-ID: <YH4PU6O+dlnF1y35@google.com>
References: <1618567313-25373-1-git-send-email-sanm@codeaurora.org>
 <1618567313-25373-3-git-send-email-sanm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1618567313-25373-3-git-send-email-sanm@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 03:31:50PM +0530, Sandeep Maheswaram wrote:
> Avoiding phy powerdown when wakeup capable devices are connected
> by checking phy_power_off flag.
> Phy should be on to wake up the device from suspend using wakeup capable
> devices such as keyboard and mouse.
> 
> Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
