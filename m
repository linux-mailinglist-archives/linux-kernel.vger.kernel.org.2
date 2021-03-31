Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F94635081C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 22:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236522AbhCaUTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 16:19:04 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:59709 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236553AbhCaUSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 16:18:39 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MuDsZ-1lkSbA1qrl-00uZkV; Wed, 31 Mar 2021 22:18:37 +0200
Received: by mail-ot1-f52.google.com with SMTP id s11-20020a056830124bb029021bb3524ebeso100531otp.0;
        Wed, 31 Mar 2021 13:18:37 -0700 (PDT)
X-Gm-Message-State: AOAM532YTjJR4P0wQCsc16/sXbP1+nsPcuC77jL2isqOvkqVZxUWcLto
        qxbu6h08ZoS3vKoEvete51s6daWL8JfWTppBAJk=
X-Google-Smtp-Source: ABdhPJxsRxjHsGwWskqjS7tzLIlp3wnwgZmfEa2JmwdgPjoYnabwcBS4iIlqtbA+/XRCvJrTVW95ZXyg5/XzYNShilc=
X-Received: by 2002:a9d:316:: with SMTP id 22mr3936070otv.210.1617221916064;
 Wed, 31 Mar 2021 13:18:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210331014603.2496983-1-danielwa@cisco.com> <CAK8P3a1rbGPxjRiUTy3AKh4S9jqxk=SHoa9s0Z-3nhgQb3xJUw@mail.gmail.com>
 <20210331175709.GE2469518@zorba>
In-Reply-To: <20210331175709.GE2469518@zorba>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 31 Mar 2021 22:18:22 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2ANBD5q-J+Mr0up+wFBdWJG3Z2ceUP=aB29G7WMq1Z3Q@mail.gmail.com>
Message-ID: <CAK8P3a2ANBD5q-J+Mr0up+wFBdWJG3Z2ceUP=aB29G7WMq1Z3Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: Add support for cisco craw64 ARMv8 SoCs
To:     Daniel Walker <danielwa@cisco.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Olof Johansson <olof@lixom.net>,
        SoC Team <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Ofer Licht <olicht@cisco.com>, xe-linux-external@cisco.com,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:2b6oZ9fX3mI70piTo9N8a2OKF3xHZKgQ7GdVJfafpb9mUX+UCR1
 +QQEDI2m+njUmbgwIW7uKwwLRURyM8yvXRcgZgOVALt/p1CVSDqMNUPh92zwZXL02ngSR9x
 ThTfFuqpM6aow+XlbOa9P1tN4p+6e3/YCEYT9w5ARp+B1wpYeMJac+r2ppaeCCI8DeoTAai
 St5a0gzjVD66YQ4g9r4nQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tt/5YC3mqAA=:tXtYtGN+sJa5uV2UEvgwcg
 h9HT4eV3AC7x7BAKayC0PjipO35ArGCgj8Smf5UZZ5tekg5Idi1CRjpqJ3APyFkrSwbWY9tWF
 pIfyRFVQV3+ElXCgEoVhWWE66TSuvInrvWPIMpn0StTyIgELGToIH8o6UT4PJ6ph/+KF5c9Z1
 PUFlE4tPXL1MJjf5JH133rjZGXoGEZRYD1SEMfEcfRTB6ZJ4i2GqGXJyQTZ5U8329eq8cZ7ji
 +OQBvOC7W5PbmgUZ76cA6ZXkJarV5I5dz/YsXwA+sTN71XPH/NPJOOBPmnM+JpZOtqs/ujlUR
 Cg3ntR+4hgKas7VhQWWpAnnurTS4ntwGCL0NXKehIX2gV5lJwiJacecEG3TRopvxN6wLLC5IH
 SHVedwrcrnHsPF8e5ogYFod4MKiq0YH+ALIBL5DE8f6r5YaGRZJw+Fy0b2V2N9FA7/vAONYiy
 PiT/FPWvuOCZLLKCODzs4kt1sTqKmjueFp/1dK2IHTapbXjqt27DFrr6/M4vU6CcSmn54NC3b
 ZvxWs4csQxAcisiGs+rTAsTKHSzZpXUVd2mW8WBocW9hxDlyRbXAFANN4LBc1p1Jjb0LwCTk0
 P30xjHQXyt6Xp/al6nPbXLLmg/ty8bryE/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 7:57 PM Daniel Walker <danielwa@cisco.com> wrote:
>
> On Wed, Mar 31, 2021 at 09:04:15AM +0200, Arnd Bergmann wrote:
> > On Wed, Mar 31, 2021 at 3:46 AM Daniel Walker <danielwa@cisco.com> wrote:
> > > From: Ofer Licht <olicht@cisco.com>
> >
> > Thanks for the submission, it's always nice to see a new platform
>
>
> > > Define craw64 config, dts and Makefile for Cisco
> > > SoCs known as Craw.
> >
> > I'd like some more information about the platform, e.g. the target
> > market and maybe a link to the product information.
>
> Our SoC is produced as an internal product. So SoC specifications aren't
> widely available.
>
> Here is an example of a Cisco product which uses this SoC,
>
> https://www.cisco.com/c/en/us/products/collateral/switches/catalyst-9200-series-switches/nb-06-cat9200-ser-data-sheet-cte-en.html
>
> I suspect that's not really what your looking for tho.

No, that's pretty much exactly what I was looking for. Just put this one
sentence and the link into the patch description and it will be fine.

> >
> > The memory size is usually filled by the boot loader, just put an
> > empty node into the .dtsi file
>
> Arnd, I must regretfully inform you that Cisco has a deep dark addiction to
> bootloaders which, are, um, how do I say this diplomatically, um , brain dead.
>
> You have some other comments below related to moving things into the bootloader,
> and I can look into it, but bootloader inflexibility is wide spread inside
> Cisco.

Ok, no worries. If the bootloader can do it right, you should do it, but
this part is not essential.

        Arnd
