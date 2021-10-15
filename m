Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE2042ED64
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 11:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237127AbhJOJTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 05:19:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23151 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235937AbhJOJTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 05:19:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634289448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1KdI1b95Ma9fj82jtMmONBjcr0AQBV2wvVKzB96XPbs=;
        b=PsFCgDe5pmbb1YgrnLQWWvP5Uko7z0mIlLoOF7O9RUOmOU+EtPCPilwkYC6+ndIMU2ZZuN
        rGg6l9xC3QCZxSIVmPFI5zEUwQunhAHf0OJdBUZ0Ae6x4AUjyPB5ocECJ7R2RA/shbpCCJ
        XYI69WLQ76Y8OsPdMPgSf9HhemJsf8U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-vRhSAf23MFmg3xIvS89DNA-1; Fri, 15 Oct 2021 05:17:26 -0400
X-MC-Unique: vRhSAf23MFmg3xIvS89DNA-1
Received: by mail-wm1-f72.google.com with SMTP id p3-20020a05600c204300b0030daa138dfeso460729wmg.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 02:17:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1KdI1b95Ma9fj82jtMmONBjcr0AQBV2wvVKzB96XPbs=;
        b=rkXjq+Ys6HmRX5ve6l5hITb9D6ndIiuOoxaHVFtR+bul/Bh76+jeq606/HoKYEzXAw
         GURrWxYuanbbUNMMMA3iphB1NMM55g6BpnPXJFf5c81bzeySfGgW/1oB67HJIGuxE2Vs
         2u7IrNfQFdN/z1DHzpN4ySSu0C7Wy54cq5os8FZ/qG0S/0DtmF9RjaInWPLZeK1+JVD+
         G3dM++jvfyFbw0VGZ2pwP2yosP0ExsKJfUC3S5vliWvXJ7qfGZpgV2Nkg/D5vq1ySCC/
         NIBvWNI1NnWqdVWBtrNOLlEo+rTJls/wDBAANd7HYto9fvCzs+vuBjfMkPQcw1mBc+dW
         XItw==
X-Gm-Message-State: AOAM531HkHl1Y7gCobwMJS2AggeYL0yEb2/rX4h2Mlx+zYS8V8kPzHKk
        BOvVNo5uBqVSf23xySfKS94Hx51cB6AOX+gBV9KGKoc9o318LdvoXbtJ1v9w/F+HsxwNEDhowSz
        wPbpl9bXY0oVVdadVrqqIpYEm
X-Received: by 2002:a7b:c386:: with SMTP id s6mr25302238wmj.183.1634289444897;
        Fri, 15 Oct 2021 02:17:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHMWc5BlwaRILOSv4LqsRXCXOvU26NnAoPb3/TeCePM3GlKLRXnpPWiu9jHQLYw72aPn5o9w==
X-Received: by 2002:a7b:c386:: with SMTP id s6mr25302215wmj.183.1634289444691;
        Fri, 15 Oct 2021 02:17:24 -0700 (PDT)
Received: from smtpclient.apple ([2a01:e0a:466:71c0:b1f7:fa09:b694:af37])
        by smtp.gmail.com with ESMTPSA id n12sm4593102wms.27.2021.10.15.02.17.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Oct 2021 02:17:23 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [BUG] [5.15] Compilation error in arch/x86/kvm/mmu/spte.h with
 clang-14
From:   Christophe de Dinechin <cdupontd@redhat.com>
In-Reply-To: <fb1da4d3-9e3e-4604-2f30-30292f9d13aa@redhat.com>
Date:   Fri, 15 Oct 2021 11:17:22 +0200
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Jim Mattson <jmattson@google.com>, torvic9@mailbox.org,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9F0C48F4-A62B-456C-9EBD-DB02026631D1@redhat.com>
References: <1446878298.170497.1633338512925@office.mailbox.org>
 <b6abc5a3-39ea-b463-9df5-f50bdcb16d08@redhat.com>
 <936688112.157288.1633339838738@office.mailbox.org>
 <c4773ecc-053f-9bc6-03af-5039397a4531@redhat.com>
 <CAKwvOd=rrM4fGdGMkD5+kdA49a6K+JcUiR4K2-go=MMt++ukPA@mail.gmail.com>
 <CALMp9eRzadC50n=d=NFm7osVgKr+=UG7r2cWV2nOCfoPN41vvQ@mail.gmail.com>
 <YWht7v/1RuAiHIvC@archlinux-ax161> <YWh3iBoitI9UNmqV@google.com>
 <CAKwvOdkC7ydAWs+nB3cxEOrbb7uEjiyBWg1nOOBtKqaCh3zhBg@mail.gmail.com>
 <fb1da4d3-9e3e-4604-2f30-30292f9d13aa@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 14 Oct 2021, at 22:50, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
> On 14/10/21 21:06, Nick Desaulniers wrote:
>>> If we want to fix this, my vote is for casting to an int and =
updating the comment
>> At the least, I think bitwise operations should only be performed on
>> unsigned types.
>=20
> This is not a bitwise operation, it's a non-short-circuiting boolean =
operation.  I'll apply Jim's suggestion.

What about making it an inline function, which would require evaluation =
of arguments:

	static __always_inline bool BITWISE_BOOLEAN_OR(bool a, bool b)
	{
	    return a || b; // Safe here, because arguments have been =
evaluated
	}

Suggesting that because I'm always nervous about casts in macros hiding =
something that the type  system would otherwise catch.


Christophe
>=20
> Paolo
>=20

