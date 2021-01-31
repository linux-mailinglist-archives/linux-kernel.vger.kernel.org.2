Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80508309F3D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 23:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhAaW2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 17:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhAaW2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 17:28:09 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBD0C061573
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 14:27:28 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id rv9so21320564ejb.13
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 14:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nsJ8S4pOORlR6TnIUl3ajB3WIZcMJZts3LO/zS/RiX8=;
        b=e9/kS7h6MQCTaBQU1Ypx5WerBItvVZ2YF3kVY0AakOAOxpWa7lJAQJArFc6eUJuiT5
         D/Kg1etTw956Vxk2UfRHBhuL+AQiOGqd6uoG+QJltg/opX5We+l3EkZ9E/2EEF3IotLn
         luVRY9sKpopuVnzOC0bW/wXT60dUauAXjXK7ienQhGYdGyFNWF3/2Li1iWOKtgHqyIKz
         ig94sTGgSRWU3l7sg356u8sXV8yKXxqminySEU8dZfXBk5Gj+9TOqPmWMvGBoqneO815
         a0zQQeTKwSjvh5xgQhPMT1xJLV8sTU3idKIzOJ3eEb6oP8U/hw5bLvYGargRXI7YsBkY
         fEgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nsJ8S4pOORlR6TnIUl3ajB3WIZcMJZts3LO/zS/RiX8=;
        b=g89tGBxM6hW73LPTFj1xGnXgqZ2ygL5lRCZ/fXnCwkG0ZRj5WHIgBBTejHj8LUwrdE
         bGxezIJQIGiR4/sWUpSFJAApn8BkkT1QCGYo3OQP6EC+CP4BhRdPltw+tHCpw28payaO
         IT14KyBJdqc+I8BAROCmolSl2qyqVuM5P5/8Gwa4Ro7nCta592g5IfviWuV6tm0ch+Mx
         OJ6cOxFxsVpsVVsOuLaR0ft8oSLEHMYp336JVNsY6Tx6F2VXZRjiiTP34qurR8ECuNDb
         UXWKa7oGxRl4Qokpu9Gs9N8LawICHJJbAOP/mIyV/e+ylif7jMWxOs+cp2T7pukEetA1
         E/jg==
X-Gm-Message-State: AOAM533KwoG62Qp84vKFeqhhEn4HykvBNtSlO+LS5PFcguNhlu0zQqMP
        x32AEs9IE5EOBg8hyAi5fgnq9O7S3Y7yObtgzPGJeA==
X-Google-Smtp-Source: ABdhPJyOri5VjqsCyn5cYc/3yvayW+WBRXXsqjjjxiRJVySzILQwICiAKnxA6C5z9/6imncg9qZxP5Z6ACRlGSF3rh0=
X-Received: by 2002:a17:906:24ca:: with SMTP id f10mr7704141ejb.96.1612132047507;
 Sun, 31 Jan 2021 14:27:27 -0800 (PST)
MIME-Version: 1.0
References: <CAP045Ao_Zb0HGg0=bvUeV6GjX=-3fz0ScsvM_jE7VsZcVk_-tg@mail.gmail.com>
 <C479ACCB-A1A5-4422-8120-999E8D54314B@amacapital.net>
In-Reply-To: <C479ACCB-A1A5-4422-8120-999E8D54314B@amacapital.net>
From:   Kyle Huey <me@kylehuey.com>
Date:   Sun, 31 Jan 2021 14:27:16 -0800
Message-ID: <CAP045AoMRNjvVd1PdHvdf-nn3LNpTDp66sp+SAmZgNU888iFQQ@mail.gmail.com>
Subject: Re: [REGRESSION] x86/entry: TIF_SINGLESTEP handling is still broken
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        open list <linux-kernel@vger.kernel.org>,
        "Robert O'Callahan" <rocallahan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 31, 2021 at 2:20 PM Andy Lutomirski <luto@amacapital.net> wrote=
:
>
>
>
> > On Jan 31, 2021, at 2:08 PM, Kyle Huey <me@kylehuey.com> wrote:
> >
> > =EF=BB=BFOn Sun, Jan 31, 2021 at 2:04 PM Andy Lutomirski <luto@amacapit=
al.net> wrote:
> >> Indeed, and I have tests for this.
> >
> > Do you mean you already have a test case or that you would like a
> > minimized test case?
>
> A smallish test that we could stick in selftests would be great if that=
=E2=80=99s straightforward.

I'll look into it.

- Kyle
