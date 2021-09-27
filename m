Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9080419A84
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 19:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236371AbhI0RJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 13:09:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56616 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236351AbhI0RI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 13:08:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632762406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=igSsZqxxeuMq7lqv87REPqLHaXVxhaGz9rpGTm3o31c=;
        b=dJhisrrn5A44Ey6SZfk8hEGA66XW/PLHZvZLJXIzCbVJYAnQ59vmhr3jZxux0kkEzEXxkW
        GbSu7CtA7k86AoHLP/wfMxPrmXF8tLG4zzGJ2Wi6q860WJDYFy2F2ZgExcBSZMt7yyQ82e
        5cF5KfW3nB2Eaeb5s7/uGc9mkGkP3dM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-BSwBDaNKN3adHaG4iKnEdQ-1; Mon, 27 Sep 2021 13:06:45 -0400
X-MC-Unique: BSwBDaNKN3adHaG4iKnEdQ-1
Received: by mail-wr1-f72.google.com with SMTP id e12-20020a056000178c00b001606927de88so1230577wrg.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 10:06:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=igSsZqxxeuMq7lqv87REPqLHaXVxhaGz9rpGTm3o31c=;
        b=uQthWKFIyazq/SPdMh3UkTfVXMGPHS+g6v9MfxVzG7NO8yPtin/dQUy7aTDzs9TayB
         M9z2YYAuxDAUbwGzMl9toySfewQuv/4ZHbBbkWw4Kr2/m6ooSZDwfHfrfpwkECiU+D9B
         ZZyJ4Mbh2kJVtlPttJgY97otDRPvcqvcI9w2G3bkpayqEfqAra9HqQ+4Aj8HoBRDddAs
         5CqWhMgVya03Iy0tOAT6KjuBDtnbqfL2jFoZTen8XuxGC+iRSnIKno7xZo6IeTyf/QIW
         CymWd6esGEe9H/rWSugwOU21MqcnR48Mw33lF4xLJoZsZOiV+1OKofPDwyX5S8ye/irF
         +8pQ==
X-Gm-Message-State: AOAM5325Kx07G0A+oavBOkNiciBvWl++a6KHq3tqJnAmXmwvI1c+ca/r
        b07XKQxLmVIsJiiZUq7ACjpezc33IX4l6qUQxlQBTxJtwosbhb0Ec8NK1eSc0RWg4c5rMhZOdzK
        zLzTq5tAgylKimsex6jKvtnxv
X-Received: by 2002:a05:600c:190b:: with SMTP id j11mr154419wmq.138.1632762404140;
        Mon, 27 Sep 2021 10:06:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2VhzlquKBuGwMC/pWh0Q+PuVz+G+F5/MHHBFIbvk1oU85YEG/416rDIbobz2zRzNLZ/Xbrg==
X-Received: by 2002:a05:600c:190b:: with SMTP id j11mr154390wmq.138.1632762403929;
        Mon, 27 Sep 2021 10:06:43 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c654d.dip0.t-ipconnect.de. [91.12.101.77])
        by smtp.gmail.com with ESMTPSA id h18sm2040722wrs.75.2021.09.27.10.06.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 10:06:43 -0700 (PDT)
Subject: Re: [RFC PATCH] userfaultfd: support control over mm of remote PIDs
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>
References: <20210926170637.245699-1-namit@vmware.com>
 <83827672-0996-4c25-9991-697ad443b6b3@redhat.com>
 <A7E15D2B-FFED-4F21-88F4-227E7228782D@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <21c6a41d-3f65-6a49-f604-b75ef53d2910@redhat.com>
Date:   Mon, 27 Sep 2021 19:06:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <A7E15D2B-FFED-4F21-88F4-227E7228782D@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.09.21 12:19, Nadav Amit wrote:
> 
> 
>> On Sep 27, 2021, at 2:29 AM, David Hildenbrand <david@redhat.com> wrote:
>>
>> On 26.09.21 19:06, Nadav Amit wrote:
>>> From: Nadav Amit <namit@vmware.com>
>>> Non-cooperative mode is useful but only for forked processes.
>>> Userfaultfd can be useful to monitor, debug and manage memory of remote
>>> processes.
>>> To support this mode, add a new flag, UFFD_REMOTE_PID, and an optional
>>> second argument to the userfaultfd syscall. When the flag is set, the
>>> second argument is assumed to be the PID of the process that is to be
>>> monitored. Otherwise the flag is ignored.
>>> The syscall enforces that the caller has CAP_SYS_PTRACE to prevent
>>> misuse of this feature.
>>
>> What supposed to happen if the target process intents to use uffd itself?
> 
> Thanks for the quick response.
> 
> First, sorry that I mistakenly dropped the changes to userfaultfd.h
> that define UFFD_REMOTE_PID.

Didn't even notice it :)

> 
> As for your question: there are standard ways to deal with such cases,
> similarly to when a debugged program wants to use PTRACE. One way is
> to block the userfaultfd syscall, using seccomp. Another way is to do
> chaining using ptrace (although using ptrace for anything is
> challenging).
> 
> It is also possible to add tailor something specific to userfaultfd,
> but I think seccomp is a good enough solution. I am open to suggestions.

If we have something already in place to handle PTRACE, we'd better 
reuse what's already there. Thanks!

-- 
Thanks,

David / dhildenb

