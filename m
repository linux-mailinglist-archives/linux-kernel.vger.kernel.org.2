Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3113605DA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 11:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbhDOJe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 05:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbhDOJe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 05:34:57 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10865C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 02:34:34 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id r5so11467879ilb.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 02:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2oxhfmgq4/lBHZsTv5waxIB12jAdndxIiCGYaYJ0QbU=;
        b=UbdMnzkMjlp4dVJzE5P6mIlHvL1lwGcw1qltoT9qncf5Oc0r2fUgB9SKUW0wR9lDVC
         tKEZRlsxRg6hWGuydX2yQhRoWDikqmWFp5mOfPESNP0UQuEbY0Z7R5UaUJ+XT9zQ6g7R
         /KAeiqhfw8gm2oDkm/y60F44SPj0DkvpIy+BE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2oxhfmgq4/lBHZsTv5waxIB12jAdndxIiCGYaYJ0QbU=;
        b=ZAGgfmIFYNEWx3022OaUYGKCmzrSVDAhzhU9Rm0x1+UJlFaCIT8OHrLoterIkFMQJx
         I9F9Jj+YoR/MCkD129r+XeB5E2r3DHSGMCN2Q8NrjWRdZFJ/w++JDDwkhXmmW6ur38S4
         3GQ+zfCRVh5rRY+/RGr7v2O8K8vhCyrXUZxUUqPTvrCdB1DhHrXzi81bxErCZMM4oCGi
         nNg9D8/wiRlgAsGE7uQB5eStlssu7b26/RsCW36KMMnKYQ5oo2/jdBL2Y8UQkBV4vFfE
         W2JTsWxst8XrJkS7P8KpNFUEh7TPSWf+dBX2AsKW2euv316Q1b2ZrgPT9DOFbdjNgtyd
         EldQ==
X-Gm-Message-State: AOAM530tguKav0Zk4p/gBshcbXC6Q/VBsr1ahu5QuYNTHhe4w2vVdy/g
        tQoKCcygJx2oVm8HRHKa9fftZc7EFxG42pndk6v8+w==
X-Google-Smtp-Source: ABdhPJzeShXmcoEfu+1+Ri6SonH6CoZJyCAHTZk+mfvL5aCtUdErvhGRLF2ppMLjZe5OeRF+Nqbi3GEmTsfRatK8tD4=
X-Received: by 2002:a92:ce90:: with SMTP id r16mr2135098ilo.220.1618479273627;
 Thu, 15 Apr 2021 02:34:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210412153754.235500-1-revest@chromium.org> <20210412153754.235500-4-revest@chromium.org>
 <CAEf4BzZCR2JMXwNvJikfWYnZa-CyCQTQsW+Xs_5w9zOT3kbVSA@mail.gmail.com>
 <CABRcYmJvzcFySYS=U=xtfn4eG7yKpmET_yh-bZYrkYfJMdx_pw@mail.gmail.com> <CAEf4Bza+rVCp=G5i97MuuBrTX+o1ZUBn3nzstssoS1KtE4F6vw@mail.gmail.com>
In-Reply-To: <CAEf4Bza+rVCp=G5i97MuuBrTX+o1ZUBn3nzstssoS1KtE4F6vw@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Thu, 15 Apr 2021 11:34:22 +0200
Message-ID: <CABRcYm+XPciihdZDWSMUBLmtBCuDSV=bHvtEUqZupfC=cng6FA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/6] bpf: Add a bpf_snprintf helper
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 12:57 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Apr 14, 2021 at 2:46 AM Florent Revest <revest@chromium.org> wrote:
> >
> > On Wed, Apr 14, 2021 at 1:16 AM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > > On Mon, Apr 12, 2021 at 8:38 AM Florent Revest <revest@chromium.org> wrote:
> > > > +
> > > > +       return err + 1;
> > >
> > > snprintf() already returns string length *including* terminating zero,
> > > so this is wrong
> >
> > lib/vsprintf.c says:
> >  * The return value is the number of characters which would be
> >  * generated for the given input, excluding the trailing null,
> >  * as per ISO C99.
> >
> > Also if I look at the "no arg" test case in the selftest patch.
> > "simple case" is asserted to return 12 which seems correct to me
> > (includes the terminating zero only once). Am I missing something ?
> >
>
> no, you are right, but that means that bpf_trace_printk is broken, it
> doesn't do + 1 (which threw me off here), shall we fix that?

Answered in the 1/6 thread

> > However that makes me wonder whether it would be more appropriate to
> > return the value excluding the trailing null. On one hand it makes
> > sense to be coherent with other BPF helpers that include the trailing
> > zero (as discussed in patch v1), on the other hand the helper is
> > clearly named after the standard "snprintf" function and it's likely
> > that users will assume it works the same as the std snprintf.
>
>
> Having zero included simplifies BPF code tremendously for cases like
> bpf_probe_read_str(). So no, let's stick with including zero
> terminator in return size.

Cool :)
