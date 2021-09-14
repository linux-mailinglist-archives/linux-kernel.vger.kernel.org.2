Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8733340B683
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 20:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbhINSG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 14:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhINSGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 14:06:54 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B5FC061574;
        Tue, 14 Sep 2021 11:05:37 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id t8so16632024wrq.4;
        Tue, 14 Sep 2021 11:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+1y8l2tNjfVvue0GuX0pU4hXK+xpXz6uowb3ztMXPXM=;
        b=lVX78cx2cu9BrWY/tMDofsnuzHJFq2TMG8Ky4M7BNgAAA3x8GrZbgFcOcHnhT0Dlk9
         CZG3gIeBPr9PQrCCJiN3B73jX1l5mXVhjhNtl0lXZctpsX9QN/qf6jb+x+WJ9i2onw5e
         TYsldgo7wemxEHewPYgD+8FsunBzv2rGD2GLOKzk0ZZuLmDwoTtNxr7xnknjW1GDfTub
         3UyWOs+CgPz3EbBfvxJtvvbxHw/0UfNJ+qa/iih66fGd4QbmGRgV52+2S/IqZCuCwoM6
         FZG2mhvPn+qwCxhEkRtLUxJq6B+u2wXUhZbvnRCSTaJZuRhvhsVbqF3qO5xXkKlB4OFu
         C0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+1y8l2tNjfVvue0GuX0pU4hXK+xpXz6uowb3ztMXPXM=;
        b=syzelaWzZjY8gGtGC3aWiv+9R+4VByIY24hQ8sRfExSAAuZSOxqMRhSgipp4JruPJQ
         XuHUI1SMVtnVZpD/rSUqRJ3ZlzY5Csp3vnjkk2jgR1p0jjpkjsD+39HllHGOlMUhUrLi
         ia+4qC4bpUFrU5ACUhnRetIkYm2cxI0NVfNYdzPEG4lEA26WLkBrkrZ1TQ+L41xZJo5o
         xfBGAFH0FzHtCV/CgKxBS4n+eFiOvOip/FGvTx3DIqpxmC26Yh1OssZCHUI51fUpHLri
         aOFPZHeJKQdR7lRGIqaZhcbj7burjqndT40+RVQ3t5e+OjmAhKe+AfsV1Kd9fJQU41CI
         aytw==
X-Gm-Message-State: AOAM532bRD4f1qKFH8WCHI4l/0BYy8vd6tl0OfuKejxzurxzepfDT7XY
        XyUimZ72fWdR1sifJTZcifU=
X-Google-Smtp-Source: ABdhPJxqpTLNGYPNjmcbbLjVJoUGnCTDdwnuvBoAur6n27EC8bdWn7zaOL01tPtyuvM42HRh+nwEKQ==
X-Received: by 2002:adf:f911:: with SMTP id b17mr517696wrr.412.1631642735637;
        Tue, 14 Sep 2021 11:05:35 -0700 (PDT)
Received: from [192.168.0.16] ([37.223.140.66])
        by smtp.gmail.com with ESMTPSA id g1sm1849151wrr.2.2021.09.14.11.05.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 11:05:35 -0700 (PDT)
Message-ID: <84ab5c30-7661-f225-96c3-59ead2391eec@gmail.com>
Date:   Tue, 14 Sep 2021 20:05:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH] arm64: dts: mt8183: support coresight-cpu-debug for
 mt8183
Content-Language: en-US
To:     Seiya Wang <seiya.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com
References: <20210913092736.19207-1-seiya.wang@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20210913092736.19207-1-seiya.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/09/2021 11:27, Seiya Wang wrote:
> Add coresight-cpu-debug nodes to mt8183 for dumping
> EDPRSR, EDPCSR, EDCIDSR, EDVIDSR
> while kernel panic happens
> 
> Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8183.dtsi | 64 ++++++++++++++++++++++++++++++++
>   1 file changed, 64 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index 409cf827970c..3ad4dd47518a 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -367,6 +367,70 @@
>   			reg = <0 0x0c530a80 0 0x50>;
>   		};
>   
> +		cpu_debug0: cpu-debug@d410000 {
> +			compatible = "arm,coresight-cpu-debug","arm,primecell";

Missing a space:  "arm,coresight-cpu-debug", "arm,primecell";

I suppose that's a copy-paste from the binding doc which is wrong. Other then 
that, things look fine.

Regards,
Matthias

> +			reg = <0x0 0xd410000 0x0 0x1000>;
> +			clocks = <&infracfg CLK_INFRA_DEBUGSYS>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu0>;
> +		};
> +
> +		cpu_debug1: cpu-debug@d510000 {
> +			compatible = "arm,coresight-cpu-debug","arm,primecell";
> +			reg = <0x0 0xd510000 0x0 0x1000>;
> +			clocks = <&infracfg CLK_INFRA_DEBUGSYS>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu1>;
> +		};
> +
> +		cpu_debug2: cpu-debug@d610000 {
> +			compatible = "arm,coresight-cpu-debug","arm,primecell";
> +			reg = <0x0 0xd610000 0x0 0x1000>;
> +			clocks = <&infracfg CLK_INFRA_DEBUGSYS>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu2>;
> +		};
> +
> +		cpu_debug3: cpu-debug@d710000 {
> +			compatible = "arm,coresight-cpu-debug","arm,primecell";
> +			reg = <0x0 0xd710000 0x0 0x1000>;
> +			clocks = <&infracfg CLK_INFRA_DEBUGSYS>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu3>;
> +		};
> +
> +		cpu_debug4: cpu-debug@d810000 {
> +			compatible = "arm,coresight-cpu-debug","arm,primecell";
> +			reg = <0x0 0xd810000 0x0 0x1000>;
> +			clocks = <&infracfg CLK_INFRA_DEBUGSYS>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu4>;
> +		};
> +
> +		cpu_debug5: cpu-debug@d910000 {
> +			compatible = "arm,coresight-cpu-debug","arm,primecell";
> +			reg = <0x0 0xd910000 0x0 0x1000>;
> +			clocks = <&infracfg CLK_INFRA_DEBUGSYS>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu5>;
> +		};
> +
> +		cpu_debug6: cpu-debug@da10000 {
> +			compatible = "arm,coresight-cpu-debug","arm,primecell";
> +			reg = <0x0 0xda10000 0x0 0x1000>;
> +			clocks = <&infracfg CLK_INFRA_DEBUGSYS>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu6>;
> +		};
> +
> +		cpu_debug7: cpu-debug@db10000 {
> +			compatible = "arm,coresight-cpu-debug","arm,primecell";
> +			reg = <0x0 0xdb10000 0x0 0x1000>;
> +			clocks = <&infracfg CLK_INFRA_DEBUGSYS>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu7>;
> +		};
> +
>   		topckgen: syscon@10000000 {
>   			compatible = "mediatek,mt8183-topckgen", "syscon";
>   			reg = <0 0x10000000 0 0x1000>;
> 
