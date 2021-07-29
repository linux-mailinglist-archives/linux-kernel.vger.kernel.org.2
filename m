Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F373DA675
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 16:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237139AbhG2Ocx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 10:32:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53800 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234206AbhG2Ocs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 10:32:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627569164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U+AwZr6Sn9QIs+ZssO0J9KYH5K5+8QtLBMpUWL2nMG8=;
        b=ApXiRylYYF9r4MOLx6PO6wZJFjzgEp71UdGlttFgUsqIVp+bxC8JSkdOvI/yaGfysES4pg
        rO8nJ0JhMi+M+cnVbUiR4hxPJcpR1xq4zDLD6whehpRHN9t81OeOTL73oblCrR6RY0HqB8
        tTrAvi09xZeKGpfptcifg73aPoYx2VU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-MRk-pwWJN9GDxTxW-XRSIg-1; Thu, 29 Jul 2021 10:32:43 -0400
X-MC-Unique: MRk-pwWJN9GDxTxW-XRSIg-1
Received: by mail-ed1-f71.google.com with SMTP id b88-20020a509f610000b02903ab1f22e1dcso3028768edf.23
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 07:32:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U+AwZr6Sn9QIs+ZssO0J9KYH5K5+8QtLBMpUWL2nMG8=;
        b=LRizwyVeCbDEBKQMZO71lkhCJL56+FUzxidiEJKp8YTRkgUJh35oTtRq5EjPDTkjVS
         lBVQy0D66/N7bLthM88S4H+BZH3dozMM1gi9mXNDXNomfKk9uvBjpAExUdBHlEOSbEEp
         OEM5qs4uD9kGCUKppEOtIYS4Fmpzq6IqrUwUkqCyNXZbbOHXCjh38TfHRrL1JFFPvW0Q
         SjBsE21tjkltt3o/orpG5OXr+l2aurFeQlrZCz5twOrQvKl5LyyvVl8+ZMOJPy9cGSef
         lxxhNOGqyp0q0wqKPKARmy/r0ZSw4Q4qz2wfKb7NWkEL62XmviqKq/316A4Z3UUvxVMW
         r4KQ==
X-Gm-Message-State: AOAM530rbQsD8UOHD/XF1W7Y/KG1UX/EAl24hiTUIY7NKjHtVtdREejx
        gvuif8UlcF7jksGNm7sylMPCVEeYEkbJCxKYwIeCzKQ7Z2R9V2DSU6/23KMsvT8dZ+ocrpxmEzm
        rmBzcQ6khPuM8lTyZVmqLPWT2
X-Received: by 2002:a05:6402:1011:: with SMTP id c17mr6190136edu.144.1627569162089;
        Thu, 29 Jul 2021 07:32:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxs6+9eblc+utmokHBKiCdXFfeP7j99/hN0GEZcvgsdBPbt0bOsWWNTTzgN3+EaToPXCjZ7Yw==
X-Received: by 2002:a05:6402:1011:: with SMTP id c17mr6190116edu.144.1627569161935;
        Thu, 29 Jul 2021 07:32:41 -0700 (PDT)
Received: from x1.bristot.me (host-95-239-202-226.retail.telecomitalia.it. [95.239.202.226])
        by smtp.gmail.com with ESMTPSA id b1sm1050820ejz.24.2021.07.29.07.32.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 07:32:41 -0700 (PDT)
Subject: Re: [PATCH] eventfd: Make signal recursion protection a task bit
To:     Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Juri Lelli <jlelli@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        He Zhe <zhe.he@windriver.com>, Jens Axboe <axboe@fb.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <df278db6-1fc0-3d42-9c0e-f5a085c6351e@redhat.com>
 <8dfc0ee9-b97a-8ca8-d057-31c8cad3f5b6@redhat.com>
 <f0254740-944d-201b-9a66-9db1fe480ca6@redhat.com>
 <475f84e2-78ee-1a24-ef57-b16c1f2651ed@redhat.com>
 <87pmv23lru.ffs@nanos.tec.linutronix.de>
 <810e01ef-9b71-5b44-8498-b8a377d4e51b@redhat.com> <875ywujlzx.ffs@tglx>
 <87wnp9idso.ffs@tglx>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <4ebcc02b-4d42-ce69-c515-f27ce4db118c@redhat.com>
Date:   Thu, 29 Jul 2021 16:32:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87wnp9idso.ffs@tglx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/21 1:01 PM, Thomas Gleixner wrote:
> The recursion protection for eventfd_signal() is based on a per CPU
> variable and relies on the !RT semantics of spin_lock_irqsave() for
> protecting this per CPU variable. On RT kernels spin_lock_irqsave() neither
> disables preemption nor interrupts which allows the spin lock held section
> to be preempted. If the preempting task invokes eventfd_signal() as well,
> then the recursion warning triggers.
> 
> Paolo suggested to protect the per CPU variable with a local lock, but
> that's heavyweight and actually not necessary. The goal of this protection
> is to prevent the task stack from overflowing, which can be achieved with a
> per task recursion protection as well.
> 
> Replace the per CPU variable with a per task bit similar to other recursion
> protection bits like task_struct::in_page_owner. This works on both !RT and
> RT kernels and removes as a side effect the extra per CPU storage.
> 
> No functional change for !RT kernels.
> 
> Reported-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Testing....

Thanks!
-- Daniel

