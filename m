Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC3E932A39E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382300AbhCBJYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 04:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1837842AbhCBI7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 03:59:12 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3430C061756
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 00:58:31 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id v12so18190666ott.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 00:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZedzYRAADqpCRUEjxpUyyJbfTq4kXSXEtgpjDsYUTaM=;
        b=VuJezB0tzWYNW+rVlp2nsM418xSp5+ufG0JWLAq5r5MM0gK8qNtLMnGAtK7yHadsqw
         TmlF+UOZJINweGW5BON+tIaVXtB2L0NH6OKZSjkNpdTma8yO6kGtpqImMC6FondtWL/v
         cYDAzZwQMwxb+qIDEpg/nF96V85V4wG/Rk7rTuvW1Sly7+7/AtTKx2fY7W5p8xkRwCrS
         1Lu3BvWIA04+WZGGBL8Pnq3XNaIYUnKTpX+08p/+LiJLC6k4RMdZrhXt8apJEY6APftp
         sj2e2Blq8v+FSC48imCvzkT7fpDSibVRZDUzuRj+zAvXCexjO4/Qdpr2e4wROPokdGt/
         LKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZedzYRAADqpCRUEjxpUyyJbfTq4kXSXEtgpjDsYUTaM=;
        b=qi99eP8ViWcbKDyELOfIi05OU1Uv1kdUvSVWqV439N0Omhy0iEl6Zhq7y1nOj5CxuL
         9/XTUxMgzPOqxzgo+CNGE3jeKRqy83S82+T4VO1bkoeprYvkobU4lBz3XsWrG8MEuB7N
         JpC54ZxOBm9X1zM57nLImcbBC6Ns8OHJ4JOsjCa8SYaKM/Xl45oAWE7ytE9vbBmKuFJk
         LfLUduCtxUlpEp+vaOqH2N6WJC6Im2PjwIgf26Z3GX/HXB1iVUxAtCOEWYn7hyhoIods
         4CrciCPovfbm//jLar0T3RjstzY4IYFG9utgoJ5lByVR5bUu+Sk4zB/ydCpw3havh61K
         RA0g==
X-Gm-Message-State: AOAM531KVPUGO+7rEn4ITXCeOlSKuN08LgVT6tcFsYoNFjpnNQAtYa8o
        rAC1bwj15ZJvTxSvXCs5ZBQwx+1NTzgbjB8CntzPuw==
X-Google-Smtp-Source: ABdhPJwyuV/L1oxMIfR9yCj0QXq4vfpZWv+7bnDC4oXhj8Ui6jlu9nIWMXS6e4hKLyGSbTtljGRukRNmhekdkwAAlVM=
X-Received: by 2002:a9d:644a:: with SMTP id m10mr17387529otl.233.1614675511068;
 Tue, 02 Mar 2021 00:58:31 -0800 (PST)
MIME-Version: 1.0
References: <51c397a23631d8bb2e2a6515c63440d88bf74afd.1614674144.git.christophe.leroy@csgroup.eu>
In-Reply-To: <51c397a23631d8bb2e2a6515c63440d88bf74afd.1614674144.git.christophe.leroy@csgroup.eu>
From:   Marco Elver <elver@google.com>
Date:   Tue, 2 Mar 2021 09:58:19 +0100
Message-ID: <CANpmjNPOJfL_qsSZYRbwMUrxnXxtF5L3k9hursZZ7k9H1jLEuA@mail.gmail.com>
Subject: Re: [RFC PATCH v1] powerpc: Enable KFENCE for PPC32
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Mar 2021 at 09:37, Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
> Add architecture specific implementation details for KFENCE and enable
> KFENCE for the ppc32 architecture. In particular, this implements the
> required interface in <asm/kfence.h>.

Nice!

> KFENCE requires that attributes for pages from its memory pool can
> individually be set. Therefore, force the Read/Write linear map to be
> mapped at page granularity.
>
> Unit tests succeed on all tests but one:
>
>         [   15.053324]     # test_invalid_access: EXPECTATION FAILED at mm/kfence/kfence_test.c:636
>         [   15.053324]     Expected report_matches(&expect) to be true, but is false
>         [   15.068359]     not ok 21 - test_invalid_access

This is strange, given all the other tests passed. Do you mind sharing
the full test log?

Thanks,
-- Marco
