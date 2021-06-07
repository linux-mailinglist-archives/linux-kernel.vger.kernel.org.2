Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70AD639E6B0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 20:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhFGSat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 14:30:49 -0400
Received: from mail-yb1-f181.google.com ([209.85.219.181]:41702 "EHLO
        mail-yb1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbhFGSaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 14:30:46 -0400
Received: by mail-yb1-f181.google.com with SMTP id q21so26348193ybg.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 11:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+0Qwo32Oi1nv9vlDwm2eqEKRAzjcx7HfOAwXOuTbk10=;
        b=lkaKgvYp2UoBsbN0mkUg7ioP3c5jqxct7eqLECGRJveesvW4KC2u1BWVhzfqxf6FSt
         HhQixNRJpZH3+7y0A2oZg1XSElp+Dr2IA308Z7sOrS3VRG/gY9in2SoimvKMgqoWKpgO
         ek1/b7A3Qwz5EYIi/CY12UoCeXWU2z/+bfhzPd+/c55NF9kmPQapkxknUHefsJ393eD+
         Df6jsV7q4u4MRXOqpNXEOh64c2G6CvR71F9RajfCGEfYIy6549eKKO4h6gFD+z5NceXk
         TaRHXRGLjE8gsKm2Cn/9AjIFDWWNuPoZlFzV82pLgrFA2jNFhqaPD8zj+4qV1TxoPYTV
         inJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+0Qwo32Oi1nv9vlDwm2eqEKRAzjcx7HfOAwXOuTbk10=;
        b=jW6psxBFMKhk1iKEiIBTxybnIJdwaBLq3/q1YYrPvLOn85ozEyFR+owxexmERUlLSQ
         drmE3MO7I9gajTsxv7lSBNSlLtNmNDisAD/Qp0DVF9S9oIvKbdpRbp6gdLXWruvWzboU
         dbJWof/wa4yu6YaF7fZkVRN6Sn+f9LLCdTdVuX3EBHiWMgotuUhzKdwW6MHcALpNfnJ6
         9DvEciLA2Jz11UWNxajmrahwj0t21pcWzrrRPpI5NN/U0XWl65IS0l7EFy0ETpEyFZoY
         IndAs+T5bON/Q5nWJkG7wuI9/YELEfDT7PbY4BcuVQ2DGKt2J2Cc4uNjcIGNhNZK+Km4
         IZeA==
X-Gm-Message-State: AOAM530mwXFqukd/1VgaMTVDtJGJksZOAgbpAi3zPj7sJ7CJMMJrog8s
        8SCL2GcE5WVBff+R5zrIVVA2ru/l5FB70BiaxDAD5Q==
X-Google-Smtp-Source: ABdhPJx4ohpuDTQlAgei1fDf+QUU1Eup7/GocO0IFqPbGVqFWzeZ/RLaM84MwQQ0WMsv8U3PsPPUtwU5EN/gSw2/i5s=
X-Received: by 2002:a25:e741:: with SMTP id e62mr26818800ybh.484.1623090458346;
 Mon, 07 Jun 2021 11:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAFJ_xbq06nfaEWtVNLtg7XCJrQeQ9wCs4Zsoi5Y_HP3Dx0iTRA@mail.gmail.com>
 <20210604205018.2238778-1-ndesaulniers@google.com> <CAKwvOdmhg2tj8cKe-XitoZXGKaoOhgTsCEdVXubt+LiY9+46rw@mail.gmail.com>
 <20210604235046.w3hazgcpsg4oefex@google.com> <YLtUO/thYUp2wU7k@hirez.programming.kicks-ass.net>
 <CAFP8O3+ggR8N-ffsaYSMPX7s2XgrzzTQQjOgCwUe9smyos-waA@mail.gmail.com> <YL5jQ6wMo9WeQDYJ@hirez.programming.kicks-ass.net>
In-Reply-To: <YL5jQ6wMo9WeQDYJ@hirez.programming.kicks-ass.net>
From:   =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Date:   Mon, 7 Jun 2021 11:27:27 -0700
Message-ID: <CAFP8O3KEqSsknL7YwvAhXLu=R6GHR4=SB_Fix0=rR8KiwBKSnA@mail.gmail.com>
Subject: Re: [PATCH v3 16/16] objtool,x86: Rewrite retpoline thunk calls
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, lma@semihalf.com,
        Guenter Roeck <groeck@google.com>,
        Juergen Gross <jgross@suse.com>, lb@semihalf.com,
        LKML <linux-kernel@vger.kernel.org>, mbenes@suse.com,
        =?UTF-8?Q?Rados=C5=82aw_Biernacki?= <rad@semihalf.com>,
        upstream@semihalf.com,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 7, 2021 at 11:19 AM Peter Zijlstra <peterz@infradead.org> wrote=
:
>
> On Sat, Jun 05, 2021 at 06:58:39PM -0700, F=C4=81ng-ru=C3=AC S=C3=B2ng wr=
ote:
>
> > You may use https://github.com/llvm/llvm-project/blob/main/llvm/tools/l=
lvm-objcopy/ELF/Object.cpp#L843
> > as a reference.
>
> BTW, Error::success(), is that a successfull error, or an erroneous
> success? :-))

A success (no error). Error::success() is a factory member function.
Its purpose is to create an "unchecked" Error instance and require the
caller to explicitly check for the error state.
