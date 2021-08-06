Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7DD3E268F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 10:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243591AbhHFI6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 04:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbhHFI6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 04:58:39 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0FCC061799
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 01:58:22 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id hs10so14122059ejc.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 01:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Iw/Qld2BXHBhuZYypT5bN2CCKgDqDnynAHMjC5IKYhw=;
        b=bAuhZuxuGSyYxPQn5X+Har7aoOkIEccdwEP6EtLovSPxgCEtOc1Xu8fMKZ740wXuY4
         8y2h444bZoljFnbwX5td/YoN0oYU9d+iQM2ArWXpJtbR0ZAajjYfZGt4MK5VLkkKJPon
         n7qiFiw/n6OArpr/D8vO4mauFptmiqu9sJk3jE9lrSg2cH4naqDt7atF29DovPILkgEX
         tAPm0vBv6ySPI2IxPGnFpeDMvSiFvRPzGLk1kbkIokGld4ot4pQGAVNAmU6g/sKwvkAx
         l02Ocaklk5fmuT8P1yC2ib+wjgfmDct3ga28KyLUNKVxCQi+YFe80w3g3838FNNL8wCZ
         AzFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Iw/Qld2BXHBhuZYypT5bN2CCKgDqDnynAHMjC5IKYhw=;
        b=gsTvj57ic3wAuEsP2Z0D9gbJrEwvmnL3L6CtRNUj08ol83cQetlSz+OtLc6/0/ZTAd
         MItHnrL8l3yy4Dxz63zUIIMXINaNlrKspmhFC17XzCWjF1kgqP3Ch2OWvwshWABHeh03
         WZPmLnKvC2PnNKS6h4YR5O41ZwGJFGC9nWSxnBLvKaI/j13/q/xaLIbC+Bgr47V7izGR
         9PM+lGejJzvls4Qww1D+0DpLSryyCRY2BNrp9Bz8Q4If72nZnFZ0VL+a23IQr4p97FtV
         vupEBWi5VBSctOTTPhxf/9rsTWcfJS6Y4EhYlOq2nD9U8XJM86Yi7X0cGkFhjr81+4M2
         8cTQ==
X-Gm-Message-State: AOAM5326J4kVPk3wNcO9noQ6/EYbNN1bc8yS2Ni82DWeIAIIFmvk4ai/
        mm0M9lWoV50QE+nryh9adg9s8Qr5t3Zmkr+s
X-Google-Smtp-Source: ABdhPJwY5LT29MLFMd+DAew3TMJoytUphZsKpnjrTCeSOTD1wf0nQmwfAyslJIIt2cMFwxki8xFdWQ==
X-Received: by 2002:a17:906:138d:: with SMTP id f13mr8998205ejc.34.1628240301420;
        Fri, 06 Aug 2021 01:58:21 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net (94.105.102.61.dyn.edpnet.net. [94.105.102.61])
        by smtp.gmail.com with ESMTPSA id mh10sm2648924ejb.32.2021.08.06.01.58.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 01:58:21 -0700 (PDT)
To:     Yajun Deng <yajun.deng@linux.dev>, davem@davemloft.net,
        kuba@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210806063847.21639-1-yajun.deng@linux.dev>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH net-next] net: Remove redundant if statements
Message-ID: <4b175501-50c1-fedf-1eaf-05c0de67c3c8@tessares.net>
Date:   Fri, 6 Aug 2021 10:58:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210806063847.21639-1-yajun.deng@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yajun,

Thank you for sharing this patch.

On 06/08/2021 08:38, Yajun Deng wrote:
> The if statement already move into sock_{put , hold},
> just remove it.

I was wondering in which subtree you had 'sock_put' checking the socket
pointer but then I realised you sent another patch just before adding
this check: "net: sock: add the case if sk is NULL"

Please next time send them in the same series to clearly indicate that
this is the 2nd patch (2/2) and it depends on patch 1/2.

Related to the modification in MPTCP part: it looks OK but we do a few
other calls to 'sock_put()' where we don't need to check if the socket
is NULL or not.

In other words, if your patch "net: sock: add the case if sk is NULL" is
accepted, then the modification in "net/mptcp/subflow.c" is OK for us.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
