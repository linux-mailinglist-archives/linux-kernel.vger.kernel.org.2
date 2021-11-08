Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40BF0447F33
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 13:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239359AbhKHMD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 07:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbhKHMDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 07:03:55 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA03C061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 04:01:11 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id i11so7349119ilv.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 04:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dC83MVqdOwYHKUmkxexdi7cEBwi0X0cH6p8fdWvRzn0=;
        b=S79vnFctVitgbPO/JQkEJ88Rlowunqpf/9YfQu6KElHAhaFAW3gP1i2TOfQkmUnXPW
         td62XmG2rpRBAAw71GQybrNxuxUppJkkiTDf9tnjfJr+XSr9UAml4umUNkxa1hmanqxj
         8MrrTFAVpu/L7tBMVNGNniqYxPq40/BoIK0P+NH8I+Ci2DxeZUxGyN13hLKT1xaI8Lbm
         aozfDfRkLlk70R1S3qjd5PJLWsQjiItFogq7K9QdD0lV01FAAhSbL4xfRDzGBnNVR4kh
         8dz8z7pRSFs8f7Uy7Jbaf+nqpaEaV5mkm0ETK8gqQ+n7bLNSCaBlgukq86ZLDLgtkE+/
         34QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dC83MVqdOwYHKUmkxexdi7cEBwi0X0cH6p8fdWvRzn0=;
        b=zDaFwELkJ2fX0o/kLb3T6sR/tuUT2NEiO84qxk2QXONvB7hPjmY2EI2mlPmoPf2WEe
         ZIAPgE3zbSV3fc1vE9W9XoVM0gNyK3ZMA2jDGBB5eRY3Q003uBEYQH1raSQxpxUGU3PI
         tLg2cwrCCE5K68jukIg25mIJGfnQu/H1JRqjae1Q3cPZr0A0Xf6sDSmhxx5RL31zYJ1Q
         cByvre6R12nczI71orSKINVCOK4J3s84FdOskG4GbOpep7ktelZQ8U5idtGMjjdTSunQ
         TfnZHhhpPYJFJrbDCtgULq8nu3QhPa7LkX22AadGSmBffySDyzgWZXA7sO89SxqRf6B3
         Hx2w==
X-Gm-Message-State: AOAM531qogekf1S5u6zUJ1dWca35Y3tiW0NJam5Zx5JmZUuUMzboSG+9
        iqxgf+ddLnZavCVWuEpvPsRKwf8wA/2rwbETQeByR+rOIkk=
X-Google-Smtp-Source: ABdhPJwqtK0kei+JnB2wG6eSXP35HsBqm4n8+r8ez45v1pna6qCjRtZIE3dOfRZYCxQ67zYl97gRoT+dG0blcylZG10=
X-Received: by 2002:a92:cb12:: with SMTP id s18mr45175526ilo.321.1636372870971;
 Mon, 08 Nov 2021 04:01:10 -0800 (PST)
MIME-Version: 1.0
References: <20211107150304.3253-1-sampaio.ime@gmail.com> <20211107150304.3253-2-sampaio.ime@gmail.com>
In-Reply-To: <20211107150304.3253-2-sampaio.ime@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 8 Nov 2021 13:01:00 +0100
Message-ID: <CANiq72mzT+bGMgrB1ppHOGu5C5w7oSDe5Sy-CRo-LKJ6Vanxjw@mail.gmail.com>
Subject: Re: [PATCH 1/2] auxdisplay: charlcd: fixing coding style issue
To:     Luiz Sampaio <sampaio.ime@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 7, 2021 at 4:03 PM Luiz Sampaio <sampaio.ime@gmail.com> wrote:
>
> Removing 'int' from 'unsigned long int' declaration, which is unnecessary.

Not sure if this is a rule, but it is good to be consistent with the
rest of auxdisplay. Thanks!

Cheers,
Miguel
