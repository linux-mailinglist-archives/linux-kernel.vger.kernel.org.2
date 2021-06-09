Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A713A2024
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 00:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhFIWg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 18:36:59 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]:40556 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbhFIWg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 18:36:58 -0400
Received: by mail-qk1-f178.google.com with SMTP id u30so25389129qke.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 15:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h4YIin9nc0Zhzp3oLI4rfG0duyRcR0Z0PNgbrlky0wk=;
        b=lLJONwKFq63Tm8D6sZ33y32elvuZEf1fRY5wmO0RsNFP8PF98lRxqaJGetLG7TddUA
         WRLdwyDIaUd2iJSycBMY7XidFZgz6kitqpKtqUdTVRTT0kMUH5K4xFoCuBpToxaWpOcP
         RPa3kK1WFQwb0jEx2vFfl0rVhuRkxgzNhfRIfeS82IEZjzc+JWsC0U0LL0Yn5TyL85Ro
         jVtgKpH10oYYgUdHf+jlOBBpfIL3Ymo+3rIp5phg12740/sOlyqVy92QXq87zPsCTWel
         11RGNx3lCoGDCzVcdDf8T4p+rOu95sYEd6pRxRybJNCUd6nU2bPIiZ7J4uUW8XqcD0VI
         pG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h4YIin9nc0Zhzp3oLI4rfG0duyRcR0Z0PNgbrlky0wk=;
        b=M/KxMgI+1h3fg/+TJwO+xlFuG2AnLSYqYKP6+NqjhZBnkQJR28TXaVz2frv4axNzJA
         x3BzVCg6LCObKhZogmF/5qdrzrGgVzkTb36Z6gPaji5dEUPCYbN7bmrASzPJL1ILEM2N
         CRZKvQgVpQEvO0B0bXYWxElpxLtOPTiOu2Un+h685ibSw+rd+jt5Cn7zBsaGya6lN2yB
         TN19btVElpjEuvph+J9oW2dfnr8IuXIVmbDjN7uchppmisB1ub+Ght0GkDhJlMlUB2GJ
         +rBkqrWIf4U3tFDL5w2evsj1PXBu5UN4TBjQs2u5zpwPSLMhVjljB/i6YzGu8kAwa7pC
         93vg==
X-Gm-Message-State: AOAM53283RcH4U2PIXRBDaDMCAh/TVz6TnPwMJQMVk+qmugg3cbRQxoc
        rz5E9K/YQ5+0S06yvR+3/xrt4pHSXWX9suT56FE=
X-Google-Smtp-Source: ABdhPJwtArpBD1ZM+4Odq67v5cly6Y8fhr0FO7NO62M2Wc4b3Mx4N9cvSdz3PhLRv3vc9jLvY1mdZA==
X-Received: by 2002:a37:b6c1:: with SMTP id g184mr1922300qkf.270.1623278042419;
        Wed, 09 Jun 2021 15:34:02 -0700 (PDT)
Received: from [192.168.0.189] (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id g19sm983133qtg.36.2021.06.09.15.34.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 15:34:01 -0700 (PDT)
Subject: Re: [PATCH 17/17] media: dt-bindings: media: camss: Add
 qcom,sm8250-camss binding
To:     Rob Herring <robh@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, robert.foss@linaro.org,
        andrey.konovalov@linaro.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Todor Tomov <todor.too@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "open list:QUALCOMM CAMERA SUBSYSTEM DRIVER" 
        <linux-media@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210608223513.23193-1-jonathan@marek.ca>
 <20210608223513.23193-18-jonathan@marek.ca>
 <20210609221055.GA171974@robh.at.kernel.org>
From:   Jonathan Marek <jonathan@marek.ca>
Message-ID: <df0750af-74a9-9bc3-a7ec-96efba248aa1@marek.ca>
Date:   Wed, 9 Jun 2021 18:32:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20210609221055.GA171974@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/21 6:10 PM, Rob Herring wrote:
> On Tue, Jun 08, 2021 at 06:35:06PM -0400, Jonathan Marek wrote:
>> Add bindings for qcom,sm8250-camss in order to support the camera
>> subsystem for SM8250.

...

>> +    items:
>> +      - const: csiphy0
>> +      - const: csiphy1
>> +      - const: csiphy2
>> +      - const: csiphy3
>> +      - const: csiphy4
>> +      - const: csiphy5
> 
> Should be separate phy nodes? Same/similar DPHY or CPHY as QCom DSI PHY?
> 

This is not a new driver, this series only adds support for a new SoC - 
the design has already been decided (and this binding is similar to 
qcom,sdm845-camss.yaml).

The hardware supports D-PHY and C-PHY, but the driver isn't aware of 
this and assumes D-PHY. sdm845 and msm8996 hardware also support C-PHY, 
so it isn't a problem specific to this series.

>> +      - const: vfe0
>> +      - const: vfe1
>> +      - const: vfe_lite0
>> +      - const: vfe_lite1
>> +

