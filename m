Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72DD43AC6A1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 10:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbhFRI7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 04:59:38 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48063 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhFRI7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 04:59:34 -0400
Received: from mail-ed1-f70.google.com ([209.85.208.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1luAJZ-00015d-3K
        for linux-kernel@vger.kernel.org; Fri, 18 Jun 2021 08:57:25 +0000
Received: by mail-ed1-f70.google.com with SMTP id cb4-20020a0564020b64b02903947455afa5so1377884edb.9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 01:57:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=90eZ7DdlkWMvodEOxckCvRjJunUc+CQAeE7AAVorkBo=;
        b=KOJAg0P2xa23svQkr6ocFCYR9d0uPRp2sqSaWUTUhi4mljmmLq52TIVOol71t+PxMv
         pS9n3shhBiv5hd8Ud29iuGMuj3PpxISVhcR/VkVrG5hpNYQLj8PETVrWWr3Co6QlTY2y
         u0DlHIRqFs76QCQsXs7cNROwyWqZoTZo+a4Lx8evl0yKoqNmSWtdvz+gvnjcEXhUQd/7
         eM/SBQlMQze8o89l3N3wSYm3ak179tGLkvI7/v5hXS5v7QOpc9dANGcMA0v6ajLtJwOB
         8IEPwHg3cRxHgxppOqzRupkp3bpVasPW2sGEDYzdiKltdxE4Qgjao5FTJz1gV5YUghjW
         I+OQ==
X-Gm-Message-State: AOAM532P7J/Le7XLKbbKp87aSEuvKqmzZ21XaR3SWNXlFiP5OWop9AqA
        P95U7lX6+sm1cQUs5IkU14kYUdxVHDAkYevTkeHWfMxSxumsr3adqpX9ZwOtMmSUTjw/SyuxG6K
        W8+l2Q2dMH9eXat4Bzz9d6lWSey1Urtddtq31YqX0UQ==
X-Received: by 2002:a17:906:9bef:: with SMTP id de47mr9635393ejc.78.1624006644473;
        Fri, 18 Jun 2021 01:57:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxWHwb0R1Y7NCVvXM1ylqzUaMbxbRhFt2x1HrSz6JE9ym4XOR5P9tZt+dFWHoNsxRJp5m4ygw==
X-Received: by 2002:a17:906:9bef:: with SMTP id de47mr9635385ejc.78.1624006644337;
        Fri, 18 Jun 2021 01:57:24 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id g23sm753292ejh.116.2021.06.18.01.57.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 01:57:24 -0700 (PDT)
Subject: Re: [PATCH 5.4 031/184] modules: inherit TAINT_PROPRIETARY_MODULE
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Christoph Hellwig <hch@lst.de>, Jessica Yu <jeyu@kernel.org>
References: <20210510101950.200777181@linuxfoundation.org>
 <20210510101951.249384110@linuxfoundation.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <8edc6f45-6c42-19c7-6f40-6f1a49cc685b@canonical.com>
Date:   Fri, 18 Jun 2021 10:57:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210510101951.249384110@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2021 12:18, Greg Kroah-Hartman wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> commit 262e6ae7081df304fc625cf368d5c2cbba2bb991 upstream.
> 
> If a TAINT_PROPRIETARY_MODULE exports symbol, inherit the taint flag
> for all modules importing these symbols, and don't allow loading
> symbols from TAINT_PROPRIETARY_MODULE modules if the module previously
> imported gplonly symbols.  Add a anti-circumvention devices so people
> don't accidentally get themselves into trouble this way.
> 
> Comment from Greg:
>   "Ah, the proven-to-be-illegal "GPL Condom" defense :)"

Patch got in to stable, so my comments are quite late, but can someone
explain me - how this is a stable material? What specific, real bug that
bothers people, is being fixed here? Or maybe it fixes serious issue
reported by a user of distribution kernel? IOW, how does this match
stable kernel rules at all?

For sure it breaks some out-of-tree modules already present and used by
customers of downstream stable kernels. Therefore I wonder what is the
bug fixed here, so the breakage and annoyance of stable users is justified.



> 
> [jeyu: pr_info -> pr_err and pr_warn as per discussion]
> Link: http://lore.kernel.org/r/20200730162957.GA22469@lst.de
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jessica Yu <jeyu@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


Best regards,
Krzysztof
