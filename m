Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA1C348463
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 23:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238743AbhCXWM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 18:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbhCXWMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 18:12:46 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB3DC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 15:12:46 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so85997pjv.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 15:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=flIXUMrWcifVgFzaSDEmMehB8YW+PGNP6tRqoJaEbVE=;
        b=w1YG5n57tU6V5WoPNofwTr8BVbm83cBU1pNJsbV0uPfNGfTqmjdyIMRvsABmu1cBOt
         z+4C4NbpkchDdr1RhFqHT0pyd9oJKf72oqDMaTJ8MVjWNkv82LxnyJdNONSTqodgP0/q
         t4kQ+hyH6dVcXAROJOeCMh5+qIhNwVADPOk63E9RZek5Spj7NHZAiFiCAkgzdzG8xGAv
         vamlBIHv+WOL+6v4+kPtRIHIuyCn2y/LCkHxlqqrLarBJq9xKdX18Am6rRJjuJaLKpVo
         iaEIxC/A6HD2WVbLs3shL0VE3qcq9DZrZduSa5huUefuGiTA9aFhME1IlJ3ld6af7DH2
         Ggpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=flIXUMrWcifVgFzaSDEmMehB8YW+PGNP6tRqoJaEbVE=;
        b=tnRI1bw2lP60efTjE1aFTO3J39hYtfU20XR4QnAX4hSackY7B3DrpxsThU2RduKwya
         lh+EyO4t/lJayaP341WuauKBfHlYlhSqzgdBUi5i+3OADhW/+IFICljAsXQaA9rGdCQd
         kdbtJNrT6Qul0DqHOqd/hBKMSQ1klINMU2PzQdeBuR3v3As43Mmk/IGk74WvJAfFsVx7
         m8QDFM+vGqXMBKSVupDmpdh6/MNwjnTa+p1JmrVJUZyw/DI3GfRY1Yxom0gFpOZj6rhB
         68ov0lEOYhIHKIGASmApDlgIWISsSjNwjZjBUo9M83HL8maYnIkBLshAEwBMUgsDV4XG
         LxHw==
X-Gm-Message-State: AOAM533IhlblNkeeL6P9dcFZDKv4QrheL0tlSxJ/c3d0BKzXQHQJppUC
        YNoX6ZxeDQljnnF0LhljvK1VBw==
X-Google-Smtp-Source: ABdhPJxtJXurekBGr96PplmNJCmNhHIHu3s005dlqHSewvgy8Gs/kUrs+nFZjmsxybjo8R6o4zrtcA==
X-Received: by 2002:a17:90a:d801:: with SMTP id a1mr5638553pjv.84.1616623965676;
        Wed, 24 Mar 2021 15:12:45 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:b9f9:ef01:c08a:fb13? ([2601:646:c200:1ef2:b9f9:ef01:c08a:fb13])
        by smtp.gmail.com with ESMTPSA id o13sm3671100pgv.40.2021.03.24.15.12.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 15:12:45 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4 14/22] x86/fpu/xstate: Expand the xstate buffer on the first use of dynamic user state
Date:   Wed, 24 Mar 2021 15:12:43 -0700
Message-Id: <95242657-E9AC-470C-9834-40BDA2E852B9@amacapital.net>
References: <90ea8d01-7fa5-100e-8590-d1ed80eb0d6a@intel.com>
Cc:     Len Brown <lenb@kernel.org>,
        "Liu, Jing2" <jing2.liu@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        X86 ML <x86@kernel.org>, Len Brown <len.brown@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>
In-Reply-To: <90ea8d01-7fa5-100e-8590-d1ed80eb0d6a@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
X-Mailer: iPhone Mail (18D61)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Mar 24, 2021, at 2:58 PM, Dave Hansen <dave.hansen@intel.com> wrote:
>=20
> =EF=BB=BFOn 3/24/21 2:42 PM, Andy Lutomirski wrote:
>>>>> 3. user space always uses fully uncompacted XSAVE buffers.
>>>>>=20
>>>> There is no reason we have to do this for new states. Arguably we
>>>> shouldn=E2=80=99t for AMX to avoid yet another altstack explosion.
>>> The thing that's worried me is that the list of OS-enabled states is
>>> visible to apps via XGETBV.  It doesn't seem too much of a stretch to
>>> think that apps will see AMX enabled with XGETBV and them assume that
>>> it's on the signal stack.
>>>=20
>>> Please tell me I'm being too paranoid.  If we can break this
>>> assumption, it would get rid of a lot of future pain.
>> There are no AMX apps. I sure hope that there are no apps that
>> enumerate xfeatures with CPUID and try to decode the mess in the
>> signal stack.
>=20
> I don't think they quite need to decode it in order to be screwed over a
> bit.  For instance, I don't think it's too crazy if someone did:
>=20
>    xcr0 =3D xgetbv(0);
>    xrstor(xcr0, &sig_stack[something]);
>    // change some registers
>    xsave(xcr0, &sig_stack[something]);
>=20
> The XRSTOR would work fine, but the XSAVE would overflow the stack
> because it would save the AMX state.  It also *looks* awfully benign.
> This is true even if the silly signal handler didn't know about AMX at
> *ALL*.
>=20
> A good app would have checked that the xfeatures field in the header
> matched xcr0.

Ugh.

On the other hand, if we require a syscall to flip the AMX bit in XCR0, we c=
ould maybe get away with saying that programs that flip the bit and don=E2=80=
=99t understand the new ABI get to keep both pieces.

I don=E2=80=99t live futzing with the ABI like this, but AMX is really only b=
arely compatible with everything before it.=
