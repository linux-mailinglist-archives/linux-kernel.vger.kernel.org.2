Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35901344E15
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 19:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbhCVSEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 14:04:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:52934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230236AbhCVSED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 14:04:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1309061998
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 18:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616436243;
        bh=5Dn/hzqvZfSibFJhzGcqjPoya56ScHhqsZpa8x6VWX0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mGJK1XbPpLAS5gt6K2+ft0a24oaImXngmCFuMPdWEZ8Ny1YO1AlTm70mhV+/+SnQD
         fDvwjYS3kX3vJG/1U/gXQH5SvK9Nulu6KdmDPUv+62Qinal/Kpmtyoocyznf73+VQV
         GxnqUq70OCBfSO8CoXe5x/baUVPmhR58EbzXZ7xwTQWfJ753HgbaVmswPuFsknUoVq
         gC9nB2yuqiVaoTNxVDQrNPN3aK8oPxuGZFdoqzvsBzAxzo4qap46DZUyHUN3jLekuX
         b44wTwGv1tNHcf+t0DyUFVU0QfqyE+8Emu6AEuoz3mrA0WdE7bMzrpLboJtgDSc2Sb
         z1Fq6oiWSFgSw==
Received: by mail-ot1-f51.google.com with SMTP id y19-20020a0568301d93b02901b9f88a238eso16836162oti.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 11:04:03 -0700 (PDT)
X-Gm-Message-State: AOAM531Exa/eF608PjYapIq1tau+iFBJus0ILTLNbxn1EYo67/yqo/zK
        9LdkCndOWKlvsXwNLW7uCgiabSheD4CN3Hn0sE4=
X-Google-Smtp-Source: ABdhPJw2un5ttiBaTn5Ti+2EjMAxggLyyWzU0D2isr+3+g++2JMn1SriCCHJ98YWT4UBLzCftEdxJBVrwoZCF0dR4us=
X-Received: by 2002:a05:6830:148c:: with SMTP id s12mr921029otq.251.1616436242366;
 Mon, 22 Mar 2021 11:04:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210322164308.827846-1-arnd@kernel.org> <20210322170330.wil52d2geopfnfka@maple.lan>
In-Reply-To: <20210322170330.wil52d2geopfnfka@maple.lan>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 22 Mar 2021 19:03:45 +0100
X-Gmail-Original-Message-ID: <CAK8P3a30_E5ouw2eGF0wAYd0CiKcekKkEe9xBay2K+OXkyx-gw@mail.gmail.com>
Message-ID: <CAK8P3a30_E5ouw2eGF0wAYd0CiKcekKkEe9xBay2K+OXkyx-gw@mail.gmail.com>
Subject: Re: [PATCH] kgdb: fix gcc-11 warning on indentation
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@elte.hu>,
        Douglas Anderson <dianders@chromium.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 6:03 PM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
>
> Which tree do you want to merge this one though? I've got nothing else
> pending for this file so I am very relaxed about the route...

I don't plan to merge any of the build fixes through my own tree.
If you don't have anything else, maybe Greg can pick it up
in the char-misc tree.

         Arnd
