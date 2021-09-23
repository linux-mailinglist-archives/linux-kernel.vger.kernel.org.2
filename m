Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34335415B10
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 11:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240190AbhIWJiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 05:38:03 -0400
Received: from foss.arm.com ([217.140.110.172]:59652 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238217AbhIWJiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 05:38:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B9AB106F;
        Thu, 23 Sep 2021 02:36:31 -0700 (PDT)
Received: from [10.57.95.68] (unknown [10.57.95.68])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 938693F59C;
        Thu, 23 Sep 2021 02:36:29 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: sm8250: Add Coresight support
To:     Tao Zhang <quic_taozha@quicinc.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Mao Jinlong <quic_jinlmao@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>
References: <1631515214-13653-1-git-send-email-quic_taozha@quicinc.com>
 <1631515214-13653-3-git-send-email-quic_taozha@quicinc.com>
 <57e2a1d8-15ec-0381-2b7d-95bbda7503ae@arm.com>
 <20210923092428.GA12869@taozha-gv.ap.qualcomm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <c9dea7c5-79c9-90a8-ad72-caa4c728a4b0@arm.com>
Date:   Thu, 23 Sep 2021 10:36:28 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210923092428.GA12869@taozha-gv.ap.qualcomm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/2021 10:24, Tao Zhang wrote:
> On Tue, Sep 21, 2021 at 05:35:37PM +0100, Suzuki K Poulose wrote:
>> Hi Tao
>>
>> Are there no sinks at all on this platform ? I had this question on the
>> previous series. How is CoreSight useful on this platform otherwise ?
>>
>> On 13/09/2021 07:40, Tao Zhang wrote:
> ETF/ETR are the sinks on this target. And I have added the ETF to this
> device tree file. Since the ETR needs SMMU support on this target and
> SMMU has not been supported for now. I will add the ETR to device tree
> later if the SMMU is ready for this platform.

Thanks. That is fine. Btw, these sort of additional information could be
added to the cover letter to give a better picture of what you are 
trying to do and why.

>>> Add the basic coresight components found on Qualcomm SM8250 Soc. The
>>> basic coresight components include ETF, ETMs,STM and the related
>>> funnels.
>>>
>>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>>> ---
>>>   arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 442 ++++++++++++++++++++++-
>>>   1 file changed, 438 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
>>> index 8ac96f8e79d4..9c8f87d80afc 100644
>>> --- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
>>> +++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
>>> @@ -222,11 +222,445 @@
>>>   		regulator-max-microvolt = <1800000>;
>>>   		regulator-always-on;
>>>   	};
>>> -};
>>> -&adsp {
>>> -	status = "okay";
>>> -	firmware-name = "qcom/sm8250/adsp.mbn";
>>
>> Unrelated change ? Please keep it separate from the CoreSight changes.
>>
>> Suzuki
> I combined this change and ETM pid change into one seies because the ETM
> pid change validation needs ETM support. If there is no ETM
> configuration in the device tree, ETM pid change can not be verified.
> Do you think it would be better to separate them? Do I need to resubmit
> to separate them into two separate patches?

No, I am asking about the lines removed above. i.e,

  -&adsp {
  -	status = "okay";
  -	firmware-name = "qcom/sm8250/adsp.mbn";

It doesn't seem to be added back in the patch. So that means, the DT
lost those lines, without any mention of that in the description of
the patch. Moreover, the lines do not look like they were anything to
do with CoreSight. This is why I mentioned they look like "unrelated".

Suzuki
