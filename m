Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED2233878F3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 14:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343721AbhERMiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 08:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243168AbhERMiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 08:38:09 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9883AC061756
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 05:36:51 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id f18so9028629qko.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 05:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MciVfqUQe33gFBLlS3xGeCPUEnGof0Y0yeUe4CWBaJg=;
        b=ASxT6lIrla63MdtFtRlyS0J4qgFpJzrB/mP29DY2AtGGRqyisoj1TkJ9wKfRe328lU
         OwQaEIshhanFyx8ZtVkBRgPhSK6gKrWlcXwZK/BxsqCVBSXtProg10kGoix+EZ1wDoll
         J4SiDUGWe73NRlhyjdETjBgLsPzS9gy3m1j3nKkW+N8uepG85AUQ/mLZwESXgMIIj3q0
         HPncjAWjGuK1+THk9Sr+ZmIp+a7b+lo4o2R82ZcLGQK390WvM9oozmeLVlnWBg59B3iK
         5t3sppyYImUGroL/Rfly1dkdnSgqLJcsSXEbFt26xjOEXVRJ5FWckDU/Y6uvqMYuc2tB
         4lXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MciVfqUQe33gFBLlS3xGeCPUEnGof0Y0yeUe4CWBaJg=;
        b=iKfthWIFRlgVLmloTSKjKBDRP1sjhZyANZCiiRZHLmw1n+TXn26CJvKrmg8LPzp9mP
         pkU9CiCMhINMAapd/w0N8fkyHqTn08oENUNMJgibTnZgh3zoR8iP6HHXJXQyx+5wg3tf
         8Yj+X7JuJ8RJyYCRk+jGvEHaLyXvZNDTU8/nAYB0Yb5WT5LRi3WZuPjYzgMEsJm1J1jJ
         1NRzZ1YBMN7oFT4VGtn2pjDD5/w6DaXGFmg0bRRWpyrEr7gWIi+HRQMqjo00zrJHj7dJ
         b4nwoOQSNCcJRbtazAPfG+JJmnQmNf5uQrVRKQrzJ+WRddRupCSFshmHWJubRINE6/CE
         2kFg==
X-Gm-Message-State: AOAM533adPnUqKMcsK0WIvKxCszhd+aunqTOW5RbRpDJDeMfDt/EE+jL
        /PYAuIPnmK1yBI3WxjQncVaxRg==
X-Google-Smtp-Source: ABdhPJxCMNPi66WuCrXRDD3GF45m9k/zmmv/rQUtDoJzKpADwWVKzap6FWV7A+nxLuCXXL1yr2XKVg==
X-Received: by 2002:a37:5f41:: with SMTP id t62mr5193696qkb.458.1621341410908;
        Tue, 18 May 2021 05:36:50 -0700 (PDT)
Received: from [192.168.0.189] (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id z187sm12691813qkb.129.2021.05.18.05.36.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 05:36:50 -0700 (PDT)
Subject: Re: [PATCH 3/3] clk: qcom: Add camera clock controller driver for
 SM8250
To:     Robert Foss <robert.foss@linaro.org>
Cc:     MSM <linux-arm-msm@vger.kernel.org>,
        Andrey Konovalov <andrey.konovalov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>
References: <20210513175258.5842-1-jonathan@marek.ca>
 <20210513175258.5842-4-jonathan@marek.ca>
 <CAG3jFys=aCJOnP11EC_PK-KBJxMksT78McKb6pLTHuBxhU2qdg@mail.gmail.com>
From:   Jonathan Marek <jonathan@marek.ca>
Message-ID: <aea11d40-a5df-d3b5-195b-d790c5df400e@marek.ca>
Date:   Tue, 18 May 2021 08:35:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAG3jFys=aCJOnP11EC_PK-KBJxMksT78McKb6pLTHuBxhU2qdg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/21 7:42 AM, Robert Foss wrote:
> Hey Jonathan,
> 
> 
>> +static int cam_cc_sm8250_probe(struct platform_device *pdev)
>> +{
>> +       struct regmap *regmap;
>> +
>> +       regmap = qcom_cc_map(pdev, &cam_cc_sm8250_desc);
>> +       if (IS_ERR(regmap))
>> +               return PTR_ERR(regmap);
>> +
>> +       clk_lucid_pll_configure(&cam_cc_pll0, regmap, &cam_cc_pll0_config);
>> +       clk_lucid_pll_configure(&cam_cc_pll1, regmap, &cam_cc_pll1_config);
>> +       clk_lucid_pll_configure(&cam_cc_pll3, regmap, &cam_cc_pll3_config);
>> +       clk_lucid_pll_configure(&cam_cc_pll4, regmap, &cam_cc_pll4_config);
>> +
>> +       return qcom_cc_really_probe(pdev, &cam_cc_sm8250_desc, regmap);;
> 
> Remove a semicolon.
> 
>> +}
>> +
>> +static struct platform_driver cam_cc_sm8250_driver = {
>> +       .probe = cam_cc_sm8250_probe,
>> +       .driver = {
>> +               .name = "cam_cc-sm8250",
> 
> Maybe conforming with the naming scheme of "sdm845-camcc" is the
> better way to go.
> 

On the other hand there is cam_cc-sc7180. But it doesn't matter either 
way, I will change it.

>> +               .of_match_table = cam_cc_sm8250_match_table,
>> +       },
>> +};
>> +
>> +static int __init cam_cc_sm8250_init(void)
>> +{
>> +       return platform_driver_register(&cam_cc_sm8250_driver);
>> +}
>> +subsys_initcall(cam_cc_sm8250_init);
>> +
>> +static void __exit cam_cc_sm8250_exit(void)
>> +{
>> +       platform_driver_unregister(&cam_cc_sm8250_driver);
>> +}
>> +module_exit(cam_cc_sm8250_exit);
>> +
>> +MODULE_DESCRIPTION("QTI CAMCC SM8250 Driver");
>> +MODULE_LICENSE("GPL v2");
>> --
>> 2.26.1
>>
