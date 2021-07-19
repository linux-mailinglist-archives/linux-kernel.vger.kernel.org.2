Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5427D3CF0B4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 02:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbhGSXlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 19:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441881AbhGSWOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 18:14:02 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F83C05BD27
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 15:23:41 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id g22so20854614lfu.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 15:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=S1fnpljt9kBpbLF8nkBT1JIQruUeeltptwWcX+/X+9g=;
        b=piBRPaIjUNzshN/BrbUoNbIVZRRui3p0yhyo1X8DW3BVlalWdPA11GyQXUsswHs0LG
         D0iYGUemhjtCC2Aq348WOHVKwGZYB1Gh5DijUUqckDrUi+3cEIdw4+K9C2F1iDMuYkKJ
         GGiIQGab9iqcdyck3LCFF/lB8INIRM3qLxYqk0jm5u9kyRnAYpM2oPppsz/d8c1GSdME
         fhs9QxmC+B6BM9Sqh91jYtjU6yB7HWfS29V/iLT2ZYL+jFckzob2BpZj71uktk9vH1rK
         +aO3cAQKVJtU1Pm+X+kbG8oTVdhaf7kLL7EVHTF7TGh+2qg6HIYddYO4CblfhecmGcU+
         3Vwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=S1fnpljt9kBpbLF8nkBT1JIQruUeeltptwWcX+/X+9g=;
        b=rA9YXdzIbtubhLQApj3MZx9WLgr4qw2XrwFyU51gZpFLIfCdX8PG424tFbYPObN3S1
         +bCNh1gF+Ugo35D2eoz9K5drv7Jsv4lxQhdGdOrne1iIo6/dcoY0HFz5BaVC8PamXENi
         S+n7OiliXzYzvHi8l0wuzEG226qa+OFz6rvaaCzkQdwA6Bp7ldnN3jwuNQLWlspZdcMY
         heya3DQyyAFuVKTgCSzvZkJnQbeO34KUUf7sZo0QArDc/61EH3z1j9xKHCpz3P4M4qSG
         AkSY3mz625KoeT5w+ZwHGGnlRWOPEg/norPxoWNATY/Nb7IgszXSBklY4LE18LQarvsE
         1shQ==
X-Gm-Message-State: AOAM5332iPOxSR4/3OJthTk1ZIq2QRH4LHw2J13sKvAjvENLRy+J95NK
        KAwTRUf175Hgp0AvOo70KOisWF3rYbMaqdfn8EQftQ==
X-Google-Smtp-Source: ABdhPJyCSP047kzsHuG6aNPCmVlBz2E1PAafIo6ezcFs1iKts6fqyEcijHkJ5ws7+/heNxQuAQpHx9jwMtF5Rt+0nNc=
X-Received: by 2002:ac2:59db:: with SMTP id x27mr19683047lfn.547.1626733419997;
 Mon, 19 Jul 2021 15:23:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210718130748.230758-1-paul@crapouillou.net> <CAKwvOdkVEa-CxbVschn5Tnh7-Ynvzcz+zChhP3LL3Q745wE7_A@mail.gmail.com>
 <7YIIWQ.1TU3IBLL4KNC2@crapouillou.net>
In-Reply-To: <7YIIWQ.1TU3IBLL4KNC2@crapouillou.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 19 Jul 2021 15:23:29 -0700
Message-ID: <CAKwvOdkZWib3YUSdOZ2LQFE=fNF+FhfgfO2hqdsgMgzwaUqGnQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Avoid macro redefinitions
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        list@opendingux.net, Kees Cook <keescook@chromium.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2021 at 3:11 PM Paul Cercueil <paul@crapouillou.net> wrote:
>
> Hi Nick,
>
> Le lun., juil. 19 2021 at 14:43:46 -0700, Nick Desaulniers
> <ndesaulniers@google.com> a =C3=A9crit :
> > Same question for GAS version support for virt?
> > Documentation/process/changes.rst
> > says GNU binutils 2.23+ is required for building the kernel.
> > If we still need to support, have you tested this change on such an
> > older version of GNU binutils?
>
> I have no idea about virt support - I hope Thomas can answer this.

Perhaps you can do some archeology on the commit messages of binutils-gdb?

binutils-gdb commit 9785fc2a4d22 ("MIPS: Fix XPA base and
Virtualization ASE instruction handling")
looks interesting.
commit b015e599c772e does too. Looks like git tags aren't used, but
checking out those sources might have a version hardcoded in a
Makefile.

>
> I did build with binutils 2.35; 2.23 sounds very old.
--=20
Thanks,
~Nick Desaulniers
