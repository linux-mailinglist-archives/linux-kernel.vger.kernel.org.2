Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1053A33CF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 21:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhFJTTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 15:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhFJTTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 15:19:30 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6028BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 12:17:33 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id e2so6414145ljk.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 12:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aPTyDJh/FqkPC7Of53mXpiFCJnipzLbSqzQI1i7wKkI=;
        b=TUj4T7lxOrr9qEMnqhOCizt9ERRD5MAMSJj4cRHm63u6EGu7ChB1eCYd47d9FGqLjl
         MOihAMN8+mkGyhbSMPPVPDLPhmgFLcrgkk0cvoUHj0jRjdnHTebtipEYIex8b3kM5mMt
         PtdSABebDp9MCpQZlU8cKNz6UtSbPye0n/YnXiuaQuWs3ddzen6tBSUdXVynKiAspwCC
         bbVgih8HOQ3zDntPyaqW6eVgl/+rmF0ke3FeRfBsiL/2kk9Y+xccCkG0wFK/l3AsSmIo
         TfUBeyGpKUg8tEVDF7/RZYFVjKsIfMe3RyLKBb0bNxKemosihwVxfQtlke7lmpoPynCY
         ef2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aPTyDJh/FqkPC7Of53mXpiFCJnipzLbSqzQI1i7wKkI=;
        b=QdwgOzssnW0U1WGDCd07Kmoy4dIlFjsoGkcOOOQ/XbaXQxhOHQp+dqG3HBrLZXQZ46
         w9Qn/ec57WUTidugWxN/tkFv5vmi30qeS6uCPNFIVYffdulo+YTm9K6Kc3ffAMAVApDm
         6/Mn53wHF+lQN6s1sonOGHxcmPJG2n6Y9QR+uq+yOhABZ7wBfZ6B6AiGLusiUOZxWNKE
         g0oij0+MrNepYTGYAIdubQOiW6cKEi3sOvHYLEcVUfmnzJPOqaUYC38BQsKLtD6E+KBm
         C8eeXRH50MoZ1JpuxfSZfWib1ZyffSFaXlmCZclW4cg/YpM76w4o3VJM7ZQ82hWeWBZm
         0yWg==
X-Gm-Message-State: AOAM5335QwFmkLXXg0cpzMP9KH58JrnfTTaZ8Mbi9Dm7Sq9NhVBo21aV
        bFTsaTlKhv9Smrb/ecCMmwy5IL8hp+OthwFFLX2olg==
X-Google-Smtp-Source: ABdhPJzcPa3ZWjUiuCZT9vcsG+t+BaG7ZWNzmhAnb13V0AEQb0YClVnreY/gDLAzgWo+WTX2EkalWOi815F5nddmsls=
X-Received: by 2002:a2e:3c06:: with SMTP id j6mr68159lja.495.1623352651424;
 Thu, 10 Jun 2021 12:17:31 -0700 (PDT)
MIME-Version: 1.0
References: <214134496.67043.1623317284090@office.mailbox.org>
 <ea01f4cb-3e65-0b79-ae93-ba0957e076fc@kernel.org> <ba06e4f5-709a-08cc-0f62-e50c64fc301f@mailbox.org>
In-Reply-To: <ba06e4f5-709a-08cc-0f62-e50c64fc301f@mailbox.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 10 Jun 2021 12:17:20 -0700
Message-ID: <CAKwvOdkpce5kjqXg_Gr8LAzqh3pZt+uJUn348wk2nESvfjB5JA@mail.gmail.com>
Subject: Re: [PATCH] x86/Makefile: make -stack-alignment conditional on LLD < 13.0.0
To:     Tor Vic <torvic9@mailbox.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 11:39 AM Tor Vic <torvic9@mailbox.org> wrote:
>
> Hi Nathan,
>
> On 10.06.21 16:42, Nathan Chancellor wrote:
> > As Greg's auto-response points out, there needs to be an actual
> >
> > Cc: stable@vger.kernel.org
> >
> > here in the patch, rather than just cc'ing stable@vger.kernel.org
> > through email.
> >
>
> Yes I misinterpreted this in the sense of "put stable mail in CC".
> So if I get this right, I should NOT put stable email in CC, but only
> add the "Cc: stable@vger.kernel.org" tag above the "Signed-off-by"?

Yep, just above the Link: tags would be perfect. Don't worry, you'll
get the hang of it.
-- 
Thanks,
~Nick Desaulniers
