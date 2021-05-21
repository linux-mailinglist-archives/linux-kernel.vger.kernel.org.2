Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E281838C0CE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 09:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236116AbhEUHgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 03:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbhEUHgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 03:36:11 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65920C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 00:34:48 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id u21so28990922ejo.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 00:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3bx94lkdjWXmg0ashKOaRNNQdgDpv0IsHnwWt7kOQLM=;
        b=VJm50whTiqsWA6fXyPpeQxHpZcw2PjFL0YVpYXWXhY9X8mLiF0YNDMC4q4PYQOO9Lr
         sSeiW/NnymkrR2hwsFStxHbwyfGsDaN6XMRnTEnUYZM2abgLWVxLT+Hmy0u9QJzYeUu1
         OXtg61aD4f4HDYsK8MHaM7pZaoAec8d61jXNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3bx94lkdjWXmg0ashKOaRNNQdgDpv0IsHnwWt7kOQLM=;
        b=QUDNim9o2Ht4xlR0Ga1n9nIE7N/SFZ+UWfCCwLkSk9j89GoCFbnGfZIJDzIzO8jLd3
         gGRFtA9qxU0rCqt88OdaESxTsaVvg3M52F2HKreYG3vbb3nJNzOgBJuVIOYHTxGVdp0I
         mOgRjg4/UwiuS++Pz4XukmzAJ7jY3aV+WC8mpLQOHs0G84caSP1c96BqhOFTHxf1Uip/
         +JEksc9TSthGDLXJt/7Hk0X35ygx8QTUxIRiJt4sZfGlZCjuJj37Ir9mn4xAEpkked4p
         1qBEK9NGhljIoxnZHcLwR/KY/etYRDdfcyxDCeDeH8KOkuj0ukiKVS52bKNGCuyawMli
         cRzA==
X-Gm-Message-State: AOAM530N+solbEvnGTsAPe4pbrnE8GVBKYBA3VbVQyYAkrJ+e/1Y92pB
        SGABqYGr9OeGSwD++I2BDnQ6ifldWeAWow==
X-Google-Smtp-Source: ABdhPJwYgpKJt+dIA5fCrVd1RSjNpSAgnVsFT2wGKXiBIFWPVlKVy0gxi/yXaFrY+/BpUQgeItkObA==
X-Received: by 2002:a17:906:fccc:: with SMTP id qx12mr8984387ejb.21.1621582486780;
        Fri, 21 May 2021 00:34:46 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id q26sm2939087ejc.3.2021.05.21.00.34.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 May 2021 00:34:46 -0700 (PDT)
Subject: Re: [PATCH] init/main.c: silence some -Wunused-parameter warnings
To:     Andrew Halaney <ahalaney@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <20210519162341.1275452-1-ahalaney@redhat.com>
 <20210519213731.fd8699098bf79bfd23c73090@linux-foundation.org>
 <20210520130330.hqejx2xw6kbdibil@halaneylaptop>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <f06b8308-645b-031b-f9c6-b92400a269aa@rasmusvillemoes.dk>
Date:   Fri, 21 May 2021 09:34:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210520130330.hqejx2xw6kbdibil@halaneylaptop>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/2021 15.03, Andrew Halaney wrote:
> On Wed, May 19, 2021 at 09:37:31PM -0700, Andrew Morton wrote:
>> On Wed, 19 May 2021 11:23:41 -0500 Andrew Halaney <ahalaney@redhat.com> wrote:
>>

> If we decide we don't care about such warnings then feel free to ignore
> this patch, but since I was playing around here anyways I thought I'd
> clean it up a little. My preference would be to care, but the output is
> so loud it is easy to make the argument that it is too late to start
> caring.

Those always-unused annotations are quite verbose. Could we instead
allow both int (*)(char *) and int (*)(void) functions via some macro
magic, say extending __setup_param to something like (entirely untested)

#define __setup_param(str, unique_id, fn, early)                    \
        static const char __setup_str_##unique_id[] __initconst     \
                __aligned(1) = str;                                 \
+       static_assert(same_type(&fn, int (*)(char *)) || same_type(&fn,
int (*)(void)));
        static struct obs_kernel_param __setup_##unique_id          \
                __used __section(".init.setup")                     \
                __aligned(__alignof__(struct obs_kernel_param))     \
-                = { __setup_str_##unique_id, fn, early }
+                = { __setup_str_##unique_id, (int (*)(char *)fn, early }

That would still require modifying each callback, but then it would be
to the more plain-C

int foo(void) // yeah, this doesn't use any parameters

I checked, the transparent_union trick doesn't work for static
initialization.

But really, the compiler should have some heuristic that said "hm, ok,
the address of this function was taken so it probably has that prototype
because it has to be that way". I bet that would remove 90% of the
Wunused-parameter noise.

Rasmus
