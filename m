Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDDCD44EC77
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 19:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235575AbhKLSKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 13:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235534AbhKLSKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 13:10:45 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFAEC061767
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 10:07:54 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id z26so12205672iod.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 10:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jYyIUcNyqFYWQevqPCKi5GHaxVLWb9zf/lJDxAk+wWE=;
        b=smtZvps6ICKig2+l9PIAtdSIYyIHcr0vo/xL3MXU52SH4WNGhI+0NmvuwixZwPIABi
         7O6x8uNw+o9f65GaWgks3M3cSRvSBf+Du45Wr7jfM3EiZ8ClukJePme8NSEyvvOhuGXn
         4ghepUehNmyyh9+aUpx7Z0Abot8SYcLi4274Dpxh7kuogiSLlW1qUzkzKSrC4QHzW6BA
         BSsrnWGK+O5vaeMjJiPnOyJG45kEw9Rp+EBjhOYoJMTPq++/+WNAP3Uws+1B5YEkLXUs
         JhEimAERjJ/Qrn7up/i4tumaC36YT+EokxNCV981rnqgF+fhcG7aFGGi9ca06Hbu2UWx
         fcLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jYyIUcNyqFYWQevqPCKi5GHaxVLWb9zf/lJDxAk+wWE=;
        b=hfLX6O9ZxtoGuksV3Q7hOWiI0XRb2p7x6OC2A7YEMSwstWhxjqcWQrCAI6GDz7069Z
         vIkumM2rPLX2bjZN1bXZledSKwVAEzQlutPBDZmFRXXo75sXUN9tgB+PCp2oY87fJJCB
         bRp8EVHqG95vjY3r6/39l3suqwzBPvk5fBPpESawyAZrTxh7i3afHsHjpcej82bDIF39
         +79pfUEEzDH00XLU/4G287EjnY5SXQrJyEc7Hh0Jsrir1AzOar/BIwTPASZ0C2UqfS1o
         u5huPEn3Frkx0uVra9Ck1xsgn7l9V9LSjwl3o5PLjrVPAU8hyf3vXOYx2/+eOgjCWfnl
         EnnQ==
X-Gm-Message-State: AOAM533LWqeCu1zknHt3CFVj2ZWmHOex5fvArVb1wF6ZqZsyPBQ2okGC
        PV/YbLC9CLK5ng9bQ8n1RE+0AVYYCotmG8pN
X-Google-Smtp-Source: ABdhPJxkWU33y7hmcUzatPLqNYlS7UN9ts+4Dd9tHRIcfrTws4t8YdH8lZYAZKHxHUy+HIiCeLyThQ==
X-Received: by 2002:a5d:9356:: with SMTP id i22mr11361724ioo.159.1636740473541;
        Fri, 12 Nov 2021 10:07:53 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id a14sm4895786ilv.86.2021.11.12.10.07.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Nov 2021 10:07:53 -0800 (PST)
Subject: Re: [PATCH 4.19 01/16] block: introduce multi-page bvec helpers
To:     Christoph Hellwig <hch@lst.de>, Pavel Machek <pavel@ucw.cz>
Cc:     Zubin Mithra <zsm@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
References: <20211110182001.994215976@linuxfoundation.org>
 <20211110182002.041203616@linuxfoundation.org>
 <20211111164754.GA29545@duo.ucw.cz> <YY1OHxpimjKYgxGR@google.com>
 <20211111185308.GA7933@duo.ucw.cz> <20211112054811.GD27605@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <396f9358-1e73-5448-96d1-98e36123093f@kernel.dk>
Date:   Fri, 12 Nov 2021 11:07:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211112054811.GD27605@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/21 10:48 PM, Christoph Hellwig wrote:
> On Thu, Nov 11, 2021 at 07:53:08PM +0100, Pavel Machek wrote:
>>> There is some more context on this at:
>>> https://lore.kernel.org/linux-block/YXweJ00CVsDLCI7b@google.com/T/#u
>>> and
>>> https://lore.kernel.org/stable/YYVZBuDaWBKT3vOS@google.com/T/#u
>>
>> Thank you!
> 
> Honestly, this looks broken to me.  multipage-bvec was a big invasive
> series with a lot of latter fixups.  While taking this patch on it's
> own should be save by itself, but also useless.  So if it is needed
> to make a KASAN warning go away we need to dig deeper and back something
> else out that should not have been backported to rely on multipage
> bvec becasue without the other patches they don't exist and can't
> acually work.

Yeah it makes no sense to me, to be honest. We're most certainly not
backporting multipage bvecs to stable, and if this particular patch
fixes something, it's by happy accident and we should find out why.

-- 
Jens Axboe

