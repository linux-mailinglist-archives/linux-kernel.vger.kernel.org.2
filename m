Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF36841288D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 23:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235318AbhITV5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 17:57:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40758 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229710AbhITVzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 17:55:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632174863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9UIsylLPvYShfxauOf8jQZM0FMZ6CBRqo/Eg9Bevgk8=;
        b=STnz18zcmrz3TOsPsa7QvlT5KpM1BYPJ05DGH2Pe6yOuVVM6hGxEUAnD3EE4K04Wovw4QU
        Qs0IJ4CfwxuHBPQJRicezsFuq8CHx4pMwED2luOkl4t/VeRsmdt6DcJG0ltq2YIScstxQO
        UbMwGyNUI5E1Wn1kOYpjYjaNaSzvidg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-ykhd0x3FMByF_q4ZRL9MLA-1; Mon, 20 Sep 2021 17:54:22 -0400
X-MC-Unique: ykhd0x3FMByF_q4ZRL9MLA-1
Received: by mail-qv1-f70.google.com with SMTP id h25-20020a0cab19000000b0037a49d15c93so199270325qvb.22
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 14:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=9UIsylLPvYShfxauOf8jQZM0FMZ6CBRqo/Eg9Bevgk8=;
        b=2BZ8S0NmqUdVZek52VJtXPjfsB+NC26XOsCY7cY++/jtiB1cTK+1fXkg46TFo1/7xl
         0oFrTtLJEYs84HMtph8q86d3VpR+VuZgmPPNKvouKU0FX6Di+6q5CUap5zRxkhxEaMoG
         bURF8hNFs81LP0AE0GsGkcnyhpmA98pMBE95XI10Qt4duwYxVDNirJLLJm0L2Ru/D+vt
         qJsjHeKIpCvLJspAuACZfeFHxtTzhKuf74YNmxyKuLYuJaGjw9cEJssmqwoPcSO7lG3L
         VQ2aoGnEMEaUfVZDtY2BHhrRWcJZAea0H123WbURVfH5awhqATOPhMZzqUwTa2ejhBp/
         eO6g==
X-Gm-Message-State: AOAM5315IOn9iWzPWfhpSXadqzShEzE3U02o5ZASGtLzsgYJRjlV/nlf
        2h9j0gz5hWIIwrsdjgf3U0pFWOlPlgDBzzOxTzFMuFU5CZjOv42enMleWlGBFiTfWXRM/CtZwUy
        2B2Dx6wMLteYBeiz9Weo5jxk22lHpiL8rWa2+NitXSWMRVnNigosG5xHE8PzHO9YXKhf6PHxV
X-Received: by 2002:ac8:59d6:: with SMTP id f22mr24742057qtf.405.1632174861204;
        Mon, 20 Sep 2021 14:54:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyD2kpkcs/5Lo+wxuwbK/mAB9+7k18YFVw4JK3TUMkPEPljSK6P7fMe5llkM10HZjv2boe50g==
X-Received: by 2002:ac8:59d6:: with SMTP id f22mr24742028qtf.405.1632174860852;
        Mon, 20 Sep 2021 14:54:20 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id l13sm2416172qkj.130.2021.09.20.14.54.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 14:54:20 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH -tip 0/2] locking/rwbase: Two reader optimizations
To:     Davidlohr Bueso <dave@stgolabs.net>, tglx@linutronix.de
Cc:     peterz@infradead.org, mingo@kernel.org, rostedt@goodmis.org,
        bigeasy@linutronix.de, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org
References: <20210920052031.54220-1-dave@stgolabs.net>
Message-ID: <1676b749-3fca-fa67-03e6-7639ef1f5b33@redhat.com>
Date:   Mon, 20 Sep 2021 17:54:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210920052031.54220-1-dave@stgolabs.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/21 1:20 AM, Davidlohr Bueso wrote:
> Hi,
>
> Patch 1 is a barrier optimization that came up from the reader
> fastpath ordering auditing.
>
> Patch 2 is a resend of the previous broken patch that attempts
> to use wake_q for read_unlock() slowpath.
>
> Tested on v5.15.y-rt. Applies against tip/urgent.
>
> Thanks!
>
> Davidlohr Bueso (2):
>    locking/rwbase: Optimize rwbase_read_trylock
>    locking/rwbase: Lockless reader waking up a writer
>
>   kernel/locking/rtmutex.c   | 19 +++++++++++++------
>   kernel/locking/rwbase_rt.c | 11 +++++++----
>   2 files changed, 20 insertions(+), 10 deletions(-)
>
> --
> 2.26.2
>
Your patches look good to me.

Acked-by: Waiman Long <longman@redhat.com>

