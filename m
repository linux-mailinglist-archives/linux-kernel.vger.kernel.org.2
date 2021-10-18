Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0AC5432009
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 16:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbhJROmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 10:42:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232183AbhJROmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 10:42:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7CEB560232
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 14:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634567990;
        bh=P+5pP9FFLfruURRWj+Zkev0wVkp9BvtVIXrYS4fyWfo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=J1uwnxn9L8NI611AAJAnZyi76VR/0S62fZD7R5k06IampVJysvN49L0tnRIZ5lKf+
         8iMjJSnsq7K/v92zQV9PzMg29gZEhcxKShRz1iVIOEZ9zBtf/Xmw8EvAw7QK5On1p7
         wiMBY7a9qegebESj1NznKvJo2kzjfTAiIUvOaJ9odhC0WhhKvFI3RAAeKnTxBtRZd9
         jlYdgoHKg8Yb+S1THdUkZCsr2zuWCAKv9dX2aWTLneTimS4Df71Qp5HkNyfNhVETKG
         D1y7SqC7ySRz/TYhNSGJ9lCfo56bWfVmsiadgipTJeGFLNakRHv3nK5IDoUhk37CNt
         oBFSv3U2dL38w==
Received: by mail-wr1-f49.google.com with SMTP id e12so41856597wra.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 07:39:50 -0700 (PDT)
X-Gm-Message-State: AOAM5317FgO3QFlB1OZ0aPGzzJtuAbPv+PwauFoQu8QI5e8snootE1DF
        18HyMjEeU52EPSjc6xSaP0eMjfxZ+lRDzKG5aSA=
X-Google-Smtp-Source: ABdhPJyR4Ho5dze+aJyCCCjg6V+tn/9q8VqwKp8sVkskgDgA5fWc9VHvcdEdmzcjUO2Mw52GML+ywaMuJVqpKq9XLLM=
X-Received: by 2002:adf:b1c4:: with SMTP id r4mr35986260wra.428.1634567988998;
 Mon, 18 Oct 2021 07:39:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210928085554.2299495-1-arnd@kernel.org> <ce05e90b-f22f-bd0e-4e0f-da560bffc0c2@suse.de>
In-Reply-To: <ce05e90b-f22f-bd0e-4e0f-da560bffc0c2@suse.de>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 18 Oct 2021 16:39:32 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1brJNoq65h15-zZtNgwV92hwXH9p32cJpzAY3=ouOHnw@mail.gmail.com>
Message-ID: <CAK8P3a1brJNoq65h15-zZtNgwV92hwXH9p32cJpzAY3=ouOHnw@mail.gmail.com>
Subject: Re: [PATCH] [v2] bcache: hide variable-sized types from uapi header check
To:     Coly Li <colyli@suse.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>,
        Kent Overstreet <kmo@daterainc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 4:20 PM Coly Li <colyli@suse.de> wrote:
>
> IMHO, remove bcache related header from uapi check might be better
> solution. So far only bcache-tools uses this header with its own copy,
> no application includes the header(s) so far. It makes sense to exclude
> bcache.h from upai headers check.

Should we just move it to include/linux/ and out of the uapi headers entirely
then? It sounds like it's not actually an ABI but just the definition of the
data layout that is not included by anything from user space.

We are a bit inconsistent here already, e.g. btrfs has all its structures
in uapi, but ext4 does not.

       Arnd
