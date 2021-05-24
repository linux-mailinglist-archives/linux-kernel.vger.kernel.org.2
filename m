Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75B1238F2BB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 20:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbhEXSIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 14:08:19 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:39885 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbhEXSIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 14:08:17 -0400
Received: by mail-ed1-f45.google.com with SMTP id h16so32991370edr.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 11:06:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZFilWAFKanClEn/uldncIoFEJ9iJ+NoZjOCtXG1E2iA=;
        b=khYUBQyik0qfd8SSzc5RjbER36UVtAbOYC0eBIFZ1bK8TxYjemBSXWr/keh8In0Y62
         6XAbCGXyZR2XA5yg925S50GLL0PIV1JsPR7jjnli8e26k5PXUaMeb+wtpaRJCPvrc2AE
         RaplycBDDEzhBidxtBUCD0CCtcPiCLMocOSxk1aSSV3oaj2mpr7eXiPEFyNrcdvW9nMM
         LaSl1Q1LjKXsDK7dMUUtPH17m01m9T1rmZGaqSjgBAl0+rlJVBSWef9fWYo5i0Vg2A3V
         +iKO2EySrBe3/zh/jxTRpzOkDZmeCSvo+zoXmnr7zLZkP0WUQF8K1L3PKtA5hIsxHabO
         0v2Q==
X-Gm-Message-State: AOAM531k54SNvyTok+ygOZh7eQZyS88BZkxacaZDKZ/71PCawYycJp7E
        WY9GW9neJ0/b915HLy19zA9bOynsAj8XuPGLjFNSKviq
X-Google-Smtp-Source: ABdhPJyv0yxOmyw0vMRKQrXRXDOII2V4HkRlaqOtHXhorZ8AMdxF2853MsMNTq0sR8Nh66cG5HT1GScQnPEdTaWxnIc=
X-Received: by 2002:aa7:c818:: with SMTP id a24mr27351118edt.310.1621879608583;
 Mon, 24 May 2021 11:06:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210523193259.26200-1-chang.seok.bae@intel.com>
 <20210523193259.26200-25-chang.seok.bae@intel.com> <de9f67eb-2be7-8950-749e-cc8eef5cc142@kernel.org>
In-Reply-To: <de9f67eb-2be7-8950-749e-cc8eef5cc142@kernel.org>
From:   Len Brown <lenb@kernel.org>
Date:   Mon, 24 May 2021 14:06:37 -0400
Message-ID: <CAJvTdK=ZRFxh1=e0q7JbtNDfQWrS1d3TzrMHGiTg2Eaq1LsRSw@mail.gmail.com>
Subject: Re: [PATCH v5 24/28] x86/fpu/xstate: Use per-task xstate mask for
 saving xstate in signal frame
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 23, 2021 at 11:15 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> If I'm reading this right, it means that tasks that have ever used AMX
> get one format and tasks that haven't get another one.

No.  The format of the XSTATE on the signal stack is uncompressed XSAVE
format for both AMX and non-AMX tasks, both before and after this patch.
That is because XSAVE gets the format from XCR0.  It gets the fields
to write from the run-time parameter.

So the change here allows a non-AMX task to skip writing data (zeros)
to the AMX region of its XSTATE buffer.

The subsequent patch adds the further optimization of (manually) checking
for INIT state for an AMX-task and also skip writing data (zeros) in that case.

We should have done this optimization for AVX-512, but instead we
guaranteed writing zeros, which I think is a waste of both transfer time
and cache footprint.

Len Brown, Intel Open Source Technology Center
