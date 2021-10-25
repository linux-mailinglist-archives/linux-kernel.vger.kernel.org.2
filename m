Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95337439280
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 11:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbhJYJhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 05:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbhJYJhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 05:37:41 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36685C061745;
        Mon, 25 Oct 2021 02:35:19 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id l13so19877667edi.8;
        Mon, 25 Oct 2021 02:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RSWOPzNpv+gqobr9oD44cMNl/gjPokC+2ZSGAR+LGvc=;
        b=a+5dD8ItWz4O5QFIzUEtGJoJsR951RDBjl81/f3t4cVyOqcgWrgIuY2AP49/K8n6Rd
         /stIXbufTsTrDU495bT0dnLGUXJrdvk7ZKyyH6Zz1Aj1wpHXP378Aj9RCraqP9mTpmbH
         icbT9i4jg/b4/D2yZEL+CWA+P1GecqsnekYdtxPX891Erk5Yn/eoaURCq2EqoISGvEXN
         eSGui04a9h4g/RQgUrqrvK5QLHPw9r7c1inttYrSJ8M2kPLuPSqmZUCSqSVhow53Oazb
         HI7YT04u3ZN+wAY5umc1PrwSY41CFxBRN04uTy6eRoZjbzWP4o+I+b11SILZWht/2ezm
         w2Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RSWOPzNpv+gqobr9oD44cMNl/gjPokC+2ZSGAR+LGvc=;
        b=hsrhv8vuZqVHSjHT18IWA377hzbpU84D3eZRJwoNWFws728YhQkzLNXLe7yNg1CVsX
         kTXwv6K99afq1Jqte+kJI1uUnX7wWDAGJm1X+ZauRhhBdro/3kGsS8BL/03xk1eqrQ5B
         ocJ9kOtguKeW1L5HIztZt95n4TdnH8ZpP2OcxsXnnKd7rc2BUtN63D1hej08oea4p8u3
         3PGjJv4SzPc7Qqom6iMMCFV4AnaUMc7UVksB2ILzKSh4elzr+W28/28M7lFUwI3q399P
         WX7G6pGVemw5LhDfTH2gQeGzC/2B9XDoZOvlgn7w00+vBYvhRQWtsrYol2h6fgrKdpll
         WY8w==
X-Gm-Message-State: AOAM531QPyWfqG1Xj6czZc8TVkOrHDLalGBujVX1/3fcRgUoy1zePadp
        MTr2F84OT5jxKns/r0UfxkZJujPZ1Nt45uIZHBjgfAE6pQFN2A==
X-Google-Smtp-Source: ABdhPJx3+UgXIEBRlA9nUZuUcAiapUMwd/T0Yw/6DynvNGWRM7W9yjJVyzjCBVv6iOwqWGLngTX5Bl78AuEdwya0ox0=
X-Received: by 2002:a05:6402:2031:: with SMTP id ay17mr25638264edb.240.1635154517795;
 Mon, 25 Oct 2021 02:35:17 -0700 (PDT)
MIME-Version: 1.0
References: <20211022200032.23267-1-pauk.denis@gmail.com>
In-Reply-To: <20211022200032.23267-1-pauk.denis@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 25 Oct 2021 12:34:23 +0300
Message-ID: <CAHp75VcvzBoY_avM2r-vQei+UCULU8oEYBdgM6dD7Yr3N69hvA@mail.gmail.com>
Subject: Re: [PATCH v8 0/3] Update ASUS WMI supported boards
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     Eugene Shalygin <eugene.shalygin@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        thomas@weissschuh.net, Ed Brindley <kernel@maidavale.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 11:01 PM Denis Pauk <pauk.denis@gmail.com> wrote:
>
> Update ASUS WMI supported boards
>
> Add support by WMI interface privided by Asus for B550/X570 boards:

provided

> * PRIME X570-PRO,
> * ROG CROSSHAIR VIII HERO
> * ROG CROSSHAIR VIII DARK HERO
> * ROG CROSSHAIR VIII FORMULA
> * ROG STRIX X570-E GAMING
> * ROG STRIX B550-E GAMING
>
> Add support by WMI interface privided by Asus for X370/X470/

provided

> B450/X399 boards:
> * ROG CROSSHAIR VI HERO,
> * PRIME X399-A,
> * PRIME X470-PRO,
> * ROG CROSSHAIR VI EXTREME,
> * ROG CROSSHAIR VI HERO (WI-FI AC),
> * ROG CROSSHAIR VII HERO,
> * ROG CROSSHAIR VII HERO (WI-FI),
> * ROG STRIX B450-E GAMING,
> * ROG STRIX B450-F GAMING,
> * ROG STRIX B450-I GAMING,
> * ROG STRIX X399-E GAMING,
> * ROG STRIX X470-F GAMING,
> * ROG STRIX X470-I GAMING,
> * ROG ZENITH EXTREME,
> * ROG ZENITH EXTREME ALPHA.
>
> Add support to nct6775:
> * ProArt X570-CREATOR WIFI.
>
> Could you please review?

> Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
> Signed-off-by: Ed Brindley <kernel@maidavale.org>
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>

No need to have this in cover letter. But it's harmless, so up to you.

I will look at it this week, I think we can still improve utf conversion code.

-- 
With Best Regards,
Andy Shevchenko
