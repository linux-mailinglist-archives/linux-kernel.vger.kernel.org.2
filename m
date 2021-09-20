Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48A00412938
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 01:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238909AbhITXLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 19:11:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35898 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232799AbhITXJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 19:09:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632179303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g7bKpAyTX7x8C8f1trrgcEx0ZWLT6lt0pjDqefZ3l1Q=;
        b=aaQGEfNZadiNS2vcP1nDXWlDo16kKDnu9u+KUwZqm7bU6qJ3H2N5wI2bAYaD6adL3ymFG7
        LpLgAGkeZ563LBIj1hNogg2EUvSESGY4FBaPLZs+qn8f79HhI0P9smoHTZ+VSlajSC+wgq
        tqaJKdNBfXYvtK4+O2Xgz2PKNXrk69s=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-q579rHFuN72-iOPUwpHNJg-1; Mon, 20 Sep 2021 19:08:20 -0400
X-MC-Unique: q579rHFuN72-iOPUwpHNJg-1
Received: by mail-oo1-f72.google.com with SMTP id x23-20020a4a3957000000b0029aff3ae536so6882712oog.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 16:08:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=g7bKpAyTX7x8C8f1trrgcEx0ZWLT6lt0pjDqefZ3l1Q=;
        b=G6WbgCzGiPdx2KzNjA053Jdb6nkD7L9ogk9AQ4OJh5EaRYIF3RMeg3IurCf7kPIZzg
         mDWeCQTwijnvTTNoOi6xR5WhPb4tx/0yAKkiBHom8BIjJExsmnZkr4f5CnCacAQvw5XG
         aCMddevYmUwUL2hYThlnSE5dQ4I6022kUQUo8E764i1Xc0Xw9SarAjhwo9rUBRRKYcJ7
         3CmMvHQdaEmWU3oBbwqU7bL/sKWo5/3RniDi1qUJPFQE5gW2n6RE934ztWGiwwOirdaL
         GI/s/H7Vb3+DlsosFKtMFzx7oe9/X9+dhRoDC8M7lxDrp1nnZksC3a/6VtUOnid5Xhxo
         ylPQ==
X-Gm-Message-State: AOAM531ecMQrLc1nRz33SYTHuVbjklmt4pyxjvl6/ziGZRrdtC2eN2GD
        J5UbbURmt3Gq2xz7U7emoXaDK9pfRG61pT2B7GJIdIG+0quWqGG1Uzt3sMlHdMAr/4ZKPyLqWxk
        D9g7qQVAd0bpEvXkxViecZoTg
X-Received: by 2002:a05:6830:1212:: with SMTP id r18mr21991974otp.159.1632179299853;
        Mon, 20 Sep 2021 16:08:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLp/e5IRrlOF0BrSHhE7BuQByvaS73fu5gWXW17CjzvDKE8uc/ZdiPcjOkFCctyn4D2drE1g==
X-Received: by 2002:a05:6830:1212:: with SMTP id r18mr21991968otp.159.1632179299636;
        Mon, 20 Sep 2021 16:08:19 -0700 (PDT)
Received: from ibm-p8-rhevm-15-fsp.mgmt.pnr.lab.eng.rdu2.redhat.com ([12.183.173.244])
        by smtp.gmail.com with ESMTPSA id d26sm837804oij.49.2021.09.20.16.08.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 16:08:19 -0700 (PDT)
Subject: Re: [PATCH] octeontx2-af: fix uninitialized variable
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
        jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com,
        davem@davemloft.net, kuba@kernel.org, nathan@kernel.org,
        schalla@marvell.com, vvelumuri@marvell.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Colin Ian King <colin.king@canonical.com>
References: <20210920165347.164087-1-trix@redhat.com>
 <CAKwvOdkSt5VymxtJ4jmOe9LM1rdy+CV7yYXhjCgOFAgbKGEPfQ@mail.gmail.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <9926e65d-6083-8d9d-efa2-a755c411ea03@redhat.com>
Date:   Mon, 20 Sep 2021 16:08:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAKwvOdkSt5VymxtJ4jmOe9LM1rdy+CV7yYXhjCgOFAgbKGEPfQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/20/21 3:22 PM, Nick Desaulniers wrote:
> On Mon, Sep 20, 2021 at 9:54 AM <trix@redhat.com> wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> Building with clang 13 reports this error
>> rvu_nix.c:4600:7: error: variable 'val' is used uninitialized whenever
>>    'if' condition is false
>>                  if (!is_rvu_otx2(rvu))
>>                      ^~~~~~~~~~~~~~~~~
>>
>> So initialize val.
>>
>> Fixes: 4b5a3ab17c6c ("octeontx2-af: Hardware configuration for inline IPsec")
>> Signed-off-by: Tom Rix <trix@redhat.com>
> Thanks for the patch, but it looks like Colin beat you to the punch.
> In linux-next, I see:
> commit d853f1d3c900 ("octeontx2-af: Fix uninitialized variable val")

No worries, those allyesconfig breaks are easy to find :)

Tom

>
>> ---
>>   drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
>> index ea3e03fa55d45c..70431db866b328 100644
>> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
>> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
>> @@ -4592,7 +4592,7 @@ static void nix_inline_ipsec_cfg(struct rvu *rvu, struct nix_inline_ipsec_cfg *r
>>                                   int blkaddr)
>>   {
>>          u8 cpt_idx, cpt_blkaddr;
>> -       u64 val;
>> +       u64 val = 0;
>>
>>          cpt_idx = (blkaddr == BLKADDR_NIX0) ? 0 : 1;
>>          if (req->enable) {
>> --
>> 2.26.3
>>
>

