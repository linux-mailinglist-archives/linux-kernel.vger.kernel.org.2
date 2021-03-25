Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12159349C9C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 00:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbhCYW7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 18:59:46 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:35720 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbhCYW7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 18:59:19 -0400
Received: by mail-ed1-f54.google.com with SMTP id dm8so4263651edb.2;
        Thu, 25 Mar 2021 15:59:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tp2zS05BwtRY3Itowm2uz6iwQX/pxSYd0u71j04Rk6w=;
        b=Q4tXndfabix/onEl0Urrziy+tK1wh/Mwutt1boQs2n8S2K2bWrT8RUbBwRmWP7OJ24
         5AeO0E5pavRrkWgc5vlj//vGnNYPoi6cfS09px+TNtKuXX86NBtDz+b89HacXv1DJUXV
         I4B4wj67ZT1/R0+Pi0E9GbNXuDWoJSvAbTAPx1AaTZxy7Ced4kEDbJiXH7DE5vc01vZ/
         eZbCYCDv+1LHOej+FBw1FKC8ZVjfc0ZT48R6SnCD118g+NbCZSASe1WeRXjsWiAcJnRW
         hxnzaE4JRx2F8RmguBFxbR50tqFs+K7PWmOHbCnJXwF9w6txjKg5ors41t0FZ9bgXf8M
         5kng==
X-Gm-Message-State: AOAM530czNE0NgMReV7W6vFed6I6cI4KPAMIS36ZUgmj1x30d60TxYan
        ehUWBtiCVHCbsnIP644PIWVGnEtKhz2K0DiNcpCfhdGiY+E=
X-Google-Smtp-Source: ABdhPJyUjBKC+uANInwiDCNBJ465jvcT0nnByAHqE7u4iEuERfWG5jkqO2XvR7KsVO6OWdT8g+qvWfndaWNv/O0hF2E=
X-Received: by 2002:a05:6402:4245:: with SMTP id g5mr11807857edb.306.1616713158061;
 Thu, 25 Mar 2021 15:59:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210221185637.19281-1-chang.seok.bae@intel.com>
 <20210221185637.19281-23-chang.seok.bae@intel.com> <871rc9bl3v.fsf@nanos.tec.linutronix.de>
In-Reply-To: <871rc9bl3v.fsf@nanos.tec.linutronix.de>
From:   Len Brown <lenb@kernel.org>
Date:   Thu, 25 Mar 2021 18:59:06 -0400
Message-ID: <CAJvTdKkOKOgnmvAiPS6mWVoyAggbOB6hBOqb_tcHYDe8+-X+FQ@mail.gmail.com>
Subject: Re: [PATCH v4 22/22] x86/fpu/xstate: Introduce boot-parameters to
 control state component support
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2021 at 4:57 PM Thomas Gleixner <tglx@linutronix.de> wrote:

> We won't enable features which are unknown ever. Keep that presilicon
> test gunk where it belongs: In the Intel poison cabinet along with the
> rest of the code which nobody ever want's to see.

I agree, it would be irresponsible to enable unvalidated features by default,
and pre-silicon "test gunk" should be kept out of the upstream kernel.

This patch series is intended solely to enable fully validated
hardware features,
with product quality kernel support.

The reason that the actual AMX feature isn't mentioned until the 16th
patch in this series
is because all of the patches before it are generic state save/restore patches,
that are not actually specific to AMX.

We call AMX a "simple state feature" -- it actually requires NO KERNEL ENABLING
above the generic state save/restore to fully support userspace AMX
applications.

While not all ISA extensions can be simple state features, we do expect
future features to share this trait, and so we want to be sure that it is simple
to update the kernel to turn those features on (and when necessary, off).

There will be a future CPUID attribute that will help us identify
future simple-state features.
For AMX, of course, we simply know.

So after the generic state management support, the kernel enabling of AMX
is not actually required to run applications.  Just like when a new instruction
is added that re-uses existing state -- the application or library can check
CPUID and just use it.  It is a formality (perhaps an obsolete one), that
we add every feature flag to /proc/cpuid for the "benefit" of userspace.

The reason we propose this cmdline switch is
1. Ability of customers to disable a feature right away if an issue is found.
Unlike the CPUid cmdline that works on flags, this is the ability to turn
off a feature based on its state number.  Ie.  There could be 20 features
that use the same state, and you can turn them all off at once this way.

2. Ability of customers to enable a feature that is disabled by default
in their kernel.  Yes, this will taint their kernel (thanks Andy),
but we have customers that want to run the new feature on day 0
before they have got a distro update to change the default, and this
gives them a way to do that.

Yeah, the cmdline syntax is not a user-friendly mnemonic, and I don't know
that making it so would be an improvement.
Like the CPUID cmdline, it is precise, it is future-proof, and it is
used only in special situations.

thanks,
Len Brown, Intel Open Source Technology Center
