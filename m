Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E203333039
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 21:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbhCIUrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 15:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbhCIUrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 15:47:04 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155A5C061761
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 12:47:04 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id bm21so31561412ejb.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 12:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rxekq9CmjmqiQezEq23fxoA2lWRbGVUv5ZHopeMn1UE=;
        b=cnHrmQr/VMb/t2E/EgCby5Ir+NbwqGQ0u5beELJg+31cT1IgztSHwumMnd5zdcoDB2
         66n4NERbQg+uvwjesYYTCrNMtq9i9BOp/xxNWs/vGHWpji0JOhm5y/MI1V1Ox4Pc4WRW
         tBCkqmAvU9bVb4X02t4bXL1znuI21REF0jrmhFii+VAU1w787tzlvvkSi8J6MFfQp9Qc
         pDQjCC5HheYIdn0dNKCnxnEBuaRZu7xTQPpa9IDV/OMAz50a7gzVrpOYTiwkLGnkyiNv
         Xl9tJ2GvH5S31+9GqAUexpRyDEuTmNjlBu3J2Ogs0+mgYdfyBUBeIAD+tjEcWDtq2eIa
         u1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rxekq9CmjmqiQezEq23fxoA2lWRbGVUv5ZHopeMn1UE=;
        b=ZfLOTy2PwCkW4oE60r8Ml44Dt+gHbjgjrQ4Hax+462FJbh6TzrlaH96YapYfg5x54u
         vMgOtor0GWTHVSNO1zZNhBZ1gD3xo6v7H3UAJtaBNZMoClzUvd9EPyszHs+NTjPZQHnB
         Ovr2xSAGPopBtzoeB92oJgO2kctY4hyb9Cx0p3VAOJH2ygtj2OjL7Dq6nnxjJ72SNVun
         iFPGTV/tf9pZY/zkxLx1o0Yh/1KCPQFzlMlD5/XiYBBazz9qPtho8NVHlonc0K/A8Jlh
         HcWKr5rJIR016pIbfYlB1hJEk9JrYZV8TQn0p+D2no/0tpgerFqJOPfjZgXSn/ZbkJ1n
         QKOw==
X-Gm-Message-State: AOAM533atFJ5dHjWGRoTmODWhKmyP8R2eeOgCI+qaYqV/iLRHDOFCiE3
        NONRhsJBDHfPp+MOcqtLPVtf8QxiAnXHTB5fg7Z+mQ==
X-Google-Smtp-Source: ABdhPJyGCNUbmQJ/wDHu5IcJL/niMgxwiRhAm5hQcCcYAEaJxVRh4Cge+6PJtQJj3bcb2aVMkwUuE9suuO9SNZofuRY=
X-Received: by 2002:a17:906:c405:: with SMTP id u5mr22581663ejz.341.1615322822643;
 Tue, 09 Mar 2021 12:47:02 -0800 (PST)
MIME-Version: 1.0
References: <20210309195747.283796-1-willy@infradead.org>
In-Reply-To: <20210309195747.283796-1-willy@infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 9 Mar 2021 12:47:00 -0800
Message-ID: <CAPcyv4iQ8qfyhungkhdDKqmOUrd0e3XtExxC_2yz+zX8ncBsrA@mail.gmail.com>
Subject: Re: [PATCH v2] include: Remove pagemap.h from blkdev.h
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-bcache@vger.kernel.org,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-scsi <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 9, 2021 at 11:59 AM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> My UEK-derived config has 1030 files depending on pagemap.h before
> this change.  Afterwards, just 326 files need to be rebuilt when I
> touch pagemap.h.  I think blkdev.h is probably included too widely,
> but untangling that dependency is harder and this solves my problem.
> x86 allmodconfig builds, but there may be implicit include problems
> on other architectures.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
> v2: Fix CONFIG_SWAP=n implicit use of pagemap.h by swap.h.  Increases
>     the number of files from 240, but that's still a big win -- 68%
>     reduction instead of 77%.
>
[..]
>  drivers/nvdimm/btt.c      | 1 +
>  drivers/nvdimm/pmem.c     | 1 +

For the nvdimm bits:

Acked-by: Dan Williams <dan.j.williams@intel.com>
