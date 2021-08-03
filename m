Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4973DEA09
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 11:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235138AbhHCJvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 05:51:38 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:36350
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235179AbhHCJvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 05:51:35 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 661183F338
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 09:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627984281;
        bh=sHLfXMDuePyx9cQpO+Z3/DyHmGyL/hwx4Rr4bCnhIeE=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=MbcamcQ+4W2R6GirRw8a7i/JWYHnwqNm0YSZsF8DrNOTg7GpDVJR05sVGcAEGtcmJ
         BSolAYbIiWr4v5pMVI+NdvELATCisbssvIBIss7hDgopJvI1ZepuZh54dM1d5cyggQ
         kFHRyVCuSG9llsDYo1sOhRYIru5mlHWRYTEZ7OL7sDIhFroOEJJRJXMIdNDpHyfBqk
         4vZdVfjMOhcJBD+4zW93mpGnYmC2UUQ/iJbbN/EoxnZ0iRmEeCfcM5DMO90P8u3bC1
         tpNjyO64IxLw/jECk973R50UtYGDR/CoUhfVbzg2ThPdTxK7eX3M/9uCDi6aysM33u
         ChBJl2ittQ75A==
Received: by mail-ed1-f71.google.com with SMTP id d12-20020a50fe8c0000b02903a4b519b413so10191509edt.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 02:51:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sHLfXMDuePyx9cQpO+Z3/DyHmGyL/hwx4Rr4bCnhIeE=;
        b=UkVH+CbiwULAGmXc5lmgLj75S8N6evH4beSZX4RJs1awa7WCCuFewJdT3hAcsBqR6I
         UGbZzwE9TWxoVRLbEOzfoc0Qp/Hopbrch2/A2bsJfTSYP9a5MD1WxpEn3GF8QLXBS6uf
         EnRffa7FseaN7XHj6u9SgOo+dwaA8JbbN68yhfcijEFIrl2D0oOw3WkvrXrPkF1G6MiX
         9E7Z22aRkw9nsgRvKfXp6fOh+W7oS9imjCsswEXZD6H5UOMCXVY6+OazJTXHtR9zAFO/
         kxCYbg+FZowohV3ayg+aNwQC2JEYD/tZCYwm5oIATK/M0sbLdNipPs/lOOSS2m1SpxSf
         mmDw==
X-Gm-Message-State: AOAM533LSl2yqfX/n7fVtMatNmhFj7aT7309CAv39BnEP2PWfC4FSoS4
        IAglvoolLbTnmp4a+30cU21+DpBjRKt8Ic3y8QBYOyF37PegZBDlY5g/sQF3eQwGAnfzLBbLIDj
        Ow+T2YrDQ2oruiA/GZ1Ogb9DYseTII3Lh3a3GSDSaIA==
X-Received: by 2002:a17:906:314e:: with SMTP id e14mr7859822eje.165.1627984280967;
        Tue, 03 Aug 2021 02:51:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+GlPWXGId+UBYUG/aEkt5Ge0/sHzm9wIEzWvMKwAFH/Ev8O42iqrxBKAvDrDuQs6nKUg25g==
X-Received: by 2002:a17:906:314e:: with SMTP id e14mr7859815eje.165.1627984280852;
        Tue, 03 Aug 2021 02:51:20 -0700 (PDT)
Received: from [192.168.8.102] ([86.32.43.172])
        by smtp.gmail.com with ESMTPSA id m5sm3526216ejg.53.2021.08.03.02.51.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Aug 2021 02:51:20 -0700 (PDT)
Subject: Re: [PATCH] memory: fsl_ifc: fix leak of irq and nand_irq in
 fsl_ifc_ctrl_probe
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
References: <20210803075159.2823913-1-mudongliangabcd@gmail.com>
 <81ccbbb5-5499-7a75-88ba-bae5328ffbf9@canonical.com>
 <CAD-N9QXfdossFaQFwa-DPCyY-deHZ-75=LtSQYihvPNDpzwqiw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <d248924f-3dca-7be8-39d6-4ac746670ae4@canonical.com>
Date:   Tue, 3 Aug 2021 11:51:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAD-N9QXfdossFaQFwa-DPCyY-deHZ-75=LtSQYihvPNDpzwqiw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2021 11:28, Dongliang Mu wrote:
> On Tue, Aug 3, 2021 at 3:57 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@canonical.com> wrote:
>>
>> On 03/08/2021 09:51, Dongliang Mu wrote:
>>> In fsl_ifc_ctrl_probe, if fsl_ifc_ctrl_init fails, we should free the
>>> resources allocated by irq_of_parse_and_map.
>>
>> Your code is doing much more. You also touch nand_irq, not only
>> fsl_ifc_ctrl_init(). This looks incorrect as IRQ is optional, isn't it?
>>
>> The problem is entirely different than you described here - the error
>> paths of fsl_ifc_ctrl_init() and request_irq() are wrong. They do not
>> release resources in proper paths.
> 
> Yes, you're right :). This patch rewrites the whole error handling
> code. Any comment on the code changes?

I did not check the exact error paths, I assume you are going to make
them correct. Therefore only the nand_irq which looks optional and your
code makes it required.

> 
> I will rewrite the commit message in the patch v2.
> 
> BTW, there is a minor issue: if request_irq fails, we should not
> invoke free_irq.
> 


Best regards,
Krzysztof
