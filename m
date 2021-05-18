Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7683B3870E4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 07:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346307AbhEREmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 00:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346299AbhEREl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 00:41:56 -0400
Received: from mail-oi1-x262.google.com (mail-oi1-x262.google.com [IPv6:2607:f8b0:4864:20::262])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82284C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 21:40:38 -0700 (PDT)
Received: by mail-oi1-x262.google.com with SMTP id f184so8619491oig.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 21:40:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:dkim-signature:date:from:to:cc:subject
         :message-id:content-disposition;
        bh=UEBUB8r+1tgTqmV7tTOpiKLtvodwZv6v3nGInbTWbH0=;
        b=gl68ltWvqs5GjbWfv3VwwsffiAaxBi/VPjuhChFSMPHAKI+3pGKOQRbyy+GBW/QZZ4
         XJFtcheVXaTejJM+uHAFwCLrL8q3iPKbqQD96cBCf8I3yegKq1m85uR4EH446iq72qKv
         xRFoW5M4/dO2AjGaw6+7BmwH/9IZLMtMgJ+thfbeAse6vLy0ZSqjKSf3TFGQX7Jn/1CG
         MwIJ361cDLBqUDaJwO1QLeRcfrNRPIPUWQGt+z2i1ND0Ad/UIYI1J7SRbP1efwg7Z9ek
         OsRszDLv7s0YCTqI2/ree2KajRXXyJQnjUCkiOmlxJyItf174GREFt0x1kym94K03OiN
         OHNg==
X-Gm-Message-State: AOAM531f7eJMmb9kdtx0R5S/y8huputrEvq4o7hIGG+o9YREy8hY+mEC
        ZHCFIKlIDBNbOLuR5WexDV90QX0fC21OgqaAgNxgU9vH7wp4
X-Google-Smtp-Source: ABdhPJx9LBRIUInKg+cbvrqzGe1mUf7M+fBUjkEU04COmNaTAvKp1xITBtsO4tOqckO0w73se4lz0XbCz9Cw
X-Received: by 2002:aca:d658:: with SMTP id n85mr2509461oig.80.1621312837824;
        Mon, 17 May 2021 21:40:37 -0700 (PDT)
Received: from smtp.aristanetworks.com (smtp.aristanetworks.com. [54.193.82.35])
        by smtp-relay.gmail.com with ESMTPS id d10sm6865000ooj.3.2021.05.17.21.40.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 May 2021 21:40:37 -0700 (PDT)
X-Relaying-Domain: arista.com
Received: from chmeee (unknown [10.95.68.240])
        by smtp.aristanetworks.com (Postfix) with ESMTPS id C253F3013EB8;
        Mon, 17 May 2021 21:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1621312836;
        bh=UEBUB8r+1tgTqmV7tTOpiKLtvodwZv6v3nGInbTWbH0=;
        h=Date:From:To:Cc:Subject:From;
        b=rb6zZgAJE0FchZzNiG35ePSrtqXbHviLI+hkRKF+3gSThJdX+OhN+ijl3Qjx7NljM
         ZuNvxboce3I8T21serdAt2VjKrgWt1xgOQEzWwWtUrDx8gRkl4lSFI7i+y0YIga0we
         HQecuAn7BvCtTWzlQpBkHSDO4UboPbrA4z7skNw+tJnJqhwoQscge5cD5zqTxpUZw/
         28pwjRuIWb022kQ8mR7rnDr047wDQd/BByhnkeU6MPwDagXM/z8vEjnqqMSy2uqVaY
         r/NXCqothYmgXcMksI7b1RUif7VegXyypve9qhL6QJ35/uw+qAbCh0OGFFiJVl2Y03
         +R35SZS97kqkA==
Received: from kevmitch by chmeee with local (Exim 4.94.2)
        (envelope-from <kevmitch@chmeee>)
        id 1lirX1-000XRe-Da; Mon, 17 May 2021 21:40:35 -0700
Date:   Mon, 17 May 2021 21:40:34 -0700
From:   Kevin Mitchell <kevmitch@arista.com>
To:     dyoung@redhat.com
Cc:     kexec@lists.infradead.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: i386 kexec-tools for x86_64 kdump kernels
Message-ID: <YKNFQnJ5JbqQ/OqI@chmeee>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As a space-saving strategy for our embedded boot environment, we use an i386
kexec binary to load our x86_64 kdump kernel from an x86_64 system kernel. This
worked great up until linux-5.2, which included the commit

9ca5c8e632ce ("x86/kdump: Have crashkernel=X reserve under 4G by
default")

Sure enough, according to /proc/iomem, the "Crash kernel" area went from
starting at 0x34000000 to 0x7b000000, which is above the 896M
limit. Unfortunately, since i386 kexec seems to use
kexec/arch/i386/kexec-bzImage.c even to load an x86_64 kernel, the
DEFAULT_BZIMAGE_ADDR_MAX = 0x37FFFFFF 896M limit is still enforced when loading
the panic kernel:

# kexec32 --load-panic bzImage64
Could not find a free area of memory of 0x8000 bytes...
locate_hole failed

I can work around this by patching kexec-tools to raise that limit to
DEFAULT_BZIMAGE_ADDR_MAX = 0xFFFFFFFF which allows loading the x86_64 kdump
bzImage. This does in fact kexec fine from that position if I trigger a panic.

However, this doesn't appear to be a general solution since the 896M does still
apply if either of the kernels is i386. In that case, attempting to kexec from
the higher address will just hang with no console output. In this case, it
probably is better to continue to fail to load the kdump image rather than wait
until the panic to find out something is wrong.

Fortunately, while 9ca5c8e632ce allows an i386 kernel to reserve a "Crash
kernel" region > 896M, it doesn't actually do that by default - I have to force
it to go there with crashkernel=@. I am not sure if this is just a fluke or if
there is something actually ensuring it defaults to a working
location. Nevertheless, it appears the restriction removed by this commit is
still required by i386 kernels. Its enforcement has just moved to userspace.

So it seems that the largest fallout of the commit is restricted to the
admittedly niche combination linux-x86_64 -> kexec-i386 -> linux-x86_64(kdump),
which no longer works out of the box without pinning the crashkernel address or
patching kexec.

Is this just something we need to live with or is it worth looking into how to
better support this combination?

Thanks,
Kevin
