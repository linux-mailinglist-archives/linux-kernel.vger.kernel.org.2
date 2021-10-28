Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 480C743F1F9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 23:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbhJ1Vmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 17:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbhJ1Vmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 17:42:38 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F80C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 14:40:11 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id x27-20020a9d459b000000b0055303520cc4so10550498ote.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 14:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=89VrJzRM6RSUwQ34qooXEsp/HB/bFE0T6xqi3PWio58=;
        b=Nst+4BGfxiu2+vvOdbBbejnK23enK5y2aRCcIlfvWfygRepiXwpjAi1yLCbk9FkpsQ
         /tl8Z5Iw4Y6eBlJZ4W7R7bvSp2lHtGJbg6aqHsCzunrD0Ip/s1csNK3H1Z/Agb0EyYf1
         euuSz0KhaeB4kZI8kXUjLU4gzwtLPkx8/uewJ9kqt59N+WZLV70BsdlxP1HGg9KgMuFy
         ZSrTJKpXubIIdc1h8DJagtmniI0xWdanAaFf9akHyt4sAZpQMILbeYf4GIjVdA5Y+w14
         OBNbtwxXnSj5qqWaUDfBrvzGmFQPY0RbyIhQAH4D9M2Ja45pWiSwFFftBGr3g1oWR/DK
         0Mog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=89VrJzRM6RSUwQ34qooXEsp/HB/bFE0T6xqi3PWio58=;
        b=q//E5bw9VpdLYliasIbKUfnM48g96ZfOc7kV1Op2mZUvtq1dP4UqIA7qdQGPl3lzvi
         P6Y9JMUReihqdb6qr36u7VSlNwmbtPIo2nhpA9giWc0rJa9LDdsH1I3bQlcacTIdnYUL
         EKaMI6hBo3WLQK81LAecKUf5tI2fjNkjVPDOlSgy9feEUqmmJfdBmWWJIHpXZAqfMAwt
         sxGFBJYj+9yFKFYZn6Tivk+ajhbBqGNSdRVcqgqOSouBIvlc1i9pgnG69U1E4e8Q3izu
         KthM7hAnlNUtH2OiNwrlSCtmlcDtR5T98kysj8rLzMKrkY/BW3qgskcqEJwaryM8hnLN
         v+qw==
X-Gm-Message-State: AOAM53118NbTozvXJu0Vrk+Pk6I2pjwIaz+goNktDjf7jsZ0HezOGCma
        JaYTaqff9zS8H3oFlpl81yH4aw==
X-Google-Smtp-Source: ABdhPJxD4RRQf4ewazIJAWZ25QZm3uIKBcw8qNYQDjh2e9Od46iqsRzLjKGWXVgPI5aOcdnn2F12Jg==
X-Received: by 2002:a05:6830:2693:: with SMTP id l19mr5551898otu.45.1635457210829;
        Thu, 28 Oct 2021 14:40:10 -0700 (PDT)
Received: from ?IPv6:2600:380:541f:dad6:7383:302f:cb69:f16c? ([2600:380:541f:dad6:7383:302f:cb69:f16c])
        by smtp.gmail.com with ESMTPSA id l8sm1398021otv.8.2021.10.28.14.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Oct 2021 14:40:10 -0700 (PDT)
Subject: Re: [BUG] About "io_uring: add more uring info to fdinfo for debug"
To:     Eric Dumazet <eric.dumazet@gmail.com>,
        Hao Xu <haoxu@linux.alibaba.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>
References: <9ac22d4d-c841-651a-fdd5-9fb3a65c57ab@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e72cdd44-c027-e51c-8b57-24f39bf21d87@kernel.dk>
Date:   Thu, 28 Oct 2021 15:40:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9ac22d4d-c841-651a-fdd5-9fb3a65c57ab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/21 3:24 PM, Eric Dumazet wrote:
> Hi
> 
> I was looking at commit 83f84356bc8f2d
> ("io_uring: add more uring info to fdinfo for debug") after receiving
> syzbot reports.
> 
> I suspect that the following :
> 
> +       for (i = cached_sq_head; i < sq_tail; i++) {
> +               unsigned int sq_idx = READ_ONCE(ctx->sq_array[i & sq_mask]);
> +
> +               if (likely(sq_idx <= sq_mask)) {
> +                       struct io_uring_sqe *sqe = &ctx->sq_sqes[sq_idx];
> +
> +                       seq_printf(m, "%5u: opcode:%d, fd:%d, flags:%x, user_data:%llu\n",
> +                                  sq_idx, sqe->opcode, sqe->fd, sqe->flags, sqe->user_data);
> +               }
> +       }
> 
> 
> Can loop around ~2^32 times if sq_tail is close to ~0U
> 
> I see various READ_ONCE(), which are probably not good enough.
> 
> At very minimum I would handling wrapping...

Thanks for reporting this. I think on top of wrapping, the loop should
just be capped at sq_entries as well. There's no point dumping more than
that, ever.

I'll take a stab at this.

-- 
Jens Axboe

