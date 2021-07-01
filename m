Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9593B985F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 23:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbhGAVzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 17:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbhGAVzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 17:55:01 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38ECDC061762
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 14:52:30 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id n14so14436237lfu.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 14:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J39z1K1H9iYgiKTRenHzC+Q5MRshLFfVFTh3xPa3JgM=;
        b=bw6xCNESDz/oRoLjaorfElSJpYWVHAjWx3+V3UIwpQq3cl/SS6ExZXKuELeedwNTV/
         PpppvmevABPPVYta6ZbqEsURwd1NR9uIZJfjAZtiQafHB/IvtttxBLkWCLNFOZryRe/v
         P3WCYwp5sR6GJuYejHu4/wj+xONy0i0jGjRRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J39z1K1H9iYgiKTRenHzC+Q5MRshLFfVFTh3xPa3JgM=;
        b=M/ed/ygQZfX9zOvCUARmTACUex+x7cyUTScOJrY5k8M9GahSACZN4jmjOPziJ8TWh3
         iVWPNVRMR51lMEiszmXTM7tsPspb5dK0K7nACHzAoPNcRtHeBDSpoTEvNAjmO7CeWFAB
         FE4dWSd5sUzRZeVWb3tjDCzlrXjGR/nq+Sr8Lu3xPex378IwgLsLD6DhqR9vhONeTHrc
         joQYeE2T1dh+3n2XOBE1B1gTXdQnI3+49+tYOMvK8HMxAfGiHXx7vAp+6KEWJCATnc0E
         MPQGNkhpX6c6oQeJTZoevYle0qCP1U6Wp4ROJXhJoZV7ocrxEyENfimF87oMuAeIzf/K
         O4TQ==
X-Gm-Message-State: AOAM530oxILVlbTEWMHCKrC9Ajgn6LH9s2PCRo1laRGhAGvwusKBfPeh
        yZLnEOoPuSPAXMZRI6p0zBRMfNowOg3imDwHSBY=
X-Google-Smtp-Source: ABdhPJxOfKDNj6HRMAOeqetv1fLn7wbOy6fTKmCEesWm4hgglceBQjM4Z0Kn/Td4JcywJq6SkFOVMg==
X-Received: by 2002:ac2:5de5:: with SMTP id z5mr1281581lfq.94.1625176348435;
        Thu, 01 Jul 2021 14:52:28 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id b5sm81844lfe.281.2021.07.01.14.52.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jul 2021 14:52:27 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id n14so14436118lfu.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 14:52:27 -0700 (PDT)
X-Received: by 2002:a19:7d04:: with SMTP id y4mr1222289lfc.201.1625176347073;
 Thu, 01 Jul 2021 14:52:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210701204246.2037142-1-agruenba@redhat.com> <CAHk-=wjk6KP3vSLFNPMjoaZ4xY4u=DjTM+C+hCS3QKt+XAE6OA@mail.gmail.com>
In-Reply-To: <CAHk-=wjk6KP3vSLFNPMjoaZ4xY4u=DjTM+C+hCS3QKt+XAE6OA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 1 Jul 2021 14:52:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=whHTB6dOrz3AkPVL7h5t8k0Ety1dy1r+BEy3+xptzF3bQ@mail.gmail.com>
Message-ID: <CAHk-=whHTB6dOrz3AkPVL7h5t8k0Ety1dy1r+BEy3+xptzF3bQ@mail.gmail.com>
Subject: Re: [PATCH] gfs2: Fix mmap + page fault deadlocks
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        cluster-devel <cluster-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 1, 2021 at 2:41 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So what the direct-IO code _should_ do is to turn an ITER_IOVEC into a
> ITER_KVEC by doing the page lookup ahead of time

Actually, an ITER_BVEC, not ITER_KVEC. It wants a page array, not a
kernel pointer array.

But I hope people understood what I meant..

             Linus
