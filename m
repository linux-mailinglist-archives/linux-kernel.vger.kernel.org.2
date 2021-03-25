Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2653348A38
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 08:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbhCYHgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 03:36:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:37912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229448AbhCYHfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 03:35:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2CB8061A1A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 07:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616657745;
        bh=mAFtoy6hMbn7DC2MvCIG2lJYli/BHY/d/v+5y4b6n7k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=je9ipGdhDYEmBPYT22pklaBYynwBnoWqzaLaQAiQ1Z2hUAr4IigwSj7glWmF7r0wY
         WjZKx0llYp9iByYw8H1mC/ZpKMGRy8MmUYhNFFwvfBRqlWUNhlvjF0egnZIutJiRIc
         l5pG6Xrn8Un4zU7dV57+hk477NZkBMNek3wC0U/0Z66Ra6VL+NxirsrTXdq4R9Lr7f
         6c8C0NIxRU2/v8Grlqdh5RdiCsgpA7bWutUWHOLXea1TNzZCbkgYi3l898CjH5sLIv
         UqtONOqHmkXppB2JSY+VbDh8tmORFKVaWFx4TVZhBAfEpAnRszaggP8SvUMWd1/Ylu
         01nCoj2Btn3Qw==
Received: by mail-oi1-f172.google.com with SMTP id x207so1244149oif.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 00:35:45 -0700 (PDT)
X-Gm-Message-State: AOAM530UJRpxLzP6Bdm/7BQ1KHelBrm94lRR3/vuf4eqrH/7DJdEQtU4
        CixVe74OOrMjeTtAscnQI0/DHO+9MA+sRKgS7ZU=
X-Google-Smtp-Source: ABdhPJz2Xsy3VR2I4XEELnMwnaYimHVh4TKARb1NPhA9p0B311inYzhu3op576u8Cy5UnACYRRf6O1hEN69/TxhjSCs=
X-Received: by 2002:aca:7c4:: with SMTP id 187mr4502209oih.47.1616657744330;
 Thu, 25 Mar 2021 00:35:44 -0700 (PDT)
MIME-Version: 1.0
References: <6c819e1944044bfa8f88574beb094ef5@huawei.com> <CAMj1kXH3BPi75h+OfLSr6S24fLD7pN=C=0tNMerXh9tY0whfEQ@mail.gmail.com>
 <54e5e0dbefa042b1b6a9c29fe9984897@huawei.com>
In-Reply-To: <54e5e0dbefa042b1b6a9c29fe9984897@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 25 Mar 2021 08:35:33 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGbwYqy3FCPuXw9nTtpU7MFduTr99Fo2A5cXe6VRvP1Xg@mail.gmail.com>
Message-ID: <CAMj1kXGbwYqy3FCPuXw9nTtpU7MFduTr99Fo2A5cXe6VRvP1Xg@mail.gmail.com>
Subject: Re: [question] insert ko failed because count_plts return 0 when
 CONFIG_RANDOMIZE_BASE is not set
To:     "chenjun (AM)" <chenjun102@huawei.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Xiangrui (Euler)" <rui.xiang@huawei.com>,
        liuyanshi <liuyanshi@huawei.com>,
        wuzengkun <wuzengkun@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Mar 2021 at 07:22, chenjun (AM) <chenjun102@huawei.com> wrote:
>
> =E5=9C=A8 2021/3/24 16:29, Ard Biesheuvel =E5=86=99=E9=81=93:
> > On Wed, 24 Mar 2021 at 08:27, chenjun (AM) <chenjun102@huawei.com> wrot=
e:
> >>
> >> Hi
> >>
> >> I make a Image for arm64 (without CONFIG_RANDOMIZE_BASE). And a ko (13=
M)
> >> can not be inserted.
> >>
> >
> > How many large modules have you loaded already? The module region is
> > only 128 MB, so if your modules are huge, you may run out of space.
> >
> > Please check the kernel VA address and the load address of the module,
> > and check whether they are more than 128 MB apart.
> >
>
> Thanks Ard
>
> I will check it.
>
> One more question, why is CONFIG_ARM64_MODULE_PLTS depended on
> CONFIG_RANDOMIZE_BASE?
>

Because modules should never go out of branching range if the
placement is not randomized and the total size of all modules does not
exceed 128 MB.
