Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6144500D3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 10:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237585AbhKOJHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 04:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237135AbhKOJGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 04:06:38 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD66C061202
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 01:03:41 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id y16so20254375ioc.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 01:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=74dMCLzYzCwsHjlKvOxajtzLp8BNnLBK0LstD+tTs0c=;
        b=qXaIOYDDOyUiGTK+4hF5GAn6kyJObiO2FhHwioNQ1TUiVk1liWEo2/u7xyHq1TSuGo
         /bUi5aDHNUBXXa1gjA3jhfqdl5BBKm5HaeNrxhX/0bsPCb/2dDaUYP6DFFjxcmuVbz55
         +GLIhtFIUWJegng74TXJpLF/S9pIaTPpw4ebfMKjYstdBiHdYk6NrMw8G/OnNM+oNBFc
         newhI2MBc9iRlFBf9x4AwoVJ4jep9ZCxoDA24SMOVxB01Cq8DCv6I1dvxz6repRcv2kv
         c/a8cExBbdHgPDOmfUv+7txP1c2G7QNNdtcOyOgjAz1CJmeBYM6AN4Zh7HJX0hxVPadb
         o/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=74dMCLzYzCwsHjlKvOxajtzLp8BNnLBK0LstD+tTs0c=;
        b=cIIbGUx2e9NdgukBuR7sX0p+oGXhkL/Pz9UcnWPTzBGksEHMttCSgUSPaDCUUBDjtQ
         Xg/jvfVI7rqYffZFdIYYnoHQRaUza5BWcMqWWaM+HYd+pEvfnG2T3OtAlkDdiTF6CtkE
         uiqXyEA6JqGWtH8TDokiJB5ldrWutA2cc3xk7eu/di8D/G3Hq1dnSNkMZ0nQ2ZJ+Zl37
         DL6StIQF2+18XszHRRTw/OPjuA8vFZiMXgcWYCVF+w6zSdBooChFRO8iFwd/6AUb7elV
         3PkA7cPGTmfmavFZpPvvTa8kV8jzZxkW49ciRs9ZJqF3SrsKMsV4CNe2ddT5TMk6O8+I
         G6MA==
X-Gm-Message-State: AOAM533TCx0ukVh3YdF96vViU4fdoqeCgKkpu/bEtWPYWAR0rBz9Zwna
        n253MPbkUR7gTtBYJZx0A+UVYQBlhp84Su9g3cig/wqE72Y=
X-Google-Smtp-Source: ABdhPJzEHl5xBgECXgiMy4JoiV/jJAwTzEoaVy/kJhsNV+vUIBWAkA6RxbuxFWMaNPObBE038Xu1cugyIsybDN5R0P0=
X-Received: by 2002:a02:70cf:: with SMTP id f198mr27842143jac.124.1636967020556;
 Mon, 15 Nov 2021 01:03:40 -0800 (PST)
MIME-Version: 1.0
References: <20211112103246.7555-1-bp@alien8.de> <20211112103246.7555-7-bp@alien8.de>
In-Reply-To: <20211112103246.7555-7-bp@alien8.de>
From:   Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Date:   Mon, 15 Nov 2021 17:03:29 +0800
Message-ID: <CAJhGHyCm2O6uj29cAQNfaHX3Wq2NyO+s4=nQAS+3PadDqhiZtw@mail.gmail.com>
Subject: Re: [PATCH 6/6] x86/cpu: Remove "noclflush"
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 6:37 PM Borislav Petkov <bp@alien8.de> wrote:
>
> From: Borislav Petkov <bp@suse.de>
>
> Not really needed anymore and there's clearcpuid=.
>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 2 --
>  arch/x86/kernel/cpu/common.c                    | 8 --------
>  2 files changed, 10 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 3a4c3fc88bf1..5239d4ae2b91 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3348,8 +3348,6 @@
>
>         nocache         [ARM]
>
> -       noclflush       [BUGS=X86] Don't use the CLFLUSH instruction
> -

The patch is definitely good for me, but I have no idea what
"BUGS=" relates to here.
(In the commit 191679fdfa63 ("x86: add noclflush option"))

In Documentation/admin-guide/kernel-parameters.rst:
BUGS=   Relates to possible processor bugs on the said processor.

For patch 3,4,5, they can have my reviewed-by:

Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>
