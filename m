Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF392424486
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 19:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbhJFRle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 13:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237771AbhJFRl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 13:41:29 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4413CC061760
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 10:39:37 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id nn3-20020a17090b38c300b001a03bb6c4ebso486529pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 10:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0wxSw7qisVOunDrqS7f7e7Lry8Q/2GqOFqAP3EHViQE=;
        b=COvDgniH8rLSITY0sop34UzfIg0DlqGltWATNZ0SwKM8ra7XKVYwhSswDmjxFfnWoB
         jkXyQ5g81nWBtjk9JV9iBqWz6bjMkkUx6Btx/pafmHt7Yp0WycPstzVublfXjLC38/A/
         rVbo6bpML3Fd6rqS7mWwENRjEw5Mz+bU6Y8+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0wxSw7qisVOunDrqS7f7e7Lry8Q/2GqOFqAP3EHViQE=;
        b=lQFcp8F5RLMdf0HPS6jyyIKhwJ0ct64R+uJVC9QaXWqZXXwH5ktKooWX21MGJiqcwK
         SgMk8BNtXL3r9pWPKPv4SnjBt+a4YRp7LMWMoBBVNJUpIov8lTHkueEnM+3ncdPmL9xr
         NS9xUxCrxl5IWgDCLEqQaVcZasy/hmaD4sqefn5+YxBGqw0hGzht2l6at5o2YcwRERbj
         ButNMMNf3jQZfypqLtZSvt2LidCl5FR6fUiTAYkcxTssdpizRHeugh77ZKRceKUJLYx8
         /PC2PNdbQYQ/nPIBzYCLcn4i9UCr778FQIzpuX0jmS/Pc6d0es6q3WvHXqZDNmH1lk3x
         XKbg==
X-Gm-Message-State: AOAM530SOp+CQ44TzrtcUq2KgZ4//n6vlOLsOgEh2K/7BQsIPbhiV6d3
        UNNXP7TNTcsne+ANqkqO13k2tg==
X-Google-Smtp-Source: ABdhPJwcHEgZhjlJeUc2eGnkpbuDa8JMMBuwvTTpop0E/nxpp6bhbr/QT6/qllxHfPV3wROn0Dgjbw==
X-Received: by 2002:a17:90b:390d:: with SMTP id ob13mr38595pjb.50.1633541976756;
        Wed, 06 Oct 2021 10:39:36 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:a463:ae21:d1fc:ddfd])
        by smtp.gmail.com with UTF8SMTPSA id 11sm20751156pfl.41.2021.10.06.10.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 10:39:36 -0700 (PDT)
Date:   Wed, 6 Oct 2021 10:39:34 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, bjorn.andersson@linaro.org,
        johan.hedberg@gmail.com, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, rjliao@codeaurora.org,
        pharish@codeaurora.org, abhishekpandit@chromium.org
Subject: Re: [PATCH v1 2/2] arm64: dts: qcom: sc7280: update bluetooth node
 in SC7280 IDP2 board
Message-ID: <YV3fVjd5ngQhuA4K@google.com>
References: <1633523403-32264-1-git-send-email-bgodavar@codeaurora.org>
 <1633523403-32264-2-git-send-email-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1633523403-32264-2-git-send-email-bgodavar@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 06:00:03PM +0530, Balakrishna Godavarthi wrote:
> Subject: arm64: dts: qcom: sc7280: update bluetooth node in SC7280 IDP2 board

Not super helpful, what does 'update' mean?

It might be easier to have a single patch for both IDP boards, since
the Bluetooth node is added in the common sc7280-idp.dtsi board,
rather than explaining what this patch does :)

> This patch updates bluetooth node in SC7280 IDP2 board.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-idp2.dts | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp2.dts b/arch/arm64/boot/dts/qcom/sc7280-idp2.dts
> index 1fc2add..5c8d54b 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp2.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp2.dts
> @@ -15,9 +15,15 @@
>  
>  	aliases {
>  		serial0 = &uart5;
> +		bluetooth0 = &bluetooth;
> +		hsuart0 = &uart7;
>  	};

Sort aliases alphabetically

>  
>  	chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
>  };
> +
> +&bluetooth: wcn6750-bt {

&bluetooth {

> +	vddio-supply = <&vreg_l18b_1p8>;

nit: if it's not really common across IDP boards or a default, you could
leave it unconfigured in sc7280-idp.dtsi, and set in both board files.
Just an idea, with only two boards it doesn't really matter too much.
