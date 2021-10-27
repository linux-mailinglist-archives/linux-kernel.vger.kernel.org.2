Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDF043D099
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 20:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243504AbhJ0SYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 14:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243451AbhJ0SYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 14:24:20 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A69C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 11:21:54 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id n18so2595176plc.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 11:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AD4ikdLw5K39nUcJPIJX19cWMB5BKDN/c11cOkTHf4g=;
        b=hd844BjOs/LgE5zD+4JOv/F0AJABnQ68WXcoF4+dzVIsQP7AuxF1u6cxPiAEoVuxDn
         br7biWXRRx7RpXpA+93SOp1k+NuaQTjhuIajGN1NNoi1BCTHzwdSLv3P+hGz4kg2so4K
         6I/eT1CMmjZvHzLagiwlM8b1jgaY/u5miPvaL5xAVvcsA3pzHVfvtFbxjva7Rp0hpVb9
         L8Yem9nDoKY5RMBXOL+GoWNdLAj7Ex6sNNawwWwI0TbxNxo1pg6aZHXEUEBKHS087bkk
         3PAz6jxrSNr4aiNhgKejtUXNHrbq7Cpveh7DDdzTz8XBrpiOFaFlVfleK/1x+ZcRMIjD
         Ah8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AD4ikdLw5K39nUcJPIJX19cWMB5BKDN/c11cOkTHf4g=;
        b=oKu1OKooV3NFwcch2umYxcabemjmBQMHOKNjXkOwxrrbK8Xhv2W7YjMgxai0OmYuAL
         kCZXyKdHYu5Ub+WZ5g5fUPGXzi38ejrnae3BghrL/3KLckuAIleprNQjWg9WU8C4ljWM
         2E42n2mbgW+l9shnVeny9NfLblqZTbHClxS2dMTyS2SkRJWq5bMVVvKmbs2G9gBIY+3T
         OfzN1H5d3556YnqdXv40wKiVL6icab+vKYemejaG3Xix8S7ROTcbLD5a0FlQzHlpaefu
         Ak0Z+VuvE6hVHSjibFKj+3yhTVZp1dmITG5f3jWZejPJxGTXOBmoEsl+nswNK6pk75CW
         H8IQ==
X-Gm-Message-State: AOAM531TeNDKEOHmvIy1ZED72fnich4mVAQtcOic8FAmV5p1bp/8UkcG
        ib2u1kx4663BL/DCmb+TA8JVMmeeIjPzTjbPncOCWKV4
X-Google-Smtp-Source: ABdhPJz5olMItRb5lXNNwbECV1Ip0cHqhy7269CxB0Ih3gDRyOLSZIjVLvC5FrFAm1PjrwTDHBedwNkSUStt11TZ9iw=
X-Received: by 2002:a17:90b:1c8f:: with SMTP id oo15mr7647372pjb.87.1635358914251;
 Wed, 27 Oct 2021 11:21:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210920053951.4093668-1-goldstein.w.n@gmail.com>
 <20211027162615.1989004-1-goldstein.w.n@gmail.com> <20211027162615.1989004-2-goldstein.w.n@gmail.com>
 <YXmIP2EPg12N7foP@zn.tnic> <CAFUsyf+Y76TxLnxMSfHiNqY3OOZPtBR4m_EbTcow=N65nvGdKA@mail.gmail.com>
 <YXmQSG7BYCcZ6jqZ@zn.tnic>
In-Reply-To: <YXmQSG7BYCcZ6jqZ@zn.tnic>
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Date:   Wed, 27 Oct 2021 13:21:43 -0500
Message-ID: <CAFUsyfKVistpw8eL9L6qwypac7JL9ecAL2W4reZtAMOq7xL+2g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] x86/xstate: Make AVX512 status tracking more accurate
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, X86 ML <x86@kernel.org>,
        hpa@zytor.com, Andy Lutomirski <luto@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 12:45 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Oct 27, 2021 at 12:37:16PM -0500, Noah Goldstein wrote:
> > What about just splitting off a field for 'AVX512_ZMM_Hi256'?
>
> Let's please not perpetuate this into what it cannot become anyway. The
> more stuff we add to it, the more people will start using it and we're
> stuck with it forever. And soon that thing will be worthless anyway.
>
> So what's the point...

Got it and done in V5.

>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
