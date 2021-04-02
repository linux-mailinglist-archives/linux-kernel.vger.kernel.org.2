Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24786352649
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 06:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbhDBEhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 00:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhDBEhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 00:37:16 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA7EC061788
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 21:37:16 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id il9-20020a17090b1649b0290114bcb0d6c2so4121784pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 21:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=vM45/P2fkskhNC9Pi4JhTYL40XcOm7rleD9sfr3mD98=;
        b=umn0kYFQss3RUcN+MI88Z4iWl2uuiLGyUdqhMxwoNWlHDuYbbgCkT0FQDFeXOnfirK
         k89l1KDyA+VPXoR7p9/EOEjauKHHw+WG4vph7n0k6lcqdXz2H7WvrM9xtun2WzhOz8lt
         xfXZV23UPtftCh7KwJyIE+tvV6jAh+QZx7FccS3yaJLM6mgr1uUBVbk6cRrkMQbZeipj
         jmYMKiPj8ZGtJRzXmrf16BCfkwTDnxP9hTJQ3T89WSMTwoRiWcjOT3/zgLUpcOlFadTg
         hjZp2BxFP+OlBMgT4ZpdFrW3O57a2RLE61n6XsLmjTMtgaFbRB+j8cc36YpuwK2t4crw
         /F5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=vM45/P2fkskhNC9Pi4JhTYL40XcOm7rleD9sfr3mD98=;
        b=RQPNJwxo+vnNsdXefRpav+4IFSBIstkJkpxs0JEN3gmr/d56dolf+3Pym+oeaACFR6
         2wwy/M0pOtlMxZ2axquEm1zl6DZyacB67X6uRArGV26rMlMiD8wyT9DNtvlbc0Qzr9Iq
         uOBYHzuxU7Nkt8qD+tfBr6aBCmPwRLuDYUE0p5fFdS/qT/N2e+8hVDBwXAZgB1VX30yA
         +wOahGPCr3d4MZMP5+zVcRBzpvWFtUu38JNP7RvpwywEfslrmbptPjv1wL2xoEdUoMpH
         Ti1OIYaTYmuMPBnEIFNiSpLvzw7EGY739ahWGzjmJ+kkSaVRl+xl3Klct1Y0nbICVJ1j
         FJnQ==
X-Gm-Message-State: AOAM531zybGB5guLvyhFRrJ/rXhiRWfzAsyA/1gcm0SyPWtTIUQkR35r
        Rg2bCt7U+TnDMhXXp5HJJPcipQ==
X-Google-Smtp-Source: ABdhPJwJpz+wXqtGbLkWvIyoQhjW1a/r+eVcAWwWeT4eygWs+CgHs2CwdQnJik04EKWP9chLze/CJg==
X-Received: by 2002:a17:90a:df91:: with SMTP id p17mr12153985pjv.23.1617338235768;
        Thu, 01 Apr 2021 21:37:15 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id y5sm6696592pfl.191.2021.04.01.21.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 21:37:15 -0700 (PDT)
Date:   Thu, 01 Apr 2021 21:37:15 -0700 (PDT)
X-Google-Original-Date: Thu, 01 Apr 2021 21:37:09 PDT (-0700)
Subject:     Re: [PATCH] riscv: Bump COMMAND_LINE_SIZE value to 1024
In-Reply-To: <alpine.DEB.2.21.2103302221590.18977@angie.orcam.me.uk>
CC:     alex@ghiti.fr, Paul Walmsley <paul.walmsley@sifive.com>,
        dvyukov@google.com, linux-api@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     macro@orcam.me.uk
Message-ID: <mhng-08e5e4fb-8a42-4f7b-8ceb-ff549784100e@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2021 13:31:45 PDT (-0700), macro@orcam.me.uk wrote:
> On Mon, 29 Mar 2021, Palmer Dabbelt wrote:
>
>> > --- /dev/null
>> > +++ b/arch/riscv/include/uapi/asm/setup.h
>> > @@ -0,0 +1,8 @@
>> > +/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
>> > +
>> > +#ifndef _UAPI_ASM_RISCV_SETUP_H
>> > +#define _UAPI_ASM_RISCV_SETUP_H
>> > +
>> > +#define COMMAND_LINE_SIZE	1024
>> > +
>> > +#endif /* _UAPI_ASM_RISCV_SETUP_H */
>>
>> I put this on fixes, but it seemes like this should really be a Kconfig
>> enttry.  Either way, ours was quite a bit smaller than most architectures and
>> it's great that syzbot has started to find bugs, so I'd rather get this in
>> sooner.
>
>  This macro is exported as a part of the user API so it must not depend on
> Kconfig.  Also changing it (rather than say adding COMMAND_LINE_SIZE_V2 or
> switching to an entirely new data object that has its dimension set in a
> different way) requires careful evaluation as external binaries have and
> will have the value it expands to compiled in, so it's a part of the ABI
> too.

Thanks, I didn't realize this was part of the user BI.  In that case we 
really can't chage it, so we'll have to sort out some other way do fix 
whatever is going on.

I've dropped this from fixes.
