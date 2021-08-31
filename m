Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3249A3FCFA0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 00:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240300AbhHaWph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 18:45:37 -0400
Received: from mail-ej1-f44.google.com ([209.85.218.44]:38730 "EHLO
        mail-ej1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhHaWpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 18:45:36 -0400
Received: by mail-ej1-f44.google.com with SMTP id n27so2331494eja.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 15:44:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qSp4z9/S/GmJmZB+68ZXewALFEkWTtL9H0IgTSE7BNw=;
        b=GKhG0+1+VRIOLmQ0if/rasXZmAPpfj+m9/zhs1Y0fLaKhxpBwrQ8yXrAHhO0LFM0cH
         CuA8ll8aGHT04bf8hhrJZBgWn5iwyl9yMjoLfStx+4Df0+aTkYAAmVkQvGMvznlGObzU
         aTplA2mtp4wJCCjo4vo7PUF/of4EYbaYu7Ee9JOlZxF7MQB1yyBEKhGacW16qP0iuVAc
         wkT213Yo1JwM9M2AfxFGoE6RdfgxSuPFQb0s3qZMo0zDlD9ouDIaOV+HQ1Y72wTCCH4+
         lbosHiWBwGJV1Z6wdyaPXhcSuddliLo6KYlnqK0sdtfufOJhvZKwzh97bF+INjX8IjVX
         VRmg==
X-Gm-Message-State: AOAM533av+BZ+dH6wHQR9ZuWF5MtHsuk8Y6UBTFF60C5r1NipAfREik7
        S4KNFJzo657SjfOhlX/QYeG/UB+BFUTxqJq1Csk=
X-Google-Smtp-Source: ABdhPJyN8v48bt7PC2J0FDeKIZcBbMhlgZYHhrj2dOl2GEIDlo5sNdc+BMmTiXQvAxch/pBc3C8qtksti+9h5KCUjNU=
X-Received: by 2002:a17:906:988a:: with SMTP id zc10mr34003082ejb.256.1630449879396;
 Tue, 31 Aug 2021 15:44:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210730145957.7927-1-chang.seok.bae@intel.com>
 <a96a65fc-061b-e94b-cee7-16201ac0820f@intel.com> <CAJvTdKkZ==89-rDeBUDy1GJEzU9FGiAb2m3rtMAGQPJQa1A2fA@mail.gmail.com>
 <2020841.9MqWvG71rC@tjmaciei-mobl5>
In-Reply-To: <2020841.9MqWvG71rC@tjmaciei-mobl5>
From:   Len Brown <lenb@kernel.org>
Date:   Tue, 31 Aug 2021 18:44:28 -0400
Message-ID: <CAJvTdKmSxkCtBRkL+qP7aaw19amHKBKzNG+z+SuSNo54RBKbyQ@mail.gmail.com>
Subject: Re: [PATCH v9 12/26] x86/fpu/xstate: Use feature disable (XFD) to
 protect dynamic user state
To:     Thiago Macieira <thiago.macieira@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
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

On Tue, Aug 31, 2021 at 6:39 PM Thiago Macieira
<thiago.macieira@intel.com> wrote:
>
> On Tuesday, 31 August 2021 15:15:55 PDT Len Brown wrote:
> > Indeed, I believe that there is universal agreement that a synchronous
> > return code
> > from a system call is a far superior programming model than decoding
> > the location of a failure in a system call.  (no, the IP isn't random -- it
> > is always the 1st instruction in that thread to touch a TMM register).
>
> That instruction is actually likely going to be a memory load, probably an
> LDTILECFG.

There is no fault on LDTILECONFIG, it will occur on the load tile data.
But yes, still a memory load (with a TMM destination)

Len Brown, Intel Open Source Technology Center
