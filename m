Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD073A8B45
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 23:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbhFOVlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 17:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbhFOVlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 17:41:40 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEF9C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 14:39:35 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso358577otu.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 14:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CVEv/IgDHzRWElqNAWTEDnLSe7O3k6kaEe7gdNKBwXs=;
        b=L7xnKUuBZnqcumMzDuO51h3ey7Upob+cfoa9yJzYNKjrprkDxr6Lvyk9hh3EeWcND1
         obGIVDNN5GP+2fZL1kRLpnDklbdretnXhk5xG8M782Li0lJT8pjLUluKOxxQok4wYoc6
         5hU2Re9fJj8zyxg3Zqn9OtVcW9hgzegr0UyHVzzKKibLfrY7feATVBs9RdcSFEuH9KB7
         JVx8AQdqljz1vxP16CMmeIAjihCuczkgM5I2Qm8qXRTegl2rekwJNR131ZljD5EY9HC0
         oqCQkjcrvzAtdvg49IunU8NI+mosF1ZaJLo61UsbP6RB1dMjzQRV9IoVeeTALlchSgsl
         JXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CVEv/IgDHzRWElqNAWTEDnLSe7O3k6kaEe7gdNKBwXs=;
        b=Hj1dr9lqz6Ts/x8ISyyZQajHBjUlJ7YccdaKTCe2/2/9dQrbmJGqGCwYi3c/V0Im7D
         rn6fWTuUmt4LQxIZxZ2sg3gLQgs63BRNxBKE5+4vI9bVIiOrg8Sk5Yk74qSBDbAwucGw
         3GnxADfrFnV9dUxXjkZliA9mN+TulHR5rPzQ6K12bJDqGAD1hbAiKpm8iIG4VH9Kn28p
         0yu6edcgBmBK1uM4ejctPrU2mF95wn1eFwvjflasxWcFFF4BpB6RMeTD7sNdsSTFl7ie
         j+6dOpglAwivTZqPS4cLLsVs16QMwvsaiwuw1rJWoZVZChPJ5u2zG1Tg9AMxJVUW668I
         7A7Q==
X-Gm-Message-State: AOAM532+arSMzJi5lYamDziVKF3bV/UKHwC1hja4ZMVkISTOjhAIaPY8
        g1Ng1TxBdaeCA+ZJi6a1Bxl/UHGSFvmM6w==
X-Google-Smtp-Source: ABdhPJzpIzcrtFLmozksgx/FN5kkj2i/e/VGxdP5QqTdJZnr11gu97Em+EN5wpKa/S90U58uzpK+Gg==
X-Received: by 2002:a9d:7b45:: with SMTP id f5mr1057063oto.183.1623793174961;
        Tue, 15 Jun 2021 14:39:34 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id x199sm30093oif.5.2021.06.15.14.39.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 14:39:34 -0700 (PDT)
Subject: Re: [PATCH] io_uring: Fix comment of io_get_sqe
To:     Fam Zheng <fam.zheng@bytedance.com>, linux-kernel@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        fam@euphon.net
References: <20210604164256.12242-1-fam.zheng@bytedance.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e12382b6-5c29-c8c0-6874-ad5e2befce1e@kernel.dk>
Date:   Tue, 15 Jun 2021 15:39:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210604164256.12242-1-fam.zheng@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/21 10:42 AM, Fam Zheng wrote:
> The sqe_ptr argument has been gone since 709b302faddf (io_uring:
> simplify io_get_sqring, 2020-04-08), made the return value of the
> function. Update the comment accordingly.

Applied, thanks.

-- 
Jens Axboe

