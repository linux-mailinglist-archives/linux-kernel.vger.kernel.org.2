Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEEA33230B6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 19:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbhBWS1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 13:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbhBWS1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 13:27:11 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C54C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 10:26:30 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id m22so12725408lfg.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 10:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mBr7UNJqLOGs/lMIuN2650GwuS6Xxag/PiTfvbinhVo=;
        b=YmeFVslLWnkAh0SqA4uyKO/rCf7CecRBmkkYhkHyVOpBgdOeEGi63SnelFBoc+SBVk
         +Wmk2FtUgcKXMvlhy71TueGREd2G+Agn8EotGZZ81Os48L7spam6gnrurcTM8UC27YWl
         ltTJcZjplD3oK+Q11gc9Y4CMWQ4KHJ6wt/+Ww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mBr7UNJqLOGs/lMIuN2650GwuS6Xxag/PiTfvbinhVo=;
        b=VQB8cjjUdLwIv/rRDjN97Yv8q5JQyYUUDJHxw85eCKtZLknqZsMwhRP6uJ8d2bmhkX
         DcuthSDv2Wu+pJ16qtHXOwgnkC0L2vYVsdvZI+5LjLKYDU2RtXNJnn9PsmNYKuEXrfZm
         sAdku6n+x/5cn/I1Y7RgWByevYSbES2fOCBeuSDtJkY1qclfIOCckQW5MDvEHuFtTs5n
         S5vmxhbVjyB/qzQMB/OztkBOej+PNBjCNNgnk5OCQUFroBq3tnIlhV10Y7eXvWHxmXeS
         n5XCm/8xogfuT0pa3/JsnmO5C7+L9weUVR33cynNj0VAWrOOrqkoILAu0s6iOFBRaWBj
         ySFA==
X-Gm-Message-State: AOAM533kmba1wI69N/IM0GFgav+TQ4muCSEG4G0rkKXxZl6oSukQqwBB
        Ghl0jl7i0xaNQfveL0N4+qjx8SnEfAsHKA==
X-Google-Smtp-Source: ABdhPJxA6Rk4ZgFk5nITcQAb6+yFSf8jgK0zX/nhwnu4Ty7VXDsO6Lo2Au4fIX59RbmrxcNCnBRBHQ==
X-Received: by 2002:a05:6512:3194:: with SMTP id i20mr17590307lfe.283.1614104789241;
        Tue, 23 Feb 2021 10:26:29 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id x75sm2764751lff.91.2021.02.23.10.26.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Feb 2021 10:26:28 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id w36so12754953lfu.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 10:26:28 -0800 (PST)
X-Received: by 2002:a19:6916:: with SMTP id e22mr16380577lfc.421.1614104788209;
 Tue, 23 Feb 2021 10:26:28 -0800 (PST)
MIME-Version: 1.0
References: <YDUibKAt5tpA1Hxs@gunter>
In-Reply-To: <YDUibKAt5tpA1Hxs@gunter>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 23 Feb 2021 10:26:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wipCbbXswcFvnrGae01H54dY1+XoaL+9YaiU71zGzko3Q@mail.gmail.com>
Message-ID: <CAHk-=wipCbbXswcFvnrGae01H54dY1+XoaL+9YaiU71zGzko3Q@mail.gmail.com>
Subject: Re: [GIT PULL] Modules updates for v5.12
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 7:42 AM Jessica Yu <jeyu@kernel.org> wrote:
>
> Please pull below to receive modules updates for the v5.12 merge window.

   "struct symsearch is only used inside of module.h, so move the definition
    out of module.h"

Whaa?

The first module.h should be module.c. Oh well.

Pulled.

             Linus
