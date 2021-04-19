Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4A5364D1A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 23:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240736AbhDSVdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 17:33:53 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:44000 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhDSVdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 17:33:46 -0400
Received: by mail-ed1-f49.google.com with SMTP id e7so42415080edu.10;
        Mon, 19 Apr 2021 14:33:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k4lZkatXb+HtS3bJ1b949kz/uK97pUNLaxlZTbtwP3E=;
        b=nfo8Fb6xGtbS9ZCBV6O2ML+P/U1g5GzbRSZp04xFRTs8MWSQ3R793tqoy+I/SqxJp/
         Nu2EuiS5AsVmzhj85SxMAGO373ojpIAaBTzfGApiPcKtRxN3qraSkaZNI+Qa0BKfjYpc
         LZbS8T9C3gjLS/IEwKpyYnulDLy2KkErLFjHNUhytKhSMj66OcJhqsNQl9CcxfEZVVei
         LningMTbvNsu41MTqX4MXjdXez87RxUSCKoedikmY6C4sq2awN+2wHN0neLz2bLon/Ha
         rHajBZ+xdjrNNNSBoiur2KrNCYvG4CpaGPa+StJQ24/jwFtnTJmSJvyyz6sEJQ31744o
         O0SQ==
X-Gm-Message-State: AOAM531fdHb/oa6DRkHgcCAKrEDxDzcnIKEpgnZJWuxnmouEM3ppSKl8
        Um2OktS1oB0QnanSLc8qCVqpxgT1cHdZl+B2GbY=
X-Google-Smtp-Source: ABdhPJwuAiwQby2+1NrkYQAI2rnCBZKDhMqU9BkmsIck8t+c/F7WCEdZapDleC/COJkjawFJ8THRmajlHX9hQgHfDoM=
X-Received: by 2002:a05:6402:35c9:: with SMTP id z9mr28154497edc.94.1618867994938;
 Mon, 19 Apr 2021 14:33:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210413034346.GA22861@1wt.eu> <CAJvTdKmLth==ZPv7ygLs0jFX7JRPVhVT82ZDoT4xcQRABEVTvQ@mail.gmail.com>
 <20210414095804.GB10709@zn.tnic> <CAJvTdKn_y8qAjDy189zEf8cnaWrvW3baca=z9FgGxV9AvQEADg@mail.gmail.com>
 <20210415044258.GA6318@zn.tnic> <20210415052938.GA2325@1wt.eu>
 <20210415054713.GB6318@zn.tnic> <CAJvTdKnjzAMh3N_c7KP3kA=e0LgYHgCANg44oJp3LcSm7dtbSQ@mail.gmail.com>
 <20210419141454.GE9093@zn.tnic> <CAJvTdK=p8mgO3xw9sRxu0c7NTNTG109M442b3UZh8TqLLfkC1Q@mail.gmail.com>
 <20210419191539.GH9093@zn.tnic>
In-Reply-To: <20210419191539.GH9093@zn.tnic>
From:   Len Brown <lenb@kernel.org>
Date:   Mon, 19 Apr 2021 17:33:03 -0400
Message-ID: <CAJvTdK=VnG94ECcRVoUi8HrCbVEKc8X4_JmRTkqe+vTttf0Wsg@mail.gmail.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
To:     Borislav Petkov <bp@alien8.de>
Cc:     Willy Tarreau <w@1wt.eu>, Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-abi@vger.kernel.org,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 3:15 PM Borislav Petkov <bp@alien8.de> wrote:

> All of a sudden you have *every* thread sporting a fat 8K buffer because
> the library decided to use a fat buffer feature for it.
>
> Nope, I don't want that to happen.

For this to happen, every thread would not only have to include/link-with
code that uses AMX, but that code would have to *run*.

I'm sure that the AI guys are super excited about matrix multiplication,
but I have a hard time imagining why grep(1) would find a use for it.

Indeed, if anyone expected AMX to be used by every task, we would have
never gone to the trouble of inventing the XFD hardware to support
the kernel's lazy 8KB buffer allocation.

cheers,
Len Brown, Intel Open Source Technology Center
