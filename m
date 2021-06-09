Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755953A0DCD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 09:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237330AbhFIHgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 03:36:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53188 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235626AbhFIHgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 03:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623224077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dKHLpYCGx0g7EoGipPcjgNbmX1MLZSaTZNKvZi1Yge0=;
        b=MjASQ07atcm0cfKbt8gYkYtEmx1OnLnJ5Fo3QxT92qq50w1RV554YNPaMcNUd6AVFVTTYD
        /mYgjWkJ/xGOVMC1HpxuwvmzJlu0CmBzjB6q4PHiPr1lely7LwnHUnff5khhOZ07jMRyeL
        Z9/rO9v/QtPYtt9yCBhaHBocQ9ygnk4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-0H6n1_NdMsy9PBeEABf_UQ-1; Wed, 09 Jun 2021 03:34:36 -0400
X-MC-Unique: 0H6n1_NdMsy9PBeEABf_UQ-1
Received: by mail-qk1-f200.google.com with SMTP id v16-20020ae9e3100000b02903aafadba721so2198595qkf.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 00:34:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=dKHLpYCGx0g7EoGipPcjgNbmX1MLZSaTZNKvZi1Yge0=;
        b=L73Rwyo3bU2ttCdVbcpm0obQ93McqZbi+Fl/cPPBmyVw1tbCNykMYF4Wo3vbkZZbUQ
         Gfoz8bohbFyzwvct1OAn3ZF7DYTyRLjehdbX13L/KeEfmXCdVttHB/WCyk2dpArRrPRt
         uCCEP66j9sTmoOLHhGqFG31ee5mqLZ4iEQBurfXRIOGOklIzDUwcTpjo4TF9InN++2t+
         4RrBaWbcHfnXaA8qBtgZGHv7i4VWtpvMz/n0WMmG6CwQNsIynn/LEF3739YVnvrsyhIn
         t16s20brCFiilu6mOsoVq63QfcYhAj5YozY0RBNWurJzdmkLwjugEsTrCd/K3+JECLoq
         xCog==
X-Gm-Message-State: AOAM5322Y9S9hO2LeyNxhUkj3CrN3gQCwSy6rORXhS5fPnE5RHFVLrRY
        1rZTehXN4T3t1dR8DzmV9c8IjgXUnlTh1azCKikuykydcpL99Zre9Jtd/B1W6QF3C/3xrcIaNhM
        UPnbJTSrVXntPU3q4FfIjmVNX
X-Received: by 2002:a05:620a:1253:: with SMTP id a19mr11372150qkl.365.1623224076136;
        Wed, 09 Jun 2021 00:34:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyeQ3vZwJD5V9+1RCCrE3JekeNNLTpi7d82jJPwWzCuGoj9yPBCBVWCXy2YNny96QDa4zPseQ==
X-Received: by 2002:a05:620a:1253:: with SMTP id a19mr11372138qkl.365.1623224075940;
        Wed, 09 Jun 2021 00:34:35 -0700 (PDT)
Received: from [192.168.0.106] ([24.225.235.43])
        by smtp.gmail.com with ESMTPSA id g19sm6014609qto.49.2021.06.09.00.34.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 00:34:35 -0700 (PDT)
Subject: Re: [PATCH net-next] net: tipc: fix FB_MTU eat two pages
To:     Menglong Dong <menglong8.dong@gmail.com>
Cc:     ying.xue@windriver.com, David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        tipc-discussion@lists.sourceforge.net,
        Menglong Dong <dong.menglong@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20210604074419.53956-1-dong.menglong@zte.com.cn>
 <e997a058-9f6e-86a0-8591-56b0b89441aa@redhat.com>
 <CADxym3ZostCAY0GwUpTxEHcOPyOj5Lmv4F7xP-Q4=AEAVaEAxw@mail.gmail.com>
 <998cce2c-b18d-59c1-df64-fc62856c63a1@redhat.com> <20210607125120.GA4262@www>
 <46d2a694-6a85-0f8e-4156-9bb1c4dbdb69@redhat.com>
 <20210609025412.GA58348@www>
From:   Jon Maloy <jmaloy@redhat.com>
Message-ID: <927af5e7-6194-d94e-1497-6b3dce26c583@redhat.com>
Date:   Wed, 9 Jun 2021 03:34:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210609025412.GA58348@www>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/8/21 10:54 PM, Menglong Dong wrote:
> On Tue, Jun 08, 2021 at 06:37:38PM -0400, Jon Maloy wrote:
>>
> [...]
>> I spent a little more time looking into this. I think the best we can do is
>> to keep FB_MTU internal to msg.c, and then add an outline function to msg.c
>> that can be used by bcast.c. The way it is used is never time critical.
>>
>> I also see that we could need a little cleanup around this. There is a
>> redundant align() function that should be removed and replaced with the
>> global ALIGN() macro.
>> Even tipc_buf_acquire() should use this macro instead of the explicit method
>> that is used now.
>> In general, I stongly dislike conditional code, and it is not necessary in
>> this function. If we redefine the non-crypto BUF_TAILROOM to 0 instead of 16
>> (it is not used anywhere else) we could get rid of this too.
>>
>> But I leave that to you. If you only fix the FB_MTU macro I am content.
>>
> Yeah, I think I can handle it, just leave it to me.
>
> (finger heart :/)
> Menglong DongI
It seems like I have been misleading you. It turns out that these 
messages *will* be sent out over the nework in some cases, i.e. at 
multicast/broadcast over an UDP bearer.
So, what we need is two macros, one with the conditional crypto 
head/tailroom defined as you first suggested, and one that only use the 
non-crypto head/tailroom as we have been discussing now.
The first one can be defined inside bcast.c, the latter  inside msg.c.
It might also be a good idea to give the macros more descriptive names, 
such as ONEPAGE_MTU in the broadcast version, and ONEPAGE_SKB in the 
node local
version.

Does that make sense?

///jon


>

