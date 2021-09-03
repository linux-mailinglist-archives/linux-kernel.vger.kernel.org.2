Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD770400571
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 21:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350582AbhICTCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 15:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239381AbhICTCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 15:02:54 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012F1C061760
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 12:01:54 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id r26so382098oij.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 12:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=SAzTnDcToUqmXsOS2Uqx6HjGpLJFdTeJaBGrr8ePieg=;
        b=fSkxncCTXR86TbzQCb1xW3s3xdTOMGyzfpctNNQvoRpmZfwq31/TpHnE/hSrh4lTKc
         u/GXxXKV+drF9Ekhf3KgE/0m/nVdmc3bhnB4f+1uGv/0b1bm6BzpYJQX4KVSDguVznhC
         pJsvND2WcJlJQ6YF6Dh/K2w26+jRkJwihxwys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=SAzTnDcToUqmXsOS2Uqx6HjGpLJFdTeJaBGrr8ePieg=;
        b=XF7VrCmaeG1237nAhzLp6LESXUCg2F0KtzcUS/5zueqPnGrS/EH9RRSbl5HFDEs7lS
         aMTXzSrO7PcF55laHkPhX36BuPKeSdX63VViNw+43qPh1MwCrOIquCZa+60OXZofe5aQ
         ZC0hZTlZfUD9QL7SiXQwOZ16dO55HJT4B1OnXWq+mEWZsfEj43WPzlALxJzfki1sSV9h
         uG0tTQkFZiOv8997Y0o29soeg29m/EKsJszVVI6pYDdfnA2RXVsMEL+mJtj8IiXZv17v
         C7Tv7GadOiQVojFoNYubv2k3kovNOz6/+z4WxUD+/DkF2WD99O9vjeq9RSHgQmThbxhD
         d5gg==
X-Gm-Message-State: AOAM533Ykyk6em5sNFSSipG4l+0eDsjHUaPDcXhbdceCIM0ze8q/j2dk
        I9pV+l82/BhWG3Z/6V8Pii4oEI3EKR+S79Z/6XtFgQ==
X-Google-Smtp-Source: ABdhPJxnKzQ5AS2ZUhj+PB1HcygTeTEtePAdA7QZT6VkdQnPumBdxHtQCjSp+nbjz+D1bTV6KWEe4wqRrA61V8sjjoM=
X-Received: by 2002:a05:6808:909:: with SMTP id w9mr244302oih.164.1630695713356;
 Fri, 03 Sep 2021 12:01:53 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 3 Sep 2021 15:01:52 -0400
MIME-Version: 1.0
In-Reply-To: <1630643340-10373-8-git-send-email-rajpat@codeaurora.org>
References: <1630643340-10373-1-git-send-email-rajpat@codeaurora.org> <1630643340-10373-8-git-send-email-rajpat@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Fri, 3 Sep 2021 15:01:52 -0400
Message-ID: <CAE-0n51c1TdO3tw6dDd9Ai=j_0rvc_H6uTm5nQ1RoibF8+PcPw@mail.gmail.com>
Subject: Re: [PATCH V7 7/7] arm64: dts: sc7280: Add aliases for I2C and SPI
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rajesh Patil <rajpat@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, rnayak@codeaurora.org,
        saiprakash.ranjan@codeaurora.org, msavaliy@qti.qualcomm.com,
        skakit@codeaurora.org, mka@chromium.org, dianders@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajesh Patil (2021-09-02 21:29:00)
> Add aliases for i2c and spi for sc7280 soc.
>
> Signed-off-by: Rajesh Patil <rajpat@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
