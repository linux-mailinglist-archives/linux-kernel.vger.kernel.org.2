Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20EA438F2CA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 20:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbhEXSRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 14:17:35 -0400
Received: from mail-ej1-f47.google.com ([209.85.218.47]:45961 "EHLO
        mail-ej1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbhEXSRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 14:17:34 -0400
Received: by mail-ej1-f47.google.com with SMTP id s22so42996604ejv.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 11:16:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UMOTYOqV6XU9AGpz/NRItQY+YgaxFe1Ax31Oqlj3Xpc=;
        b=AyLDTVEemBcQn25He/6R0EHKpfkkRMfbFYtGiEdtjIJmggblmnmWSgNuyDkTjmWrc9
         5pHIpOCXklGJ+aj5eMvU5qBmwMDR/yXXnxvsDZrXIOSKipBE0cInWfV247h1ydkU2vMm
         xc/1zx47y/mTPk2yK9oGG3Win+vHLbGFpSye73ETpkajIlsDEGIlcZOTGtj5CRHaPyyF
         QoOMvsY/Eqi9YERrgqYRakJ2eGw3VFkNF8LL8++6JPthnlOA92jcY6HKuBIDAUVRZsm3
         dwUR1QZmWyHoZWEORbzdrcVgUc27EhPOkO6n4oawW+3pG2/r+zs+3CEbYMa5hswstf0r
         IByg==
X-Gm-Message-State: AOAM531xAdWA2vaqgnh+yzZ2EJd8LIa93c7KIRc6dNIBv6DAg0RhnlIb
        ubeZGkJjVMaKhS1Tfkqr923cxTYzML7J7uorb6E=
X-Google-Smtp-Source: ABdhPJxI+21e71vi6Z7xE7Bh+VYFcWU6Z7tTN6m9n/GrmRG9J8R97N4/loI6VLreNSbHWLJQ7blqhU6e46OP9Zq/WIQ=
X-Received: by 2002:a17:907:33d4:: with SMTP id zk20mr24600147ejb.330.1621880164378;
 Mon, 24 May 2021 11:16:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210523193259.26200-1-chang.seok.bae@intel.com>
 <20210523193259.26200-26-chang.seok.bae@intel.com> <6197fd94-76a9-a391-f290-7001a71add7f@kernel.org>
In-Reply-To: <6197fd94-76a9-a391-f290-7001a71add7f@kernel.org>
From:   Len Brown <lenb@kernel.org>
Date:   Mon, 24 May 2021 14:15:53 -0400
Message-ID: <CAJvTdKmq2qKgkkbeQzQ6dG14+EWZ_eTbz6c6neGLFo_X=PCJeg@mail.gmail.com>
Subject: Re: [PATCH v5 25/28] x86/fpu/xstate: Skip writing zeros to signal
 frame for dynamic user states if in INIT-state
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

On Sun, May 23, 2021 at 11:28 PM Andy Lutomirski <luto@kernel.org> wrote:

> But what happens if we don't have the XGETBV1 feature?  Are we making
> AMX support depend on XGETBV1?

Yes, AMX systems always have XGETBV.

> How does this patch interact with "[PATCH v5 24/28] x86/fpu/xstate: Use
> per-task xstate mask for saving xstate in signal frame"?  They seem to
> be try to do something similar but not quite the same, and they seem to
> be patching the same function.  The result seems odd.

The previous patch allowed non-AMX tasks to skip writing 8KB of zeros
to their signal stack.  This patch builds on that to allow an AMX-task
in INIT to also skip writing 8KB of zeros to its signal stack.

> Finally, isn't part of the point that we need to avoid even *allocating*
> space for non-AMX-using tasks?  That would require writing out the
> compacted format and/or fiddling with XCR0.

The current signal stack ABI is that the user receives all
architectural state in
uncompressed XTATE format on the signal stack.  They can XRESTOR it
and the right thing happens.

We can optimize the data transfer (and we have), but we can't optimize the space
without changing that ABI.

Again, I'm happy to investigate a new opt-in fast-signal ABI that doesn't
have all this state.  But so far, nobody has asked for it, or even identified
an application that cares about minimum-overhead signals.
Can you recommend one?

thanks,
Len Brown, Intel Open Source Technology Center
