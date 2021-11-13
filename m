Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF7E844F0E1
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 03:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235558AbhKMCuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 21:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbhKMCuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 21:50:08 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C50C061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 18:47:16 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 131so28554522ybc.7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 18:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gL+jvp5JmnCvTdXi9Rc4Ov4LOBuMEciPu5evGB2eT5I=;
        b=zd7kQzzSEossrGgvCHZxFwcVUdFMX/sjkUeG3NVnxHQC4fzA6fMIr71R81ebk8LCuS
         CeMNOgBbiUnNMIYKr2/8Ejf7I/GjWXny4Wg1lghDF4wTsnzrIvBUppOvTE32ZBCisILW
         AEDz2NwOtFhNj4H1g7VgV9eoxYK9PQDeivBpBLRr9ngYw2fNRduWRtSSI+2Cp7K2bzJR
         rmjngGqdGhwI/ymY70aUvyBajiQysXLKDJB7kFpsfj8b57dAcVs+Cju+++zK9x2STHaw
         6VbFrxANIznlxSMq2kIv6tPYQ/ixFPp77JCCSSosS8tzfij4H9D3jt8jXqU16wLV4xeG
         QZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gL+jvp5JmnCvTdXi9Rc4Ov4LOBuMEciPu5evGB2eT5I=;
        b=bWfwwekuSQ2yx1vx0AAuf0DP3+blwPU8e0YFcKYVPqjKuldxOB+KCVyhYMb+kvXeSP
         GhHbLLJLSWXNenGPaBtNzjKUJ29I76f0oxL2FN+zvlN5UZTzNDUQyHbpmb7E0h42BwYl
         VbbiUCyLZsP0yI9rPUjyrz6Wn8d/zSbjzaiuao5Y38mM9dYT9Pm1vfprjbZ+Jl8NKW/p
         lDX6zYNEHRlqRg4Y702RGDDQ4WqXn1h3DQaS9zhClHtQYrGuIkChLJy2JCKkmKMyngsI
         zPymW6Rj+vvWiNg4947F7IohijV3p/Ftp3n9U+fhD6XQx9W/4xam/jP/dPLawXsuzLru
         0qWQ==
X-Gm-Message-State: AOAM530/lk5EuEPLMU28T7PggVgcjkOGFXQMj3dmW7oY6j6/TXIf5EIF
        MNJwInVoXdmSkOrqtqUcPApHIf+/OUO/6Clqyvu1c1XAG89oD6Q1
X-Google-Smtp-Source: ABdhPJwneNPbuSMOsF43QZbw0eRXysCpGN4BgPb0azMYiCwbO3Ruox8LtHwllfr+TjzY8cbZyHDqExvEA8g87kKVXHo=
X-Received: by 2002:a25:b0a8:: with SMTP id f40mr20465219ybj.125.1636771636135;
 Fri, 12 Nov 2021 18:47:16 -0800 (PST)
MIME-Version: 1.0
References: <cover.1636732449.git.xhao@linux.alibaba.com> <f178322529c7498d85a545b9a07ac7c8dec7d58e.1636732449.git.xhao@linux.alibaba.com>
In-Reply-To: <f178322529c7498d85a545b9a07ac7c8dec7d58e.1636732449.git.xhao@linux.alibaba.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sat, 13 Nov 2021 10:46:38 +0800
Message-ID: <CAMZfGtUSObcR8OK7QCf=xiQD=tbpmg-mn4uQVNmjXxOLP053ZQ@mail.gmail.com>
Subject: Re: [PATCH V3 3/4] mm/damon/core: Using function abs() instead of diff_of()
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     sjpark@amazon.de, Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 13, 2021 at 12:02 AM Xin Hao <xhao@linux.alibaba.com> wrote:
>
> In kernel, we can use abs(a - b) to get the absolute value,
> So there is no need to redefine a new one.
>
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> Reviewed-by: SeongJae Park <sj@kernel.org>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
