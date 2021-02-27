Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A19B9326DD2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 17:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbhB0QXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Feb 2021 11:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbhB0QW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 11:22:56 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7475FC06174A
        for <linux-kernel@vger.kernel.org>; Sat, 27 Feb 2021 08:22:14 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id m22so18593461lfg.5
        for <linux-kernel@vger.kernel.org>; Sat, 27 Feb 2021 08:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7rdkQd2nFo/KCgD1LcCFyZvYpZw3T9bvfpxt4ESvC74=;
        b=g83yuITN74+zzKknKk40bwZmybSxrR4J6Dt/SRQIsqRwol3dO6PJp11DL6FG6pjj+e
         V6nsjoYNFg20Au0H7BtkAf75VI6j/R8rS0XYhvcgrdsWxTgxGml880FfPz3PnEgbkCYM
         Lf6BX69TlWhFtZ/4uFjS4epYIuhbfnuuvCFvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7rdkQd2nFo/KCgD1LcCFyZvYpZw3T9bvfpxt4ESvC74=;
        b=L9U9BDaXvBN3N3AtFVYiEvR3fExyWBmA8oJVlo+qpGjjnMD7dTLZ2NG6nkjQm8Sv26
         lVsNVY7AS5rIuJ5hbjqCzBFdJAZ0Ljx50+SA5xOEo7ToIasiDYVcQBS7EfttDMKauH4z
         XOKf3pe4poE9SjP+cHdUooRO2UavdwjaQvks0dhjCv79bRJVijBWYxz/00LSm25v4GhV
         5kNyNrjQtXxfcAUmxn7M7WnhlH12uiXn+xgZz6pbrJoosUnHzByQuCciFDGvcnYn2Fg9
         Vj+OrTbxJ8hPLuMVipi+tX5sQLMnAE3GT2/8sFWlQbot1Zjx8LTcEkqc+qRt5cdpSu99
         awWw==
X-Gm-Message-State: AOAM530/H80RyIlvIz4LQVBJknJAt+rBrSoxDikZQCzzKVVqrx1THCnV
        4d01BAI6U32vzjZwa+2vG1pxgHAP6zZo4g==
X-Google-Smtp-Source: ABdhPJydC5ZVFMyJYCSOJXeNTsqTn/raiUoOZz2LsaoA+y4YuOufjvLvCbB0yAxr4/0Pfx3oKY5ahw==
X-Received: by 2002:a19:6d01:: with SMTP id i1mr4816489lfc.36.1614442932651;
        Sat, 27 Feb 2021 08:22:12 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id t16sm1624854lfe.179.2021.02.27.08.22.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Feb 2021 08:22:12 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id n16so1643507lfb.4
        for <linux-kernel@vger.kernel.org>; Sat, 27 Feb 2021 08:22:11 -0800 (PST)
X-Received: by 2002:a19:ed03:: with SMTP id y3mr3977259lfy.377.1614442931514;
 Sat, 27 Feb 2021 08:22:11 -0800 (PST)
MIME-Version: 1.0
References: <YDnf/cY4c0uOIcVd@zeniv-ca.linux.org.uk>
In-Reply-To: <YDnf/cY4c0uOIcVd@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 27 Feb 2021 08:21:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=whHCLK=_h27zMi8A=sn-GO=C+JOAX4nb7QjuGRbLebgbQ@mail.gmail.com>
Message-ID: <CAHk-=whHCLK=_h27zMi8A=sn-GO=C+JOAX4nb7QjuGRbLebgbQ@mail.gmail.com>
Subject: Re: [git pull] vfs.git misc stuff
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 10:00 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Al Viro (3):
>       9p: fix misuse of sscanf() in v9fs_stat2inode()

Hmm. Technically this changes some of the rules. It used to check that
i tall fit in 32 bytes. Now there could be arbitrary spaces in there
that pushes it over the limit.

I don't think we care, but..

             Linus
