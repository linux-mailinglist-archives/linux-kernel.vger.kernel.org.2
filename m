Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 329EE397DFE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 03:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbhFBBVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 21:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbhFBBVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 21:21:15 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA43C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 18:19:32 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id i13so840932edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 18:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MDyyOOU0l27yFmi9xpWkaC5jfraGYI47BaflHO+G+r4=;
        b=iHmCcSyzzhwTVSi58cQ4JCOdZhSNRuwp+fX3DkSawsOIwULFUe2JRdGvXGpNIU0MMN
         /1jtrCm3toPkMDIodBU6lDfW+mgUdj74u2xU1GM5e64cGEvSCKc8RPWVCDlroT89m0oX
         n7vItLfNFJitAWwBcbviDN0u+kb44JyA7ZH1Z6zP5gqXf383czeKql4UgpMu+QVXuPQg
         Mtev3O8CxYFS1GR23pCPHX6YNzofRkNr7Msldg5Z2KBuyDHLsTR/w/xPiREN7jMihHPj
         uN+dswg8H5P1f/NmFrFTb5RSAluWEMdZyO0UZY83wTX1Wrl6Fw7btGlfaugmC2YuUOia
         shuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MDyyOOU0l27yFmi9xpWkaC5jfraGYI47BaflHO+G+r4=;
        b=qRKRu2SaWmlWruH1h4TZVsfRBA0A1iVVg/SAyIxJJYJZ0807tHB2p44UkiU8lHZYJa
         wLAgjcWlf294Tl8G5U0RwgYge86e2i/THJ2mutz/nDXY4QwDPOV9x5BtNLjz7FsOCDPc
         A56qk+lXoNeMaNQNuWnlqewno3qGzjGN2BwyIkDAS73JK4nJWfSF4lUKP5PPhdtqCSm5
         tt9r+syx4hKJXNU36cVY0QG7JUJWCZ4jX6XUogCRJIORkS5xr9TrDcU9Ue5AbaVz1thF
         rD/BQNBg9LJYTZcYn//d2PAneeWuEsjGuIa3nAtA00Snz5UlZk9FLFKlLBbiK6bZK2is
         0a+A==
X-Gm-Message-State: AOAM531M+3NwE27Fc4qf/syaHK+656xT3qRxwX+3A6G23V2ALY4z50tU
        glc9+g2Rq2lgAqIYya2Ag2hMOezt8Wy0JKpGIIcq5w==
X-Google-Smtp-Source: ABdhPJwfcbj66YCKvYsiCkueyitZ2M4CytwYWerYVBWpBpoKXbmt7/54D/wedq0vndWO1TKP+ftLAdkz69R0rPld/ZY=
X-Received: by 2002:a05:6402:510b:: with SMTP id m11mr35350762edd.26.1622596770646;
 Tue, 01 Jun 2021 18:19:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210527150526.271941-1-pasha.tatashin@soleen.com>
 <20210527150526.271941-4-pasha.tatashin@soleen.com> <87sg28rx3c.wl-maz@kernel.org>
 <CA+CK2bDvsFX_s-G5tRcE1GreNW_xLTognosUFbPPgaUK7-cafQ@mail.gmail.com> <87r1hl22qm.wl-maz@kernel.org>
In-Reply-To: <87r1hl22qm.wl-maz@kernel.org>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 1 Jun 2021 21:18:54 -0400
Message-ID: <CA+CK2bBwd2+QB6qCWYQdC5x_Vkf7-64pr8UWJFoUkQgtfaAsHQ@mail.gmail.com>
Subject: Re: [PATCH 03/18] arm64: hyp-stub: Move elx_sync into the vectors
To:     Marc Zyngier <maz@kernel.org>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mm <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>, steve.capper@arm.com,
        rfontana@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        Selin Dag <selindag@gmail.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        madvenka@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > It cannot call mutate_to_vhe because #HVC_VHE_RESTART is not used
> > here. But, if it had to it would not work as we cannot return to the
> > old kernel text after relocation.
>
> OK, so you are happy with having a dangling branch pointing to
> nowhere? Something in me screams that it isn't a good idea, in
> general.
>
> If HVC_SOFT_RESTART is all you need, I'd rather you have a small stub
> that implements exactly that and nothing else. Feel free to extract it
> as a reusable macro if you want.

Sure, I will add in the next revision.

Thanks,
Pasha
