Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 133E24007D3
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 00:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350144AbhICWR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 18:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235919AbhICWR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 18:17:58 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD37C061757
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 15:16:57 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id t2-20020a4ae9a2000000b0028c7144f106so118128ood.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 15:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=gyxxsdZLj8EDyZ8pMKsT8E9AIC0KIFdqfoCQ/9/VW7s=;
        b=KzKWTzHJKM0GKba56YF5OciltCPo9hSKK8f5cpEKMtbsG9tWyvJJGHkeT6PSfXQ2TN
         b1Ap77GzvCJpOaZ6+t7kiXTbDUsBwqHylC5VC7qzcLwLId5gKVHxIAUiiHWe+YGotf+q
         TOt4BjbM9gaM0JxQ2MbNsexxH40Xp8tGP+7II=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=gyxxsdZLj8EDyZ8pMKsT8E9AIC0KIFdqfoCQ/9/VW7s=;
        b=tAaM9HstF2QGfQovqTbN3uSgN7D6griX2FlYBjttlFzjcdYKfb/6Xjn+xNQxDdJtm+
         hbpqQvo1Ye5m8641FFh1Fqm9U2PXFAY7l3BbJoFNUwgZCYel3yosx4/yO0ct8sHnRI3i
         czOjbzwDmvRtbdtaMXZCjxy0S4WgZ/ob0CVsSUlv4Anzz2NSbpAzsc/5wMP3axSjaMeF
         BFPmfvynmThT+Uq1X4YQpOFmphL/9YKxhD96IqWSuEdQUWxmPblSehLoat0nuzdbZe2O
         qmGHaOrr6iRBfqkIkp9qPxFhMb9/QJe44qgATu76b0KmtCumZL06qYHTZG+1j++q/aNM
         E1FQ==
X-Gm-Message-State: AOAM530bvp0XF78I/ZGTrYX0vXOrXJkQcZNJJIMXBBNLG+hPJBXWEm2b
        reMSfJ2zlcZ4js5GC7vBUh0ng48DdM9lKAT9KnGl6g==
X-Google-Smtp-Source: ABdhPJxWPP+fblb2lSlYDuskdZ7Ww49r0yeIcSQUmfZQvLdpLnGscWBy3tt3mJcdzD7/hJtBMIyVBzoxRJdl9jX/D5A=
X-Received: by 2002:a4a:a98c:: with SMTP id w12mr4727929oom.29.1630707417219;
 Fri, 03 Sep 2021 15:16:57 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 3 Sep 2021 18:16:56 -0400
MIME-Version: 1.0
In-Reply-To: <20210903122212.v2.1.I9777d0036ecbb749a4fb9ebb892f94c6e3a51772@changeid>
References: <20210903122212.v2.1.I9777d0036ecbb749a4fb9ebb892f94c6e3a51772@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Fri, 3 Sep 2021 18:16:56 -0400
Message-ID: <CAE-0n50WDf21qkLpEynUJ4mQChLrK-2EhUaroE96spQ45JBqpA@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7180-trogdor: Delete ADC config
 for unused thermistors
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Kaehlcke (2021-09-03 12:22:19)
> The charger thermistor on Lazor, CoachZ rev1 and Pompom rev1+2 is
> either the wrong part or not stuffed at all, the same is true for
> the skin temperature thermistor on CoachZ rev1. The corresponding
> thermal zones are already disabled for these devices, in addition
> delete the ADC nodes of the thermistors.
>
> For Lazor and CoachZ rev1 also disable the PM6150 ADC and thermal
> monitor since none of the ADC channels is used.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
