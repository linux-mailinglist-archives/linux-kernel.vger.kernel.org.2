Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 835A8439D90
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 19:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbhJYR3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 13:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbhJYR3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 13:29:13 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BE5C061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 10:26:50 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id a17-20020a4a6851000000b002b59bfbf669so3897209oof.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 10:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KfOb2eIS89lcVTT7KSpBk1AQTOhqvqByR0j8ZKXzoqo=;
        b=kvcVxrf0BOB2XZcKCjY48WnrlH3sGi42UzdM+sc3NB9bVex7b+HInK22322KTpujlh
         r5iXN5JbJeN3YgCmlHv3jXAWR19BzyQ+5xw89flz+P5n8KeQw+SopsW8lybUEC498GUm
         kBWzV2EZaifpAuExsg2GaC2PlgnJe/M+7S3rn/elEkuFgC8VMLk5MfGtADaRXojtXsub
         fh6HaI6wdxobmljQR3EWGUph0+keT4cqZWYZYZd9S3TYTAdybmVAQYwyUTCfd408EweI
         6Tya4Lp4z8PISOAFgSQmd3awglmJ3q7eITtQtTGWYXmhpqAao+WEF+AwbEZNb4EgsyDe
         Cy5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KfOb2eIS89lcVTT7KSpBk1AQTOhqvqByR0j8ZKXzoqo=;
        b=kEQo2ExDZZmZd5UpNPOF339u3FLNG4v2QDbP4P5p5liR0RrccWbDnYsBSZvxq9/Ebk
         Rt45F0R8WrEXDOoWc1zLFYjjiD3qrCK+WVkLGPrCsYfpe05Q33r5/gq5AiriSs1xLH4s
         8quo0KeiXfUgu+zbmRAxfuFuGiLph2VqpD0ZoI5uShAUI4E184ugv7oztyobU363jHPA
         kcpeEIvABq2itHQ+Qr31GN0JykANozVzbQftfB/El72la14rkVE4hcof0Y43JZo1bmrJ
         AObtjHcOyt0H7XgCtnC7uhhA2eh8NUTM8uk1PH3BfHUgFYtxVQAL8wC69+BUxKN967YB
         NdRA==
X-Gm-Message-State: AOAM531urKtyQpZakJkYNlIc/XMBCQ4SZ3OwDNN8DX4vMwIKsnNttqye
        BuButMahwpb+8w4hqfPBidA=
X-Google-Smtp-Source: ABdhPJxCl1xJWf5SgF1E/pTDaZemn7gw0LebbJtsuyGJLvBhludb5qCw2npv9ohI/jRqwJ2i4lwxvA==
X-Received: by 2002:a4a:be0a:: with SMTP id l10mr12941343oop.64.1635182810337;
        Mon, 25 Oct 2021 10:26:50 -0700 (PDT)
Received: from ?IPV6:2603:8090:2005:39b3::101e? (2603-8090-2005-39b3-0000-0000-0000-101e.res6.spectrum.com. [2603:8090:2005:39b3::101e])
        by smtp.gmail.com with ESMTPSA id bi20sm3986570oib.5.2021.10.25.10.26.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 10:26:49 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <de1bddd8-8e09-4b8f-1fd8-ae9047e60269@lwfinger.net>
Date:   Mon, 25 Oct 2021 12:26:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] staging: r8188eu: core: remove goto statement
Content-Language: en-US
To:     Saurav Girepunje <saurav.girepunje@gmail.com>,
        phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        straube.linux@gmail.com, fmdefrancesco@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
References: <YXafzp5F8T7/+tk2@Sauravs-MacBook-Air.local>
 <7dc4eba4-c009-b8b7-bc08-5b608bdf86a0@lwfinger.net>
 <e2020caf-1b0c-ce0e-3d94-d105be85ed38@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <e2020caf-1b0c-ce0e-3d94-d105be85ed38@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/21 12:00, Saurav Girepunje wrote:
> 
> 
> On 25/10/21 8:45 pm, Larry Finger wrote:
>> On 10/25/21 07:15, Saurav Girepunje wrote:
>>> Remove the goto statement from rtw_do_join(). In this function goto
>>> can be replace by return statement. As on goto label exit, function only
>>> return it is not performing any cleanup. Avoiding goto will improve
>>> the function readability.
>>>
>>> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
>>> ---
>>
> Hi Larry,
>   
>> You need to read section 14 of Documentation/process/submitting-patches.rst to learn how to submit a revised patch.
> Resubmitting such a revision using the same subject line is likely to confuse reviewers and maintainers alike, if not patchworks.
>>
> This is original patch (v1). I haven't get any review comment for this patch.

Why did I get it twice? At least I got two messages with that subject line.

Larry
