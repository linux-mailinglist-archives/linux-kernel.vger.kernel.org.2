Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C51F3B6919
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 21:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236558AbhF1Tch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 15:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbhF1Tcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 15:32:33 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AA5C061760
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 12:30:07 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so20050646otl.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 12:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VFJY8505wyLq/TqpNtGxx/X4mufdytmO16W0L0dHIgg=;
        b=om4/U1E+hj6T7UkgHhPtAr+MURu4APHxmHXxUJG1zNOw+zEl+i9NmsNx3QnEYmmNCp
         t5rlS5d/Weh7HtAbUzHIz3gebtjOexW6hV5er/4UNfgesAv55oB0eNOqwh5ZbTOJK/g5
         mmELdGLy/6PiyMJtTefdbQ9vqO+4dpJxQb8bhb2sD26EtqVaM4l+VBwLu8z+oLgnGrJA
         7JRvkVcgqJbA8TVSkSmHJyxT5B3B42fPTHenlSLt9m4gER/SRYB5BU3YJlnvVC3d/nAV
         /4/i8jJd4gUGylUuI7MzMh6daNP+Kz6t7IWsXvW6dw6k1KHRxIMnL8Oq2oE4S1HsyORb
         8DoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VFJY8505wyLq/TqpNtGxx/X4mufdytmO16W0L0dHIgg=;
        b=MFn3Fkcv+JkIKIAsDiqUPHtxrQUFKiQBxQOiyXeWr94ldEl2FUiSZJuRt80dqT8TQc
         1GlZHxcxgINYHaYMBWunwuakD4O0AjuaK4d6bk0klGGDXSlAgCYY6OidDRWqr1WVujTx
         oZKRqarfaroI1nT1stN2OplO1YLUXgUJoZaIYOlhB+A1CCIawlpSPDrL/oZ9zdSmIC8N
         I4D/jSGsZ2ECq3bFHb6tNH57F/9xg8xgPxw5ia0JYO+cgWi4OAIHQdboakz4VbfUXBWw
         6jXM0g2o4rxcfPmPezt15iwzVGPj5KJG3FrxVJVZ1tUb5LPlh61WpNwMyIkARtZeNehH
         NtWA==
X-Gm-Message-State: AOAM532C7eOICkmeR73YoigqF9SqnDrsQFvCTwPvY/V+e0egs72M69Gp
        LHzN5ThlEoSKZtYzlHg4Aix+toKVwq+8Itdu
X-Google-Smtp-Source: ABdhPJyQF1m0BxNSgT0anmTMLiJYKDNJJnKXUgkXT4+p9bUZ460gWnijh9Yo+M4Apn9fU8Cn89ZRYw==
X-Received: by 2002:a9d:62cf:: with SMTP id z15mr1002438otk.306.1624908606386;
        Mon, 28 Jun 2021 12:30:06 -0700 (PDT)
Received: from [192.168.86.166] ([136.62.4.88])
        by smtp.gmail.com with ESMTPSA id p190sm259011oop.2.2021.06.28.12.30.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 12:30:05 -0700 (PDT)
Subject: Re: dma_declare_coherent_memory and SuperH
To:     Christoph Hellwig <hch@lst.de>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210623133205.GA28589@lst.de>
 <1a55cf69-8fe1-dca0-68c7-f978567f9ca0@landley.net>
 <20210628133858.GA21602@lst.de>
 <4d6b7c35-f2fa-b476-b814-598a812770e6@landley.net>
 <20210628134955.GA22559@lst.de>
 <1141b20f-7cdf-1477-ef51-876226db7a37@landley.net>
 <20210628163312.GA29659@lst.de>
From:   Rob Landley <rob@landley.net>
Message-ID: <4415e2cf-5a6a-8e83-a6d8-391c25e1f041@landley.net>
Date:   Mon, 28 Jun 2021 14:47:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210628163312.GA29659@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/21 11:33 AM, Christoph Hellwig wrote:
> On Mon, Jun 28, 2021 at 09:29:59AM -0500, Rob Landley wrote:
> >> Your plan is to eliminate the ability for non-device-tree boards to do DMA?
>
>> > No.
>
>> Which part of this exchange have I misunderstood?
> 
> The part that there is no easy way out without the device tree
> conversion.

Interesting use of the word "No".

I didn't ask for easy, I asked what needed to be done. What is the patch you
want to apply to kernel/dma so I can see what infrastructure needs to be moved
into arch/sh so it's our problem and not yours.

If a wrapper function has to fake up a temporary device tree snippet to lie to
new DMA infrastructure that refuses to export non-systemd APIs to handle this,
fine. It's still less intrusive than converting EVERY device to a new API on
boards I can't easily regression test. (And hey, if you squint that would be a
little like a partial incremental device tree conversion.)

Rob
