Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7344433CB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 17:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235113AbhKBQwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 12:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234965AbhKBQvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 12:51:47 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAF1C0797BC
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 09:26:11 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id bi35so44004843lfb.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 09:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Q0JPKYImsEJj8uXVW8VH9ex3CWAhIL8zIYTnj92VzE=;
        b=b2wpaHZtxvLTTFPBxpmHmXcYLsOooGKiTRHoJm0lDHl9gjWU3E8C5iKELK1urL9nl0
         /eh+1gSgJQdZ0B6p9JqHjzhSCQMRq8oujbnPuUFf3+zcVzQPjc/4E1WgaXNf4CUI45fw
         l/da5LhUd9WL5f11IO5SZp3AUVnwxjS2Lawu9L7H5V7nVq0bTn/qsg4J8cokd7eIc5Pf
         Xzj5AhUtir4rSvNiIfy78uCzhl1pBSrepsGKkQFdZkhrlcG+YrRG9ivYblEs5p7RKm3v
         qTqQh5dlLsWAowfQlKY+NpoFli/H2a8HDqBHHTeDoXCJQ4uOHIYXSTtJp4tMO7F8/faF
         kYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Q0JPKYImsEJj8uXVW8VH9ex3CWAhIL8zIYTnj92VzE=;
        b=qAAyP4yGcMmFQMZoJK3T2h3hqZhdUn/mrD8OjnCxGGjQ42s4epk19suw0RgG5Oa5P2
         hUCV9CqKEX8lnlYaFn55smEhVSpDwRry/hpnNN4BJti1iGyU+m+/2Xjde8RsTwvbQA8L
         vCsXRxstsV3BiM6rFcJnEAvCSCk51NgtC9kbA6foLMZcNd5+dOKwv8JN8kvAnp19eYwo
         YCN7NZAOUdfRT9gkbOWIAmOULreRTqHetWjnZcupXX38IFwyeyUsiW5A6+xp1xc/r21U
         qSz6r/2jHvR3czXb3LSWjjQxAYiBctdIxpzMUxRzNEwz8XOTAAH/JCVTslufilnJPGBW
         akVQ==
X-Gm-Message-State: AOAM533JSrl7W4TxgS8GOfsduM2nU+38aywKa75M+6EHL0uGaUygRaYT
        YybU/IhM3S7egI9OqvVsNj5PPe7j5aasHcWJU1S85w==
X-Google-Smtp-Source: ABdhPJyE48dVJQUvXK3BpIfv6YeOgL+VG6t5AJUmekuPNbSHTfUNWQhfUPoxkvPHoscLLNfESi/wos0A9JOKGtEJKN8=
X-Received: by 2002:a05:6512:3d29:: with SMTP id d41mr12071889lfv.685.1635870369633;
 Tue, 02 Nov 2021 09:26:09 -0700 (PDT)
MIME-Version: 1.0
References: <20211102142331.3753798-1-pgonda@google.com> <YYFh323otsIauvmH@google.com>
In-Reply-To: <YYFh323otsIauvmH@google.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Tue, 2 Nov 2021 10:25:58 -0600
Message-ID: <CAMkAt6pnmr53V1Ckdw8vdK3=Ed0evknE8XPNyV35eFD_WP-RMQ@mail.gmail.com>
Subject: Re: [PATCH V3 0/4] Add SEV_INIT_EX support
To:     Sean Christopherson <seanjc@google.com>
Cc:     Thomas.Lendacky@amd.com, Marc Orr <marcorr@google.com>,
        David Rientjes <rientjes@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        John Allen <john.allen@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 2, 2021 at 10:05 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Tue, Nov 02, 2021, Peter Gonda wrote:
> > SEV_INIT requires users to unlock their SPI bus for the PSP's non
> > volatile (NV) storage. Users may wish to lock their SPI bus for numerous
> > reasons, to support this the PSP firmware supports SEV_INIT_EX. INIT_EX
> > allows the firmware to use a region of memory for its NV storage leaving
> > the kernel responsible for actually storing the data in a persistent
> > way. This series adds a new module parameter to ccp allowing users to
> > specify a path to a file for use as the PSP's NV storage. The ccp driver
> > then reads the file into memory for the PSP to use and is responsible
> > for writing the file whenever the PSP modifies the memory region.
>
> What's changed between v1 and v3?  Also, please wait a few days between versions.
> I know us KVM people are often slow to get to reviews, but posting a new version
> every day is usually counter-productive as it increases the review cost (more
> threads to find and read).

My mistake. I can wait longer between revisions. I was just trying to
include Tom's feedback promptly, I didn't think having many versions
would be an issue.

Between V1 and V3: I have fixed a lot of style issues Tom identified.
Added documentation to the SEV documentation file. Fixed some
incorrect type usage. Made the logging more uniform. Removed writing
on the SHUTDOWN command. And fixed some error handling.
