Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE420309F36
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 23:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhAaWWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 17:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbhAaWUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 17:20:47 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE92C061573
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 14:20:07 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id y10so4651159plk.7
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 14:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=DdYFear2V9dqZ/pu2Vj/ZMYQfCEnmO587YzIQyXHcqU=;
        b=e/QKZmx/86jwKfjB1DheqBkWgBh6jp6V5+zR1dkVZKetF31fnCkLbwTcZu+azbEuON
         6FNWRIKqE5O3YBWGMXVU9QRIATorafVL0r0rvthCrWy/9uIOoPmPnxOglTOtbhYuXfaD
         HVubZLZFAHTFIZXPjFppIWISzcy1Cqyq+5mN1sNsuehTDCGYxA1Tuhsun65twvAtKDnb
         6lvBDZ1miB14euzJOlrleL3OOpn/0pBegZN/X7kWNvwPHiH/zfa0QJYGHI5B4freV2rS
         xoHty+y/b9J5PszeuXpJsfkUUnkb5yGjxAlr24AFYbq5HKLoxKCwB8vTvZfC3yrWgafs
         kwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=DdYFear2V9dqZ/pu2Vj/ZMYQfCEnmO587YzIQyXHcqU=;
        b=ErMzxEz9bQapXoAhdHcmpj849x+gLLJfYMdgufrEAWjEvmGGLOL6kcveT4TJZPwCKH
         NEQjgOfQQC+j/0bnHokLFMsoL7+dnPQ+c4psLiLPaAWcYDlsa2ejvHkSyvTvBqfmaks2
         om+3z9o0qDLGq1q/58qFCY6/T95nQ4im9dYvgZZaw3dSV630Sd+Zht/RNcWdZdQPojYe
         L0IbsH07Ae8plWSlc0vXE04bmHTE7FMy6w0dW5J5xu6cdD8cPxpSRz795APh+iFoRk4o
         C1lsYgRi5tA1veT5ClJPrOVimQ1lIcr77DZAEqbsybo8ZQvP97xgDd9xh+2+M/fDtdHv
         Ds2w==
X-Gm-Message-State: AOAM531PwZpaFDEsQyyDGmf1Vepdd4tnNGrgnVKhvKJowAPAtP97HiAh
        i+feCYgPJrmk554zuAIuCQiPbQ==
X-Google-Smtp-Source: ABdhPJxtXjS7dxE1GXwf/BHWU9mPBZISf14FkZ6jFzSKjQauIG5tEnFrthZs9oDxTp9quWfBcfu2tQ==
X-Received: by 2002:a17:902:b58f:b029:e1:6a9:f744 with SMTP id a15-20020a170902b58fb02900e106a9f744mr15286937pls.1.1612131606700;
        Sun, 31 Jan 2021 14:20:06 -0800 (PST)
Received: from ?IPv6:2600:1010:b05e:e964:2432:9f62:e00b:9795? ([2600:1010:b05e:e964:2432:9f62:e00b:9795])
        by smtp.gmail.com with ESMTPSA id r9sm5853108pfq.8.2021.01.31.14.20.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 14:20:05 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [REGRESSION] x86/entry: TIF_SINGLESTEP handling is still broken
Date:   Sun, 31 Jan 2021 14:20:04 -0800
Message-Id: <C479ACCB-A1A5-4422-8120-999E8D54314B@amacapital.net>
References: <CAP045Ao_Zb0HGg0=bvUeV6GjX=-3fz0ScsvM_jE7VsZcVk_-tg@mail.gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        open list <linux-kernel@vger.kernel.org>,
        Robert O'Callahan <rocallahan@gmail.com>
In-Reply-To: <CAP045Ao_Zb0HGg0=bvUeV6GjX=-3fz0ScsvM_jE7VsZcVk_-tg@mail.gmail.com>
To:     Kyle Huey <me@kylehuey.com>
X-Mailer: iPhone Mail (18C66)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 31, 2021, at 2:08 PM, Kyle Huey <me@kylehuey.com> wrote:
>=20
> =EF=BB=BFOn Sun, Jan 31, 2021 at 2:04 PM Andy Lutomirski <luto@amacapital.=
net> wrote:
>> Indeed, and I have tests for this.
>=20
> Do you mean you already have a test case or that you would like a
> minimized test case?

A smallish test that we could stick in selftests would be great if that=E2=80=
=99s straightforward.

>=20
> - Kyle
