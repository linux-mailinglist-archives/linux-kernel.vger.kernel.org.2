Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071A53AA82B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 02:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235003AbhFQAiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 20:38:02 -0400
Received: from linux.microsoft.com ([13.77.154.182]:52204 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbhFQAiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 20:38:01 -0400
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2BD4720B6C50
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 17:35:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2BD4720B6C50
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1623890154;
        bh=nSQmbjzbgb1j8KCoKYVkQ2g1Aa92qKKacWv9fs3WBPA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QkDDYGYkJk9AMH4pCU9QPuv6IG2+qCLUsSCIEJDWp6EcWvHl1k8oktruX2JhxDLhz
         LrryRmsZwHlVWKg6e4P8BSbGaEVtl00+neXCcK63DDPkDIem6fSYEw+uaT34262qTO
         4aB8hNn0Q8f2uarQdFsiJAQ3tdNkFtzdD8tx4Gv0=
Received: by mail-pj1-f46.google.com with SMTP id mj8-20020a17090b3688b029016ee34fc1b3so2853558pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 17:35:54 -0700 (PDT)
X-Gm-Message-State: AOAM533AfN5bqMnhVy11sVxzyYQit63urgz4RkovC3tqPFoBzY9H4Uvy
        rdDnvOCwNvbVnONES6oLbYPfrUm0KA4sBYuBmB8=
X-Google-Smtp-Source: ABdhPJx3JiNQ0tm8EvDfICAYgXqIrJslx9qWsmujYPcf1ux4fPvBvAFiYfcpo259SmysTJmLBLM9mxAzoI70p6ZeP+I=
X-Received: by 2002:a17:90b:4b49:: with SMTP id mi9mr2570938pjb.187.1623890153770;
 Wed, 16 Jun 2021 17:35:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210616234503.28678-1-mcroce@linux.microsoft.com>
In-Reply-To: <20210616234503.28678-1-mcroce@linux.microsoft.com>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Thu, 17 Jun 2021 02:35:17 +0200
X-Gmail-Original-Message-ID: <CAFnufp3Xp=8L5h38MGUXQ1bRT+Ptpv6br9Tv8zGCg2Nv1Y+xsg@mail.gmail.com>
Message-ID: <CAFnufp3Xp=8L5h38MGUXQ1bRT+Ptpv6br9Tv8zGCg2Nv1Y+xsg@mail.gmail.com>
Subject: Re: [PATCH] lib/test_string.c: allow mode removal
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 1:45 AM Matteo Croce <mcroce@linux.microsoft.com> wrote:
>
> From: Matteo Croce <mcroce@microsoft.com>
>
> The test_string can't be removed because it lacks an exit hook.
> Since there is no reason for it to be permanent, add an empty one to
> allow module removal.
>
> Signed-off-by: Matteo Croce <mcroce@microsoft.com>
> ---

Small typo, s/mode/module/

Regards,
-- 
per aspera ad upstream
