Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6685B45A617
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 15:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238309AbhKWO4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 09:56:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238312AbhKWO4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 09:56:35 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CF5C061748
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 06:53:27 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id k4so17247394plx.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 06:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=maDqwh1X8f7cSN0fnXGtc0hBKQIUGOLhEANsObWEWYQ=;
        b=j7P+vUaj6aapj1yh5efgw2hxrBEpwYJQ/NIyhVl5ysZ50e7lmC8FnMm402n/fHYemt
         R7wna6zNxRo1dJCDMhLhwWXF9qU1DcmK9Of9R54tC9qRtduLv9HnKPl4B7Yvy6yzkvHw
         14Ioc8TcdAM230smUcxAXob7ulehMN/1vIsdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=maDqwh1X8f7cSN0fnXGtc0hBKQIUGOLhEANsObWEWYQ=;
        b=oOJEF7L82xzGk/DPu8+pRLczWpinw+Ta4Lq46EVk7NZCw0FNGdi0LwN/v5RWvCkvrf
         Ff3wGCtcIdSYVovgGZ5+sA66Y/IHWNlkMKzWdCnuyovyiLDdFdQ2tZYcV0S3cBVuj288
         e5sM1Is/iQkCG/x2ZlHZj3vSUsUdrd6GbgbDSVCV9VwX1XNLYEBESQEy2AkBtpt4Brkp
         QfK8Y2suiMbAan77FcKjC/urxELv5wk/nI8i4rgZ9IOGz3yjwYcaAVq1ypFJKA963Shw
         FBWjFLekrMnXSFzzAyWWgnZ7OxmsQim/omKg2eHA24Z/tJWrR9PRd0v3r4x/TMgipoQW
         6/uw==
X-Gm-Message-State: AOAM5309RtbT01AfT6dArhG1rS/ft5/QfIRQOpNMy4yYb1QX4oMzqnPN
        3gw+BdoCxoEpf0kCvAdfHb2H2fa8eqaitg==
X-Google-Smtp-Source: ABdhPJzgy0vfyZ/bqcSxJYg6gCR8GQcLKZassfIXV5fVSVKubGoI/Dp6S2mc9J2JGpncofFsDCDpkg==
X-Received: by 2002:a17:90b:4c89:: with SMTP id my9mr3585722pjb.229.1637679206572;
        Tue, 23 Nov 2021 06:53:26 -0800 (PST)
Received: from localhost ([2620:15c:202:201:5fa5:d920:9d68:9c16])
        by smtp.gmail.com with UTF8SMTPSA id p188sm12693118pfg.102.2021.11.23.06.53.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 06:53:26 -0800 (PST)
Date:   Tue, 23 Nov 2021 06:53:25 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sboyd@codeaurora.org,
        dianders@chromium.org, kgodara@codeaurora.org
Subject: Re: [PATCH 1/4] dt-bindings: arm: qcom: Document qcom,sc7280-crd
 board
Message-ID: <YZ0AZQDB6VPUAt8s@google.com>
References: <1637650813-16654-1-git-send-email-rnayak@codeaurora.org>
 <1637650813-16654-2-git-send-email-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1637650813-16654-2-git-send-email-rnayak@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 12:30:10PM +0530, Rajendra Nayak wrote:
> Document the qcom,sc7280-crd board based off sc7280 SoC,
> The board is also known as hoglin in the Chrome OS builds,
> and given there would be multiple (at least one more) rev
> of this board document the google,hoglin-rev0 compatible as well.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index c8808e0..2abfd28 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -203,6 +203,8 @@ properties:
>            - enum:
>                - qcom,sc7280-idp
>                - qcom,sc7280-idp2
> +              - qcom,sc7280-crd
> +              - google,hoglin-rev0

I think we also want the generic 'google,hoglin' compatible string, analogous to
for example 'google,lazor' and 'google,lazor-revN'. For lazor there are no
explicit compatible entries for rev3 and above, there were no DT relevant
hardware changes for rev > 3, hence the 'google,lazor' compatible string is
used, without the need to modify the DT for each new HW revision.

Also on my CRD the bootloader thinks it is running on a rev4:

  Compat preference: google,hoglin-rev4 google,hoglin

The board still boots thanks to the 'google,hoglin' entry in my device tree,
but it seems you need to add more revN entries, or start with rev4 if you
don't really care about supporting older revisions. In the later case you
coul only have 'google,hoglin' for now, and add 'rev4' when you add support
for the next revision (supposing it has DT relevant hardware changes). The
sc7180-trogdor boards can serve as an example on how to deal with board
revisions.
