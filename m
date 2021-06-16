Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18FD3A9E20
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 16:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbhFPOy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 10:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234200AbhFPOy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 10:54:26 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56DBC061767
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 07:52:20 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id k5so3271189iow.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 07:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ho0nMLLWDiEI8PWRRnO12oSgVwkuBUrJL0BDNxvINsA=;
        b=hoREoaRWaUrQikoDfDACdirEoAtNi+fOmNy3ydxCJMLyS1AYVOlkcC6i6q2ACi7hoR
         YdvK7zt01zFnWIoInOM4K4wHv15MobleKQ1Md6yZJgidSl5oEj8UBm6vgBx5+levT+bF
         gqF6j+MUp/6RnngHTAeIvJzipUGYH5hjKD1VuO/9eya66IdaHMbpo/KgDZ3DVaHvErqA
         B3qi1ZmurpgN6d4R5YCa0cXu/kDnuxtw+1LeEfjQcxRp6ZbVEoBzspOFJuy/TVVDm65t
         V0QVWPMfUuOXT+50eXThDDyewiClZ1fYk3Xwe/r2yV0gFF5zxhb9twIsyab3WIZv3KyY
         DAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ho0nMLLWDiEI8PWRRnO12oSgVwkuBUrJL0BDNxvINsA=;
        b=MM39cvIT9qJa5un4cX9c0QtIfly88MVXktQMuIolRtcDOmLLJLInKShjcUO5C8H4aq
         nZCtTEKWilW2+nAeAUZuBi08QMF6vcY6J838ihRZ9zmwCgjLj/6/7NsckIa75cufpt68
         A6X35C6sqs7WUeoPTfnYV5vCXGaDeHspsmTWfwoiq2iJobxbza28cgaQ3z3Y56+Y4R3p
         eu7Bf9hXS+Y65A9cb+uE/Lo9T7wiZZVUvhTXKWe5Ta/XNW7TJfI+tB1nTu8L0w1qIvx6
         nekqM9AHrhaoM9H5bWyCtBZfvArdEdhnkpR1IhqkjOxkdRE1CbZjEuSvS8sNM4rPqLUG
         2p6Q==
X-Gm-Message-State: AOAM532KVdMsCC+TGwO5Bf3YxeCcRX5A1S2OqTgg5GK/vw84OSmIvmqf
        R5XT9j+/kPumeYHwL0r5pEhqgQ==
X-Google-Smtp-Source: ABdhPJwRYyaHR20NfmOGxiiM9sMUCdWhA1YbxXGNbJVFB3qF4ZclbwduUBkSVJG7m8JN/4680wB/fg==
X-Received: by 2002:a5d:91ca:: with SMTP id k10mr292660ior.23.1623855140114;
        Wed, 16 Jun 2021 07:52:20 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id h200sm1298166iof.6.2021.06.16.07.52.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 07:52:19 -0700 (PDT)
Subject: Re: remove the legacy ide driver v2
To:     Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org
References: <20210616134658.1471835-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4b003372-41d0-507a-b74b-b73aa33189f4@kernel.dk>
Date:   Wed, 16 Jun 2021 08:52:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210616134658.1471835-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/21 7:46 AM, Christoph Hellwig wrote:
> Hi all,
> 
> we've been trying to get rid of the legacy ide driver for a while now,
> and finally scheduled a removal for 2021, which is three month old now.
> 
> In general distros and most defconfigs have switched to libata long ago,
> but there are a few exceptions.  This series first switches over all
> remaining defconfigs to use libata and then removes the legacy ide
> driver.
> 
> libata mostly covers all hardware supported by the legacy ide driver.
> There are three mips drivers that are not supported, but the linux-mips
> list could not identify any users of those.  There also are two m68k
> drivers that do not have libata equivalents, which might or might not
> have users, so we'll need some input and possibly help from the m68k
> community here.
> 
> This series is against Jens' for-5.14/libata branch.

Unless someone complains loudly, I plan on queueing this up end this
week.

-- 
Jens Axboe

