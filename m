Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC7C415154
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237593AbhIVUYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237553AbhIVUYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:24:51 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6915AC061757
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:23:21 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id bk29so14130769qkb.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TEV/Vzi75nBQ0CgOWTo2LIT5xk/CQpqKUn1lL40YXMU=;
        b=DDbmxtbe6npd0HBHK0YoCqJgrvf7mfstmOFC+uUJiEnR9C1o+94NaRaQcE2K2Sm1Ln
         JBLoMsOdAZ8Ds9czVGxzHL4m5lj0Z0r+HlZLchgn50khgYUIHfBlEdyPwOcOFOSIt1+A
         9sK4B4AXSoL1lXMuIPnbu7+M1xxK3QtdGWNWIxDldG4NtGOZLnRK+9LZIIneRsTx2s15
         7dECv1IZltjJumF+7mFuFDafWSEzY+2TwQOUAJ7qJd9uWVspQccFL6SKchtj8VBXTf6P
         Y8vScOJMUirdYG7UeIEydi1JxHvhI4XKxNi5YWBb/WzwFVvw3J1f4mzX2omiHmaRXpRu
         CMzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TEV/Vzi75nBQ0CgOWTo2LIT5xk/CQpqKUn1lL40YXMU=;
        b=ANPxVVV0UFzY+zkixGpJ6pEbtzIIl5L7Jfi9PHejIuCTbQJ4SzrBbua5RkI5cZNaml
         2krqByqi+dNCMMa/8Ee+bQsg8zxbpXVPWXzJW4dISkSrXSzquJ1jf2/VaDYiqbHN4IN6
         +H6zmAXoKWT/MlZHle7Gt3pCMB6xFqYAUmBPn2L/7CwfEdU9feCX4Z1qT1gbH4/ML9Ne
         MZI85pLN+GMViTCnnwnqbMWubWN0CZHLHDNcixixm0HLCVIM3+eGL9ObAUGI0VdmxM4+
         CznUl5ySDrxz4+4qSJCiejTeyLMiUuOOTIOMTDMGIvLq+nJBsZ42ZIiN3RXMv4LF0UcX
         EQfQ==
X-Gm-Message-State: AOAM531qMQsVYfm01rpM0uTUI2AP2LoCbJazhutULH2LskCttUgk43Kl
        GJ3bQnZWaeJLbLZnFxRsqy5FPDQyryQbT+vZDXoYNw==
X-Google-Smtp-Source: ABdhPJyEx6KBe9BQEZ0kEhx991VWLgF8Es/v0jUNZTuXN7al4IqDjMj8qvUcB4XbYLssLYxzNl/Kn+9mRNLr1Tn9jNQ=
X-Received: by 2002:a05:620a:53d:: with SMTP id h29mr1232083qkh.395.1632342200580;
 Wed, 22 Sep 2021 13:23:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1632240523.git.cdleonard@gmail.com>
In-Reply-To: <cover.1632240523.git.cdleonard@gmail.com>
From:   Francesco Ruggeri <fruggeri@arista.com>
Date:   Wed, 22 Sep 2021 13:23:09 -0700
Message-ID: <CA+HUmGjQWwDJSYRJPix3xBw8yMwqLcgYO7hBWxXT9eYmJttKgQ@mail.gmail.com>
Subject: Re: [PATCH 00/19] tcp: Initial support for RFC5925 auth option
To:     Leonard Crestez <cdleonard@gmail.com>
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Yuchung Cheng <ycheng@google.com>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Christoph Paasch <cpaasch@apple.com>,
        Ivan Delalande <colona@arista.com>,
        Priyaranjan Jha <priyarjha@google.com>,
        Menglong Dong <dong.menglong@zte.com.cn>,
        netdev <netdev@vger.kernel.org>, linux-crypto@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 9:15 AM Leonard Crestez <cdleonard@gmail.com> wrote:
> * Sequence Number Extension not implemented so connections will flap
> every ~4G of traffic.

Could you expand on this?
What exactly do you mean by flap? Will the connection be terminated?
I assume that depending on the initial sequence numbers the first flaps
may occur well before 4G.
Do you use a SNE of 0 in the hash computation, or do you just not include
the SNE in it?

Thanks,
Francesco
