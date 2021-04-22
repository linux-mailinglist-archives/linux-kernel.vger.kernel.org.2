Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C2A36878D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 22:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239116AbhDVUCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 16:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236822AbhDVUB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 16:01:59 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3907C061756
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 13:01:23 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id sd23so61959653ejb.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 13:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iL1WsOQVTYMGLSrNemHFm1Wr4O/+l/TQ2XP4MbaIT84=;
        b=CmFvXIcEhplHy1cMKEiKqrrqPheSSo1tQSdHL5LuMKhZpbjL0xzsjRbBEY7JGPNwgB
         Rq2HDJXX7H9NUz+rdw7db6fYhPfq+H4AGu9PcMFUm5AhsIBYGkPErbJhrcfuYlbBPFYQ
         HLRYZPoypAdPbIrrECtkBoFVczwlLhCcpX0aY3EAAk+3n7JPzT+V2jtReizvuenO7+j8
         ASjo98WFatar+0BBXCjWu/epjHUSYjFmdVvwLdtR9NMGSyP556uJiaR9BXYmAkz6Dk++
         VqnXUHcRFiLap4vdlP7I9NJWWERch31qrDZ1/V0QRI0/hvcEqMMe9fYP62kf6RyW0FIS
         dLTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iL1WsOQVTYMGLSrNemHFm1Wr4O/+l/TQ2XP4MbaIT84=;
        b=Vt24FiKYP9uE57TbwfhwhxQvrBAZzj5f98bFrpsdBLaTRXfJslHY9zUijRqpe9zqs9
         jqQQdpDFQq4bQ3xXClG+yLkkpZYjPDZHPWOXO0vXOkQywJcMIBmgrbh/8rYDPIbc7nVb
         XGgE/8XF15+IiCj3PVSwT+zLyLeMFTfTsi9fMEEM6w4HliW+PtMxNeZWHrYrUchUitGU
         MUyGy2xKvcZFqyHCmSpU3pNCROA1j6WpGc4XKHhjg1ADENKbs/nGKm8y2AIfkrMHUfvR
         tJw5ZrsM+gvvlZ2AKJFNyWKNoIHrkU3/9atpZq6gGFNbLRTZ1qNIqLm9EW2WjyQ+fuyN
         HEEw==
X-Gm-Message-State: AOAM530bweSl8d5LP9FcXAvEVWAF2+rEKCKPJqR8pCmpGD4lRnG3tBQ2
        wB2e8L7LVnJBz/DFplSiUKTU/Vpfr6Ltw4mIjywmipG2dAc=
X-Google-Smtp-Source: ABdhPJxheq+t6LYA8/KKx2YNYbEpR++dNjUtqeUQbiQdqjBErA0pDEeM018l9DULvaWGHbUk0fe1JMJaEi3JtxAjkBw=
X-Received: by 2002:a17:906:18e1:: with SMTP id e1mr359080ejf.341.1619121682614;
 Thu, 22 Apr 2021 13:01:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210419213636.1514816-1-vgoyal@redhat.com> <20210419213636.1514816-3-vgoyal@redhat.com>
 <20210420093420.2eed3939@bahia.lan> <20210420140033.GA1529659@redhat.com>
 <CAPcyv4g2raipYhivwbiSvsHmSdgLO8wphh5dhY3hpjwko9G4Hw@mail.gmail.com> <20210422062458.GA4176641@infradead.org>
In-Reply-To: <20210422062458.GA4176641@infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 22 Apr 2021 13:01:15 -0700
Message-ID: <CAPcyv4h42yPKmWByBVkjgL_0LjBg3ZNYKLBJKgjixsdTzOpaiA@mail.gmail.com>
Subject: Re: [Virtio-fs] [PATCH v3 2/3] dax: Add a wakeup mode parameter to put_unlocked_entry()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Vivek Goyal <vgoyal@redhat.com>, Greg Kurz <groug@kaod.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 11:25 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Apr 21, 2021 at 12:09:54PM -0700, Dan Williams wrote:
> > Can you get in the habit of not replying inline with new patches like
> > this? Collect the review feedback, take a pause, and resend the full
> > series so tooling like b4 and patchwork can track when a new posting
> > supersedes a previous one. As is, this inline style inflicts manual
> > effort on the maintainer.
>
> Honestly I don't mind it at all.  If you shiny new tooling can't handle
> it maybe you should fix your shiny new tooling instead of changing
> everyones workflow?

I think asking a submitter to resend a series is par for the course,
especially for poor saps like me burdened by corporate email systems.
Vivek, if this is too onerous a request just give me a heads up and
I'll manually pull out the patch content from your replies.
