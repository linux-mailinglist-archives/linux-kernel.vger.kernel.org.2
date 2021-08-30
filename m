Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8177E3FB948
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 17:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237661AbhH3Pww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 11:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbhH3Pwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 11:52:51 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A47C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 08:51:57 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id x19so5540528pfu.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 08:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uXT7A/l6L3b7KWJXeBUvP34+lDTxoCEzcItWSXZkL8g=;
        b=FCgOaTZ/pO1kggtnC0wWNTAVX4lrtWHKauBQPlgOt2qFBMgvhh/YBoKx0LI76pFUAT
         na9Le64L/5IcziN2Z8y0dBHwwRTxf6kee/9gv/UX5sHx314IlBfU/ZpanSdHV9EVskyP
         Hj78y2m1UWC+2UJLg3ddk9zWDXliasQWq9GAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uXT7A/l6L3b7KWJXeBUvP34+lDTxoCEzcItWSXZkL8g=;
        b=pnLVOLiyoS0niVTrcOVxbbif7IwVykP7dFQmMX8jlapBRUeDdGw74250OWRAH2Lp92
         zhmiD5bkiqgWFj0f3/OmIMYimUhiTj5+Z1l4MJoQJkQgAgBARXtEyUmL/l0BlJoNWRDW
         4BbqEz9llHp+8gO0eNCUFWOrVS9iKCiuqd7Rm5xjeOGBvUaj40VsByragO17MgM/6icL
         swqRVlYzYMZdEMCmB5yarymyEc0xCglk47t3iNuJ9OswnlWKGyWGlGUjV81Ud+/Emg6i
         WhA3L8aH3r0fzfBYcEdab771dNrr2BzOZLIo511atnOT4AcjzihIqieE53GGj8CaTYMJ
         2bSg==
X-Gm-Message-State: AOAM530Ci+lsK8iDBcmm9iaQNUbZ90EeM+jqymphISrocGwjL6NYEXez
        b65bc4STWDAjwffrFISb8fB8hQ==
X-Google-Smtp-Source: ABdhPJwg4nU87p1CD63IyGPktFv+S5MI16lzovEjLVwZh64w9yph7OuEAWpqk9vtAGhODlhsu0F3Eg==
X-Received: by 2002:aa7:8b07:0:b029:2f7:d38e:ff1 with SMTP id f7-20020aa78b070000b02902f7d38e0ff1mr23964901pfd.72.1630338717477;
        Mon, 30 Aug 2021 08:51:57 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:8f95:c27f:f5d8:9315])
        by smtp.gmail.com with UTF8SMTPSA id i20sm15537076pfq.35.2021.08.30.08.51.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 08:51:57 -0700 (PDT)
Date:   Mon, 30 Aug 2021 08:51:54 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     bjorn.andersson@linaro.org, sbhanu@codeaurora.org,
        swboyd@chromium.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Move the SD CD GPIO pin out of
 the dtsi file
Message-ID: <YSz+mlfJuWeFhSum@google.com>
References: <20210830080621.1.Ia15d97bc4a81f2916290e23a8fde9cbc66186159@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210830080621.1.Ia15d97bc4a81f2916290e23a8fde9cbc66186159@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 08:06:37AM -0700, Douglas Anderson wrote:
> There's nothing magical about GPIO91 and boards could use different
> GPIOs for card detect. Move the pin out of the dtsi file and to the
> only existing board file.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
