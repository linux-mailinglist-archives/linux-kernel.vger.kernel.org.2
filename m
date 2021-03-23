Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23EA7346617
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 18:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbhCWRPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 13:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhCWRPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 13:15:37 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB60C061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 10:15:34 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id bf3so24364314edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 10:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7kxlgEcdUFm8TUBbNBULfXqJU2RwcDNLA6hcE2ptw0w=;
        b=j6rZ/jWRRorU6MnJ1POUaoTUoIvmuU9L8aHPP375ZeeE9hm17hlauPiZHM33jDAdlW
         gXq7W7g9kBFPKfgjXQsJ1j+uZpr4//rfbhzWOETd+uHTQurq1+v/bCxar0qfHhDQU/TF
         hDnRGOOoN6q+sLFClGlSQQD4kqGj3itv+ZCTTzAVzuWYuwr12hP9/luEEIwKeqqM77nf
         lhbqaltTKphNRKiS5sWp90nWZe+WONQjIxzxqvWR8AeFOgygMiqpqXEOYZSLNO3domdl
         Q254+qJNJqBYF4yFiCvJZ8RYVkMVh0YUZmq5clU5yJRpsWbqDoIbj0IQMtzseoiFjIsu
         U8Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7kxlgEcdUFm8TUBbNBULfXqJU2RwcDNLA6hcE2ptw0w=;
        b=G40poaeG0dF1CYDj1LQvMNIyActm9b8fcv2I10Us201HF5M9dRez6ybR2I8j4wkM2A
         FIcns3RuBEQuUAmTBVtHzd0HQbUe/pR+92Y4w6lIhKMk+zfJuSWMP904qsoJO62AiZPR
         EU6OJP/heQu0rZJw6/Zks0nLwziKxVS29CR/DhXGHdQ7FCIHwWeyfuKR7upM/wQDT2Jo
         A9py2MlXwavLDrYxgA/1N5i8it7rDFMeZd7noYZAH7UN6z4rcYqloomRpbqHMGbqlhb2
         S7Ju99oXcTLCz2002mgglzcS/R74iylxryLLxPc6r9F1ziRAtRwqDz4H+MVodiI8Cd8h
         hUHQ==
X-Gm-Message-State: AOAM530cJr7g2cWs+ATTGQlnMeisjetSRMrO1oI3qlH3UuYsMca0/6fx
        EWNCARX7J9tbgBAHpjj11VFXqvFZRUo=
X-Google-Smtp-Source: ABdhPJxxzKOGkL68UUv1sR0lG3OR7/Z60qmaPR2XUHpylT+ECh320vbqbd2N+Xo8veCozV4gKyEv7w==
X-Received: by 2002:a05:6402:14cc:: with SMTP id f12mr5825876edx.19.1616519732724;
        Tue, 23 Mar 2021 10:15:32 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id f9sm13015606edq.43.2021.03.23.10.15.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 10:15:30 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id e9so21579444wrw.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 10:15:30 -0700 (PDT)
X-Received: by 2002:adf:fa08:: with SMTP id m8mr5149878wrr.12.1616519729613;
 Tue, 23 Mar 2021 10:15:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210323125233.1743957-1-arnd@kernel.org> <CA+FuTSdZSmBe0UfdmAiE3HxK2wFhEbEktP=xDT8qY9WL+++Cig@mail.gmail.com>
 <CAK8P3a2r+wjJH3NsHf8XDBRhkbyc_HAbNtizO3L-Us+8_JC2bw@mail.gmail.com>
In-Reply-To: <CAK8P3a2r+wjJH3NsHf8XDBRhkbyc_HAbNtizO3L-Us+8_JC2bw@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 23 Mar 2021 13:14:51 -0400
X-Gmail-Original-Message-ID: <CA+FuTScvHD4fTfhzd42hPk_bLPUk0GtbVtq-TZ0=RQerztipBQ@mail.gmail.com>
Message-ID: <CA+FuTScvHD4fTfhzd42hPk_bLPUk0GtbVtq-TZ0=RQerztipBQ@mail.gmail.com>
Subject: Re: [RFC net] net: skbuff: fix stack variable out of bounds access
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexander Lobakin <alobakin@pm.me>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Guillaume Nault <gnault@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 12:30 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Tue, Mar 23, 2021 at 3:42 PM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > On Tue, Mar 23, 2021 at 8:52 AM Arnd Bergmann <arnd@kernel.org> wrote:
> > >>
> > A similar fix already landed in 5.12-rc3: commit b228c9b05876 ("net:
> > expand textsearch ts_state to fit skb_seq_state"). That fix landed in
> > 5.12-rc3.
>
> Ah nice, even the same BUILD_BUG_ON() ;-)

Indeed :) Sorry that your work ended up essentially reproducing that.

> Too bad it had to be found through runtime testing when it could have been
> found by the compiler warning.

Definitely useful. Had I enabled it, it would have saved me a lot of debug time.
