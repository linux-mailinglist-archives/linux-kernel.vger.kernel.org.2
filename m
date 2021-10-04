Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66B4242149C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 18:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237906AbhJDRBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 13:01:24 -0400
Received: from mail.skyhub.de ([5.9.137.197]:52662 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235754AbhJDRBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 13:01:19 -0400
Received: from zn.tnic (p200300ec2f0fe400ce4149225ac01b7e.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:e400:ce41:4922:5ac0:1b7e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6B34A1EC03FE;
        Mon,  4 Oct 2021 18:59:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1633366769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=mzoIXD8vqb3ZXpDUu8n6sOgVFOmimNsgP0yg1PVSUjE=;
        b=BrcRMXQgn7F/9dK/nlGjIrS9TVfoabXUOocuA87+KE3Gk9ANWdfvmAUob2BOpyR/aAqx9E
        wkIec3izSs5L8GTk63mHL6gXedPtGFtSoExxps+xF/4U4j9cTwY1ZbQzID7HyJIs93Pp35
        EP9TqWedSIKEpatBNn19Bbz+YWGH5o0=
Date:   Mon, 4 Oct 2021 18:59:16 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Daniel Scally <djrscally@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
Subject: Re: [Bug 214453] New: skl_int3472_unregister_clock: kernel NULL
 pointer dereference (HP Elite x2 1013 G3)
Message-ID: <YVsy5Gv3z6JAWnxj@zn.tnic>
References: <bug-214453-6385@https.bugzilla.kernel.org/>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bug-214453-6385@https.bugzilla.kernel.org/>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding more people to Cc.

On Fri, Sep 17, 2021 at 12:18:27PM +0000, bugzilla-daemon@bugzilla.kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=214453
> 
>             Bug ID: 214453
>            Summary: skl_int3472_unregister_clock: kernel NULL pointer
>                     dereference (HP Elite x2 1013 G3)
>            Product: Platform Specific/Hardware
>            Version: 2.5
>     Kernel Version: 5.14.5
>           Hardware: Intel
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: low
>           Priority: P1
>          Component: x86-64
>           Assignee: platform_x86_64@kernel-bugs.osdl.org
>           Reporter: kernel-NTEO@vplace.de
>         Regression: No
> 
> Created attachment 298863
>   --> https://bugzilla.kernel.org/attachment.cgi?id=298863&action=edit
> dmesg oops log
> 
> On a HP Elite x2 1013 G3 a kernel oops is caused by int3472:
> 
> [    8.820565] int3472-discrete INT3472:02: No sensor module config
> [    8.820569] int3472-discrete INT3472:02: error -EINVAL: Failed to map
> regulator to sensor
> [    8.820574] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [...]
> [    8.820654] Call Trace:
> [    8.820657]  clkdev_drop+0x1d/0x60
> [    8.820665]  skl_int3472_unregister_clock+0x15/0x30 [intel_skl_int3472
> a61329898df9463f8661b1eee1ed1e20b1626f62]
> 
> -- 
> You may reply to this email to add a comment.
> 
> You are receiving this mail because:
> You are watching the assignee of the bug.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
