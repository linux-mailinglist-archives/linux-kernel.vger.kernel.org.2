Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56F0333CC6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 13:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbhCJMma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 07:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbhCJMmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 07:42:10 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91DCC061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 04:42:09 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id l12so23132382wry.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 04:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hY0Jhu8wT7V8ZQXnYvLhJQTUPLVmTFuidvQylpZANlI=;
        b=LaCPxpPRFfgxla0eGWzfrNKvk/MWez1ih7ahc7n8iSHcGYJlA4MX4JCY1liBFJBWM4
         ih2xdFuXbZX+w27Cm2KpOiYamMmiVhSuyVbfZ7zr/9P8zi+bssPQFckKOREb8fr/j37V
         ZYjl60c0giHzX8qI9ioMTmHpWfvn7JaJ+HePyXP4Az+JFNdirUS2wSYn3Wn3vjyd+xWZ
         qtIz1CRmRlRHcBURYfoAjCLT4VnpTRnq9xMq50/TL98nr5ZE/5Dcl5Ghn+Xr4yqorIwa
         zp2VxLYBbw0dIZT4bl6HO2j6X7gVvhIWY8rN3Ja3eEpcTzLB4JZqF7IXBT1KTubpMGAL
         lDlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hY0Jhu8wT7V8ZQXnYvLhJQTUPLVmTFuidvQylpZANlI=;
        b=SR/oXCY9b+BUnjVM2YKTDDlhtYdzdkhqbe9nW4pmyrloNLFrv4Zl9BaA8igmZkkFrf
         IKFOL7tQTsZJUKOX11j6wx8WjtmOxatXTgg4bjJc7w7FGqYpg+KXn2z3JR6WHvdxtXPl
         wR+Hlkhx3evwf0zv5oqi/9LpI4js9PPAhOQcQy3WNGNuSeBcJzyD0ttHKfRTH9SskQrz
         eAGNNTGYw3dV1yElppjDmazZQDAC971qscpoG5EwUIG1hR/s7pYHbiYUxEN4mIDk/p5q
         HQuWEPPW7Hg75Cpzfa8cBc///OAb9l614gvNU13MHYLBlpwP12Ulxzv0maMa7N01y/i4
         KTWQ==
X-Gm-Message-State: AOAM533n9l/XvLEz1DWb6w3tPEmico1FPWOX616lm2kBcH/zfeLDr3mU
        z5EvYIEa5s9mdjzigYHaHHaxcJV7A60CPA==
X-Google-Smtp-Source: ABdhPJxoxQR4GvIWoJVNiaP/ojkeJ6Dy26wSDJUoajoGdG3/DHN8BM0jq36K8XsS8f/eYzBks680mg==
X-Received: by 2002:a5d:6ca6:: with SMTP id a6mr3296016wra.179.1615380128613;
        Wed, 10 Mar 2021 04:42:08 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:8018:efa9:4421:9140? ([2a01:e34:ed2f:f020:8018:efa9:4421:9140])
        by smtp.googlemail.com with ESMTPSA id h20sm8670290wmb.1.2021.03.10.04.42.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 04:42:08 -0800 (PST)
Subject: Re: [PATCH v2] thermal: thermal_of: fix error return code of
 thermal_of_populate_bind_params()
To:     Jia-Ju Bai <baijiaju1990@gmail.com>, rui.zhang@intel.com,
        amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210310122423.3266-1-baijiaju1990@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <bd1fde82-7e4d-9a3e-4054-60c7ee486b11@linaro.org>
Date:   Wed, 10 Mar 2021 13:42:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210310122423.3266-1-baijiaju1990@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/2021 13:24, Jia-Ju Bai wrote:
> When kcalloc() returns NULL to __tcbp or of_count_phandle_with_args() 
> returns zero or -ENOENT to count, no error return code of
> thermal_of_populate_bind_params() is assigned.
> To fix these bugs, ret is assigned with -ENOMEM and -ENOENT in these
> cases, respectively.
> 
> Fixes: a92bab8919e3 ("of: thermal: Allow multiple devices to share cooling map")
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Thanks, applied.

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
