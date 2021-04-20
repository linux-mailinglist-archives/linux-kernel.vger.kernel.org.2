Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D16365E50
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 19:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbhDTRQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 13:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbhDTRQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 13:16:36 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA33DC06138B
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 10:16:04 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id e2so15724461plh.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 10:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=irTmuEe2pRr0Rl3uOVQJ+XhzXrvVBN56ZxLdfK0T+Z8=;
        b=SCqmMaRSS1gGfkcJyngj89CG845AhRXkGK2F88BZk5KT1u/+c8BoliHPu42RtXIaml
         8iugl8CuYxLqemFK5aOFf5DZYEjC+eiO5TfkbqxtZxDATPZ+aYB+W14vHXDVKGgQE/P7
         wXRpK+/sPm8NdC1J6Hd0yPwtPFDMMpRQnxGFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=irTmuEe2pRr0Rl3uOVQJ+XhzXrvVBN56ZxLdfK0T+Z8=;
        b=Ey3Daj5p8Bpp3W/RIuwyllaCba/69kLsBBDZWS5oFzFmcrMOx6k4JJtLAjS8bBFlrE
         U2sipk8fOrxsjFrykN77JcsmyyEOdd804er6bNjilejbvppdsC1YT0TOwK10BVm1l+5O
         E5ilLMZt2ygTxCKgQXbIdC2xaDT0ysmU9gTTaZJPmno1OPRtt1n+xgYQUii/gkp/f1v6
         A+1cJ5dPwwWYaaSFgrgnSc18CgWjQGF3h2ocf3QxA1cCy0vMt+m6BOqUjdMRJzEVHWZC
         jZ6ALeCJi72sG4MpddCSGBb9o+JGudpvKBgFHgUploukxRzcgWZV/5ekxSiR2h075sY5
         Tz6w==
X-Gm-Message-State: AOAM533puyhrLhCmk1LiMhdJOYlzPnEH5CTTbwNf+IvB6fhDvaTQI8Mf
        B18EQwi+IxsSsPw9InYZrlEamA==
X-Google-Smtp-Source: ABdhPJzFEFl6Idin15/xKtXbEuWZIi6Nr1FUejohVJutVMscIDnw3HwfW6EcMFACHdsyzlselUTI3Q==
X-Received: by 2002:a17:90b:3646:: with SMTP id nh6mr6049573pjb.119.1618938964244;
        Tue, 20 Apr 2021 10:16:04 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7a9:7e56:e9c3:13e8])
        by smtp.gmail.com with UTF8SMTPSA id a4sm10234479pff.140.2021.04.20.10.16.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 10:16:03 -0700 (PDT)
Date:   Tue, 20 Apr 2021 10:16:02 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     satya priya <skakit@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kgunda@codeaurora.org
Subject: Re: [RESEND PATCH V3 3/5] arm64: dts: qcom: pmr735a: Add temp-alarm
 support
Message-ID: <YH8MUkYJdZbkuXt/@google.com>
References: <1618398783-7834-1-git-send-email-skakit@codeaurora.org>
 <1618398783-7834-4-git-send-email-skakit@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1618398783-7834-4-git-send-email-skakit@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 04:43:01PM +0530, satya priya wrote:
> Add temp-alarm node for PMR735A pmic and also modify gpio
> node to add gpio ranges and "qcom,spmi-gpio" compatible.
> 
> Signed-off-by: satya priya <skakit@codeaurora.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
