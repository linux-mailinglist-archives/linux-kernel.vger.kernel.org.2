Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1296037ABE3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 18:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbhEKQ2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 12:28:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57521 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbhEKQ2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 12:28:22 -0400
Received: from mail-vs1-f70.google.com ([209.85.217.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lgVE2-000484-Kd
        for linux-kernel@vger.kernel.org; Tue, 11 May 2021 16:27:14 +0000
Received: by mail-vs1-f70.google.com with SMTP id c29-20020a67e01d0000b029022aac4b245fso3983216vsl.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 09:27:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JObhrtfEgDnBO4QfIE9yqa2CVVVzCmrusirYIoKk6HM=;
        b=TJEJ8P8soIjZCNlbCpVFiW862tJRZMlA0MdN6fKW6yCEoEz0kOUNEjKAv9Kz6VUbmQ
         HiQOFa2OaOllQwuVlWV0zm6kk6A0SUQXh4D9QiA6G1tIaJGc2Lcbt+KsIr0Ts+d/r2eh
         FJLwojU+0+gF/xsvFGsQownQjUw8hpqyHecCRlCtoQa6HNs8X769NCPQbXwF2bKnjxgf
         vmPDeBhQME5ploBPimGXJqGT5vYi88T4D2Blr4j0FmhXk1H1Ct/ExY9zwQEaljPc6KA3
         p05VsKOag3mozmET3A+wnDQkmIa8JFQz8fB0zDnG22OC93ngBNDbs81CBvZ1YG0q4ytJ
         Zolg==
X-Gm-Message-State: AOAM530mZyz661n7InUivsdf1FKeq8kl7ft9CV/OSJZI2+73vHiADrLb
        zM/PdWku5HhW0DbEpd5fpjQsPuWwufb03dZZ0C2xNb8GPKpRwnl3nFhTHBDnKCZ8NX/1XkS5WWj
        mYXHZM/+piuj4n30OW/cqxL9Z4bdBp6JrnBlPVTHXXQ==
X-Received: by 2002:a67:fb92:: with SMTP id n18mr26803683vsr.15.1620750433166;
        Tue, 11 May 2021 09:27:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz80w6SQFwALM2jChXcNHcmbF6apkgAtd1V281pi3IV7i+VV4+QKFvlEfSqnkVkYxXH7y1wHA==
X-Received: by 2002:a67:fb92:: with SMTP id n18mr26803650vsr.15.1620750432956;
        Tue, 11 May 2021 09:27:12 -0700 (PDT)
Received: from [192.168.1.4] ([45.237.48.2])
        by smtp.gmail.com with ESMTPSA id a6sm2250077vsd.33.2021.05.11.09.27.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 09:27:12 -0700 (PDT)
Subject: Re: [PATCH 4/4] extcon: extcon-max8997: Fix IRQ freeing at error path
To:     matti.vaittinen@fi.rohmeurope.com
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
References: <cover.1620633360.git.matti.vaittinen@fi.rohmeurope.com>
 <9047a741b4c4d97e721ed8b48cc4b434a46acba3.1620633360.git.matti.vaittinen@fi.rohmeurope.com>
 <edf3ff4d-8bd7-17cf-0d7c-96b4f704dddd@canonical.com>
 <978a829103c768a01ed8a1b37ea607ea5fb0ddb0.camel@fi.rohmeurope.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <f5b5c30f-9a84-459e-d3c8-5a5760912cb1@canonical.com>
Date:   Tue, 11 May 2021 12:27:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <978a829103c768a01ed8a1b37ea607ea5fb0ddb0.camel@fi.rohmeurope.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2021 23:32, Matti Vaittinen wrote:
> Hi Krzysztof,
> 
> On Mon, 2021-05-10 at 10:21 -0400, Krzysztof Kozlowski wrote:
>> On 10/05/2021 04:12, Matti Vaittinen wrote:
>>> If reading MAX8997_MUIC_REG_STATUS1 fails at probe the driver exits
>>> without freeing the requested IRQs.
>>
>> The driver frees IRQ on probe failure, so maybe you meant missing IRQ
>> mapping dispose?
> 
> No. The commit 3e34c8198960 ("extcon: max8997: Avoid forcing UART path
> on drive probe") introduced a return w/o IRQ freeing if reading the
> MAX8997_MUIC_REG_STATUS1 fails at the end of the probe. This is not
> visible in the patch though - as the return is Ok after the IRQs and
> work-queue cancellation are managed by devm.

I see it now, right. The fix is big and changes too much to be
backportable. I would prefer to simply fix the problem with "goto
err_irq" and convert to devm in next patch.


Best regards,
Krzysztof
