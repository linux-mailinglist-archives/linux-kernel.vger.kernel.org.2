Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF263450E6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 21:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhCVUfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 16:35:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:36214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230154AbhCVUfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 16:35:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3377F61992
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 20:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616445312;
        bh=z1Z4INuI0ZuFkHgzcVXC34uGZe/tmrmYgvsc2ALuh1g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LpKDbnLUUigOuN3CZGw5uN2FvAvDnZlUXQLnaQ728S6JGQl+p1ynl6mPThATDtvzP
         hDEUNcQB+DDudyx+L25wfHdsz65+s48/C+AiumpfiAEUfgXvryNa1xAaxsmKQaM+Em
         peWawEsVQmWcOJ5/wSgk+9OQlSiW9n/j+s2HF/FXnLzlWlm8Se8N8kSten0ZuDuvxP
         +KJQuE3WM1lIXVRJoUmyZp1ZzbE7ITCa29pG8T45VXgFBiN/YtG8hhQs2H87nBLV3e
         E/IP2w0u2rzFL04hojpcQPaq50Q9mEaEDWS/rQY+AYnBRPEy+tp7YgRpom2esLhsW4
         xBtl11k5AmRKw==
Received: by mail-ed1-f51.google.com with SMTP id j3so20942923edp.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 13:35:12 -0700 (PDT)
X-Gm-Message-State: AOAM533da05OhirvuwPol/h7/WgDo/5fq2Y8b6oyR6SgQhvWMQA4qCRl
        zfs0IfQG7ljNbg23OyT6yj2MXSY/OTWN4Bn9QQ==
X-Google-Smtp-Source: ABdhPJwlg0uF8AIufzZE02wsgOTWKpLhLI8/63yo1hQ95eeS04ID4dsrazKVYx8gpdEaONzfLoqdrzZJx3Y3UAUDBhQ=
X-Received: by 2002:aa7:d3d8:: with SMTP id o24mr1405691edr.165.1616445310805;
 Mon, 22 Mar 2021 13:35:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210314224503.GA2000@duo.ucw.cz>
In-Reply-To: <20210314224503.GA2000@duo.ucw.cz>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 22 Mar 2021 14:34:59 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLoWFjdXBnkLpjsJhkHr635Bkx=SUQSJusW1rOJ2qcKDw@mail.gmail.com>
Message-ID: <CAL_JsqLoWFjdXBnkLpjsJhkHr635Bkx=SUQSJusW1rOJ2qcKDw@mail.gmail.com>
Subject: Re: compile error in scripts/dtc/libfdt/fdt.c
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14, 2021 at 4:45 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> I get failure building ARM kernel. I can workaround it with. Are
> system fdt headers used, or something like that?
>
> I failed to copy the error message, but FDT_ERR_ALIGNMENT was
> undefined symbol.

I had another report on this. A 'git clean' solved it. I'm not sure
what the underlying problem is though. None of the auto builders have
complained either.

Rob
