Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3115453D20
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 01:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbhKQA1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 19:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhKQA1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 19:27:36 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4E6C061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 16:24:38 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id j28so967767ila.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 16:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=/pEfGkWQBLFClD5gaoJQWvWctAYpNAJTcnDj24nvJm0=;
        b=miT9XQdXFknzZPA34wqinbKGbyYqUl01gPASe9MSyu35Rm9geaNpp3+iCRW9h9z5pS
         3fQ4P+W+ZRCBFo5mKP6pb9N1qbmnXClY4XE/hut/sSK55IXGV9n9mikp4ZWIDv8VsoQL
         EfOz3zzD1YMmQrgKX6Pd4pLKIDDvnC3RIpKSaRb1BtuUU+0TSrHZbQTs9FEVHJFRnb0M
         7rJc3ydeGxm/7+CxxOtkIUvtoYsUQbnYBgx5+8W3xzZqvkpncCuVc7Jl0b1c7HACkGx4
         2na4XEgUBMV7l6H6ZTevRhIJfF2HyoBQxvWeRuBIeOfMqXCYJIiMtLiVAxulnIV65JR1
         80CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=/pEfGkWQBLFClD5gaoJQWvWctAYpNAJTcnDj24nvJm0=;
        b=eaRLjwFF0w0RYAworEImbeuWB2KGU7zNdWi+01FDyDBp3OPXRwhV6MAZWnomRt0UlN
         gNUCaf+6mNSrgTHHBd79t/h/VsIKZGL4UnfGqofKHv7v71r1Sk4W0CkOKTXY5b5uWqL6
         6VLZnnIqJyC8CjL1XCSuWj3rZ2uOijft4RTJyfzw6rOHYPStb96Gk+JbxRuo4M56EsWj
         Yfsdf/CNFiQ6G2Ek/l+IoO/EldriDTfdo29iz8pfFqX0kuVlSebZKO3H3xhdLxYhJL8L
         s7vnm8jd7CShCbr5BpZV6aioeFWR032Bus48d/TSBJ68WZxWPW8FQxF2uNxvujhjPunX
         wMbw==
X-Gm-Message-State: AOAM532UjfyoBCFVblHXqWveyxvS7+Q4h0Hf7Ywa/YapmwKssJWerHHR
        spEp96YZsBsIhVidNwBhz0Nxig==
X-Google-Smtp-Source: ABdhPJyMeDC3egt4W/paF4N9v3vze/pMMRkkFtMSEGbbXzixmzAX5weF9B/O2vn0TrubxWcFY6egCQ==
X-Received: by 2002:a05:6e02:216e:: with SMTP id s14mr7536860ilv.247.1637108678118;
        Tue, 16 Nov 2021 16:24:38 -0800 (PST)
Received: from [127.0.1.1] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id o1sm12109540ilj.41.2021.11.16.16.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 16:24:37 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org, Kamal Mostafa <kamal@canonical.com>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211116175530.31608-1-kamal@canonical.com>
References: <20211116175530.31608-1-kamal@canonical.com>
Subject: Re: [PATCH] io_uring: fix missed comment from *task_file rename
Message-Id: <163710867764.168848.11469885210160402299.b4-ty@kernel.dk>
Date:   Tue, 16 Nov 2021 17:24:37 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2021 09:55:30 -0800, Kamal Mostafa wrote:
> Fix comment referring to function "io_uring_del_task_file()", now called
> "io_uring_del_tctx_node()".
> 
> 

Applied, thanks!

[1/1] io_uring: fix missed comment from *task_file rename
      commit: f6f9b278f2059478e9a57ac221995105641c7498

Best regards,
-- 
Jens Axboe


