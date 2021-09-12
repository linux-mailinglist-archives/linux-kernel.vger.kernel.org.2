Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8813F408244
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 01:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236688AbhILXP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 19:15:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46848 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236622AbhILXP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 19:15:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631488451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kE+f8eZSnmxip1KphitcMWzsxYEael7Knbp5a1w+0jw=;
        b=INwQQU6HHK4TjME1RJ9ufI59Z+b38md+xB1SsNBd4r2UMNNevlaRV4gRtxWDWzwGFsyXSo
        KF8cS2V1wfMpN4he1ehK1SSAdbXYPDFJWsTupjOjOASoZhm9nP2FmKMyejjsxUQOjRPtzK
        9/2TTeYJNreSsxbIqpigLmXSKrHCaM4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-XG27dXaOP_-2yP5eTSihkw-1; Sun, 12 Sep 2021 19:14:10 -0400
X-MC-Unique: XG27dXaOP_-2yP5eTSihkw-1
Received: by mail-qt1-f199.google.com with SMTP id b15-20020a05622a020f00b0029e28300d94so54152543qtx.16
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 16:14:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=kE+f8eZSnmxip1KphitcMWzsxYEael7Knbp5a1w+0jw=;
        b=OQPHcolEfTWgLB1QI0/p/Tnpywc5kR0WCVof7mgNpfjGziI1gLACpD9VRwSRw4oopQ
         N/9fY+Mbs29hXXl0XgN95NfCSmIF52iPnDMeTB4g4khr/ib8a7PVI6odK5xO0b/qepuS
         HRUDhFmfX0TXQBH71hMEvb1FF3VzjdPuJUF7Zgmsc31ErRMMz+ihk2PJUcdYGygwJTLP
         ZGJ5hD7JD6J1vJfeDLOIjakfadhqJ6uxO6piJLVD09GL4MwHGZwDPZiGLBW7upi3QYv0
         BSZRY6DaBcGQqeEzycfJOTQbZ8bdxo/bQWzqZ81271szfk3Z+fIieXWN3ohtz0ANQpxV
         XuNw==
X-Gm-Message-State: AOAM532M/7Ivz0kLCoBT5CXij330cFXHOhNvH08YvV+d7e+r7vqfL8+N
        KIUPqI97v9mBV4Vwb5Tb/A5o22Jdtpo0UBHzDcguG1WY8mbamVGWUvBR9GJoRjEUpHqE9xnoyl1
        am1vb0ycPu2KJ/1w0LurMsnDm
X-Received: by 2002:a05:620a:89b:: with SMTP id b27mr7258508qka.429.1631488450070;
        Sun, 12 Sep 2021 16:14:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdVLlOYUeUXdlomx1acPMw/JaEVviENsKd4hMZAnyh1ZGDxZFLdD/vlSplLFhe2m6Uh8Q2kQ==
X-Received: by 2002:a05:620a:89b:: with SMTP id b27mr7258485qka.429.1631488449893;
        Sun, 12 Sep 2021 16:14:09 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id t26sm3943296qkm.0.2021.09.12.16.14.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Sep 2021 16:14:09 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 1/1] x86: change default to
 spec_store_bypass_disable=prctl spectre_v2_user=prctl
To:     Kees Cook <keescook@chromium.org>,
        Andrea Arcangeli <aarcange@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        YiFei Zhu <zhuyifei1999@gmail.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>, Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andi Kleen <ak@linux.intel.com>
References: <87eel8lnbe.fsf@nanos.tec.linutronix.de>
 <20201104235054.5678-1-aarcange@redhat.com>
 <202109111411.C3D58A18EC@keescook>
Message-ID: <c0722838-06f7-da6b-138f-e0f26362f16a@redhat.com>
Date:   Sun, 12 Sep 2021 19:14:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <202109111411.C3D58A18EC@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/21 5:13 PM, Kees Cook wrote:
> On Wed, Nov 04, 2020 at 06:50:54PM -0500, Andrea Arcangeli wrote:
>> Switch the kernel default of SSBD and STIBP to the ones with
>> CONFIG_SECCOMP=n (i.e. spec_store_bypass_disable=prctl
>> spectre_v2_user=prctl) even if CONFIG_SECCOMP=y.
> Hello x86 maintainers!
>
> I'd really like to get this landed, so I'll take this via the
> seccomp-tree unless someone else speaks up. This keeps falling off
> the edge of my TODO list. :)
>
> -Kees
>
You can add my ack too. Thanks!

Acked-by: Waiman Long <longman@redhat.com>

