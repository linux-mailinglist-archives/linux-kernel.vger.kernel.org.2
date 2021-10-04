Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8200942077C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 10:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbhJDImq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 04:42:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:38171 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229507AbhJDImn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 04:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633336853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=++xf85KrwjKjUR0N++5TlHyfSBlnuiKqimGu6zW+36M=;
        b=XSA3Sqv9r0hWjU5ViAe9CinlyzP/sOC6hoT1QX9TPORsu7T9sbCutC65DvRBvQgy2aZ0OJ
        K9S/UCuKU76LcENCPkZjU/GarMnAMYDfugGH3F7pa93CDdpYuqBHGos7WkVpMgP3EgqqH7
        bSUDfOQPqOlJHYWX+LrZwli2WPWAlTQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-Y8e2y2gxNXeXoVfB2wjmIQ-1; Mon, 04 Oct 2021 04:40:52 -0400
X-MC-Unique: Y8e2y2gxNXeXoVfB2wjmIQ-1
Received: by mail-ed1-f69.google.com with SMTP id m20-20020aa7c2d4000000b003d1add00b8aso16525327edp.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 01:40:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=++xf85KrwjKjUR0N++5TlHyfSBlnuiKqimGu6zW+36M=;
        b=QYdxLQnRBh8eKRgeKitPg93G4UkpEEsKFdbFJCLgXlcS1LKzXz90oiVyd2etWx+/5h
         2ciGa9KQ+GFDZ7KnMHYea9Fr5tuKyVpS/UDKT5/1dQzUg5JMiyb51514OtjWyQAGjYeW
         pLLtm0JPlFBHnDstsbjj8S1H1+eUWam0BZ6YtZS/SyJHHWfhbsbTCq7fdbId7B69cyjS
         icprXLP8AeJSodWFjkMoF91k/ERfNh2v7KPgPfXW7mA2Te0nIwDtEzgz1SoX7a/UqMpS
         vMwx7+aQSuVbRJn8GAMPVp5RpLaDllERvfMPCfwJvwulja4GjaJC1YezVY05MENAToLK
         /2NQ==
X-Gm-Message-State: AOAM5306y/fGQy49RKq0+SaoJNZ9E1wZpgxQohn1oWqlWwWutS3ft1/g
        42uNTkTjNAD5Ev+/LfxV/okjkZxzojNA6ajEJFYIFY25/hCWB7L5Jwz0WqE4kxKDLSZ38fVExPR
        q0K6rEqQflWrXW+ZYXki1y1x2
X-Received: by 2002:a17:906:bcf7:: with SMTP id op23mr16092831ejb.317.1633336851489;
        Mon, 04 Oct 2021 01:40:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcakdHkBGbuLanS3x3wbeKZDEtGC7oRl9PdPTJXqNEgmgTiWU4R0A0+dfATKe3rGIuRn6dnQ==
X-Received: by 2002:a17:906:bcf7:: with SMTP id op23mr16092816ejb.317.1633336851258;
        Mon, 04 Oct 2021 01:40:51 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id j16sm6957067edw.23.2021.10.04.01.40.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Oct 2021 01:40:50 -0700 (PDT)
Message-ID: <86d3981b-2195-7c03-9917-520761aaeaa5@redhat.com>
Date:   Mon, 4 Oct 2021 10:40:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v20 00/17] KVM RISC-V Support
Content-Language: en-US
To:     Palmer Dabbelt <palmerdabbelt@google.com>, anup@brainfault.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        graf@amazon.com, Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <Anup.Patel@wdc.com>,
        philipp.tomsich@vrull.eu
References: <mhng-b5a035ae-a545-4c81-a8d9-301c6f7e6982@palmerdabbelt-glaptop>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <mhng-b5a035ae-a545-4c81-a8d9-301c6f7e6982@palmerdabbelt-glaptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/10/21 18:18, Palmer Dabbelt wrote:
> 
> Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
> 
> IIUC the plan here involved a shared tag at some point, with most of 
> this going through Paolo's tree.  If you still want me to merge 
> something then I'm happy to do so, just make it clear as I've mostly 
> lost track of things.

I'll prepare a shared tag with the first two patches as soon as I finish 
reviewing the rest.

Paolo

