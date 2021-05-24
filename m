Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2E338F250
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 19:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbhEXRgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 13:36:10 -0400
Received: from mail-ej1-f41.google.com ([209.85.218.41]:40893 "EHLO
        mail-ej1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232708AbhEXRgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 13:36:09 -0400
Received: by mail-ej1-f41.google.com with SMTP id n2so43008806ejy.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 10:34:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iD63KMcaK425H8hm2GhShuQzmtgMHe7ccDBTbjGg9P4=;
        b=ZzVs/O5/G+ipsrZlNqi8gPHDkAYNDhjwlkvQAHwIWN+h0FJXNrPoGRXvPg96j0uriF
         3BcrWjsiwiCLPO6gIoybTaHOTbLLhuVIfvdR6fR+NrGSPEIQPzTbjDNDkr30CyPnlp0Z
         q3ZyDWmdBB51opw46O54H0tMurbY/FVQDiyBiV5mNkylS3mI7XEWnJqj2+VPW3oXSNBZ
         syPwoH0FVDDsVW54lSb7jHFR736xu1DwxZEg5o1zkQpuYFQR/8f4RoD2FGLXQDuqIfXH
         eVnVMzL0wnlChGFZm947acgn5DsIokdY//yWEZAez3PupY33yCsOusTIbd17x+0Mu7AW
         YIyA==
X-Gm-Message-State: AOAM532YPBonTljuo1nYAu2pFjW9rRK5x7LPO71Va5zyeD3AWfw+ja2h
        QzR/+bNdA3qrF4kcGb3NvUAtzxVULgN24R8r5JQ=
X-Google-Smtp-Source: ABdhPJztj9YoQmryvyxdBXocLfyaGrVpMzVwtw8T81wdk+ofIHhjYDWSr4KE6rzkjjM4heQ8MFB9DR+R5DRgnMZ3m+w=
X-Received: by 2002:a17:906:f2ca:: with SMTP id gz10mr25190022ejb.317.1621877679038;
 Mon, 24 May 2021 10:34:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210523193259.26200-1-chang.seok.bae@intel.com>
 <20210523193259.26200-29-chang.seok.bae@intel.com> <fd9ea1d5-06cf-c5e7-e44e-d74fa7627983@intel.com>
In-Reply-To: <fd9ea1d5-06cf-c5e7-e44e-d74fa7627983@intel.com>
From:   Len Brown <lenb@kernel.org>
Date:   Mon, 24 May 2021 13:34:28 -0400
Message-ID: <CAJvTdKk-53JzUzgGbgWSsfMcGPjQ0Wvrb-AqYOhX3JArVsB=Qg@mail.gmail.com>
Subject: Re: [PATCH v5 28/28] x86/fpu/amx: Clear the AMX state when appropriate
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 10:07 AM Dave Hansen <dave.hansen@intel.com> wrote:

> Could we maybe say:
>
>                 /*
>                  * Leaving state in the TILE registers may prevent the
>                  * processor from entering low-power idle states.  Use
>                  * TILERELEASE to initialize the state.  Destroying
>                  * fpregs state is safe after the fpstate update.
>                  */

Ack

> Also, referencing fpregs/fpstate is really nice because the codes
> doesn't actually say "XSAVE" anywhere.
>
> > +             if (fpu->state_mask & XFEATURE_MASK_XTILE_DATA)
> > +                     tile_release();
>
> Doesn't this tile_release() need a fpregs_deactivate()?  Otherwise, the
> next XRSTOR might get optimized away because it thinks there's still
> good data in the fpregs.
>
> Will this unnecessarily thwart the modified optimization in cases where
> we go and run this task again without ever going out to userspace?  Will
> this impact context-switch latency for *EVERY* context switch in order
> to go to a lower idle state in a few minutes, hours, or never?

yeah, seems we missed that.


thanks!
Len Brown, Intel Open Source Technology Center
