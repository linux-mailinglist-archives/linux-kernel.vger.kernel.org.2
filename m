Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C47023B092B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 17:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbhFVPfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 11:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbhFVPfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:35:08 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E070CC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 08:32:52 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id d2so30765851ljj.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 08:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hmjRNaRTsIzZ03uK9rRt/2A93U0PY9kbbj4A/XRT2RE=;
        b=B6yWARmK6avEL61zEXxkktz5rMZ9fVIMLFKMWeX9LV0Sfcd5VNigl3pqQdvVOnT5fc
         wmXE3hK9zOlTCkZFZLMF/QUQ+0cmNYbS2oB34FCfw6eCV15UfYIvGJflzAjcMTMrjE3J
         gE/yWAYAxnnXGInGBg5PdjmBrZOcNgYDrgWts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hmjRNaRTsIzZ03uK9rRt/2A93U0PY9kbbj4A/XRT2RE=;
        b=PTmTaB2bZRbwpMgpPgPNCwqdIw6MvPDQKBqX322DRUXvSX4B0MI7u2c0m7oJ0Wuhwi
         bfiJX69RCn7c5Ac9NVNfx/gIbH2iTp/7u5GII0HRWxbi+5clM7Dkg3KP5gta35sJyB1F
         MlKFtl896esrKXkZYADqpskBHacIb/em4zjhY6UmY/1y/DjoDg6gEknzynTw468zph1B
         9AOOMe6io+li+z9K1dMf6FUBnSm//wM/cNldFQEK9B2ktmqvUE6w+i1qx3d06wikbyBG
         4b5GcbgcIj/yF2xM5sDRzKkrrv6WOCk1OCet5qnCkVcHQWnNW7vSjGaSU61QhknjTAXJ
         jP+A==
X-Gm-Message-State: AOAM533l5/MFXUQWB2K2Q/5R4YpJ8QStXwAjCO0xtHWKBbk8C09SmYtQ
        jIjvHGqmcmh7RK/8r4sT5HguBqvcEdGdFRe7bYk=
X-Google-Smtp-Source: ABdhPJzrAWsma8B6dHyWFCJ1a4CESj8+iPImp3+zi7X3JPYN6V/Bo+ms3ZL80gRLAvmVUdn6yJEpVg==
X-Received: by 2002:a2e:8584:: with SMTP id b4mr2393948lji.107.1624375971124;
        Tue, 22 Jun 2021 08:32:51 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id b4sm2173285lfp.223.2021.06.22.08.32.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 08:32:48 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id d13so30665059ljg.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 08:32:47 -0700 (PDT)
X-Received: by 2002:a2e:7813:: with SMTP id t19mr3700308ljc.411.1624375967597;
 Tue, 22 Jun 2021 08:32:47 -0700 (PDT)
MIME-Version: 1.0
References: <3221175.1624375240@warthog.procyon.org.uk>
In-Reply-To: <3221175.1624375240@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 22 Jun 2021 08:32:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgM0ZMqY9fuYx0H6UninvbZjMyJeL=7Zz4=AmtO98QncA@mail.gmail.com>
Message-ID: <CAHk-=wgM0ZMqY9fuYx0H6UninvbZjMyJeL=7Zz4=AmtO98QncA@mail.gmail.com>
Subject: Re: Do we need to unrevert "fs: do not prefault sys_write() user
 buffer pages"?
To:     David Howells <dhowells@redhat.com>
Cc:     "Ted Ts'o" <tytso@mit.edu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux-MM <linux-mm@kvack.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note this part:

On Tue, Jun 22, 2021 at 8:20 AM David Howells <dhowells@redhat.com> wrote:
>
>         copied = iov_iter_copy_from_user_atomic(page, i, offset, bytes);

The "atomic" is the key thing.

The fault_in_readable is just an optimistic "let's make things be mapped".

But yes, it could get unmapped again before the actual copy happens
with the lock held. But that's why the copy is using that atomic
version, so if that happens, we'll end up repeating.

Honestly, the first part comment above the
iov_iter_fault_in_readable() is a bit misleading (the deadlock would
be real _except_ for the atomic part), and it would logically make
sense to only do this for when the actual atomic copy_from_user_atomic
fails. But then you'd have to fault things twice if you do fault.

            Linus
