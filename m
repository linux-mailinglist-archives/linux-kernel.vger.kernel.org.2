Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35DEA3CA57C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 20:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbhGOS0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 14:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238509AbhGOSYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 14:24:53 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E420BC061760
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 11:21:58 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id hd33so10798669ejc.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 11:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a64fucJ3nradLqS8b0xWylaDujzNDAEVUEg6XMLQFh4=;
        b=oGH/EaFLiAckIljXb9GhTC074m/Bzr0mO99DSaKBORzBZFLFBYKy2BliXNavS0u6La
         deOvQrRK5tkJf+6NTJlln66+wnNcuKrxrVAodVFuhhIIsVm7aXOAJScpcqwySp61DCz5
         5CYoJ8Jo4eEjWkZFHAjmHt4tF/1FfU9Wr4jLoNDz8FUy3twADpH4N1BfFdDKE+6sKLSO
         WveCBYvueMge/KVLiziNUAfZq0E5LHT3DYZ3AK0U3CCBaiE6bRK5I6rM8580AAOaXraY
         oNsPEcnyA2zSvUfs/JwkIz37zusaRh8N9SbLr0E8mVtysJuQyWoZDZAFxWCoJUmsQo+v
         6pYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a64fucJ3nradLqS8b0xWylaDujzNDAEVUEg6XMLQFh4=;
        b=qIHlPCZk7zIEEO6TJJIy1YJ37DZkgQCsAcjR6QoU9/EKXPn/q0UmBvaV04YP2qQEs0
         nMnUscYVmiEZFcuQ/ZDqHn/lBTKU6S7cVhkuUStx/nbE1LIXFdFbku3nnNvCOpf6HQGO
         HReAMj3WlDvDm/+GXpfqJnu+URq0AX6ixHMKFmgydCEgYrSICEvnyTNj9oRncRivNBfT
         95qPuRWKusz0BXvZKebS8TeYTSa5ZRkG7GsvXyvkjC8e1H1YsMOW5C0rWm3GKBqW1BVF
         6V88/pUX+rgn7z5t32m78IND0RpcF6VKV5eTBdhV/LO8BoMMV7qw+knplURMiCQ3dZu+
         ULUA==
X-Gm-Message-State: AOAM532KpMahIX9tlCodeWPvqtPDRIYz5+EAmTT2V/OqmLqfO4+F+tK8
        gxh+jf5dB4KuZWocCRxRp/wbNCgIoMTW6w9YZc7GVA==
X-Google-Smtp-Source: ABdhPJwUWWrVhb+RuCQTmMau2LEvFNXiuDituncPfCEBDqHpnmdXtiGSHtOykRFTgPSvB33znKqlBmD0mVkN4GchgsY=
X-Received: by 2002:a17:906:fb90:: with SMTP id lr16mr6978465ejb.541.1626373317450;
 Thu, 15 Jul 2021 11:21:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1626371112.git.zhansayabagdaulet@gmail.com>
 <343394260f599d940cacc37f1dcc0309239ae220.1626371112.git.zhansayabagdaulet@gmail.com>
 <YPB7rBlU1SinK6FR@casper.infradead.org>
In-Reply-To: <YPB7rBlU1SinK6FR@casper.infradead.org>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 15 Jul 2021 14:21:21 -0400
Message-ID: <CA+CK2bCPMmbr+=h4evTkbJoEFQu_th_NOe0Gp11hU7xz3fLZ8A@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: KSM: fix ksm_run data type
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 2:18 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Jul 16, 2021 at 12:01:01AM +0600, Zhansaya Bagdauletkyzy wrote:
> > +++ b/mm/ksm.c
> > @@ -289,7 +289,7 @@ static int ksm_nr_node_ids = 1;
> >  #define KSM_RUN_MERGE        1
> >  #define KSM_RUN_UNMERGE      2
> >  #define KSM_RUN_OFFLINE      4
> > -static unsigned long ksm_run = KSM_RUN_STOP;
> > +static unsigned int ksm_run = KSM_RUN_STOP;
>
> Should this be an enum instead?

I think "unsigned int" is OK here, as it is exposed as uint to users:
Documentation/ABI/testing/sysfs-kernel-mm-ksm

/sys/kernel/mm/ksm/run

run: write 0 to disable ksm, read 0 while ksm is disabled.

- write 1 to run ksm, read 1 while ksm is running.
- write 2 to disable ksm and unmerge all its pages.

Pasha
