Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 279193993EB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 21:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbhFBTwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 15:52:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53419 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229724AbhFBTwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 15:52:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622663430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y+mlRznXk5uF6iXxffuwd5UPE2tHtEL5uBgD2A9gsuo=;
        b=I2wANYvm6kqKPXIIsjDsL7nmJxj/evBpmytG7Or0puWuLuSAFVCu3D9BXI7hPEWC0BuCVG
        4q5CfOsadW9oBxsEN731JoSPrveiD2Io8XJ0Pebds4Gl/tYFplfbIcj/ja1H2NoHVCqWKy
        gt/ZtpnzZ6gSLEQhixRVajyc74ScmqQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-CRE9yyuvPV2Dlq3EiGWt6Q-1; Wed, 02 Jun 2021 15:50:29 -0400
X-MC-Unique: CRE9yyuvPV2Dlq3EiGWt6Q-1
Received: by mail-qv1-f70.google.com with SMTP id h11-20020a0ceecb0000b0290211ed54e716so2650629qvs.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 12:50:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=y+mlRznXk5uF6iXxffuwd5UPE2tHtEL5uBgD2A9gsuo=;
        b=R07aTX8ndHX6SKr37ujx2D8zBipwSg1G6F9eMqnWiv4g08Js/n5lVw1/aLlpO/fkIn
         hZMx2EhRbAwpWVw6SQKXrYxXoBjnH2EqnMphYCquY23PkII5Vc8QLfjRulfutAX5ZvJZ
         whryUDwuSF5//jisLUNIY+pbGZ/4nTKfn2/Z1knwzF5TiP1thXJOBjQvS1I7aszfhlu8
         GdDTwrBb2wpcyMM/fpLc5o1ApeDQqqXswtNRY84J1CkdtLrWeZc/YtvdEFDgTX+TE9UV
         3VNSnBshDRzelgX599Dx2vpuUhQAB4ZsjHPJOUmX8pZgTfwz9BWJXMvubQt7s+l3jzx5
         WPPQ==
X-Gm-Message-State: AOAM5303wGnajPzU2I69pVlrZZBLWLcp9v0Vs/ifU8iBKawxp+7wa2og
        T4sWnlGEHi4u3uE5ZBTETlGJSPHaace4KG5LQMcAamXrwu+nBAqoU0HULWk6HmEzNvibk4TdeIY
        QOkDZaHK/bibe3I5zaFAV2W2Uu32DVxg84y/IzJetnWGMbkhUrXkDfyCznXWdaSf+Cc3TcG8KiQ
        ==
X-Received: by 2002:a05:620a:28c6:: with SMTP id l6mr28652837qkp.155.1622663429133;
        Wed, 02 Jun 2021 12:50:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzFJHBmcUbD55J5L4sZyDu1eqC9Fnu8R9UkmhdgxORBAi0xGp+SYGoDpH2tKnts8hKPDkz2w==
X-Received: by 2002:a05:620a:28c6:: with SMTP id l6mr28652815qkp.155.1622663428868;
        Wed, 02 Jun 2021 12:50:28 -0700 (PDT)
Received: from [192.168.0.106] ([24.225.235.43])
        by smtp.gmail.com with ESMTPSA id p3sm469425qti.31.2021.06.02.12.50.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 12:50:28 -0700 (PDT)
Subject: Re: The value of FB_MTU eats two pages
To:     Menglong Dong <menglong8.dong@gmail.com>
Cc:     ying.xue@windriver.com, David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, etdev@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
References: <CADxym3baupJJ7Q9otxtoQ-DH5e-J2isg-LZj2CsOqRPo70AL4A@mail.gmail.com>
From:   Jon Maloy <jmaloy@redhat.com>
Message-ID: <e91baaba-e00a-4b16-0787-e9460dacfbb9@redhat.com>
Date:   Wed, 2 Jun 2021 15:50:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CADxym3baupJJ7Q9otxtoQ-DH5e-J2isg-LZj2CsOqRPo70AL4A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/1/21 10:18 AM, Menglong Dong wrote:
> Hello!
>
> I have a question about the value of FB_MTU in tipc, how does the '3744' form?
> I notice that it is used in 'tipc_msg_build()' when memory allocation
> fails, and it
> tries to fall back to a smaller MTU to avoid unnecessary sending failures.
>
> However, the size of the data allocated will be more than 4096 when FB_MTU
> is 3744. I did a rough calculation, the size of data will more than 4200:
>
> (FB_MTU + TIPCHDR + BUF_HEADROOM + sizeof(struct skb_shared_info))
>
> Therefore, 8192 will be allocated from slab, and about 4000 of it will
> not be used.
>
> FB_MTU is used for low memory, and I think eating two pages will make it worse.
> Do I miss something?
>
> Thanks!
> Menglong Dong
>
Hi Dong,
The value is based on empiric knowledge.
When I determined it I made a small loop in a kernel driver where I 
allocated skbs (using tipc_buf_acquire) with an increasing size 
(incremented with 1 each iteration), and then printed out the 
corresponding truesize.

That gave the value we are using now.

Now, when re-running the test I get a different value, so something has 
obviously changed since then.

[ 1622.158586] skb(513) =>> truesize 2304, prev skb(512) => prev 
truesize 1280
[ 1622.162074] skb(1537) =>> truesize 4352, prev skb(1536) => prev 
truesize 2304
[ 1622.165984] skb(3585) =>> truesize 8448, prev skb(3584) => prev 
truesize 4352

As you can see, the optimal value now, for an x86_64 machine compiled 
with gcc, is 3584 bytes, not 3744.

Feel free to post a patch for this if you want to.

Thanks
///Jon Maloy

