Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7143D39B948
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 14:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbhFDNAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 09:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbhFDNAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 09:00:07 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FC4C06174A;
        Fri,  4 Jun 2021 05:58:10 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id q5so9251518wrm.1;
        Fri, 04 Jun 2021 05:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SgHpQ4QoLBEs1F+YWq7Dw3mAD1i1XABsToAa1xmK68I=;
        b=QW+WYPextBD7RVr9x+p52qil2JPfyUNsCMwaa9FMarAgtcd62l77QtUDEVdXcAzy4c
         IvQ2IGtWUYdDOw4zaTiyF1PT1v15MLl+th2/bezk7YVC/B4WbbQMcpaGTh+IUrX2jlcE
         xYDQfE19+U6WnPjIsuVsWHGNPAaPFo8Sz6YppWD0JDavmzgjol83zuDUWBpHVvZakdrZ
         vqOswF1KqzPxhuGEoWG9QCoUEHABbWxsiMHersU3YCDVIXlFYmTByIz4pK62mpaVT4nz
         iK1nOO5Z5BZi3YQUN1uNNUtz7VvXV58+HJvvHlzCY+DM0CUgz9TiJRjvtaMjJAELf/s4
         c2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SgHpQ4QoLBEs1F+YWq7Dw3mAD1i1XABsToAa1xmK68I=;
        b=giviM/S1OJjkpQWHjjbFh0RZrjrz2Kh3Q5rhIDmYN2Q54dNU0k+tiQM6WpFcLP/XaT
         qlGgt6LWTZsEnaRoHNmXbQarSisdWTUt+cu29W+YVD1mYZXSeVUTglpl2LEYdDhIESh5
         z34uR7IGRhAO/K82osNu1FpnLZIGm20CdzSCnENQkRtFL5Sif6nVUQHDgoUMNoizT+43
         R7IG/om2vWItWdGR6xDTBD/RSuouapm7+hIcA4dz384CQeS0OSIvgQDGUYNoPAhocPqL
         cdYVHqqQpWE/XFVHe3XdFhBnxNce13UMAc+ltL2L59pf/cIAU+q6zTvs6qCJAT2XXtDk
         apZQ==
X-Gm-Message-State: AOAM5306ZUdOw7wq6LirBup1bU8u3CeKuqJZwb6nDRLZn5ywq5VTsy13
        BaSCv4Uhkmc03B62DEeQFmpY7YEucEQ=
X-Google-Smtp-Source: ABdhPJwo5Bjwxsjrlbwh0vAAF8goewnbqwQ2QzlG8lx0QwJ7wKtS1W5ixdXkkM5djidOdjgkH4P08g==
X-Received: by 2002:a5d:47a3:: with SMTP id 3mr3857385wrb.42.1622811489058;
        Fri, 04 Jun 2021 05:58:09 -0700 (PDT)
Received: from [192.168.2.202] (pd9e5aba0.dip0.t-ipconnect.de. [217.229.171.160])
        by smtp.gmail.com with ESMTPSA id g17sm1905073wrp.61.2021.06.04.05.58.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 05:58:08 -0700 (PDT)
Subject: Re: [PATCH 0/7] platform/surface: aggregator: Extend user-space
 interface for events
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <mgross@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        platform-driver-x86@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210603234526.2503590-1-luzmaximilian@gmail.com>
 <c86a976e-64cb-ea10-486e-fa5d4482ad5b@redhat.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <a29f3acb-6a49-02a5-d9af-07baff8d9307@gmail.com>
Date:   Fri, 4 Jun 2021 14:58:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <c86a976e-64cb-ea10-486e-fa5d4482ad5b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/21 1:40 PM, Hans de Goede wrote:
> Hi Maxime,
> 
> On 6/4/21 1:45 AM, Maximilian Luz wrote:
>> Extend the user-space debug interface so that it can be used to receive
>> SSAM events in user-space.
>>

[...]

> 
> Overall this series looks good to me. I've found one small issue with
> PATCH 4/7 (see my reply to that patch) and as the kernel test robot
> pointed out there is an used "struct ssam_nf_head *nf_head;" in
> PATCH 2/7.
> 
> With these 2 small issues fixed you can add my:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> to v2 of the series.

Thank you for your review.

Based on the issue reported by the kernel test robot I've been
restructuring PATCH 2/7 to remove some code-duplication. I'll add your
R-b to all except that one.

Thanks,
Max
