Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88ABD3E877D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 03:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235954AbhHKBFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 21:05:31 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:44554 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235756AbhHKBF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 21:05:29 -0400
Received: by mail-pl1-f169.google.com with SMTP id q2so435291plr.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 18:05:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CgNWZSgrNzJPLq2mMqUN5nw8xAzOXxjDw3rTcWX5ovg=;
        b=eQRkJFV2PZgPAgca11NAD7OG4Xe5Cj8xc3L1pRtGYtPqg1dhdDC4Nr8W5THX+ev9jh
         flo4YTw58R3tkoq7j91ZEVQ34JgAyUiWbkvQMVfWrF+Cs0pMGMoHTcjeP8Q/betadESB
         /HgfSk9rwD/YJbZ0E0X15yzBRpw9NBtTMfypfTI+CRl2OAv3/Nu3yWg+QJBwgjCZcI7X
         8nqwxfFUxAmJkN7E0FkuEUAtgNcCZxj1etfGlUslIJIKp6F1XUu+GImkGvB4PWOOZFlw
         XHzJbYZtiMK1A1OC76+3lYGMtZUanxIb2jMO4NSe8l1XQOWSIx9Z/LoqHFZHDoVB7AO/
         a+Fg==
X-Gm-Message-State: AOAM532kQ2HxHI3cvAanTiJgq6h0b6zl8FOZUEjvpe4HBmg6bA9WJIQv
        /ej5et0tYAqympyUFW6X49Y=
X-Google-Smtp-Source: ABdhPJwDNVIOmkI4OSVdRpyOi7HjUPALBUuuEH4209cpN7PfkEPWc6DyiUkhGWsyPV4T3o/+erUEHA==
X-Received: by 2002:aa7:8a13:0:b029:3be:c2a:7a45 with SMTP id m19-20020aa78a130000b02903be0c2a7a45mr31944891pfa.8.1628643906594;
        Tue, 10 Aug 2021 18:05:06 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:61e5:4b9f:b48a:e987? ([2601:647:4802:9070:61e5:4b9f:b48a:e987])
        by smtp.gmail.com with ESMTPSA id x19sm4406732pfo.40.2021.08.10.18.05.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 18:05:05 -0700 (PDT)
Subject: Re: [PATCH v4 6/8] nvme-fc: fix controller reset hang during traffic
To:     Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Wen Xiong <wenxiong@us.ibm.com>,
        James Smart <jsmart2021@gmail.com>
References: <20210802112658.75875-1-dwagner@suse.de>
 <20210802112658.75875-7-dwagner@suse.de>
 <79c89923-f586-79e7-6dfd-c15ceb21f569@suse.de>
 <20210804080847.bajae2twtnmccvq7@beryllium.lan>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d43f83cf-a3cd-df16-5af8-1f530b25d1cc@grimberg.me>
Date:   Tue, 10 Aug 2021 18:05:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210804080847.bajae2twtnmccvq7@beryllium.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Wed, Aug 04, 2021 at 09:23:49AM +0200, Hannes Reinecke wrote:
>> There still is now an imbalance, as we're always calling
>> 'nvme_unfreeze()' (irrespective on the number of queues), but will only
>> call 'nvme_start_freeze()' if we have more than one queue.
>>
>> This might lead to an imbalance on the mq_freeze_depth counter.
>> Wouldn't it be better to move the call to 'nvme_start_freeze()' out of
>> the if() condition to avoid the imbalance?
> 
> What about something like nmve_is_frozen() which would avoid the tracking
> of the queue state open coded as it is right?

Why is there a conditional freeze?
