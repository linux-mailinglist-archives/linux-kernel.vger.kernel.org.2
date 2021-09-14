Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB5E640B5DB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 19:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbhINRZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 13:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbhINRZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 13:25:46 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDEA3C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 10:24:28 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id h17so11008834edj.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 10:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EGRPFgoAwi4AvXS75+7qSU93iD+OaTNIU+GyjPC/BlU=;
        b=KE6BCfdmrHnbCw4KivnyDYC3bfsky6Y6SeLsyBAp3AN0b+uaHSJxSnsmrK2YAtF+fi
         DH5INupOzneqTyCVgO2YBr/2un9+mPXGALyPILv8Uf3R8KalHSirt2XsMi6NzpwEOR4S
         OywKlTzRc6rB85nY9vMNmUxUhph62CP+yGaXeuT0j9v1EDJQV8jmUOI/+KGYlCTyKjzh
         Zk9Ls973N2S4pSbkeGrEpAfLVSG7suT7IwK7GjsdpSsrcGwh5OK3rrIJi2JVGuK6Goub
         0e61X+Jjnid7qEMUi+jzoe+LQ7n3yh4oGWgGMWAIFaecAmHQMSmgEHzFYnJuNXvX0fEp
         9tIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EGRPFgoAwi4AvXS75+7qSU93iD+OaTNIU+GyjPC/BlU=;
        b=Y4wdk2JLhDKOCfZCumJ3SKErO9UMWjLQlyYKZyrgQawY8BuLWdsN/TIG4WX8Z2Kkw/
         xH5h20I3iZCoLBooBQwc2wZLm4508WiLuq6EAhfOX9NxfJ4Z2/rG3rEXHa5+7OhXeIZ7
         Q7/J7c7Mp986osGeOfUq60ki9MMVycl5GRJqYs4hOI/H907711LndT62AgCMrJlW/hXj
         /cwYrj/nAW/+vkemoOB6SEodCojSbBs6y2HcA+NUEC6+BzMuDyz5sK0AF8+ss+KzgQ/A
         Q68MXDAEM4swlXzbaOHVg6oNxUJ4r+M/Kyrh7xheHKX9eGTWHQeLLct2FNB4roRgUKg6
         19QA==
X-Gm-Message-State: AOAM533IV87aa836OjXhpllHg2X4LLUag4j4jlQnRaXrG4xDusD/Hngc
        WpQCZOk8mvhQTnbmxDUUxeWCceglfj5qXqwnphc=
X-Google-Smtp-Source: ABdhPJyzqoBsNhtNjKYHRSRkd5KA7l/L5E+Z2/ap7lQ7sj/n1gnz/LHDPTXzZ1kKJbUtTq26vq7m88pKBLc8SCMkFdo=
X-Received: by 2002:aa7:db87:: with SMTP id u7mr20535016edt.92.1631640267390;
 Tue, 14 Sep 2021 10:24:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210912025235.3514761-1-linux@roeck-us.net> <315e4a23990444f585a15d2e23a39b8f@AcuMS.aculab.com>
 <46f59bf8-f243-b65c-07b3-8ecbf7b410fa@roeck-us.net> <CAMo8BfLOhr8Gw9RbSM_pVhgokDcBZ3PgwQAG6sCxDBAm_rMy7Q@mail.gmail.com>
 <a34cac4a-dc17-acf0-f24e-69c06217adb6@roeck-us.net>
In-Reply-To: <a34cac4a-dc17-acf0-f24e-69c06217adb6@roeck-us.net>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Tue, 14 Sep 2021 10:24:14 -0700
Message-ID: <CAMo8Bf+rFk_CJiUOdQC5yLuMT+y-awgS9MSx0g3-DqLXYEeX7w@mail.gmail.com>
Subject: Re: [PATCH] xtensa: Increase size of gcc stack frame check
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     David Laight <David.Laight@aculab.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chris Zankel <chris@zankel.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 7:02 AM Guenter Roeck <linux@roeck-us.net> wrote:
> I still don't think that those stack limit warnings (now errors)
> will ever get fixed. Which is the point I was trying to make,
> and your observation that the stack frames are really that large
> because of KASAN just makes that argument stronger.
>
> Other than that, it is not my call to make that to do with this
> patch. If you think that it is inappropriate, by all means
> reject it.

I like it, also for the reason that with KASAN enabled
kernel stack size on xtensa is 4 times bigger.

-- 
Thanks.
-- Max
