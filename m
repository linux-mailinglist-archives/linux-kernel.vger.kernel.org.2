Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A418A3A8B51
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 23:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbhFOVn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 17:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbhFOVn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 17:43:56 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CE8C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 14:41:51 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id d27-20020a4a3c1b0000b029024983ef66dbso155327ooa.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 14:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=520moXzIk4YESMW1//dMoR4RUm/M9aunMakQVpWHwpQ=;
        b=STjpJgYbK6Vx0ffKYCrnxAtgUid4PJrTd6Qf+U8XyGnNetf+gv5/p2MxC5nSptjqNW
         42q5yMA9Ouhx30hyJszlSz3uPp14irdpsQMKIw0hDyCa5++BL+/+CibdCQCppsslqBEt
         f5IFFyBRUjtHMg+L2sdC12mkhH/PiXS7yYss43vld3IjL8WB62fn3v698OZ4RQl+CjQq
         Xl7v2ExK6HSO7cVWB2OkUkhRPh5VdPsXYngTyF5adqeIbqk43VIARtIVWmS2oS2b+Hp+
         yhXSzR8JfFhrjqAfo/6AmWE0OYzD2wVpmevCcEHl7BJ0IYvSA0Gnrl339e4FgSRF2JjQ
         6MPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=520moXzIk4YESMW1//dMoR4RUm/M9aunMakQVpWHwpQ=;
        b=NBuVDYheTLsmR+HdOM+fYehUU5laOiiCBAwUne9naSUbsuX4YESTbM+F4+AeVF0B/a
         XwWT1k52VNb84wKyC90iLjPtVbzWphIfpA2032DJ/BGNYuG30liFYqemzSD9PTITnoQZ
         Oy1oV3wf5Sv+HlLc9rbKn2uhI3eFs+ukCSssUZ6pzLzDSlOHT7aH4FIL16ajdSgaXa+6
         f4kz6I24bZG33iCsdZtnzMqa5Ilm6eeexJKEQYN4fiwtuAn9Jr8K9mnQsK5RsHMYapiB
         o2c6blVJf8vEOIbpk/Faem8YFUaDGn3pig/SzTW8Vh4Eq6Ycnl4pZFgXATRGqHrUeA6U
         p8xg==
X-Gm-Message-State: AOAM533BmQhj07iZ2lZssk+5RkSuzWGuhMaR8+qqvxdKmc1InOveFG+w
        lzLwgLaqRgZOgRqZNKZamT6z3fzy3On1SA==
X-Google-Smtp-Source: ABdhPJza7IOYH8gu8YO5B9F4vbim9sALt/2zXs/4ZpJN3za/HGMYltgCy33Y00LBqZwxsHJ7/bPOpw==
X-Received: by 2002:a4a:6049:: with SMTP id t9mr1064404oof.14.1623793310350;
        Tue, 15 Jun 2021 14:41:50 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id s81sm29061oie.23.2021.06.15.14.41.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 14:41:49 -0700 (PDT)
Subject: Re: [GIT PULL] Floppy changes for 5.14
To:     Denis Efremov <efremov@linux.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <2f80871f-a1a5-7c02-52f9-118a0e68d84c@linux.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a8f153a1-daa5-63d1-43ad-c82f358e11a7@kernel.dk>
Date:   Tue, 15 Jun 2021 15:41:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2f80871f-a1a5-7c02-52f9-118a0e68d84c@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/21 12:56 AM, Denis Efremov wrote:
> Hi Jens,
> 
> The following changes since commit d07f3b081ee632268786601f55e1334d1f68b997:
> 
>   mark pstore-blk as broken (2021-06-14 08:26:03 -0600)
> 
> are available in the Git repository at:
> 
>   https://github.com/evdenis/linux-floppy.git tags/floppy-for-5.14

Pulled, thanks.

-- 
Jens Axboe

