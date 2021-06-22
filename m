Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 405FD3AFFD0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 11:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhFVJGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 05:06:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41696 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229486AbhFVJGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 05:06:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624352641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ANzaJSLFFBLAe06Y/sBuxfE6og1qOQNyUI433GTInyA=;
        b=ax5i19aOUAmNUaWBwm2U4IWK8Lb5DfLW+uaP7S84kc0sXwFjo0cDe1YYvLffxh8xgQP4mu
        NZogvSKsLHJELLl5+oudJnwojzqP0jslSqyiTdOyJw6RBjzgpinnEkhTseOQ5fhpgcLWtT
        e8I35v/qejQ3JyP5xPKT5aB/xWr6fv4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-M5cwRqqhM9mQblhQoNaQPw-1; Tue, 22 Jun 2021 05:03:58 -0400
X-MC-Unique: M5cwRqqhM9mQblhQoNaQPw-1
Received: by mail-ed1-f71.google.com with SMTP id v12-20020aa7dbcc0000b029038fc8e57037so9151811edt.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 02:03:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ANzaJSLFFBLAe06Y/sBuxfE6og1qOQNyUI433GTInyA=;
        b=NKXsysr5H4DRE1+pCgrTjeYmuH9IUnG3k+GcdlR5AWfe6xVeUFcOMtJEP+ptyYUG2S
         vAXzy5C24zebWlevozJImM4ZWh76KNTj1bXztTKd5gX9C6CgPf3rlq8QErntg/FU+D+B
         PTpyRpiSlJHo74wWYc44BCioWSNzTfMCs4g0I7lwHv8ByqsWu26/xKiRqnnyDpB3FkOK
         ETmTlNAGVRfSpO5yuXIrPlY27ELcGuDqtXUYnqsj4cXId1R/k2+m0L3HXKTxePLO1Oei
         Ca1CKceHQlTMGTG2mEJkc3JUH6iPIYgFOsx+aVj0aNEa2DfST2PihPd/SaoBZgWClC6/
         f6ZA==
X-Gm-Message-State: AOAM530gWMQbqVY4OuXp7AN7bt5kBwdlLjC7RJzCL2WU3pNxN8iyWqUg
        o1EVq5/w+7CttJYX6/oZz7U1RQNY/pZsyNsKXo3cYKuUIumwwfGJi4LJR0rP9cAB6Vx61hEIRWQ
        hDUnrB5lwEhNLWgQ7HV1iHiAq
X-Received: by 2002:a17:906:1318:: with SMTP id w24mr2810240ejb.222.1624352637773;
        Tue, 22 Jun 2021 02:03:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxWoz+otEuPZXWbOrMuuDEoK9BD/nT21EjD39p7UyGYGWFwNQQpD2zMULF+0d5rNvHcwjPpYw==
X-Received: by 2002:a17:906:1318:: with SMTP id w24mr2810224ejb.222.1624352637655;
        Tue, 22 Jun 2021 02:03:57 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id ee47sm4586283edb.51.2021.06.22.02.03.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 02:03:57 -0700 (PDT)
Subject: Re: [PATCH v2 1/8] platform/x86: Remove "default n" entries
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Mark Gross <mgross@linux.intel.com>
References: <20210618125516.53510-1-andriy.shevchenko@linux.intel.com>
 <CAHp75Vcjr5F=4qSCrEWtUhBhFycBrE6u55Krg77ENsVn6DbOMA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <23f1f2db-7a08-416e-ba0a-4cbf9774647f@redhat.com>
Date:   Tue, 22 Jun 2021 11:03:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAHp75Vcjr5F=4qSCrEWtUhBhFycBrE6u55Krg77ENsVn6DbOMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/22/21 11:02 AM, Andy Shevchenko wrote:
> On Fri, Jun 18, 2021 at 4:09 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
>>
>> Linus already once did that for PDx86, don't repeat our mistakes.
>> TL;DR: 'n' *is* the default 'default'.
> 
> Daniel, thanks for your testing!
> 
> Hans, patches 2-6 were reviewed and tested, do you think we have a
> chance for the series to be applied?

Yes I was working on applying it right now :)

Regards,

Hans


