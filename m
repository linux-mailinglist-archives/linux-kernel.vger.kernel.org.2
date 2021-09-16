Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF63640DDF7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 17:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238967AbhIPP3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 11:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238925AbhIPP3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 11:29:23 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454DFC061764
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 08:28:03 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id a15so8377686iot.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 08:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9PGyga+u2JMpsASTRDGCIEIQqGlu+knYZsympOND9rQ=;
        b=InU3QiCwubwJ7wJwH2fV9uC/toVkZlNbVLSyRxruFnAVHOXGg8qvphDFYNBNPGxhhe
         4mmIwTZtIsJwMy6F0zfAo1dq23wBKs4+xMPWb339vAePTt0htSMmm0NVpzhLB1T7WH6k
         ohYTSufm2x5u42lzIV0PUetLBqPuk6V88BKEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9PGyga+u2JMpsASTRDGCIEIQqGlu+knYZsympOND9rQ=;
        b=gXKSYcP5zk8fSnPHHfKW5tlUSmwbc5YaoMmw/nHcIURAP8b/R5zKvp5QhcetzBfjsp
         2ycJG3b1askJyE+mgU0+WwNExuTITzZL/R0B+94Z2cJnEU5f67M9an5970GtbpN1lrc9
         HEzR0RF/lV2EWbQ2Cvvo3+FsnnYw1/B5hfOJd35s7WoIteJ3Wbh3aCxENZhR5TVBJjp/
         Gqcb48ylnTCyIs8w4Yz1DhpIDNqEhN0pegV4Ao4mLyYQ9/5Kiu8RBehWPGuYiEK5Gpfa
         A4xK0lSq+80U8xwIbFn5qsqXfEt/A7OGoHJlCrO1CWGvjNYlIkmDod2rYnWpvVDHZOr2
         GUSg==
X-Gm-Message-State: AOAM532Aoz3txgt5HnkgKvl+YW28S713Hc3wUf7qqi7fcD6UPMe1rDec
        CcUPUAv7plDDBF1FBMDQ/uKny9PVkoV4Bg==
X-Google-Smtp-Source: ABdhPJzbxrQERB0l9/fkJ2oA/PeIUeEQLr0VpJA09vmvoo+y3L1zQa8omGJMCU+6lBiRYLktjDm8Vg==
X-Received: by 2002:a6b:3f54:: with SMTP id m81mr4805569ioa.184.1631806082526;
        Thu, 16 Sep 2021 08:28:02 -0700 (PDT)
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com. [209.85.166.180])
        by smtp.gmail.com with ESMTPSA id i20sm1776821ila.62.2021.09.16.08.28.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 08:28:01 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id v16so7037309ilg.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 08:28:01 -0700 (PDT)
X-Received: by 2002:a92:da0c:: with SMTP id z12mr4329512ilm.120.1631806081058;
 Thu, 16 Sep 2021 08:28:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210830080621.1.Ia15d97bc4a81f2916290e23a8fde9cbc66186159@changeid>
In-Reply-To: <20210830080621.1.Ia15d97bc4a81f2916290e23a8fde9cbc66186159@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 16 Sep 2021 08:27:49 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XSFHgUEo2BrEY+o7Vavd3jHcwSZ7hKgwYOTPSHhHaZAw@mail.gmail.com>
Message-ID: <CAD=FV=XSFHgUEo2BrEY+o7Vavd3jHcwSZ7hKgwYOTPSHhHaZAw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Move the SD CD GPIO pin out of
 the dtsi file
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Shaik Sajida Bhanu <sbhanu@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 30, 2021 at 8:07 AM Douglas Anderson <dianders@chromium.org> wrote:
>
> There's nothing magical about GPIO91 and boards could use different
> GPIOs for card detect. Move the pin out of the dtsi file and to the
> only existing board file.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 1 +
>  arch/arm64/boot/dts/qcom/sc7280.dtsi     | 4 ----
>  2 files changed, 1 insertion(+), 4 deletions(-)

If there are no concerns with this patch, I think it's ready to land
now. Thanks!

-Doug
