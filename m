Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538F33CB86C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 16:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240131AbhGPOKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 10:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240103AbhGPOKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 10:10:35 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C07C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 07:07:39 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id a6so14238410ljq.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 07:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=NU1cGNZWHLpJq5kkWL6d3ktpCgc/h7TAFPwU7X+FUGc=;
        b=pPlwcKTJMD0RFR6LhUaa2N+jQ3aSW6tMtQeTECYV/5D0DteNpaEmf1fI60GXuujAuk
         2+j+a2Qg0RCDmEWov5plktuVO4mHSCmzoRtGuSP4fq/Ch+ceR11j6E06Rp/cq2Xbteyg
         Zpd2aHXxatfItGdveTE96OCOJDkDkP96njwGffY3Kv6Tsop9ZyyYlgRr/69nYHmSgJEc
         Z3JcjUWo8Tg+uXlz26WdKgUUw0BmBsY0OXaKW3HmRpfmY9ljlZSAGQUWNpExylxRgMq2
         /HNtPbOOe5WmYBcHCmON7z/YP0EoAv2CE/g0yaeNNVH3PPp6JbFy7YxXhcB+wJX2ux7c
         oSAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=NU1cGNZWHLpJq5kkWL6d3ktpCgc/h7TAFPwU7X+FUGc=;
        b=fxMBAfJPzK0Pe9ySep9tdZhTpLYbkd1JGgTohUcGimxNNoI+XsKsMVGQawLY2alHmS
         +Iv5FJrUtuwIZ9akSZ1hfj9WkWQc2ASkEOXIN9tM1B/pVYgmRyaNpG11IWI/i/VWEDqU
         3frtlbVjGb7/GAat53/0a7wnpHKY8VkFaJl0/MFIcjP9XLcs3nuBTsHK4g1RpCKvUxOk
         16Ft/SnVqAR3XluIQ0z0LVJBDGVSQTnYUUGuVbKfD8j2t0PUQBzX+aEUTOUpFEYuJCKm
         xgrztCAzViPCuLrXUaFhxX0vXxa+KDclVtMva7cyhSdpz+Ey3DLT/f0cLyvmNBrXBulU
         6YkA==
X-Gm-Message-State: AOAM533gQHww4lnSUZy7wLoY2xJX6bO9KSazr33JResjOKf/ndYArGCU
        n2HLQI7K0naqGqpzPrudbTSVO1XLsPpIrDbKzyD0Rzkk0w8=
X-Google-Smtp-Source: ABdhPJwwYHMKTm6VjkGX5Kyq6mMgEZg4Qa56fiswEKGpG8qhFAcwidtYuhv76eYY2gmAnr3mT8C0X1OX/KsGkjGOMkY=
X-Received: by 2002:a05:651c:1244:: with SMTP id h4mr9399433ljh.139.1626444457578;
 Fri, 16 Jul 2021 07:07:37 -0700 (PDT)
MIME-Version: 1.0
From:   Archie <highsky@gmail.com>
Date:   Fri, 16 Jul 2021 23:07:26 +0900
Message-ID: <CAN4GSsdgv__GrVZ8W-gUmsBv675tAa=EejV-9E-gW2npR9aDZQ@mail.gmail.com>
Subject: Restoration of the pgprot_t prot parameter in __vmalloc()
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

I made a regex kernel module (https://github.com/smcho-kr/kpcre)
several years ago and it needs executable pages for its JIT
compilation.
I recently discovered that from the 5.8 kernel, the __vmalloc()
function's third parameter - pgprot_t prot - has been removed.
The regex module doesn't work inside the newer kernels because I can't
set "PAGE_KERNEL_EXEC" in __vmalloc().
Would it be possible to revert __vmalloc() back to the old version?

Thank you.

Archie
