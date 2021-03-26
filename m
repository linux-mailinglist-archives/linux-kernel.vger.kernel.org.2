Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD7834ABA4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 16:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbhCZPlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 11:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbhCZPlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 11:41:51 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56140C0613B1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:41:51 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id x16so5829522iob.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iLQnrJ2ZXxBft+6FvwIWC3XE/HkPy4u/bgjtAyAPsio=;
        b=gr4syNmH08iVrvkYMJw/LEWmA0VL2DgNrJtWdtMm9wXAEMqC0p3/K08lMMtOYwyX1r
         IVyPWUGXNt5KV5OtjurY4rmoehbvFQPi/SRPNGAlVbkbMrjuKi7RBoV4v74UeodN27ps
         imixx4K7NuuCcP1Jf4abMMBGXCyRCDpbJ83nX+3OvkV9SAMUR6gmZwPabe5nGg7wVyY5
         qxxzjaSZGRuXxxU2+2Oanc+TsPBdM4sA++jRweKZaLf9oNHM7V0C9yGZisYsuTEjQHmR
         PYW68EpRHTNeGeQAsF7kSSxki9hNtDGzOEBK4Y5lfrlTquylZUna6y4M/LxDpZqd5QaW
         DLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iLQnrJ2ZXxBft+6FvwIWC3XE/HkPy4u/bgjtAyAPsio=;
        b=Arayzwf5++jWr8clGX+YuorWrasFrxwbqkXk0nwt7gTHDqwmm9l1r6wFDH+7PvS0NA
         tiHeuS/w2SBngSPaH+ZI9RDp6nPjGCSdHh/x1iNuIXmCgPN82YYq7WlujTcgkxH2ecFM
         5ML8oY3qDPkycmnPvR0SAAiiGHXQkqzd6U3h7h4ZBaJnz2qojYAFMMPoZhEHw1dwk7MZ
         5GYhwtBQn4Jcy9RWZ6mVSV/tdnILZ5boSIGKCXplfQhdM9tpl0z8B5kScTtwvDMOcExi
         Y5x8WjvInfVC6QUGK7xt4aKCRchFCFikN22JBx/spBCQAjVAJ8Lb6AVv2KqtETdkJGHj
         5wZw==
X-Gm-Message-State: AOAM531aUw8gEDFHvaRdfwxGwTEiHZ+0KQC3VuPWVmen47MNfC6DIyA2
        xYWAJui3mSft/Kqv/AfmyihXAw==
X-Google-Smtp-Source: ABdhPJzoCpYrlG7KxIQiDAmFsfxK5yHsZnlVRl9R26j+j/74QF96VAs2yHtKaNSp7iGG/Pyz37hTUA==
X-Received: by 2002:a05:6638:1648:: with SMTP id a8mr12290195jat.25.1616773310628;
        Fri, 26 Mar 2021 08:41:50 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id d1sm4603381ils.49.2021.03.26.08.41.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Mar 2021 08:41:50 -0700 (PDT)
Subject: Re: [PATCH 1/1] block: fix trivial typos in comments
To:     Tom Saeger <tom.saeger@oracle.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
References: <31acb3239b7ab8989db0c9951e8740050aef0205.1616727528.git.tom.saeger@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2831e351-0986-28d5-5eef-53edcf8f41c3@kernel.dk>
Date:   Fri, 26 Mar 2021 09:41:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <31acb3239b7ab8989db0c9951e8740050aef0205.1616727528.git.tom.saeger@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/21 9:04 PM, Tom Saeger wrote:
> 
> s/Additonal/Additional/
> s/assocaited/associated/
> s/assocaited/associated/
> s/assocating/associating/
> s/becasue/because/
> s/configred/configured/
> s/deactive/deactivate/
> s/followings/following/
> s/funtion/function/
> s/heirarchy/hierarchy/
> s/intiailized/initialized/
> s/prefered/preferred/
> s/readded/read/
> s/Secion/Section/
> s/soley/solely/

While I'm generally happy to accept any patch that makes sense, the
recent influx of speling fixes have me less than excited. They just
add complications to backports and stable patches, for example, and
I'd prefer not to take them for that reason alone.

-- 
Jens Axboe

