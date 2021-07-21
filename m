Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 675C43D0D25
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 13:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239266AbhGUK36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 06:29:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25111 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238931AbhGUKTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 06:19:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626865184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZNFxyv8EkVrHF82POeUeAbgVCzcWksdQvRviSPKQXfw=;
        b=blbu9g1vnXHaqeDqvqUat+ulLp6a7FEHkb0TrJw9OWTn73HtB5syWid8lOm1rqfu1BEGbY
        gkPG/3LdFPYxLL2dxMB9hkAksO74YcljhNiBXCZdw0OCshalG1cqglDGykwyaOF5MJ8CYE
        hyUZnlq0Zi2Ti7K5f06/QI+8Uut5eI8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-CLcyHjDqOG-npt81N11sqQ-1; Wed, 21 Jul 2021 06:59:42 -0400
X-MC-Unique: CLcyHjDqOG-npt81N11sqQ-1
Received: by mail-wr1-f70.google.com with SMTP id m4-20020adffa040000b02901404c442853so851758wrr.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 03:59:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZNFxyv8EkVrHF82POeUeAbgVCzcWksdQvRviSPKQXfw=;
        b=EHAl/p3f5q0JtCu6N2b0N3x+0ERUEBNX+chlUvJfAt/83JPG4y3bndV4o7kd48TqjF
         LmDiNbYctmjW/lLfpvaqm5jbY/M88Z7s4jy+XgnvdIvb2NYcZTDWn9QUNZvN7RFGrrGE
         A8ijXU+pqEYY5vkO8aC2wjiD8c2geO04QSHPsk5QBObkhIUQRRm+H3VCzdpCr03JX7Q3
         Aqr3ESJ0rkgf1d97ZlZDP+M+6dGQ4UvhvtV0jAPU2qFIavDoLzaqK9CXuXjBQXAezcx+
         vBXAErVWdWKSaLMhLrB8NMuqRvIIJ1UnX3HMdbNUj/mZiuc0iJV1ds6K0m82Lq76jxBu
         a+kw==
X-Gm-Message-State: AOAM530aydG2Kh6EiTZhUY0VJtNeivXmynFvAdotNWdtSzOhmmsVNHhk
        TAnjVz48IJHmTIybOB0EZjQ12KNHNSsZitZSPDYv41FR0t4z9eL4eh6fqhyyKNhlEMI2/5Gxf0h
        sQ4ni7nfziLV4DvpWGxwmHwKG
X-Received: by 2002:a7b:c74a:: with SMTP id w10mr3441865wmk.54.1626865181440;
        Wed, 21 Jul 2021 03:59:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyAz8QRFjMdVMkdngNvEh+DxLGf/YfcxGPbpYARXikkxgkKmd2Lg2dIaNEzL9byiF2pZqDjuw==
X-Received: by 2002:a7b:c74a:: with SMTP id w10mr3441847wmk.54.1626865181224;
        Wed, 21 Jul 2021 03:59:41 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id z7sm13424582wrt.94.2021.07.21.03.59.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jul 2021 03:59:40 -0700 (PDT)
Subject: Re: 5.13-rt1 + KVM = WARNING: at fs/eventfd.c:74 eventfd_signal()
To:     Hillf Danton <hdanton@sina.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Michael S. Tsirkin" <mst@redhat.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <df278db6-1fc0-3d42-9c0e-f5a085c6351e@redhat.com>
 <8dfc0ee9-b97a-8ca8-d057-31c8cad3f5b6@redhat.com>
 <f0254740-944d-201b-9a66-9db1fe480ca6@redhat.com>
 <475f84e2-78ee-1a24-ef57-b16c1f2651ed@redhat.com>
 <20210715102249.2205-1-hdanton@sina.com>
 <20210716020611.2288-1-hdanton@sina.com>
 <20210716075539.2376-1-hdanton@sina.com>
 <20210716093725.2438-1-hdanton@sina.com>
 <20210718124219.1521-1-hdanton@sina.com>
 <20210721070452.1008-1-hdanton@sina.com>
 <20210721101119.1103-1-hdanton@sina.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2b4aea8d-a038-e347-7f6f-10476d771b7e@redhat.com>
Date:   Wed, 21 Jul 2021 12:59:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210721101119.1103-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/21 12:11, Hillf Danton wrote:
> On Wed, 21 Jul 2021 09:25:32 +0200 Thomas Gleixner wrote:
>> On Wed, Jul 21 2021 at 15:04, Hillf Danton wrote:
>>>
>>> But the preempting waker can not make sense without the waiter who is bloody
>>> special. Why is it so in the first place? Or it is not at all but the race
>>> existing from Monday to Friday.
>>
>> See the large comment in eventfd_poll().
> 
> Is it likely for a reader to make eventfd_poll() return 0?
> 
> read	 *     poll                               write
> ----	 *     -----------------                  ------------
> 	 *     count = ctx->count (INVALID!)
> 	 *                                        lock ctx->qwh.lock
> 	 *                                        ctx->count += n
> 	 *                                        **waitqueue_active is false**
> 	 *                                        **no wake_up_locked_poll!**
> 	 *                                        unlock ctx->qwh.lock
> 
> lock ctx->qwh.lock
> *cnt = (ctx->flags & EFD_SEMAPHORE) ? 1 : ctx->count;
> ctx->count -= *cnt;
> **waitqueue_active is false**
> unlock ctx->qwh.lock
> 
> 	 *     lock ctx->wqh.lock (in poll_wait)
> 	 *     __add_wait_queue
> 	 *     unlock ctx->wqh.lock
> 	 *     eventfd_poll returns 0
> 	 */
> 	count = READ_ONCE(ctx->count);
> 

No, it's simply impossible.  The same comment explains why: "count = 
ctx->count" cannot move above poll_wait's locking of ctx->wqh.lock.

Paolo

