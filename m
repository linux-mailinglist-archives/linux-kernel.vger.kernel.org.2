Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7106440F1E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 16:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbhJaP1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 11:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhJaP1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 11:27:02 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DB3C061570
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 08:24:30 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id d27so6570849wrb.6
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 08:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=19n05qfiW98RVpHOrFkOChis0ARUtExJBjEeqbNaB48=;
        b=KT/evdb/mWK+KSwMDlCs317aUzvSEk35gqa7kNBMlUxM8j/x/nMxMW/6sGndd8w0hM
         pdijaFIFR3rYIFia3difbA/eTYS2Dd2IfqOV8rl/0VGB/Mj/eacovUzv8VpGum286Ut1
         n1XuXp2GdDNvaMBUrgPqiDEU81RdZ1XwbKH8Iby4acoFO65Njkn6LUK1DAKJErV635S/
         gQidVT3i22S7/BZoGH6GSQapknLtqdUkG0MPcynSGD/aEoNvfwsajgcnZCJAqyF43lDP
         LwoY0YoYxn3j+mKQ/yuI74SQFq9J++GVQn91cDxaG7VwUYGgxArgpJAeOa1v7B6BAzAv
         jw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=19n05qfiW98RVpHOrFkOChis0ARUtExJBjEeqbNaB48=;
        b=XTt6qUclyLlWg5UnfjE7fRnv1JO7Ov6WbuxyrcUfcVP32nKOWQkS2/fDiKVjYw+GZU
         6JBvb68Tv8S1vEwFEvBBWCAa3y5xY+uBgMrZAfx90YHdN1aWFJLO7rhDFPTzw9ae0Wg4
         uhp4GsgeuFIT+cp/zQ8Wukw3wE0xoc457Rd/99H+pDTuVK4dGs09V0NQDvemAz+B3ChW
         Vhaf5pTSRPjXw0+i6yYISmwGTxE8koc3fxgX9Sluqj394WemkW5BPIXQ6EZYe2oggaEm
         5J6HBEZPRCF85Oj+UnnE2Pje70bR3m1spzbs23+v+GSFhAf3cAfT9dkQfF9qz9Lr++ci
         dSkg==
X-Gm-Message-State: AOAM531DNA0BZTuSrpHEIINmavA+4qdLMr8NRpUiJwxFV1WVlHfizluI
        WJKahbX2s0MqEyJ+iNYs/DNrUQ4xNAMwV1/L6JZvMoweG8M=
X-Google-Smtp-Source: ABdhPJyVubI0Izo451jDFLBTdnlKkV/sCPtXFoHE5sTmS0iPFH/YePM9+H4bJrtnVWz5ti5kzph6aAlOf7mv3f4Yyos=
X-Received: by 2002:adf:fc88:: with SMTP id g8mr725217wrr.334.1635693868148;
 Sun, 31 Oct 2021 08:24:28 -0700 (PDT)
MIME-Version: 1.0
References: <20211029132700.8552-1-ajithpv.linux@gmail.com>
In-Reply-To: <20211029132700.8552-1-ajithpv.linux@gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Sun, 31 Oct 2021 11:24:16 -0400
Message-ID: <CAGngYiUnYQok=9XUr3wXo5WERTMx-YJeaQUyvYMgbcgLXoX+hg@mail.gmail.com>
Subject: Re: [PATCH] staging: fieldbus: anybus: reframe comment to avoid warning
To:     Ajith P V <ajithpv.linux@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2021 at 9:28 AM Ajith P V <ajithpv.linux@gmail.com> wrote:
>
> host.c file comment produce warning with checkpatch as below:
> WARNING: Possible repeated word: 'interrupt'
> Reframe the comment into bullet points or steps avoid this warning.
>

Looks good to me.

Acked-by: Sven Van Asbroeck <TheSven73@gmail.com>
