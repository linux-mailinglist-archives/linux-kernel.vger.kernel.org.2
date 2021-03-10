Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 636823332B1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 02:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbhCJBRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 20:17:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbhCJBRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 20:17:43 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272D8C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 17:17:43 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id m22so30545659lfg.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 17:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a13kYin//Z1Uu0mBwEjZfHHvzWPjQ9yqWl+iSWde6Xw=;
        b=CAL9qlfmA4i7sZIwO00pPz1JRzgj2hwsui/qlV72baToSOmv6zFT6FPa15cuKcOe9Z
         enEm3ob5EDI4NU0Ipb0OpUMgYUU+J75AtbgiItNaNKJnfXzEBJIBscxnH89AXxoHt3Uf
         ZA/Jj3HcAaL++BrkMIo284txFsXhlPb2wnFjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a13kYin//Z1Uu0mBwEjZfHHvzWPjQ9yqWl+iSWde6Xw=;
        b=hG4duq6JkyHqaYd7idQ2Oczl6uyomt5R+P2l1P1+0lPWB7gw9s/Y7zUD1oauu8imk2
         kaYnr+pXjOEq1lguTBoFpS1flmnXR9h05cYtWvDhognIhiz9fPFxPStwmrntl0DNIrAP
         cboDi85FgI4vmycWCjLvTxy5XbDELfrzyXSPCs2xyCIFlFOOifXR+iAWssVvFJyg4HC3
         o1ehVL3zGaaAB95Y5UIUdytcyjtzwmcaflXv3+otCS9cZFvXZ7ZwXy3EWgLkQb5n6frD
         I14a099EfwhvSCaeDlOT+IlU0Q5jLFNJ4OlL/0jaM2MXTZHT37XoUDmeAZjT9kvgy1dE
         esRg==
X-Gm-Message-State: AOAM530m5/rKYbS/0J4HJ26r6QKYUaSlOPydx2HLuhV2IEFZGQDU+bgM
        BYdECiQvicocN2WjZocyQZM0rwq3cC06qw==
X-Google-Smtp-Source: ABdhPJyG7hrXmqmoE1bYUBw2xcpZP3E5eCiY9zgfmwSsiwgtbbruA5kufQKQGQXaV1rJlQGTizNBqA==
X-Received: by 2002:a05:6512:3194:: with SMTP id i20mr477367lfe.283.1615339061380;
        Tue, 09 Mar 2021 17:17:41 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id v20sm2064679ljh.105.2021.03.09.17.17.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 17:17:40 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id 2so23351897ljr.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 17:17:40 -0800 (PST)
X-Received: by 2002:a2e:9bd0:: with SMTP id w16mr248823ljj.465.1615339060263;
 Tue, 09 Mar 2021 17:17:40 -0800 (PST)
MIME-Version: 1.0
References: <20210309.110812.234617387417457658.davem@davemloft.net>
 <CAHk-=whgiPiFy9Ye_t=fV9J8VdqgZW5XQcb-1z8PgpQbVBWqCQ@mail.gmail.com>
 <20210309.162454.822491855062735992.davem@davemloft.net> <20210309.171540.1612415953102779664.davem@davemloft.net>
In-Reply-To: <20210309.171540.1612415953102779664.davem@davemloft.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 9 Mar 2021 17:17:24 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgvDZRBoWfynXPDOzTTyD7Ms3UzqVw_K1zzd5S2asn25g@mail.gmail.com>
Message-ID: <CAHk-=wgvDZRBoWfynXPDOzTTyD7Ms3UzqVw_K1zzd5S2asn25g@mail.gmail.com>
Subject: Re: [GIT] SPARC
To:     David Miller <davem@davemloft.net>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sparc <sparclinux@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 9, 2021 at 5:15 PM David Miller <davem@davemloft.net> wrote:
>
> Somehow you pull didn't get commits:

Look closer at the pull date. That was before you had updated your branch.

I did a second pull just moments ago, I'll push it out (along with the
networking one), after all my tests have passed.

            Linus
