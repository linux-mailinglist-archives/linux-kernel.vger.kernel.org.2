Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C33C4371629
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 15:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbhECNsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 09:48:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60850 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232195AbhECNsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 09:48:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620049650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ffFCAR2cXSWF5mqx4pWMJSVc5PKfjZLjCWyRA8EWt54=;
        b=IYqsmSj1v4jQKS43jp/N07gcwrws6l/joPcFrDN3z/Yjdh0Wdfg1TbPzA5JQCWxCat4Rm6
        3qlRIy6M5IKIxp6Ier1aB9O5nZ5amkF4rkM+GEAh7IoviH6nOjPFLVd4NKQK0XknKbhcck
        V4eFJUoE+1wQaEERIrEYozDIXYHcQps=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-ZyAwS0FwNY6r27RJmlOW4w-1; Mon, 03 May 2021 09:47:26 -0400
X-MC-Unique: ZyAwS0FwNY6r27RJmlOW4w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA111801817;
        Mon,  3 May 2021 13:47:24 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-112-137.ams2.redhat.com [10.36.112.137])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 812925C22A;
        Mon,  3 May 2021 13:47:21 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Willy Tarreau <w@1wt.eu>, Andy Lutomirski <luto@kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-abi@vger.kernel.org,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related
 features
References: <20210415044258.GA6318@zn.tnic> <20210415052938.GA2325@1wt.eu>
        <20210415054713.GB6318@zn.tnic>
        <CAJvTdKnjzAMh3N_c7KP3kA=e0LgYHgCANg44oJp3LcSm7dtbSQ@mail.gmail.com>
        <20210419141454.GE9093@zn.tnic>
        <CAJvTdK=p8mgO3xw9sRxu0c7NTNTG109M442b3UZh8TqLLfkC1Q@mail.gmail.com>
        <20210419191539.GH9093@zn.tnic>
        <CAJvTdK=VnG94ECcRVoUi8HrCbVEKc8X4_JmRTkqe+vTttf0Wsg@mail.gmail.com>
        <20210419215809.GJ9093@zn.tnic>
        <CAJvTdKn6JHo02karEs0e5g+6SimS5VUcXKjCkX35WY+xkgAgxw@mail.gmail.com>
        <YIMmwhEr46VPAZa4@zn.tnic>
        <CAJvTdKnhXnynybS4eNEF_EtF26auyb-mhKLNd1D9_zvCrchZsw@mail.gmail.com>
        <87bl9s8kfb.fsf@oldenburg.str.redhat.com>
        <5d3d513b-77d6-e2e2-779e-ff3ea33deba3@intel.com>
Date:   Mon, 03 May 2021 15:47:34 +0200
In-Reply-To: <5d3d513b-77d6-e2e2-779e-ff3ea33deba3@intel.com> (Dave Hansen's
        message of "Mon, 3 May 2021 06:43:54 -0700")
Message-ID: <87zgxc53pl.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Dave Hansen:

> On 5/2/21 10:18 PM, Florian Weimer wrote:
>>> 5. If the feature is enabled in XCR0, the user happily uses it.
>>>
>>>     For AMX, Linux implements "transparent first use"
>>>     so that it doesn't have to allocate 8KB context switch
>>>     buffers for tasks that don't actually use AMX.
>>>     It does this by arming XFD for all tasks, and taking a #NM
>>>     to allocate a context switch buffer only for those tasks
>>>     that actually execute AMX instructions.
>> What happens if the kernel cannot allocate that additional context
>> switch buffer?
>
> Well, it's vmalloc()'d and currently smaller that the kernel stack,
> which is also vmalloc()'d.  While it can theoretically fail, if it
> happens you have bigger problems on your hands.

Not sure if I understand.

Is your position that the kernel should terminate processes if it runs
out of memory instead reporting proper errors, even if memory overcommit
is disabled?

Kernel stack allocation is different because it happens at system call,
so errors can be properly reported.

Thanks,
Florian

