Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90CC414BE4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 16:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbhIVObK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 10:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbhIVObC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 10:31:02 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B19CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 07:29:33 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id 134so3558593iou.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 07:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LkHNahxe4Opk7ltbXSKSeyp56JUc25N+JObY5cRDFWc=;
        b=aOrhP0mv2RWtlBrBj3fYKJ0tGdWUe+SEZptNqmFmG1geSe9GAwL8iEvIVWR6CtHLBA
         wH/mtdrurZkJqTSl2Qh1Z36Y3fkUcmnEiShyhULDfK9t48/tn4oXVg8rpuuMxx9gA9w8
         Dv9baPveSavSM45XbUTcdGhkqoxFO1MbhU8C3H8r//9FQGYfKN8/mHAP3q/hAQzFR8mu
         iIyryYgPnYEhO2d0IYgBObntHh6oGJPaX5i8yZF6+ILBzUVK4XwsRDBNpekXF5SY11+e
         1cQjtxxvCU67UAhzzawbRK8aNQZ3Z/EoV2er4zzgwkZfV334DI1BcGqpOzSXNDa/a9Oy
         S9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LkHNahxe4Opk7ltbXSKSeyp56JUc25N+JObY5cRDFWc=;
        b=WaIwtI4sAsKiewFWheyLDfaQWshECosMBIgmuruPKA9Z0Q6leUgaQsR7SmZT9WP1d8
         sF4RvBtohQBG5iGgEe0UWLMG9TuIif/N2FdA8TWW/vMEeDXUD59uvI8j8bXLxnwprwtG
         FjIxh0f2LfVSyuReQp4+xKStPZGeY188HNVkupc3ajTI8mL1ZoncB0XZb285ctHPRncf
         nXNC/cEYtVXdzVAG41RSB07uwf7vNEOYEymYeVBHfJ2kgB9pLv0pPjVq/PnCnR9aqrbL
         apDWgk2WxIUchBYOUaYFxavTQr7n0Y1UZ796SxQDqNL9ZRPN7XbLsSPui0vls32CTFrt
         bFzg==
X-Gm-Message-State: AOAM531nN7JQUHX0QqPI08WdFpC3KB/90ZEmpNp1i+QnFgslrJZlw5un
        O/U0vWpKT8QBs3ES+xr5FP4odDNSTBRofOB/EKk=
X-Google-Smtp-Source: ABdhPJxkPMuEngkZ3AMT/nv4SOGP0ecCSItToEOfVDpBlDJWAorvfHe/+T6qxgWAoRXJve5leudqEA==
X-Received: by 2002:a6b:d209:: with SMTP id q9mr4751648iob.206.1632320972411;
        Wed, 22 Sep 2021 07:29:32 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id v17sm623069ilo.1.2021.09.22.07.29.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 07:29:31 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: export blk_mq_submit_bio symbol
To:     Prasad Muppana <Lalita.Muppana@microsoft.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Christoph Hellwig <hch@infradead.org>,
        Atin Mukherjee <Atin.MUKHERJEE@microsoft.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "schakrabarti@linux.microsoft.com" <schakrabarti@linux.microsoft.com>
References: <20210909053653.144360-1-kumarpraveen@linux.microsoft.com>
 <7e80b65b-51a4-3ca1-da43-e87612b8ca5f@nvidia.com>
 <f7add831-ecf0-6599-158b-cd2f15543da5@linux.microsoft.com>
 <YT7rL4PhovDOHfHO@infradead.org>
 <75f77917-a8ba-0138-750b-8dedd8f7ce7d@linux.microsoft.com>
 <PSAP153MB0518F021C769875159C3A03984A09@PSAP153MB0518.APCP153.PROD.OUTLOOK.COM>
 <792dd48b-a246-0456-58a8-00d739201251@nvidia.com>
 <PSAP153MB0518090A749E26814966672684A29@PSAP153MB0518.APCP153.PROD.OUTLOOK.COM>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <36660d33-c02d-27ee-1332-4ea6e7126b88@kernel.dk>
Date:   Wed, 22 Sep 2021 08:29:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <PSAP153MB0518090A749E26814966672684A29@PSAP153MB0518.APCP153.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/21 11:45 PM, Prasad Muppana wrote:
> Hi Chaitanya,
> 
> Thanks for the response.
> 
> Our driver code is not yet public and so Praveen has explained the
> flow of the code. Please let me know is there any other way to get
> some help here quickly.

The explanation, while appreciated, doesn't solve the problem here. We
_never_ add any exports for APIs that don't have any in-kernel users.
That's a hard rule that we've had forever. As such, there is not a path
for entry for this particular patch right now. It should be submitted
alongside the upstream submission request for the code using it, as a
preparatory patch.

-- 
Jens Axboe

