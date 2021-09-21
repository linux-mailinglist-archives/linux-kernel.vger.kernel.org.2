Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E92A4137AB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 18:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhIUQhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 12:37:10 -0400
Received: from foss.arm.com ([217.140.110.172]:36322 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229448AbhIUQhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 12:37:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AC99113E;
        Tue, 21 Sep 2021 09:35:40 -0700 (PDT)
Received: from [10.57.95.67] (unknown [10.57.95.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98C763F718;
        Tue, 21 Sep 2021 09:35:38 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: sm8250: Add Coresight support
To:     Tao Zhang <quic_taozha@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Mao Jinlong <quic_jinlmao@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>
References: <1631515214-13653-1-git-send-email-quic_taozha@quicinc.com>
 <1631515214-13653-3-git-send-email-quic_taozha@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <57e2a1d8-15ec-0381-2b7d-95bbda7503ae@arm.com>
Date:   Tue, 21 Sep 2021 17:35:37 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1631515214-13653-3-git-send-email-quic_taozha@quicinc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tao

Are there no sinks at all on this platform ? I had this question on the
previous series. How is CoreSight useful on this platform otherwise ?

On 13/09/2021 07:40, Tao Zhang wrote:
> Add the basic coresight components found on Qualcomm SM8250 Soc. The
> basic coresight components include ETF, ETMs,STM and the related
> funnels.
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 442 ++++++++++++++++++++++-
>   1 file changed, 438 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> index 8ac96f8e79d4..9c8f87d80afc 100644
> --- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> +++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> @@ -222,11 +222,445 @@
>   		regulator-max-microvolt = <1800000>;
>   		regulator-always-on;
>   	};
> -};
>   
> -&adsp {
> -	status = "okay";
> -	firmware-name = "qcom/sm8250/adsp.mbn";

Unrelated change ? Please keep it separate from the CoreSight changes.

Suzuki
