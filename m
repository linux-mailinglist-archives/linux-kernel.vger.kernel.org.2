Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4BF13AFFC0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 10:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhFVJBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 05:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbhFVJBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 05:01:41 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D909CC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 01:59:25 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id i13so34667426lfc.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 01:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IgEmzdTN4HRdSGSGItritGnREG7UWG/WRpkp7ArUXcE=;
        b=rGxrgaPHp+sQC8l6VapK8a6P5JqjpCZwJMXBj5xpye8EpqoWWkNlfMdkIdX5xHnqdL
         3d7HZpEuLuxfLrsnaxPnbxThAWdjgDSMO7dFAv/gStfhd10R17bNGBDxQGTWDtNGj05s
         ousef4QBfEkd8sZfycBEZooTm6yIngfBBQhY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IgEmzdTN4HRdSGSGItritGnREG7UWG/WRpkp7ArUXcE=;
        b=DKmR4QqfydbjcNe3WmYr5NqsPHHPCEGlfXiTvfz6o10QQEHbu6Q86U1FJiTNcv47dz
         ke/O4G1WJ9Yi4r5+08pBDrD79QGV5alxBsI/cLR9oPnsJAuKsdEqO/Kqesf/1s4VkKpY
         EM8Zr0qa6nLBtrK9FfEzIvQ6yP3zYa8dnMhSGfmTdAUjOLqFtaR6DtXBpGq9v0yw+Rzo
         TbgvM0oPYLZEECVkxLqkPH0ORLRyCLEgWWF+h+KcRiYWSr6TwgML7QRqv3m0Q/b/eopz
         ZTUH2TAh9YLFrjrnewztMiv8xVGpNDkmdncQRrCjC0ak863/3IaF+rw5ZmEbBOsAlPT5
         4Rkw==
X-Gm-Message-State: AOAM532Jj4RS/uYwwxT2sXEyLDKCgp3KO6/5NwMHQmVf395IrgEku7+C
        DD/hzjNZTCfAWJ16LLlKi8QUcJPaKEmhh4SiPqCAEQ==
X-Google-Smtp-Source: ABdhPJzp+TlD60AbwK4d3/UXVRAhqAIiO3g137IxT9Fo7F+PNWnfzCBea7CtOcT9B5cFOg/d8yatTDuV+UGXrgsRXB4=
X-Received: by 2002:ac2:4db6:: with SMTP id h22mr1985921lfe.171.1624352363827;
 Tue, 22 Jun 2021 01:59:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210618105526.265003-1-zenczykowski@gmail.com>
 <CACAyw99k4ZhePBcRJzJn37rvGKnPHEgE3z8Y-47iYKQO2nqFpQ@mail.gmail.com>
 <CANP3RGdrpb+KiD+a29zTSU3LKR8Qo6aFdo4QseRvPdNhZ_AOJw@mail.gmail.com>
 <CACAyw9948drqRE=0tC=5OrdX=nOVR3JSPScXrkdAv+kGD_P3ZA@mail.gmail.com> <CAHo-Oozra2ygb4qW6s8rsgZFmdr-gaQuGzREtXuZLwzzESCYNw@mail.gmail.com>
In-Reply-To: <CAHo-Oozra2ygb4qW6s8rsgZFmdr-gaQuGzREtXuZLwzzESCYNw@mail.gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Tue, 22 Jun 2021 09:59:12 +0100
Message-ID: <CACAyw98B=uCnDY1tTw5STLUgNKvJeksJjaKiGqasJEEVv99GqA@mail.gmail.com>
Subject: Re: [PATCH bpf] Revert "bpf: program: Refuse non-O_RDWR flags in BPF_OBJ_GET"
To:     =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Linux Network Development Mailing List 
        <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BPF Mailing List <bpf@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Greg Kroah-Hartman <gregkh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jun 2021 at 22:37, Maciej =C5=BBenczykowski
<zenczykowski@gmail.com> wrote:
>
> Please revert immediately.  I've got better things to do.  I shouldn't
> have to be thinking about this or arguing about this.
> It already took me significantly more than a day simply to track this
> down (arguably due to miscommunications with Greg, who'd earlier
> actually found this in 5.12, but misunderstood the problem, but
> still...).

You're barking up the wrong tree. I don't object to reverting the
patch, you asked me for context and I gave it to you.

Best
Lorenz

--=20
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
