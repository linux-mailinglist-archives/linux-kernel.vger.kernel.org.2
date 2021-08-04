Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E667A3E073F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 20:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240049AbhHDSKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 14:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240015AbhHDSKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 14:10:06 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216CDC0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 11:09:53 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id r1so2472260iln.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 11:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ral1ZU11g69msFJZlb1AivOjbzPYxaeW+eku+0mRJ1Q=;
        b=ZdpCifRsCW6GB8eOi9zm4n9aiu7rUAmMgdDIQanh9nsmMQb/RAGRmrE77owCgMJj4m
         Z0iBbtCVfh4snh6bBno2aqNo0/5+bYsX6Z2kRoVe1YNrqrwpuvTveBmp75auLTyRc+WG
         L2d6NrzzvBXmZtkY/jZyETVffjtWsz28PsDMdM9wT2aYCcDUe7fJwVW6gbtZtXvSrsmv
         VEUs8ofuNWsyTHnXw18L6zG5iz45tmP/FjvlNEKTXJmbcaPdZ14hMobjpKgZufdOJz/G
         YcXoRXon/4tEGt+mUuCgpUKg3gYOhqOkTTvidnlTSQp4vr9pMDprEQ23eLrYm+E3RnP5
         OofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ral1ZU11g69msFJZlb1AivOjbzPYxaeW+eku+0mRJ1Q=;
        b=W9xoDTn5cJQiXwQi4jRh2pmNXFauVQtRklp41aknNrZslrQeYccgDamr1U7/B3xXXc
         GpF+Y8G2gmTvy8JAPNcNCSstV27jfqSIDFxC8o315cC5nMaHxjm9z3B4arZmZw73YeM8
         iTuQ12LZbiN5FK0f9JlFJDBH1n0nW6Jw0gmNL1VkPJ+nUWcLzpa9O7fXMcGWZzkfOfQY
         0cHBN3cBtJYHRV2H7wePkqztrw5CT5G5Ci4A0BTBLQvFvmbYs+H/BTcY0jKCVtvD97Kg
         5xDjZjaccoXFeyzJ+70XlF4kFHIZRHPTvTGK0u6iH3pCG6AOQes0qGoxaCRxYW376eT0
         nAtA==
X-Gm-Message-State: AOAM5327r21eqiGdkRG3fQvHQUvLed05BUFyN+EkUIgHQ5VBipNsH6Rz
        WLytpLrBEwh4c5IOvKzHT3xX77LN+IS4RTgm0d8=
X-Google-Smtp-Source: ABdhPJwWllpY0T39LJXhCw/0U7yenBQb2W5YEsfggwvJnDY/A2UR5PGwFzPYwZOD5vS+aS78JdsFPrFpdwUufn9pZGY=
X-Received: by 2002:a92:b74d:: with SMTP id c13mr695593ilm.176.1628100592598;
 Wed, 04 Aug 2021 11:09:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210720181542.2896262-1-ndesaulniers@google.com> <CAKwvOdkdoAadmOt1w2cE4Q5rOM48qPt3_WgkSkhxGVsyVV6U0w@mail.gmail.com>
In-Reply-To: <CAKwvOdkdoAadmOt1w2cE4Q5rOM48qPt3_WgkSkhxGVsyVV6U0w@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 4 Aug 2021 20:09:41 +0200
Message-ID: <CANiq72nxUxYLOu=O785rgpn-1bRw=sBC4hH1Mg9+Ofq1xfiyYg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add Nick as Reviewer for compiler_attributes.h
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 4, 2021 at 8:00 PM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> Bumping for review EOM

Applied!

Cheers,
Miguel
