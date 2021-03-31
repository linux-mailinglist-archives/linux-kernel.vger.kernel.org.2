Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2573D34F691
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 04:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbhCaCWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 22:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbhCaCWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 22:22:01 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF59EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 19:22:00 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id nh23-20020a17090b3657b02900c0d5e235a8so456790pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 19:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EzGPZze2rxZ5ckak4efZEC8hTHEU66acZEHiJwumMu8=;
        b=q0WYGltBETSjrz66ziaGgKL0wMUSu6IL7mmgOt3LEuyY0H9q78WSOHIhgxph+WjrWd
         c8S1y/lDaNtxbDxNGyqNd9g8T0f3OVFm5+jOnoiU6ugIJzJ44PlDYAdPs32cZOgbsCOV
         kMA6uk3iy0AeWx3qU3kqbmDk92ci6VSCm6nWz/IvToINxPLoe8vx8/Gs7qxXcJ1qRuUI
         6RrU3q6QKmrFndx1syyehDJ9+UWCjYvRp64+eLoENG1qKNRNmMU2HuCUIqEIF7x3JNCs
         p9H8CAnf17PyJA/pRKHR0wqxCbFhh6kWMW6KdCWGFC/LiQjPVkjmimrzgiHB3dfFa/aK
         KPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EzGPZze2rxZ5ckak4efZEC8hTHEU66acZEHiJwumMu8=;
        b=rIwB6wmc6RFYfwDaWNBIWUbd52OC1Ur9JYz123rPU/llzazN9BxqauBVUOs2IvYNv1
         Ah4fBDN8g1hisYu6nLjfOhy1l8dfeQM8fi6pgiAITwz5x8KB5+ccM5qXpD5wwjmetQ3t
         Kc/cGr/nL0BV9nIpEmD9/GATv5ww6XZ755NNwfh+q7mJGUlVGM+AeHx6mKyfu8RbtTKr
         wQixj/Com0pIWm/Xj1nFH+cWTwYn4bzQKLG6RPKz5LnSVned1t6SCoMGXQtJtbtfCpdh
         PPZ/+e96E0w8g3+OmhikQwIzqJOj87v6J6nA885K99rzU1SSCrsDI+OiyPn0jOySbK0u
         ZphA==
X-Gm-Message-State: AOAM53262bosFMKDzbvxbkAlIYJIxe21+2Q7d9icPNcNclmpLqfegbJn
        zkpkBaYnHhT+XDZwaOo/KA50KA==
X-Google-Smtp-Source: ABdhPJz/1xeV8h/a0ujmMXoNrk7xFaIvOPc4DH5SzBrfbA8/srLkePGygB3p3Y/nFWXIS0lqGL0mHw==
X-Received: by 2002:a17:90b:4395:: with SMTP id in21mr1184209pjb.201.1617157320363;
        Tue, 30 Mar 2021 19:22:00 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id t6sm365028pjs.26.2021.03.30.19.21.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 19:21:59 -0700 (PDT)
Subject: Re: [PATCH 00/15] [Set 2] Rid W=1 warnings from ATA
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        ALWAYS copy <linux-ide@vger.kernel.org>,
        Andre Hedrick <andre@linux-ide.org>,
        Colten Edwards <pje120@cs.usask.ca>, Hat Inc <alan@redhat.com>,
        Jan Harkes <jaharkes@cwi.nl>, Jaromir Koutek <miri@punknet.cz>,
        "L.C. Chang" <lcchang@sis.com.tw>,
        Lionel Bouton <Lionel.Bouton@inet6.fr>,
        Mark Lord <mlord@pobox.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Torben Mathiasen <torben.mathiasen@hp.com>,
        Vojtech Pavlik <vojtech@suse.cz>
References: <20210318085150.3131936-1-lee.jones@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e4b9785d-ba31-e1ce-dbab-0fd31605e9d1@kernel.dk>
Date:   Tue, 30 Mar 2021 20:21:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210318085150.3131936-1-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/21 2:51 AM, Lee Jones wrote:
> This set is part of a larger effort attempting to clean-up W=1
> kernel builds, which are currently overwhelmingly riddled with
> niggly little warnings.
> 
> This is set 2 out of 2 sets required.

Applied, thanks.

-- 
Jens Axboe

