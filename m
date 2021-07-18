Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B063CC9D6
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 18:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbhGRQRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 12:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbhGRQRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 12:17:06 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1E9C061762
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 09:14:06 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id a80so2913100qkg.11
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 09:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9pTKSaEiqDPuxq1mYJI/hsCyKbG+BA3UnWw1ZtFqKm0=;
        b=ElkEONjioNv3x10NwxzQZ6Al9CdjKVXOBfQv5IhYDghffSGRtUtrQeeINcJjw1Pzpk
         d53X6R8XDBoUR1FP/jYt9vTjXoycCbfn5q7Cuwb3jEPMd9YJyn2AO6fktFoyEQ4PsgnE
         mh47P6NucS+ifU2vxZYXWPg2xGvoj5UsydLb//DfgwvYK22Zvgr8llcjpRWK/D4dKXyO
         jh6F0eT8g5LdIjZR5H1f0TLJoEWo2gCvgdujgNV36+sqXSKyE/d4eGVvgTLGnWV/kF8p
         C+HDRGH0zJj8uZ4hyq5e45Eb1dw0wvI8b94FW7N+VB3bcTCIRukVN60VwD32Pe2WvkSL
         ejHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9pTKSaEiqDPuxq1mYJI/hsCyKbG+BA3UnWw1ZtFqKm0=;
        b=fi13W6wY7jkaZFbN/J/z3ljDHGnhWb7iM3eRuxV5c6712gcMmKbNmSvcy+B4kj0qLe
         w4pD4NXCieHzaiBsbdGXhJ6xDfnpYqos4z8GbZEjthvBYaz9U29+BKAAk3/0pIXkfKj5
         +i1bSToMOqnYVRcqEyYJGmYF5DIKuK68FLwqs7ynklD5hlS7qlnu5SmYfIHkS6zHEe0U
         XpOTNkikH7/MH8gPTc40eNurnL0pXjGmfu4y4CkigmqyCLl5gfxJcUVXP31qc7XgKxiP
         BVQm1Nq5U7YauDw6+oz2CUo8ghVRWml+I6RE+WQZRoXM9yTPOfOcBs7SbfdAftR4BeeY
         iG5w==
X-Gm-Message-State: AOAM531/Bj0Yc1lsIIomtMK0+hgs2N+5g18T659z7Tevf/aGG+H6+PsU
        pMOtZlCGqdyursvoi4/46LhY5vt4UDasbzyTZLk=
X-Google-Smtp-Source: ABdhPJxiZsJIqhv1xjnG/CmFewSFHA+ZoMChKKgGSLug7kQHn/3ZDq5tc5xeMRMHtbFEdq/brCmWaddcuQcE+IuKhjU=
X-Received: by 2002:a05:620a:2289:: with SMTP id o9mr20410100qkh.34.1626624845818;
 Sun, 18 Jul 2021 09:14:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210716221159.3587039-1-linux@roeck-us.net> <CAOSf1CHuLhYO1rXiAhPz6xyQ-GgrjE-dj=Af6v7CWSH6QroEtQ@mail.gmail.com>
 <20210717161438.GA3038659@roeck-us.net>
In-Reply-To: <20210717161438.GA3038659@roeck-us.net>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Mon, 19 Jul 2021 02:13:54 +1000
Message-ID: <CAOSf1CEN6022gv_=O9fwyDtJ7ibmXnH+LrpRQvGXTZ22RH-u1g@mail.gmail.com>
Subject: Re: [PATCH] powerpc/chrp: Revert "Move PHB discovery" and "Make
 hydra_init() static"
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 18, 2021 at 2:14 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Sun, Jul 18, 2021 at 01:54:23AM +1000, Oliver O'Halloran wrote:
> > On Sat, Jul 17, 2021 at 8:12 AM Guenter Roeck <linux@roeck-us.net> wrote:
> > >
> > > This patch reverts commit 407d418f2fd4 ("powerpc/chrp: Move PHB
> > > discovery") and commit 9634afa67bfd ("powerpc/chrp: Make hydra_init()
> > > static").
> > >
> > > Running the upstream kernel on Qemu's brand new "pegasos2" emulation
> > > results in a variety of backtraces such as
> >
> > ...and actually using it appears to require both manually enabling it
> > in the qemu config and finding a random bios blob that is no longer
> > distributed by the manufacturer. Cool.
> >
> That is absolutely wrong. vof.bin provided by qemu in the linux root
> directory works just fine, plus chrp32_defconfig minus SMP.

It looks like I forgot to actually merge the current HEAD into my
local qemu branch which was a few weeks old. VOF support was merged on
the 13th so I didn't see it. My apologies.

Oliver
