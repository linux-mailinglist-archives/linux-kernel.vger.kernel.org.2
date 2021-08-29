Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39E673FADA7
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 20:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235755AbhH2SM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 14:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbhH2SM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 14:12:28 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AAAC061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 11:11:35 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id y6so21801928lje.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 11:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nOEXbomGVxdTg2YIKOufPA0FWw0BA6Ntj3OHAW88ff4=;
        b=G9weGkeHN8FlJqJ0GQMGRkvYxT9+fXAmH0dB17bI65t7LV9Q70hlMMFtwZr4o4zSms
         C3ZBm+mpNRjS+UkmvFIj8dKgUWkyzIyP3SJa7hZUeOvoF9uuwyCa0eKl5/wXl5LDkYvt
         g1hC/0+a5me3A0DEW79RnUqRw17xLL0C1Ysgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nOEXbomGVxdTg2YIKOufPA0FWw0BA6Ntj3OHAW88ff4=;
        b=au2eMW7hteGMKLj47u7FJRmpv73HmJGN0UfsXQjZnVTM1ya7AbOHitzGltbgF/N6pu
         nLZgk2WfYsor9Jhp5Sxrac5oN8I/wmOq0eAVISEcOk/12mL/1mJQoEwYULudxGFSajV4
         3RrhBK4ArJdiLSuC0wlZcNRECain/RmmWRBW9khF3NvI3z2m4TP9zSG0SupD2J1sOiwy
         ejI5uvyS8+xvXP/HxPBhsmW5ex4x61A/y//AdX6xF198cnt+od3AipFp8bfDt1HJnxkQ
         jageGP5p2z3XRYxcA8msQS/D7g7lTeQpA6r+5lLVQWUjemZAgwFhRsoFNbzKdYQvYPOc
         q08w==
X-Gm-Message-State: AOAM532VnABhdHMbanCSCvBhyWjgihviBzwMzKS0r8DTEJBAesQqDIri
        9wPyTQQR/8q55smBXwPhHHmHSTsniiHWhxqJ
X-Google-Smtp-Source: ABdhPJy0wcUldvfhb8V8jnDVUbjyvj5Lnddv0fsWkqRoS0D0mzAtVii5Obbnzme9Rp+EU/SQnN0PUw==
X-Received: by 2002:a2e:99c8:: with SMTP id l8mr17554685ljj.178.1630260693675;
        Sun, 29 Aug 2021 11:11:33 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id u20sm1532486ljl.76.2021.08.29.11.11.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Aug 2021 11:11:31 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id q21so21732338ljj.6
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 11:11:31 -0700 (PDT)
X-Received: by 2002:a2e:7d0e:: with SMTP id y14mr17065408ljc.251.1630260691346;
 Sun, 29 Aug 2021 11:11:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210829115343-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210829115343-mutt-send-email-mst@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 29 Aug 2021 11:11:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjYkPWoQWZEHXzd3azugRO4MCCEx9dBYKkVJLrk+1gsMg@mail.gmail.com>
Message-ID: <CAHk-=wjYkPWoQWZEHXzd3azugRO4MCCEx9dBYKkVJLrk+1gsMg@mail.gmail.com>
Subject: Re: [GIT PULL] virtio: a last minute fix
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     KVM list <kvm@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        "Cc: stable@vger.kernel.org, david@redhat.com, dverkamp@chromium.org,
        hch@lst.de, jasowang@redhat.com, liang.z.li@intel.com, mst@redhat.com,
        tiny.windzz@gmail.com," <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 29, 2021 at 8:53 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> Donnu if it's too late - was on vacation and this only arrived
> Wednesday. Seems to be necessary to avoid introducing a regression
> in virtio-mem.

Heh. Not too late for 5.14, but too late in the sense that I had
picked this one up manually already as commit 425bec0032f5
("virtio-mem: fix sleeping in RCU read side section in
virtio_mem_online_page_cb()").

                Linus
