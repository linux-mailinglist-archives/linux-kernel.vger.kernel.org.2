Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9875F36E977
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 13:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbhD2LSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 07:18:01 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:57319 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhD2LR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 07:17:57 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MhDIw-1l6Zb50hKE-00eP9z for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021
 13:17:09 +0200
Received: by mail-wm1-f52.google.com with SMTP id f15-20020a05600c4e8fb029013f5599b8a9so9033260wmq.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 04:17:09 -0700 (PDT)
X-Gm-Message-State: AOAM532H4md8vAtjoF019oqYzXwPNLdLPhUuqsJuhva57UHDJnhb1x0b
        91M7ZE9JpL66tbtL17NfcepULUR2RoAgJmLsV88=
X-Google-Smtp-Source: ABdhPJyDWoC/ym2DkxTwOlrTJfTfOpX3HwZAlq5h9pUN7MtTX83B8bsWTbCb2UI3t3hqLMGsQ8YVwDxicRugaT+YDbI=
X-Received: by 2002:a7b:c344:: with SMTP id l4mr9631153wmj.120.1619695028817;
 Thu, 29 Apr 2021 04:17:08 -0700 (PDT)
MIME-Version: 1.0
References: <a7fac800-02ae-62d4-00d4-770facff4a7c@rasmusvillemoes.dk>
In-Reply-To: <a7fac800-02ae-62d4-00d4-770facff4a7c@rasmusvillemoes.dk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 29 Apr 2021 13:16:33 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1Cgt+Lx7-CZE5muY+=Bs0PWGvs-=L5ghzEQFx7u9=1bg@mail.gmail.com>
Message-ID: <CAK8P3a1Cgt+Lx7-CZE5muY+=Bs0PWGvs-=L5ghzEQFx7u9=1bg@mail.gmail.com>
Subject: Re: RFC: collection of common distro configs?
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:4Hy4lcRBMh6NFxG3rmjMRa9LhpsRq3fH/ZeoXdU5BHv5wolEiYz
 bvKsNIMSIoqd7bHNpKJVRjETlIlzIo+PA797N88gnuQvKhAT0F+1i8DTA8iQa6ZJxyzCMgN
 zsPztknq70I79FP1RgYjRV0pxON3yYEctyGf+5BhHycyO6OeV7rKnhV42rlM+xRvQmOpt/U
 cTq2RxFAA7jMbYmNDoNlQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:44P/ANmGEyk=:X0BFM8fcGdWhMnJw0MpzCx
 F7HNgFlr7KPsIJqgBPMds6BTxNkxKmlyk6Dh4QfDWB6L0Tscm+adl6aCf+Uy8iZpbcdOHv5wS
 wSZhOo7CZ419q+Zx0Ow0YxKwMedfHqkivZM1YSMsoCHzHias+PFpgnVFzhaMkMW2aWeNOmnFd
 sOz3FrXOTYWjcF30+1ckQuo7bk6+rwvxNd0HLA1GMLxpX7HuQh6dZKMvYmtJDwhP/0BQWupg3
 7e8GsNfAZ00ftZYBjYor0jg/c1FRp63vvbWwbaoOceATMLt/G553y4AFv4zE0JsyJO4KHlnaM
 vAuBu38ilvRTHstg+umU9nqarrPO17cbt2fHC7p3+K2pzdilh0tC6NT2ErZoYBKnCdvYeXuAL
 Jsf8A+4KNP/vSWUp1ZKrQEBVHMjA5lnF4QBTqsJ00kCfHpMG6kQFm0cQPvnVM0pwtJgzySVPz
 6hjSHYECVvKrGWltGiWzIK+qT3bOdM2GSf1yWDrPBcpeGPpUpeNtl+EBun1REhZCn/OAgAvjk
 8vdBosdQBuy3dJUAbhZTKo=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 12:26 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> Hi there,
>
> Does anybody know of a place where one can find a collection of .configs
> from various distros? I think it might be useful to be able to grep
> around to see what features are actually enabled by which distros.
>
> Based on the domain name, I hoped linuxconfig.org would be such a place,
> if so I cannot find it.
>
> If no such collection exists, do others agree it might be useful? If so,
> I'll be happy to throw up a repo somewhere and start collecting them.

I've looked for this in the past and couldn't find any, and I think this
would be very valuable, but it also sounds like a lot of work for you
to maintain.

Another thing we had discussed previously would be to check in
distro configs into the kernel itself in some form and have the distros
only maintain the diff that they would like to apply on top, in form
of a config fragment.

     Arnd
