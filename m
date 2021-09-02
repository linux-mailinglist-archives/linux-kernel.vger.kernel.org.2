Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66C23FF3B1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 20:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243525AbhIBTAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 15:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239024AbhIBTAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 15:00:34 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECB6C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 11:59:35 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id j15so2896112ila.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 11:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Xsi+0cTgKaznOMOYa7ndIBDlIfhPFj246cgZs1bGknU=;
        b=g74tZNTcjI6g5SvV2FnS3hsfdhAv3wxUzHslFQDDOAchPn9oQHwAkTfKoC5TTIUXHa
         sOE2BjWyplSHj9taTWXWCuuqO3jzBDOkwbPNAu6BNXDYpMNxvc4XNAoSg2VYdd6yccQW
         PryF4xOMnvoPI5FTlZvrH+Oho8EpC7kxlcRk9vtB7XrNpvI+xuWiCug0g7KErMQV/OMu
         sksSq5tJuNvNrLy4TU83s7a2/FgKvhrl/4kw2GRUhQf5bP+GUVvTDyhoFHFfzl6w3Tmz
         NJ12a++8jgiKobd7QJgRt6tHA3iuzeOPsLwwIaZ21qeY6DCBXz0UPvTKRCRm71p7+S/v
         6uLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xsi+0cTgKaznOMOYa7ndIBDlIfhPFj246cgZs1bGknU=;
        b=hlkWTOVg1Ce5BRehmJXDVQHbvyCQ1cR5BaKna0IKCvjpoVFDjwiR6jAywbHzNMqCiI
         RNrat71YH4G/T2Qe6pxi8GJ0OT1aviDuVARkrOBvg3nIXfeIbHzNuh2orPiLt90tgJUC
         Mh53PtscA5rlzC7NFuL52qlJ5wT5enTXbhmxuud7lXdZJJU/NAu1MdJXLxGB1aBEK6wB
         E9qUjRfCaGD018QWv7TA8I5WH9W54Q8SjL3KwyylgJAdD/+v+oZXCzzZpsRPOWqLlz+I
         iWlHXdE8Yak0pqkc9ZWBCUuxaNTXLxniRAimP4fRbeVI+gJWM0OPmxD3tWICoBEAeUIx
         3oyw==
X-Gm-Message-State: AOAM533YeoZ4fdseR4oJms5IhW/dKJVx5F+yAj/SzurTwzCjFFWB+c8l
        W2b19MYrUvPMEeDR5/2UZ9IUnuMG3aHTHg==
X-Google-Smtp-Source: ABdhPJxtVDDqsMy6b72TGsV8ri2gqDOIuiOEylcLBNzndH8SXIshTYO7hqOtxZEuHk8bBGWBCq+IqQ==
X-Received: by 2002:a92:7b0c:: with SMTP id w12mr3458035ilc.307.1630609174837;
        Thu, 02 Sep 2021 11:59:34 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id b12sm1417094ios.0.2021.09.02.11.59.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 11:59:34 -0700 (PDT)
Subject: Re: slub: BUG: Invalid wait context
To:     Matthew Wilcox <willy@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Lameter <cl@linux.com>,
        Linux Memory Management List <linux-mm@kvack.org>
References: <3b7661a1-dbde-ea54-f880-99777c95ae22@kernel.dk>
 <YTEeTK83KNBmuJLC@casper.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <91af18d0-64cb-71ac-e9f4-4135fe02cb33@kernel.dk>
Date:   Thu, 2 Sep 2021 12:59:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YTEeTK83KNBmuJLC@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/21 12:56 PM, Matthew Wilcox wrote:
> On Thu, Sep 02, 2021 at 10:22:23AM -0600, Jens Axboe wrote:
>> Hi,
>>
>> Booting current -git yields the below splat. I'm assuming this is
>> related to the new RT stuff, where spin_lock() can sleep. This obviously
>> won't fly off IPI.
> 
> You want to turn off PROVE_RAW_LOCK_NESTING for the moment.

Because?

-- 
Jens Axboe

