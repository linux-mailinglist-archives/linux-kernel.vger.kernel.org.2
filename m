Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3E2325AA5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 01:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbhBZATr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 19:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbhBZATn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 19:19:43 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E47C061756
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 16:19:03 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id b21so5026878pgk.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 16:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EpLLhisLnKlrh/KO9qG6Kmzca1e22HdLGOqsO0hQAnQ=;
        b=fBWETq+7jgrQIAa83TLSvqi0KPX3lG6JPAJHk0fwJ4eH3Gu+mZPFs6265I5bcFUgxF
         8p5gAelIvilquUp5H302B78kywoBrfgvFq6tU6ZpFOuupGbmxAqYwryUHL/WNiqW9OPv
         dT5D5fTh+zlOdJloeJcKzeSGON15a4m3M9YcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EpLLhisLnKlrh/KO9qG6Kmzca1e22HdLGOqsO0hQAnQ=;
        b=lMuQdK1eh4Ovkfl+8skAhtANYtn1qCktCvMJ6m88GVyYa2nNoP0Y7EnOHieTZzFyJW
         YKtv6khBRvBtlyclQV22LO+hIlhwICEzdB52PJ+YLH1THBbceKVv84Pk8dfcQXXLeusL
         KYhYWFJjb3v1mJ9WapQBt7cDbEtBr+YVHHlpF2L9hVJMBUtrYdW51PP+umQczLlUZeHm
         k+KsF0nHV+yotDXEFfRaG88sMGHO33V6nCJdyv5oXe8QruCeO4auSHg5zophHu3+DRn9
         PzXb2OOuN/Wpje18fC4n2x3d91TcjMR94bb7wynb1wZr63TtaQdln5cQ7tWv6mQYzkoa
         H6RQ==
X-Gm-Message-State: AOAM530NHwTlHLVv9Af41uwgyeXgVj++6ekPf2aRlF2y10vvGN/L9iMl
        UuwCXgoAhcoRIcseIm3SlmK38g==
X-Google-Smtp-Source: ABdhPJzd0qB647RFl4SgkXhkXemEci3xzGR+wupLWWkZdHLdouVqp6NgBRHSdXVEgyYNrl7nOKiaXA==
X-Received: by 2002:a63:4c4e:: with SMTP id m14mr444952pgl.35.1614298742500;
        Thu, 25 Feb 2021 16:19:02 -0800 (PST)
Received: from localhost ([2620:15c:202:1:1d8:8d0c:f75e:edd8])
        by smtp.gmail.com with UTF8SMTPSA id d16sm6700471pgb.12.2021.02.25.16.19.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Feb 2021 16:19:02 -0800 (PST)
Date:   Thu, 25 Feb 2021 16:19:00 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/13] arm64: dts: qcom: sc7180: Remove clock for
 bluetooth on Trogdor
Message-ID: <YDg+dCuGd+v2z+3S@google.com>
References: <20210225221310.1939599-1-dianders@chromium.org>
 <20210225141022.8.I80c268f163e6d49a70af1238be442b5de400c579@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210225141022.8.I80c268f163e6d49a70af1238be442b5de400c579@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 02:13:05PM -0800, Douglas Anderson wrote:
> From: Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
> 
> Removed voting for RPMH_RF_CLK2 which is not required as it is
> getting managed by BT SoC through SW_CTRL line.
> 
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
