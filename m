Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B7A40B301
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 17:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbhINP1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 11:27:54 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:48877 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234167AbhINP1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 11:27:52 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MX00X-1mOFSs0K8v-00XMMD; Tue, 14 Sep 2021 17:26:27 +0200
Received: by mail-wr1-f42.google.com with SMTP id d21so13187870wra.12;
        Tue, 14 Sep 2021 08:26:27 -0700 (PDT)
X-Gm-Message-State: AOAM531Bw8nrt96Metxb7d3vMiS7JhYl8fPUuKYf93SWVITPbEWwvALC
        x4rn/J5vXK8nKyYrRUleK73P5v95wQoMvpA4L98=
X-Google-Smtp-Source: ABdhPJx58PLXLbIDPH3agyMnNUczBn+6WHGZgh2cx7ovkyQCQ1tT2E26eQzrosGp+LginhSbFYIKP6merOG8OWf3s2g=
X-Received: by 2002:a5d:528b:: with SMTP id c11mr18953468wrv.369.1631633186700;
 Tue, 14 Sep 2021 08:26:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210910190322.27058-1-romain.perier@gmail.com>
 <20210910190322.27058-5-romain.perier@gmail.com> <CAFr9PXnLZC1zfs4e1GqZU4UU3knU-BwREe0-abrWNq7akrTntw@mail.gmail.com>
 <CAK8P3a24NTmkyh01OEzDQ8=oTWpUnDtwWQgUUxUbW2wxsgAFeA@mail.gmail.com> <CAFr9PXkipBnVDBOpdYhUD4bYNaL8qybPhGJi7YwSHaCNrPz6rw@mail.gmail.com>
In-Reply-To: <CAFr9PXkipBnVDBOpdYhUD4bYNaL8qybPhGJi7YwSHaCNrPz6rw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 14 Sep 2021 17:26:10 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1=GTcgbqkwnzsFtBtFZTtf4Lop7U5hsCAid-fCgs07yQ@mail.gmail.com>
Message-ID: <CAK8P3a1=GTcgbqkwnzsFtBtFZTtf4Lop7U5hsCAid-fCgs07yQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] MAINTAINERS: Add myself as MStar/Sigmastar Armv7 SoC maintainers
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Olof Johansson <olof@lixom.net>, SoC Team <soc@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:VnVHxWypdRtpTbbOUa3/mrs9CuHe1McNGJueNVuhoFnIryByfgv
 gnhVwKUfnik/lAGj/0SBJ3aNpwaRx4z5vX5x4GhkU0odrAe8BnzBkVrd/WS8EV4ncrzwYQm
 CdASMDKwEIp+zr5sjoRJeELJSW0pfkzUHJ8NxD/WwsnRx+YnIHMTb/wks0+3jJD9OEve6gE
 g4+9KQRv47kfTfUKwG1KA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qjObmYm+w2w=:vN4YTObWx7sfcSi4+rQb9j
 Wydj7yVS0y/R447f1vtO0c2rfQBvfCzIwEtw+hIv4QREpG3EJUXuaPZQpe0MUDRXqBmqwcb3o
 lJK+J7M9epXQQVAcQ0BwgZMdBqV7PmufSkek02wjInMAMy8TyC2wN2m4Llv/U+wETnNALqnFr
 Us7FKhJ7Wrmlo2CrKT1nzo4IcPl9ERRqvZNh/JcvvKWAds9EglYQKuK/BRR8E7UxWcu1GHGKu
 EIybfSZdgn8PyfM+Tex/55EoWB1FN/OztrGMr9N0g5T0Wut/jnXq1VkGY3xwoAkCO5lBslSmT
 ntaRX5vMhD+1KXPXkKE5c8yZ3fO4rj+QYb81odICBeiyfhPPvfY9tCbje+l8PhyXWZsT+0bI5
 oKjU8Upekf0o7v3w/HvJqYz17lqdM//oRzhR4rWNrmLJqzR8jK1RqNZI12wfvLIMDtdqiCm0z
 zbrnayozAKmNqpcvus0EPZipIWkIJmePcLobd/3SIkXBCw9nlX+4Qmc6sKDJJzFZfdm1WBjNm
 +FaZFWM/9pebNKZpqChePwb+kDFoHpHi4U4bx7w82+SPCDDnLd7GF1juuFUTCeYFhDfsk6i/s
 UaTe89lD8XDSK3omw9M1fa1VMvyLz2KwvKajuCl5JAN14l/zckp96fdkYRy4mYQOL4Ev3Mhfw
 U53vOKWzCV3GWma2TltFD4/mKVNs5mocAYZyW0Jq8kC+8SdGgT3eHdNpuGIddFs97HNRgbGEP
 dXSIVO+CP29L8lc+dM+e9oI9OlTYVrfj7s0++Q==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 5:03 PM Daniel Palmer <daniel@0x0f.com> wrote:
> On Tue, 14 Sept 2021 at 22:54, Arnd Bergmann <arnd@arndb.de> wrote:

> > FWIW, I'd suggest merging the MAINTAINERS file change as a
> > bugfix for 5.15, it's generally better to do these as early as possible
> > to make sure any patches reach all the right people.
>
> That makes sense.
> Would it be possible for you to merge that single commit for me?

Done, merged into arm/fixes.

> Seems like that would be easier than me creating a fixes branch for a
> single commit, sending you a PR, finding out I still don't actually
> know how to do PR properly.. :)
> If it's a hassle I'll do the PR though.

If you only have one or two patches, sending that patch to soc@kernel.org
is usually the easiest way anyway, unless there is a reason to keep the
branch description separate from the patch description in the git log.

      Arnd
