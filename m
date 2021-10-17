Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63DF0430933
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 14:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343646AbhJQNBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 09:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343627AbhJQNBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 09:01:34 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE2DC061768
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 05:59:24 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id 188so13098932iou.12
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 05:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ytX4HdIZmZ28e1ub8YIdiheHvRBS77VmJQMUomMwZkA=;
        b=b2D1jO0GcUxp7achKObI+Nv8UhJt1FNRDu1AyUc9+GJ849mv89fpQRQp6IRF1UZKvs
         Vr1AoR+naW9m9uEQnSrSVCPdouciTZRAi/ZVdmkKeZKmOc9JNn8VaovuT5VVxsjMR1KD
         8zNfTLGBaAvFb2fT26a8KFooz8U4VrXYRZdFw4tFt1uJRzN4hEOTgyfs+J7DAmh1LSRv
         XjfQoIPKU6gnVyTjdQ9aoTJKcYP7sITOmaOJtwKKpRKKvJ2XeWmPUXPWH5LYHgxsefkV
         /AdTg6rBNEFrT21voZkAQOwJIXq0uk1RMboPKEvJOuNv1UlH1d3Xmhekk29Un3mt8Oxc
         /JEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ytX4HdIZmZ28e1ub8YIdiheHvRBS77VmJQMUomMwZkA=;
        b=bX0lY7AlV9LgLXCVUyO4I5KlxxZ8ZgzD4h2veaLig1i39IAg2/Ub/ckZxm7rDbOpnK
         mtdV1eXO43T+q7V/uo24LgIuqI+kD/Vz0CpCepyQCA1P0G2SNL1KYu86QkJkUYMJJoh3
         BVAAg/ESRd7chJrQtJYf/cgQOSgcdUynGNLt0rfht0hBe0PQ+T/EJR7uLYYs2PBZm+Q/
         Pn85JfglyN7M/j/KcQYG0ukMS2yNahGrpEHPeTxVSKuylKwcDHJ2YV0D6/ICk0Xns9ov
         pD3Bp53B267vTrpgnYz/delkTmOFzOOdTG+Nxm3AB7EL/QOQPsRidb77KJqtPXczL0Ap
         OXlQ==
X-Gm-Message-State: AOAM531GHCkUSqsqXNgQR2DwwPQlFQYEvXeWdjFD+iCjP2QmhO65rOED
        tW7kYO4IoSkHyO1jQOJ4eDYw489/Jj7U/Q==
X-Google-Smtp-Source: ABdhPJynKQdq8QvliNhrBE29N1TiRlprCrIimKQqCsGfTIN8WfnfzrKPRWW++mb6W8hidJYfWUomyg==
X-Received: by 2002:a02:cb94:: with SMTP id u20mr14596094jap.134.1634475564268;
        Sun, 17 Oct 2021 05:59:24 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id h10sm5367427ilh.48.2021.10.17.05.59.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Oct 2021 05:59:23 -0700 (PDT)
Subject: Re: [PATCH 0/5] cache request_queue pointer
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@infradead.org>
References: <cover.1634219547.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <dba463cb-3f1e-0972-aeaf-099d7c12bd0e@kernel.dk>
Date:   Sun, 17 Oct 2021 06:59:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cover.1634219547.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/21 8:03 AM, Pavel Begunkov wrote:
> Cache request_queue in bdev and replace two derefs in
> bdev->bd_disk->queue with bdev->bd_queue. Benchmarking
> with nullblk gave me around +1% to peak perf.
> 
> All patches are self contained and don't rely on others from
> the set including 1/5 and can be taken separately. And some
> changes go in separate patches to minimise conflicts. When
> we agree on the approach, I'll send the rest converting some
> other spots out of block.

Looks fine to me. Christoph, any concerns?

One note, though - s/fater/faster in patches 2..5 in the commit
message.

-- 
Jens Axboe

