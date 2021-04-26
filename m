Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9F636AF54
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 10:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbhDZH5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 03:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234275AbhDZHty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 03:49:54 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8E9C0612EF
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 00:46:04 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id q6so5256705edr.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 00:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9AdJMoYPBl3Z5Zio9ck1KLt6M+3zzcFR0rywHxTwa9c=;
        b=BdE7/IFwaZCrkfwI3Gq+949jgF9Z1VJGx0rHfR7jCTOa9LxluWsyj6yzpHby6VYRDb
         YYkFClh4cNrmDSmzwArzJwJEUljIf6zjXytNeoNe0WP3qsDCPGeHQuh9kg/YWJAnILLI
         c8f+hHett96uxMh1S8QQsaIqYbsvb+OexobB0ILi5SR3AVZeFRDBwGNZfEOP7r5p036R
         O1yYHSB1j7J0vIBZdc3DVMGBkhALQ4ptJ5bUwb0cvsqzdJm80zUJp0MuJzdLN0fQSKC5
         PdqdEqd7fki0mmlgCCzcfjoZOVkedRkELnGCSngIytofByPlF+jL4YhY0IuBoFd/+UpI
         Qk8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9AdJMoYPBl3Z5Zio9ck1KLt6M+3zzcFR0rywHxTwa9c=;
        b=NzM0suZX+D4TdSyisHUO78LlXFJsa07bkwwDxfitB54x+9cgtAUdS/vAO9YyZ8Pq/I
         y37GupzoiSL+FT2s4a9baqAu+e57UBpoWh6P/YfbQD3XIZ4PtBffTAt905ICqNM8kFqG
         jkGmnOuXQdQHbtXtwyUNJvH19BSVqNy2gHgFybF+t1MjY1B3xDP01kVTVHoGFZ7Vo2/3
         8Tpc21D6hT4Trg3iCT7i/DILbGu5VzIH8IPr3/X4VJUFfW4UZrCqdtLULru66z3H6+Uu
         wXKirG3VmuQ1nf4kkRftKGvqnmTEbrfQrVvcAHFHsg2CdJnQMoJDdjylncjfVE+Jp8T/
         Iv4g==
X-Gm-Message-State: AOAM532zkIzG00e3q+TivM+RVw3It3CjqKceFmX9Q3egmoBkamVx7sIL
        9Ogtk+507avdG05OEt2M/GSDIeJedcwEMOYwig==
X-Google-Smtp-Source: ABdhPJyqvQVMtofuVBy8cA/Zy+sgx2jHD4bCfxl/w+7tTn5PO9OxED4mRclsIf0IRuawcRjW6tnwcoUCylS1yuLF3xg=
X-Received: by 2002:aa7:cb48:: with SMTP id w8mr5276015edt.55.1619423162936;
 Mon, 26 Apr 2021 00:46:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210316141916.447493-1-rsalvaterra@gmail.com> <CALjTZvaX8miSycr4oGmF_rGN4KWWBzfyBj1-7jefT=Uz3w9Oww@mail.gmail.com>
In-Reply-To: <CALjTZvaX8miSycr4oGmF_rGN4KWWBzfyBj1-7jefT=Uz3w9Oww@mail.gmail.com>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Mon, 26 Apr 2021 08:45:51 +0100
Message-ID: <CALjTZvZ_MNp_0EgichkgWbQ-6htvHRQmUGb0tV+-1D98fS-JBg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] jffs2: add support for zstd compression
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     lizhe67@huawei.com, christian.brauner@ubuntu.com,
        gustavoars@kernel.org, trix@redhat.com, keescook@chromium.org,
        dwmw2@infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Mar 2021 at 14:47, Rui Salvaterra <rsalvaterra@gmail.com> wrote:
>
> Friendly ping (and also cc'ing dwmw2).

Ping^2, now the merge window is closed.
