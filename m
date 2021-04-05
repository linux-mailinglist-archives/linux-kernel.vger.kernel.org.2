Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31F30354909
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 00:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbhDEW54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 18:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbhDEW5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 18:57:54 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8465C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 15:57:46 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id e18so12188752wrt.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 15:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GsALzx0Rjvc16XQc7wuGcWWs8xedjpRc0kR3W8dinuE=;
        b=mE3omOY/EFLMCJc3dDUmtHxXvkjrAkxlLz4C5kho710fWtkKrs6ZnjM8oPE3yIfemZ
         nAdrNh3jOusTpcwmN1PxGMxadU2rImNXnLBV5kTnh0A4+8lcIAgARsmLkfeSUc7vYpux
         Ot8/2TingupqyorxLkpeX0YUlKZM7PR8Uik+ttPgJzZMXa9UkpRN7kkvjjP0/r1zSqhg
         h06zgNv0WDXi3DJP//DDOmhTghhWfl/+RTbqSW5NRKf8Sz8kP6UXadxiHcuBitO7EgrP
         RsX4eBSJMkGdwuIR9icrUTB8HdBv9sfGDgfQu9ju+IT8ELS5BAFBp32+ZaYQiBHokiIR
         Uzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GsALzx0Rjvc16XQc7wuGcWWs8xedjpRc0kR3W8dinuE=;
        b=CE8K/fOzVM9eiGrjjlqAPTFGDi8Krjf/5gqc3aI7gC8itp87b4GAWETHiP1Z0mBy4h
         yAxZ67j654nrAWaIcVoVV2+PXvE/l1SxN+xgziYcluf35J2ro3wLOoP3bD69nxBEfUrq
         KfXDLPacOgh2QdF5s6oxB9kXqoMmfexEgVRfdHGVrYADmCLZzlVEOU/PiEJcsVVOTYT/
         zKPYORkKyeKi4RJpq76WJ9VXRREw5CCFkNNl/Utu381hQ1GIqJTcrDZ14WIRQqeISezc
         m41UC5DIIK4R6ECK56O+ejW2BIsznFp/jwbHxC10NWR6ggMGl4n0QEokgnlvrh4OLaSG
         gJlA==
X-Gm-Message-State: AOAM533Sael0j/w2YeZFPGYuCdgl5hYTD5a9mP1XPxbv/qbBRE7qLvK2
        WMkc7Lra9tJhycHfJ++Q/NpC89qvyzg5AA==
X-Google-Smtp-Source: ABdhPJxB7LQBvAilsUzNItl26qAaZg+6/4Bbyj6m+LxE0fncKjRk1axkNV4VyzHNOL7bW6aOas0ypw==
X-Received: by 2002:a05:6000:1209:: with SMTP id e9mr6545242wrx.36.1617663465585;
        Mon, 05 Apr 2021 15:57:45 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:d506:6f5d:adb6:da14? ([2a01:e34:ed2f:f020:d506:6f5d:adb6:da14])
        by smtp.googlemail.com with ESMTPSA id c2sm910286wmr.22.2021.04.05.15.57.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Apr 2021 15:57:44 -0700 (PDT)
Subject: Re: [PATCH v14 0/9] Add support for ipq8064 tsens
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Amit Kucheria <amitk@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210404144823.31867-1-ansuelsmth@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <00314fdb-c9f4-03b0-5639-a8b8f5afbba2@linaro.org>
Date:   Tue, 6 Apr 2021 00:57:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210404144823.31867-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2021 16:48, Ansuel Smith wrote:
> This patchset convert msm8960 to reg_filed, use int_common instead 
> of a custom function and fix wrong tsens get_temp function for msm8960.
> Ipq8064 SoCs tsens driver is based on 8960 tsens driver. Ipq8064 needs
> to be registered as a gcc child as the tsens regs on this platform are
> shared with the controller.
> This is based on work and code here
> https://git.linaro.org/people/amit.kucheria/kernel.git/log/?h=wrk3/tsens-8960-breakage

Applied, the series.

Fixed a minor conflict with patch 9/9 and "dt-bindings: thermal:
qcom-tsens: Add compatible for sm8350"

Thanks

  -- Daniel

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
