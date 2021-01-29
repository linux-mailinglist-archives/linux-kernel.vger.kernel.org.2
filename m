Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F7630845E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 04:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbhA2Dsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 22:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbhA2Dsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 22:48:46 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42323C061574
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 19:48:06 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id a12so10609307lfb.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 19:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+RVbZgfsU27MnyOS7YMT70ViFp1xQVbbYZs5V2e2hgg=;
        b=Fh7O3vXfH2iyqKhFBJuNYwWj1cljAskTJd0ZxeD+aoLIIjHmBRtoySBKBp1E0FLDWP
         kITiBmszAx6GIN0SHoOYCzS5pH5loF6qJ+2jm3nCJ7ZDNvjbh7hQs3jN+C3ZfhZRJiSh
         9tuDkf+eI641lWLqh51GW3234PKeaV+3mWD+0V0Dp7pQxqzYWcskc1x8PDAvYqPnlFsb
         2ivbZlxVaY3XWoPg6j6BmF7rsNvcchB+hgXHXvDgK6Sm+b9Fg7lVhSUVxdXdm+sjzPJs
         G+P2hjitkYuhWmcS7fulRqjsmXUFO39+dRKIckj/3KFzh3NUoNeLKcTmd8Yy8xX1qcPO
         uPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+RVbZgfsU27MnyOS7YMT70ViFp1xQVbbYZs5V2e2hgg=;
        b=gewn6b1VAD6hVTzdpQEsgdwhG9Tgvjg28p7t824iIiRGlaRID1laAgYNq11VqGqI6X
         YphLPxxib6Z0Elf9J7SpVk0/bE68TwP6vb1qT0lnb8UQuMCglWuaBFDuwrY16icgPfyp
         N2th0E2eqRk/pQgdofxJmQ3JWEQH3auS6LNiWBBElBSlNtuIlufvMJGPhr4wmVjTc09W
         xyDZhBnHrXC5zJJGhC1i7UvQIwnols47PwCYfC3HMAWAWFl3KMNkoiOikVwyIgFPKkv2
         +Ph7FZTFFQMTVHb4wcq6ZaA0Ee1J77lV+epcGFbPMipbhzq8kY4kwcFzDs7b3e5WKWOR
         7gSg==
X-Gm-Message-State: AOAM531ujN3Q65Xdz8UtkCB7AJcj/sp7u26lKgGlagl05UQkUh7ghoSs
        K+a8lBUawUIyYo/yuY8QMMMwww==
X-Google-Smtp-Source: ABdhPJyGfnobprraIQMymppd5iwvMRH9pIQIdu4gNIuVIs3aKuPqxYiCW7vk3XbQ4sB63jvq6mLAHg==
X-Received: by 2002:ac2:5f41:: with SMTP id 1mr1125071lfz.65.1611892084715;
        Thu, 28 Jan 2021 19:48:04 -0800 (PST)
Received: from [192.168.1.211] ([94.25.229.83])
        by smtp.gmail.com with ESMTPSA id t2sm1880821lfl.141.2021.01.28.19.48.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 19:48:04 -0800 (PST)
Subject: Re: [PATCH v2 4/5] arm64: dtb: qcom: qrb5165-rb5: add bridge@0,0 to
 power up qca6391 chip
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>
References: <20210128175225.3102958-1-dmitry.baryshkov@linaro.org>
 <20210128175225.3102958-5-dmitry.baryshkov@linaro.org>
 <CAL_Jsq+uim_0fDsCqSjgbz-xzUEu4GAf+KOgxSd1KdrFWjhd3Q@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <05758918-1ac1-eaae-a634-8b5ab4b7d944@linaro.org>
Date:   Fri, 29 Jan 2021 06:48:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+uim_0fDsCqSjgbz-xzUEu4GAf+KOgxSd1KdrFWjhd3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/01/2021 22:21, Rob Herring wrote:
> On Thu, Jan 28, 2021 at 11:52 AM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
>>
>> If QCA6391 chip (connected to PCIe0) is not powered at the PCIe probe
>> time, PCIe0 bus probe will timeout and the device will not be detected.
>> So use qca6391 as pcie0's bridge power-domain.  This allows us to make
>> sure that QCA6391 chip is powered on before PCIe0 probe happens.
>>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
>> index 2b0c1cc9333b..b39a9729395f 100644
>> --- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
>> +++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
>> @@ -581,6 +581,18 @@ &pcie0 {
>>          wake-gpio = <&tlmm 81 GPIO_ACTIVE_HIGH>;
>>          pinctrl-names = "default";
>>          pinctrl-0 = <&pcie0_default_state>;
>> +
>> +       bridge@0,0 {
>> +               compatible = "pci17cb,010b";
>> +                reg = <0 0 0 0 0>;
>> +
>> +                #address-cells = <3>;
>> +                #size-cells = <2>;
>> +                #interrupt-cells = <1>;
>> +
>> +               /* Power on QCA639x chip sitting behind this bridge. */
>> +               power-domains = <&qca6391>;
> 
> This all must be in a child node of the bridge representing the wifi
> device.

Ack

> And all the regulators in the &qca6391 node should just be in
> the child node here. The indirection is pointless from a DT
> perspective.

It is not an indirection. The qca6391 node is shared between WiFi 
sitting on PCIe and BT sitting on serial port. One can not say that BT 
is powered by WiFi or vice versa. Thus there is a need for separate 
'power domain' node.


-- 
With best wishes
Dmitry
