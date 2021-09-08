Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5798F403FAC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 21:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350349AbhIHTQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 15:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbhIHTQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 15:16:37 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987DDC061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 12:15:29 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id b7so4708634iob.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 12:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mjDGouD+M9yKQtkIm/4GL2bnggnKQCdFLvusLC3KaDY=;
        b=SmfnVW9cLbCsKjgfyTfU0MHE84dmfcvVpd53zYbVhMwKx/We0L46qHRL4qfFxfLoC4
         aOXVuRHhTrZkhDuP4tqQthID4FqOScs0GLbufoTpIgzws7SCMPixYeVPkTUQeGPtN4iU
         8SJdOnZr3ybMR4ygUc6/7gOe0tc88iDy+oLGKT3t3O4TBORyCsTOgf8vEVqGm83zKxHa
         3vR2iWZj8cEtO7vQhviL726O15JHnAonuylEUgcgKaQQQJ5kTo04CmW8xZI6l4G7euu6
         nyzpp1FC2stcKsDDPvNQYzGlDsOPZjD3Vqw5hY2hJxaLH02O3kT/FLtK2GQN6elPr6hk
         jzzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mjDGouD+M9yKQtkIm/4GL2bnggnKQCdFLvusLC3KaDY=;
        b=fXUgpbIQG632qWn8CHUDYVoaenVZbR7kwtAQCsf2XQQ//0HeTKEKlgGVpydxtZBDe3
         s99+DXevcNll/KQ0N7myLtGdi1e9/rT9t27ziqmiblp+Le4y5BQjsgJW32BBghRRwfoJ
         v93QBN8pkoybd+VtdYbHlguzFZHo2caTfLmrqmseF0fvu4dxkJPZ7tVFEsCFhAvLnyZW
         YkAiuBwhVA1vU+7oZWSh6UnRhRKO3h4y1i4F36t9TM3RrTB7fz2BPscWZkQA7SYPatJJ
         oCEumIh7M3Yzy8pBlT9k7WXrfJr3cHsqxqVOI+YkMJgdwj69+i+Cc6D4/Qi6J01EyHTP
         ZPYQ==
X-Gm-Message-State: AOAM531JFqNKBzKaJKYnmgZhz1yn1CRmyyWuNPBIL3ucsuo3EmR+418Q
        AOHffguMclfHIpPn/V1FRkZHuhyLMpZJFA==
X-Google-Smtp-Source: ABdhPJxWJ2sGn5YEaol+LSukYkii0hC5K7GfDJ5DpWi+Dn0qUf5qdFNJJxvzAcpplNMW43xRV4UC9w==
X-Received: by 2002:a02:2402:: with SMTP id f2mr5220765jaa.28.1631128529061;
        Wed, 08 Sep 2021 12:15:29 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id j14sm678625ile.39.2021.09.08.12.15.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 12:15:28 -0700 (PDT)
Subject: Re: [PATCH v2] /dev/mem: nowait zero/null ops
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     io-uring@vger.kernel.org
References: <f11090f97ddc2b2ce49ea1211258658ddfbc5563.1631127867.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9370d400-3944-b62a-65f6-5c31ac86ea35@kernel.dk>
Date:   Wed, 8 Sep 2021 13:15:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f11090f97ddc2b2ce49ea1211258658ddfbc5563.1631127867.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/21 1:10 PM, Pavel Begunkov wrote:
> Make read_iter_zero() to honor IOCB_NOWAIT, so /dev/zero can be
> advertised as FMODE_NOWAIT. It's useful for io_uring, which needs it to
> apply certain optimisations when doing I/O against the device.
> 
> Set FMODE_NOWAIT for /dev/null as well, it never waits and therefore
> trivially meets the criteria.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

