Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 194CF351425
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 13:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbhDALEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 07:04:14 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:52181 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234000AbhDALEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 07:04:02 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M5PVb-1lQYCr46bN-001UKe; Thu, 01 Apr 2021 13:04:01 +0200
Received: by mail-ot1-f42.google.com with SMTP id h6-20020a0568300346b02901b71a850ab4so1742097ote.6;
        Thu, 01 Apr 2021 04:04:00 -0700 (PDT)
X-Gm-Message-State: AOAM5332uRNNpVLBqeGcHCgl4CPMAH6cKgNq5iUjXyhyAEPDMO8sJOEH
        PBaeAPI0mpMSyVL6ShLUwCgp9ZUlzlMT1GTitUg=
X-Google-Smtp-Source: ABdhPJzv7NfJJM5P4rtmBV6imKoE6SXOGcuNPsyG7xm5vTrhAebddjzZDciuJMsX9IJPq79khP0o2GXRH+qVT+juje4=
X-Received: by 2002:a05:6830:148c:: with SMTP id s12mr6614473otq.251.1617275039517;
 Thu, 01 Apr 2021 04:03:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210223061830.1913700-1-daniel@0x0f.com> <20210223061830.1913700-2-daniel@0x0f.com>
 <1614108850.540354.4116103.nullmailer@robh.at.kernel.org> <CAFr9PX=h2JPdAwjYS2849ufH=wnxSti2Dj60fbq4bg8b8=xy_g@mail.gmail.com>
In-Reply-To: <CAFr9PX=h2JPdAwjYS2849ufH=wnxSti2Dj60fbq4bg8b8=xy_g@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 1 Apr 2021 13:03:42 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1L62YT1WUxmmfLNmvERo7DbeVwfCHCxuKvxs7Uap+iXg@mail.gmail.com>
Message-ID: <CAK8P3a1L62YT1WUxmmfLNmvERo7DbeVwfCHCxuKvxs7Uap+iXg@mail.gmail.com>
Subject: Re: [PATCH 1/8] dt-bindings: clk: mstar msc313 cpupll binding description
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     Rob Herring <robh@kernel.org>, SoC Team <soc@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Willy Tarreau <w@1wt.eu>,
        linux-clk <linux-clk@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:VYITO51LBE9r9PCcrCD8PAJtMuvCJtiQ2yotVDhuUgxbaS6ogPD
 K+omwmuiJtgYAxermfB5znfB+aAlZeqDNkeY/rqSfRjcjMJs5bXk+yRyxpgut1FgCpQnTIo
 R4+4zD9cmOC4CAa0CVtnvha17jS5efA58K1S9tqXxRwKdjXvKabcXMGC/QkWo5zTVvAxjN0
 tExHTxZbz9BIMtSJm2erQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:zRn54HoKq6I=:v79/lefLgMBPzWuAVUpQqi
 SkB5xaungZs1NOZECnXq0moEiHqVwPLvcaiNfLxkhqns3VhD26eggo4R1PjgypbjdIYWsgzDq
 yHepV8HuZHFzBvQ1ujDIqgelCqAx4dEfbnSU2VTb2+ZBasv/PfoW1amqL+p4UIgxEfKyvleL8
 Vlh7lgIjOtjuZuoncu3laK0sCSApsxcpW56Oq4B9K5m8w1tZafLyt/sTMKUwy9h83XnnbQ8yR
 6U+r20DselenS63vh3efm0Z25EYKZKhsOykIvoCQ7UBsgUX5kz0NYV2vEZaxdKnLVrpVjbwj/
 a1NhAbP9L1o+lFXUwTorOMEjXYpjZ+ClH8vwWxT4ecsfFXKjWbxFK5uZN+3vkUgCYyt8utQQ6
 Bj1+BHMVs9gbKDa9znS3pPGuRo/cnZZ/ltljZ14DfOQRcdVDjVeXyV6xVJ04vmLHPmMoRak4t
 /4HP919OpB3hm31LRraIvZgDIsJ7a0M=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 12:31 PM Daniel Palmer <daniel@0x0f.com> wrote:
>
> Hi Rob's bot
>
> On Wed, 24 Feb 2021 at 04:34, Rob Herring <robh@kernel.org> wrote:
> > dtschema/dtc warnings/errors:
> > Documentation/devicetree/bindings/clock/mstar,msc313-cpupll.example.dts:19:18: fatal error: dt-bindings/clock/mstar-msc313-mpll.h: No such file or directory
> >    19 |         #include <dt-bindings/clock/mstar-msc313-mpll.h>
> >       |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > compilation terminated.
> > make[1]: *** [scripts/Makefile.lib:344: Documentation/devicetree/bindings/clock/mstar,msc313-cpupll.example.dt.yaml] Error 1
> > make[1]: *** Waiting for unfinished jobs....
> > make: *** [Makefile:1370: dt_binding_check] Error 2
>
> Looks like I sent this too early. I will try again later.

I found this is still in patchwork as not merged, and I have not
seen a replacement. Marking all eight patches as 'changes requested' now,
please resend.

         Arnd
