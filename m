Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378CC40D75E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 12:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236458AbhIPK2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 06:28:01 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:40316
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233913AbhIPK17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 06:27:59 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D2D293F077
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 10:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631787998;
        bh=6S5AMhCNVrlspN/3bjYdeLfuwtE9nTG661txhmEAamc=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=jdVf2kKPfNvog9XGy1qS+JnSgmqepI47liE/8I+qzTOd4pbJwI0PRtRrH+Q7IcEl3
         Q1bqkfMczZEXxPVfRHEjk6zcbSM2vW0qDFQ++rhNjJNPrOimCGlaDct8VnAPK2HyO8
         PhXEaBy0THc/U+8jnNyHTyjFYtoLOfKjqnTYRc4Mu4+vSXYVJAlT3W+a+hVOAYnYRL
         5vea2+BCPfVUVnnmiZYGIarqVk2HoAjJIOXZzhkuqoCiPC7NHBhqAh7nw0M0XCb0/r
         PoZL9aLzOA+7anVGhL4U6Oq1wus0vDXEhNyWuXn9DMByq6TAEw+x1foHAJsDRonJxa
         ChGFRYD70TItw==
Received: by mail-ed1-f71.google.com with SMTP id m30-20020a50999e000000b003cdd7680c8cso4898656edb.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 03:26:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6S5AMhCNVrlspN/3bjYdeLfuwtE9nTG661txhmEAamc=;
        b=O/BismoWToOCQAM7BB6GY/iNkhU+T9fZTPu+9NggsTUFvKzQ/5LVedsZ7XWPuK8UyV
         SQmNLgP7HwJI97LRPi53iLNpMRLrs8CFXU8iubXXKB4fLiJ262zR4b3IgoRAnOuNGxkE
         CnOaKaWZrOxgGoIC9Ga2mjzNRigz+NYwl/6AOBkwObN8DHxCw2z1Aso1Z63U+/3bgtYo
         9XeCGEHzY+IU3zzYBS3b74mPdj25LS6F/NWA0zIzMCxse5+ImQ/191jINdp+wBlIIaDD
         jfFm3+D6eA02+I1rEDn1Y/9WF8VuCj/D8xCI0rJwNFzipKOFFAdI0eqDGnoNQ2VCabwD
         n84A==
X-Gm-Message-State: AOAM530+fIaodIu7RTkdOyJzio4xkxCtQlHkBsB7nuGo1HZ9A3Wmmzw7
        lDgFnFMEjrKmKTLeDhkImq+ZTvR3SmgAya3GY90YHnugMdmhse/dEK82LGk9kbpy754XcgfOCK8
        ulr4/KfjYBavTXjtotI4Cxvizg20AbwJEEmK6w2NnHg==
X-Received: by 2002:a05:6402:4cd:: with SMTP id n13mr5650688edw.215.1631787998091;
        Thu, 16 Sep 2021 03:26:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfSeMhkwPLYCWP2Bv59mSbK2nZi0Xj85qeOtzME5EdliawbHvYnmlDnqnvoh8tL8BfQ4m2Bw==
X-Received: by 2002:a05:6402:4cd:: with SMTP id n13mr5650680edw.215.1631787997971;
        Thu, 16 Sep 2021 03:26:37 -0700 (PDT)
Received: from [192.168.3.211] (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id v12sm1224424ede.16.2021.09.16.03.26.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 03:26:36 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] power: supply: max17042_battery: Prevent int
 underflow in set_soc_threshold
To:     Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Dirk Brandewie <dirk.brandewie@gmail.com>, kernel@puri.sm,
        stable@vger.kernel.org
References: <20210914121806.1301131-1-sebastian.krzyszkowiak@puri.sm>
 <20210914121806.1301131-2-sebastian.krzyszkowiak@puri.sm>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <eb0d1829-2379-c0ee-4043-70c86203286d@canonical.com>
Date:   Thu, 16 Sep 2021 12:26:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210914121806.1301131-2-sebastian.krzyszkowiak@puri.sm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2021 14:18, Sebastian Krzyszkowiak wrote:
> max17042_set_soc_threshold gets called with offset set to 1, which means
> that minimum threshold value would underflow once SOC got down to 0,
> causing invalid alerts from the gauge.
> 
> Fixes: e5f3872d2044 ("max17042: Add support for signalling change in SOC")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
> ---
> v2: added commit description
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
