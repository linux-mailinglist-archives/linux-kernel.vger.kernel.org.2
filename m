Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C37B3AEC85
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 17:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhFUPhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 11:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhFUPhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 11:37:16 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CC4C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 08:35:01 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id r16so25826142ljk.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 08:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j44+jGT4gaUeudY0gWel/YPb1b9YxVj2UqOwtpaKh2g=;
        b=jNf9+hJQ1qI30RXI5/ROZhjy0PKG8Wcu1hnK8021pKFEboTdFenTyUe7YhW7//NqgX
         2IN26mwtJYa6OcCnjmBbhOk85wSA5z+fKaygt0FhG5rx8g6rjoAyTB9L6e3VtZLCc525
         lcuNfnr7aJ2Zphg9ZbK2SCO8deE0ZZz51naQlDN2G4TJ6bznUgwBJbcMS25Xoo5g+We4
         bAj6P4qHPXxGMRclLulhXBHVIa3MX5SdK3vyxu5ofu+r1PtCjazGwfiySH6EZ2fdcOaj
         Eg1GHN74deEB4WuM6U9fpfKydwbH2a2HFoCNyzD0D4iGPvUh9DPkV7N5sGw+a7pvuTFU
         o+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j44+jGT4gaUeudY0gWel/YPb1b9YxVj2UqOwtpaKh2g=;
        b=jBl7gOQ0D7eBizFzm3AUhti4p2BVcdXNahXKkUdkBykQkaAGt2I06QcYPqUVMtmLqV
         HC3RN55+TnETuDgikYOCq5wDUE0bwxwyc0HeRKSZmGV2rgY8EmwiwuVYsO1lB3CXANha
         xVGaVyYnpfLmyqTiL3QrWB10QXTVdxsYPW2UjjdBEIgLLMcHp+jMGgoA4rXcNlFCOF26
         bzhAm2k/VRe9cNtRV1DIGOyAJ8fb+w4WRU5Bodbn9SuYLm95Hifnz/WphHDREy1X7lzB
         nlwIDZOa5M0t42/Ys86FfG5SLKMMU5JjeGwtV9VpaNvF1sNZaEO56DSxYI4fbYcQEo31
         S/EQ==
X-Gm-Message-State: AOAM533tGzw8ksj0EnRlU672+rnjLb4h4IUlnrSO1rg1LKDgtYBOsEfb
        a7ECbFZCk3AxIhxMeM+RQSx2dJfeEtQ=
X-Google-Smtp-Source: ABdhPJx8bfyNhzvjmRju8kWhJlFDFr1BYGkxMbKT6MJbJWWQzPvl8N20pvwLNNK8EciGXYhg5qovyQ==
X-Received: by 2002:a2e:a722:: with SMTP id s34mr21825380lje.104.1624289699398;
        Mon, 21 Jun 2021 08:34:59 -0700 (PDT)
Received: from [192.168.2.145] (94-29-29-31.dynamic.spd-mgts.ru. [94.29.29.31])
        by smtp.googlemail.com with ESMTPSA id e12sm655705lfc.84.2021.06.21.08.34.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 08:34:59 -0700 (PDT)
Subject: Re: [PATCH v1] regulator: core: Add stubs for driver API
To:     Mark Brown <broonie@kernel.org>
Cc:     Thierry Reding <treding@nvidia.com>, linux-kernel@vger.kernel.org
References: <20210619124052.1354-1-digetx@gmail.com>
 <20210621114659.GE4094@sirena.org.uk>
 <5dd6145f-046f-9ed5-9f8c-58cf096287ab@gmail.com>
 <20210621123447.GH4094@sirena.org.uk>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <de8fe5dd-30d3-1ba1-66cd-1bb8b88f984c@gmail.com>
Date:   Mon, 21 Jun 2021 18:33:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210621123447.GH4094@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

21.06.2021 15:34, Mark Brown пишет:
> On Mon, Jun 21, 2021 at 03:04:30PM +0300, Dmitry Osipenko wrote:
>> 21.06.2021 14:46, Mark Brown пишет:
> 
>>> Why would something be registering a regulator device without a
>>> dependency on the regulator API?
> 
>> For example if regulator device registration is optional in the code. We
>> don't have such cases in the kernel today, but I decided that it will be
>> cleaner to add stubs for the whole API.
> 
> It doesn't strike me as the sort of thing that should be optional TBH.
> It seems much more likely that not having the stub will catch silly
> errors than that the stubs will make something work that should.
> 
>> If you think that it will be better to add the dependency to the coupler
>> drivers, then let's do it.
> 
> For coupler drivers it's not clear what function they serve without the
> regulator API being enabled.
> 

I'll prepare patch to fix the Kconfig entry of the coupler drivers,
thank you.
