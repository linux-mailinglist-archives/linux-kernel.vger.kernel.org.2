Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7038F37BE5B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 15:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbhELNlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 09:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbhELNlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 09:41:03 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50CAC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 06:39:54 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id pi6-20020a17090b1e46b029015cec51d7cdso1070189pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 06:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7HnfwX7m3Z+g9y+GxvV9dTr4oQgwcIKMOrB57DgGB/M=;
        b=RTwXYeJiCx5LbA/TppKdWG0bNmgqampo4zDXVYfA3AqbhFdlwCw6wfiKqLIhVRtIfb
         B21DPt8xHlw5rCM8LXxfjz4tQk2HAaxCGEQcTciSfS/n2YFZ+4Rhi8zibR8jxWcZwOFv
         lRKod4qWmA5J6HeVQKaKZ9sI7OCtqJMAwknWMBp5BYjMwP9EJwNo1v6Ozv4V+xiuq/eK
         RfYjLjgOhHeKoKhf+YfcXLDrRV2NDeY6XM8ttaNLryA9S8q4hZcFuhvqTexYvaKvKMZ/
         Xf5JNRv1IA6j20ir1aCmw+4BxFof+6PFo20aHoS0ToPpVZQw6F5pT8VZ8LTkePK/7xg6
         YSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7HnfwX7m3Z+g9y+GxvV9dTr4oQgwcIKMOrB57DgGB/M=;
        b=R8gOMER+6UtYUynV8Qr1CThnmcfQJ3J/1OB92GBi30xrneX/HO5Qtm8aBexUObu6k2
         QWreI2yBmd5SfQsMdffuezDyi/OPG/dNFLAWuOi1lNuGi8BHqsolfwyKiPUKRKba1jmi
         Q4Vc7csCjyqyG2Cm6d6U/zeO7mKaPFz7GenBDyNnUky/j1VYUhw3G1+D0BKrP6beEHlM
         k7x+K3gPLOWbewRg7rKJZ+I5eyFRUtLMjKMpx1y4I+fD6L3CTj1rNVajsbqHwsQuGEuV
         uisjyKgA2mWL3l5wNYrEs/2hY/wjPjXj/p1mlIW782BPhcVNIqbdTqrLuDokDAtnwcEa
         zDfA==
X-Gm-Message-State: AOAM533AqRUbZv07qERNCy8fvflCkDgPtREIYdlD2ZdAbPOncwotRJsV
        8YC4vorQtovA3Dw/Qw6VhxrGPA==
X-Google-Smtp-Source: ABdhPJxP6vRQYyKOUIGJG6xxYEUOrOMhrrtAzel+K3wr2JRaGqTBKmFUGojyyUTsAfc0BvuvA9M1Fg==
X-Received: by 2002:a17:90a:1382:: with SMTP id i2mr10981240pja.83.1620826794133;
        Wed, 12 May 2021 06:39:54 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id 80sm49501pgc.23.2021.05.12.06.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 06:39:53 -0700 (PDT)
Subject: Re: [PATCH BUGFIX 0/1] block, bfq: a bugfix for stable merge
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@redhat.com
References: <20210512094352.85545-1-paolo.valente@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d83a2097-3800-a222-4580-ae692bfac030@kernel.dk>
Date:   Wed, 12 May 2021 07:39:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210512094352.85545-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/21 3:43 AM, Paolo Valente wrote:
> Hi,
> this patch fixes a bug I've found while debugging a failure reported
> by Yi Zhang [1].
> 
> This patch seems to make that failure disappear [1]. Yet it was tested
> only together with other debug patches (which add logs and invariant
> checks), so I don't know whether the other patches influenced the
> outcome as well. At any rate, this patch does fix a bug.

Applied, thanks.

-- 
Jens Axboe

