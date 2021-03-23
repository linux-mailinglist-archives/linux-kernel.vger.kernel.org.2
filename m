Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9B5345A7B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 10:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhCWJL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 05:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhCWJLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:11:31 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D128C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 02:11:31 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id y1so24597223ljm.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 02:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UZjB+r8IkfvsZJXLvIUvdrHiUh88Uu5sR/RyChLpr98=;
        b=KLGiXrXgKsKBSQiZC1qqxOeZEFQnTJH0+O4D8Z5z3ofPQ/4x1PE+CPEAW0eIIqQ942
         pmZSQqetkLq5WZOcy/PLgoex5XttWVDpXu3Wg4YnF4PlnnLb3A/19FvQQvAzbRhj2Dbs
         JNKP1mkhfmqqECCsKNNVJbBEbzv8M8EFUeljFlbBeCCu3dw0V7fsgshscA51OoFdwCyc
         X0VLye6DJJ0zecGF6jUOmn0KI1/7wIw2M+VNyungA+FCLOrFzUxWJRvt4Ha39eWZRANg
         2g2WixnsVIilPw9KX+hq6Vno2fI0BqRq5VeVfk1NrQPvO6pSsfqKs59UaoqrXjpSTiWb
         6JKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UZjB+r8IkfvsZJXLvIUvdrHiUh88Uu5sR/RyChLpr98=;
        b=gg9vEdzueGFxCYQ10EMiObuwwaHPKAumovOIR3dh07Zmd1RHt3Yfjxna94hzgr7XU2
         veYZG701Ug7qmjU8jFdVPhY4VLF9fVuhMti9/KAZen9OP16KmicYPOU2IKUb8sd1eXpC
         jecPndH5MujcFxRVtECc2x31mWOL9o4AzUQ+Fr7hvPfFoddmB0vz1QGnk54eLF1qgoLo
         SJqc8lMKdsmOQyZmKpPMFsKETGGqR8weoKZHKw56DNTJjXU3eDN2Oc4zUURG7g8toNBh
         KKLysq0+GVQNDOZwGT+7EOdCXzuhNGrrwj6wVCp/4Xt5ZbwZhN3FtOPwiVAx21wRJ41D
         bg/w==
X-Gm-Message-State: AOAM530v5Ldn4HTguE65+EUQQQ/C3JRsjlA3315cPEWfGStWcnVJk+pI
        6kgAId+LgkOduyuElFn4+K3eX3qgE9mr1tFlVbZGdw==
X-Google-Smtp-Source: ABdhPJy8J5gh0ZqDHx8HzNWAMOESSZnyphJlLDWgHlD/pMjAY5YXmdQ2WUcSvTm0VeTzfZ1lp5oGTTFeP6etIYmAcSA=
X-Received: by 2002:a2e:9004:: with SMTP id h4mr2565529ljg.326.1616490689746;
 Tue, 23 Mar 2021 02:11:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210312083604.3708890-1-linus.walleij@linaro.org> <20210323085748.GH2916463@dell>
In-Reply-To: <20210323085748.GH2916463@dell>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 23 Mar 2021 10:11:18 +0100
Message-ID: <CACRpkdYK4m_zsa_FMYDOpYaBLPsWk=DG-V3yeOhq4hdBp4prwA@mail.gmail.com>
Subject: Re: [GIT PULL] Immutable branch between MFD and Power due for the
 v5.13 merge window
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 9:57 AM Lee Jones <lee.jones@linaro.org> wrote:

>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-power-v5.13

Thanks so much for fixing this Lee!

Sebastian: if you decide to pull this in I can iterate some more
patches to the AB8500 BM code this merge window, else I will
just defer to after v5.13-rc1.

Yours,
Linus Walleij
