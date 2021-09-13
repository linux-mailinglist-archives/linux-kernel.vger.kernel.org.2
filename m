Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F76C409981
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 18:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238702AbhIMQkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 12:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238642AbhIMQkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 12:40:17 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67E0C061760
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 09:39:01 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id b10so12926506ioq.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 09:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QgPmXhkOYWcDskB4kHZOp4vG0diXj/h4QVPXGAl64bo=;
        b=lYth0XvBIHWMPE+3uTwLezuvykWxoJCYCe5y5sBoWoCbiRi5kpNA8sc9UvqcaOlwwa
         zZhXSYtlGJLlb8OWWlK66kC0Fq9ZY+cEbq00CWOUEIYayBfEF62nSenTs9d5y60yQynT
         J18qnVl6TXP1RQTgB3LMTfzw0AgZeSIZIxnyOKJPvUbb7UHh2y/Nm+HHoYhkA2cEsCmK
         7pUr+pxEu870h5bm/VJnbi4LkbxnMH1e05J4AY9PZVGEfXDWkrjUQM+qsPLzlhgYKn9k
         PR55TU2ErL1q2s621azApGXnas7hMKqv19ZqOnr76KTXFON7kKa3qbxDH/LrQLDA8Mnf
         y9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QgPmXhkOYWcDskB4kHZOp4vG0diXj/h4QVPXGAl64bo=;
        b=EyGGn0WMlcLl/j3wPZgOjs7SCdJy6josjTdrYh2uX/2llP+LoJlr/baZTKcqVcy8ms
         Rgs/Dn6r3q91lGizn7lwL/bdiKszoBO0o+8bGOQUDgrhZ39cGwM5hCdpNdtc+qQDkhWq
         5ZyXbW3FSi5YVl3t72n0/JEwOwf7vB/Q7EshasKc+gPOR9+ldV7hDQHqgemDJoeFsEkj
         PEs4q3GtGEksa1wwK9c+F6qXHEnBZxczVreW1eak/vih2ocNbUCJ5jietBMxoT0Oncwd
         TlCcuL2G4rG/tIc0iC5cN31dwFqGX7cMqOhCL4poBSNc5h/4K5HHriOSwBQ4xh9l2zPi
         zpDw==
X-Gm-Message-State: AOAM5329wj3ZtHXmOZHdcTe90a/UnCc5I/pipCh9V+PBZinfycy3/swj
        3B1xDsShssejr9hactiE3AiEkA==
X-Google-Smtp-Source: ABdhPJwIH46yMQrRfonY6727T9MHgQNlwt2v7sW0W15MmUyGo3M1vGiZdaYBQi9u+uTk/0WQ56dWIw==
X-Received: by 2002:a6b:3e89:: with SMTP id l131mr10002238ioa.74.1631551141125;
        Mon, 13 Sep 2021 09:39:01 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id x5sm4803710ioa.35.2021.09.13.09.39.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 09:39:00 -0700 (PDT)
Subject: Re: [PATCH v3] io-wq: provide IO_WQ_* constants for
 IORING_REGISTER_IOWQ_MAX_WORKERS arg items
To:     Eugene Syromiatnikov <esyr@redhat.com>,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Dmitry V. Levin" <ldv@strace.io>, linux-api@vger.kernel.org
References: <20210913154415.GA12890@asgard.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3d808823-ac22-cd97-ed7a-bac638b3d3ed@kernel.dk>
Date:   Mon, 13 Sep 2021 10:38:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210913154415.GA12890@asgard.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/21 9:44 AM, Eugene Syromiatnikov wrote:
> The items passed in the array pointed by the arg parameter
> of IORING_REGISTER_IOWQ_MAX_WORKERS io_uring_register operation
> carry certain semantics: they refer to different io-wq worker categories;
> provide IO_WQ_* constants in the UAPI, so these categories can be referenced
> in the user space code.

Applied, thanks.

-- 
Jens Axboe

