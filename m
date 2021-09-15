Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE2E40C260
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 11:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237104AbhIOJHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 05:07:01 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:48632
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236903AbhIOJHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 05:07:00 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 72D3C40289
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 09:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631696741;
        bh=X7Cc3jU81HRUvI9Nu63KcpmXz37KgSemXGthehwJJeg=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=NnbjDhYGIe4FnnMt07KjCNzXBOb4mfZ2Osi9GakQeV9c+gV3x/AqVijGK9f10ZB7f
         4etHNu7CUrXYOQzyUuRCKRvN6FiQVrqTHBXzXKAj6+1wHe3jfwubOemLj87xxyfan4
         6CVcXCf4cTjRBBnyJZf7JftijNNSmcMEt1BJneUWbsmdgLvtmm4WJQ0HCjwO8bQ1Q3
         WImikxSu2JLVAOOofoVHt2e2Lt0XunwLRf+HVaL0S0dq6XbEtiA1QIlH33OLmgjOH5
         PQUD289eul0fk2mNqPDZikB/E5qtuJDGRtCsZZFxrz6kt7w3WBB9DpTso0a4LsZq9R
         4cgaoK8Cdaycg==
Received: by mail-ed1-f72.google.com with SMTP id b8-20020a056402350800b003c5e3d4e2a7so1235202edd.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 02:05:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X7Cc3jU81HRUvI9Nu63KcpmXz37KgSemXGthehwJJeg=;
        b=fFQjYM+ZAldVGPK7RllQg3QcbJ3zXTS4KQy5TMVkDGCL7o9Ef9ilQ5iI75HaJDSS/z
         +3ueyB42gfuB7WjXQxT3v6bOhIeBfhs/ln/9BW5WciAlDvtcd1QY7DOs+9FKuKKx936q
         zparoko7cDgcCjOsEddVSVDb3wo/e+ImZohQq4QPv3XTIbn0UJM7QEC5hVuiWGngDFdt
         DvPmoGwqQW5ZvKdmvvjNW4YvL60nBI5pHYjNCcSzdmtWq5F1KILlGYLM5RUdrWvQU11t
         MS6+wa4CQ/eQxeMfO5k65UZfNrsvLuZQmJEGVveMavdzjz5HcbabQfZ40sO9lyRpDn3d
         P+PA==
X-Gm-Message-State: AOAM533UBM5v6vR1ZJQpxOQwTulswPn8801+5WW7RT6FovD+YxAlPE5F
        JQUR17MEqFqoGuYpWE5jg2hHVQ6JoIffY5QEqBKo3Ui7HliNsmGOWqvAL8Ken4Gx6j/PFVOb5Gx
        Wfc+dTl0yjHynGRqsU06mVu4l0VG3E01d1RLMPmFBWQ==
X-Received: by 2002:a17:907:7613:: with SMTP id jx19mr24334742ejc.453.1631696739814;
        Wed, 15 Sep 2021 02:05:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzD9fO3zbzPRg3ejtmsih8V9NIThIYB0jKBalTlLEm2XpSRUk4IVkXNzIOR7td1TQ+/UiTNCQ==
X-Received: by 2002:a17:907:7613:: with SMTP id jx19mr24334728ejc.453.1631696739675;
        Wed, 15 Sep 2021 02:05:39 -0700 (PDT)
Received: from [192.168.3.211] (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id c5sm6843180edx.81.2021.09.15.02.05.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 02:05:39 -0700 (PDT)
Subject: Re: [PATCH v4 8/8] memory: gpmc-omap: "gpmc,device-width" DT property
 is optional
To:     Roger Quadros <rogerq@kernel.org>, tony@atomide.com
Cc:     robh+dt@kernel.org, grygorii.strashko@ti.com, nm@ti.com,
        lokeshvutla@ti.com, nsekhar@ti.com, miquel.raynal@bootlin.com,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210914122705.15421-1-rogerq@kernel.org>
 <20210914122705.15421-9-rogerq@kernel.org>
 <e0c4759b-7c2d-e32c-f912-8409c1f65b49@canonical.com>
 <6a06f4bd-f20a-8b5a-c152-0877707670ff@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <1b915c39-fd6d-3c3c-e4bf-4df9a694dfb6@canonical.com>
Date:   Wed, 15 Sep 2021 11:05:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <6a06f4bd-f20a-8b5a-c152-0877707670ff@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2021 10:47, Roger Quadros wrote:
> Hi Krzysztof,
> 
> On 15/09/2021 10:12, Krzysztof Kozlowski wrote:
>> On 14/09/2021 14:27, Roger Quadros wrote:
>>> Check for valid gpmc,device-width, nand-bus-width and bank-width
>>> at one place. Default to 8-bit width if none present.
>>>
>>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>>> ---
>>>  drivers/memory/omap-gpmc.c | 41 ++++++++++++++++++++++++--------------
>>>  1 file changed, 26 insertions(+), 15 deletions(-)
>>>
>>
>> All the comments from v3 are still applicable because it seems you
>> ignored them. Please respond to them.
>>
>> It's the second patch where the reviewer's comments got lost, so it
>> creates rather poor impression.
> 
> I was wondering what comments and then realized that gmail server has put
> all your messages into spam folder.
> 
> I'm very sorry about that. I will address your comments ASAP.

Oops. There were just two emails from me for v3. Can you send me
(privately) the headers from my emails so I can investigate why they
ended up on Spam?

Best regards,
Krzysztof
