Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD1A341982
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbhCSKHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhCSKGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:06:51 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A24BC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:06:51 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id x28so9106837lfu.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8XzLArLsyk3g5rpI/3JDxf1hyv3KFABRme1zPfvsqFk=;
        b=FX0/ylSlO99cEwowCNM90yJ8AptNYb4gYqODKqjHRomDfA7cyKYnMM+IN1KcmGDw/U
         Gk3BB3yjASGpiRxvFsZnPQjMWyv0u4A2n2sQ92f29IkGZFoCtVx4sLWVoCw/MSljyEcp
         dTW0iStFiRjUhhwzFqsY2Yf5XTkXwRd3BWgCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8XzLArLsyk3g5rpI/3JDxf1hyv3KFABRme1zPfvsqFk=;
        b=kfp332mr0uXtT5+0CEjbGlFNm1Jn3am+Vk4sySm5jf9OQ7f+py0d3FLhkMeIMzrfxX
         y0qdtSNZb2c2H0cMxI4F0vG5k1D5ntfMtExotceXSAnh7mJVOsxP6kmOQFXRlW3cH5Gr
         X9VXE3rhdsT5SI9NvhHaTl+B1YqsM+O5ZBv9CG3rsh8DMGXgyIaanpBrMRngMzqtxqvA
         C4vGSyOxF0HDrqwjjKvBnE28KTGfdMYCoOHfqEmPXJqACUw/wEULe/WTppdzMfo7qbC9
         mX9HUkJkOjTIlPbpyTXbqohOLBT+hTG08DlRTLCXMckpuBA6wLA4h9vdmZjg2b2707YH
         WQ6w==
X-Gm-Message-State: AOAM5314pKDMhRISC9x4lBF8XX5/tJBwGhHgKt+TPtvY8+YBxMGLr66z
        FhcJ7zT5H/3v6mvjQ97mlJGpw3WU6E17jyQHM2Tqwg==
X-Google-Smtp-Source: ABdhPJyxThMXX8UYrDYd7Tzd5ZgGipqDmmdnDErvXETNp0XlpsA95sItuyuDrQLEOGSsyWBVaT2OT36Z5epdn8RRQh4=
X-Received: by 2002:a05:6512:33cc:: with SMTP id d12mr332009lfg.487.1616148409546;
 Fri, 19 Mar 2021 03:06:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAMp4zn9oEb6bJJLQWjSE1AFg6TqwkF3FOvFk2VSkKd+0Kj7TCg@mail.gmail.com>
 <20210301110907.2qoxmiy55gpkgwnq@wittgenstein> <20210301132156.in3z53t5xxy3ity5@wittgenstein>
 <202103011515.3A941F6@keescook> <20210318145454.d2xbetk2werv7j2u@wittgenstein>
 <20210318203912.GA26982@ircssh-2.c.rugged-nimbus-611.internal>
In-Reply-To: <20210318203912.GA26982@ircssh-2.c.rugged-nimbus-611.internal>
From:   Rodrigo Campos <rodrigo@kinvolk.io>
Date:   Fri, 19 Mar 2021 11:06:13 +0100
Message-ID: <CACaBj2b1nQMeyQmKNFDB0Z=xkoZmHnFc91ssBX-9UKYwY8r3Gw@mail.gmail.com>
Subject: Re: seccomp: Delay filter activation
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Keerti Lakshminarayan <keerti@netflix.com>,
        Linux Containers List <containers@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hariharan Ananthakrishnan <hari@netflix.com>,
        Kyle Anderson <kylea@netflix.com>,
        Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 9:39 PM Sargun Dhillon <sargun@sargun.me> wrote:
> I believe that the OCI spec[2] is going to run into this class of problem=
 unless
> we introduce an out of band signaling mechanism. I think a valid way to h=
andle
> this is do a send() of the fd number (literal), and wait for the other si=
de to
> pidfd_getfd the seccomp filter, and wait for the socket to be closed to c=
ontinue,
> but I think we should maybe create an example (I volunteer) showing how t=
o do this.

Well, we created a runc implementation for that OCI spec change and we
hit exactly that[1].

runc has a pipe mechanism to communicate already, so we use that. What
we do is: do the seccomp syscall, send the plain fd number over the
pipe and the parent gets the fd with pidfd_getfd()[2]. We use the pipe
to sync, so no issues with that part.

But, of course, if the seccomp filter blocks the syscall to send over
the pipe, this fails.

Christian, can you please elaborate on how you solve this on lxd? I'm
curious to understand if we can use the same in runc or not.


[1]: https://github.com/opencontainers/runc/pull/2682
[2]: https://github.com/opencontainers/runc/pull/2682/files#diff-f0214a0f16=
408fc7f168c6fc9837d189590025cc1813ebf7c1d751136936dfbfR172
--=20
Rodrigo Campos
---
Kinvolk GmbH | Adalbertstr.6a, 10999 Berlin | tel: +491755589364
Gesch=C3=A4ftsf=C3=BChrer/Directors: Alban Crequy, Chris K=C3=BChl, Iago L=
=C3=B3pez Galeiras
Registergericht/Court of registration: Amtsgericht Charlottenburg
Registernummer/Registration number: HRB 171414 B
Ust-ID-Nummer/VAT ID number: DE302207000
