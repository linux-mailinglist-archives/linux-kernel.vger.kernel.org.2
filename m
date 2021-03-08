Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA34C331262
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 16:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhCHPht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 10:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhCHPhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 10:37:20 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7FFC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 07:37:20 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id u8so10310344ior.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 07:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vI4y95dsjFP6QvXsKyX146AWKFu5fhgoOrqLZ5xUPaM=;
        b=VBWYtLwykkl/MOGhHmAwY6+1Xo8NMHaFtFRCZwK5WzH5Wc6uQ+UzoFn6ITSISbkf33
         Zll0FyCBFBVfbWlFLZrg4XIpR2L2kjtyyROyS4MBiFMsmfivMXjh9JOmwHdJBQxpj4c8
         nssaXOX6ykQf+pAiKZNC0ZIXX7f+IYf5A+67vrhN+zcxFkstsCn3+2MyoVgRlrejZdWt
         tr+p8oSNw6GdTxmWYtXnYkkbHADHs6DRDcK0Lvz2oBSSJ6sTJpdONgoPUMUxKrn3FzeY
         09ThTnUHi8JdXdV8aVq0/cPBf9ZZDE1BWzMgyYn0qKFGJ6WQYGIQ6IqJZ2tJVX/v1c7w
         UCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vI4y95dsjFP6QvXsKyX146AWKFu5fhgoOrqLZ5xUPaM=;
        b=ojXEapsNls2VMzwye/bk+1IoXhiFYVAUn0v/007PoYM91L0wrwsyjsFqgmm3z2JFJA
         UogUXyH3jFBNE2wgmkPc9/KTrEjQsgG36DLFXOmssFz/pWKvZ8/brPhFmqP5PWCffRn6
         rSjma3so6h2FiSF1HcDN8vjPLC/AeDnDU8mYvqAxV9ZTEiCQQfmmRXYBwTNwc0ZVMk7p
         54GpnSfs1ye+fyBbrwkqukkKFI0w8zHpAROkZGvZ/liuCNaaTv8Exm/yhd5iBiydV9oO
         pGdSgm44QHQfLGlAXgYFZ8sPRdRDM83cVPuh/bCOGENv6xDmc+WiZEiaLlpeUyOvDTIf
         F1Nw==
X-Gm-Message-State: AOAM531OVIUAmeSyT0FYwi37r6sNri/PJ3djhJjUnsuUgWGKpMFCWPDd
        JZ1g9ynIzNI/U7OTDP43Dq79KYHPCn6eG4RTFK4zjQ==
X-Google-Smtp-Source: ABdhPJzGzK8xS81w2BDW7XmKJkK0rNjv0i1fW08iiTAa43J6AE48WY+//YmW/grhe9T7pkVntYzO/y4DhuZ0pkKPDNU=
X-Received: by 2002:a5d:9e09:: with SMTP id h9mr19820742ioh.178.1615217839515;
 Mon, 08 Mar 2021 07:37:19 -0800 (PST)
MIME-Version: 1.0
References: <1f6d32e14f121a8ccf8807b8343597c3ae88c7d2.1587196252.git.yu.c.chen@intel.com>
 <20210308134957.23852-1-youling257@gmail.com>
In-Reply-To: <20210308134957.23852-1-youling257@gmail.com>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Mon, 8 Mar 2021 07:37:07 -0800
Message-ID: <CAAYoRsXec2eq=t-pSn5TOqNt0G6kfZCKkDuEhCnX5SgL0zgkBg@mail.gmail.com>
Subject: Re: [3/3,v3] tools/power turbostat: Enable accumulate RAPL display
To:     youling257 <youling257@gmail.com>
Cc:     yu.c.chen@intel.com, lenb@kernel.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, dsmythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 8, 2021 at 5:50 AM youling257 <youling257@gmail.com> wrote:
>
> this cause turbostat not work on amd cpu.
>
> root@localhost:~# /turbostat
> turbostat version 20.09.30 - Len Brown <lenb@kernel.org>
> CPUID(0): AuthenticAMD 0xd CPUID levels; 0x8000001f xlevels; family:model:stepping 0x17:18:1 (23:24:1)

There are already two fixes for this in the queue.
https://marc.info/?l=linux-pm&m=161382097503925&w=2
https://marc.info/?l=linux-pm&m=161141701219263&w=2
