Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D40F93E03E0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 17:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238235AbhHDPF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 11:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237601AbhHDPF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 11:05:56 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA15AC0613D5;
        Wed,  4 Aug 2021 08:05:42 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id oz16so4213646ejc.7;
        Wed, 04 Aug 2021 08:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=apXako6tqUazW99r8dSb/XUslxRiTi4p8nrGsfYfU48=;
        b=UgQ6w8r/cPCgyzxk3fq0RxMllPR0/FM6lcrW/uG7TxyIkyfFYfmpcMNiaKQaq6iNqI
         /p94ftzRdCS/WIjtGrBgczmg1N1Lr/jmo8cNLVaWwQ6zqEgEhcVNKJJHvKaVXmImBUaU
         KIjP9O114HdwkyBS0Xo+zYXR3/YEXqiPurlrgfPahK6kMZL3IW99s/3WETsShna2x9Gm
         3GYpvFrMMkrelXP5zUN/mt8h/QHn/F9iGbS/6rywnPh91KM1M/D8VUuucjaXAj5mp3hP
         IgyCR6GZf1Rm1KxKOytcUiVRUtkMiYV+lxHEvh71H+UMqMDMlLmIEf9xfIZxSOG5s08e
         TOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=apXako6tqUazW99r8dSb/XUslxRiTi4p8nrGsfYfU48=;
        b=jWThtdBO7hFCl6z15sHk/QpMNvoKMg5qrbVnzVPIBtRU7rnSQSJdTuIUrT/eg9CrgN
         l2JAPaDnRTo79c//o7bVFCMuoybiiVn1LKbsQG9m/BQWUJTQUf+vCernTVbU05uXtefu
         sPRSDcwBG5m9orD8i6CTRgB7R2AJAndUkmQFHb+ILJh7pPK7qyaxORQjbeFFW7o4yCXH
         RUyIFJpucJhE1Z/cV5Pp59sd8sUMjOlenkQYwuNdhHAI8cVRBWELPn7L2LMAqP9zv7OJ
         PFlSxrNz+4D4QZxeaVC+9/9PcbcUOG2PvJQWQovTl2yTYN/mXpB0s0woNJ8TVRldSEfI
         RCCg==
X-Gm-Message-State: AOAM531QiEP/qhcYNliyO7/1/2EZU5tlYnySSBVcoghYy9E7AsXW3Iby
        mqre80KurR5yrjlSVLgddrY=
X-Google-Smtp-Source: ABdhPJyDlAczSHhxndS5VvIC4kSrfYdJcP9gF+zKKIC0cnlhgK1rvxgZeRGiTG+Mlki6bDtvh1uOEg==
X-Received: by 2002:a17:906:260e:: with SMTP id h14mr26075850ejc.258.1628089541336;
        Wed, 04 Aug 2021 08:05:41 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id h19sm1074852edt.87.2021.08.04.08.05.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 08:05:41 -0700 (PDT)
Subject: Re: [PATCH v2 4/7] arm64: dts: rockchip: enable io domains for rk356x
To:     Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Simon Xue <xxm@rock-chips.com>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Zhang Changzhong <zhangchangzhong@huawei.com>
References: <20210804130625.15449-1-michael.riesch@wolfvision.net>
 <20210804130625.15449-5-michael.riesch@wolfvision.net>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <6f557e45-075f-9a12-f603-cec8a4dc28a6@gmail.com>
Date:   Wed, 4 Aug 2021 17:05:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210804130625.15449-5-michael.riesch@wolfvision.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

pmu_io_domains is a sub node of pmugrf, so add it to grf.yaml as well in
a separate patch. Place document changes before driver patches for
checkpatch scripts (undocumented compatible string):
./scripts/checkpatch.pl --strict <patch1> <patch2>


  - if:
      properties:
        compatible:
          contains:
            enum:
              - rockchip,px30-pmugrf
              - rockchip,px30-grf
              - rockchip,rk3228-grf
              - rockchip,rk3288-grf
              - rockchip,rk3328-grf
              - rockchip,rk3368-pmugrf
              - rockchip,rk3368-grf
              - rockchip,rk3399-pmugrf
              - rockchip,rk3399-grf
==>
              - rockchip,rk3568-pmugrf

    then:
      properties:
        io-domains:
          type: object

          $ref: "/schemas/power/rockchip-io-domain.yaml#"

On 8/4/21 3:06 PM, Michael Riesch wrote:
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> ---
>  arch/arm64/boot/dts/rockchip/rk356x.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> index 3e90a8832bb9..834863940eba 100644
> --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> @@ -203,6 +203,11 @@
>  	pmugrf: syscon@fdc20000 {
>  		compatible = "rockchip,rk3568-pmugrf", "syscon", "simple-mfd";
>  		reg = <0x0 0xfdc20000 0x0 0x10000>;
> +
> +		pmu_io_domains: io-domains {
> +			compatible = "rockchip,rk3568-pmu-io-voltage-domain";
> +			status = "disabled";
> +		};
>  	};
>  
>  	grf: syscon@fdc60000 {
> 
