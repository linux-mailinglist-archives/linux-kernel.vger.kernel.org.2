Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90CAD44054F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 00:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbhJ2WLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 18:11:03 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:57287 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbhJ2WLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 18:11:02 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MK3eI-1mMB5S0PWg-00LS7M for <linux-kernel@vger.kernel.org>; Sat, 30 Oct 2021
 00:08:32 +0200
Received: by mail-wr1-f53.google.com with SMTP id d3so18829375wrh.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 15:08:32 -0700 (PDT)
X-Gm-Message-State: AOAM533o1OM8kVVHArevKY7z2Dzq5SELBX1D6LeB73S+XyeyXn0eEGvw
        y4WE24tY5v0rv/ip2CERG0YLTI+132gfIZdrlk8=
X-Google-Smtp-Source: ABdhPJwDOca8ffBixEPllikPdfg5ONXLu8oOt6PFxJsramgRAu0zcyYo2Y06yib1kHBUHoxS+NxxOADS3pvm86qnK1A=
X-Received: by 2002:a05:600c:4f42:: with SMTP id m2mr22891965wmq.82.1635545311718;
 Fri, 29 Oct 2021 15:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <20211029214244.17341-1-julianbraha@gmail.com>
In-Reply-To: <20211029214244.17341-1-julianbraha@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 30 Oct 2021 00:08:16 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0dOMOzP6GF-T4eR38=pG2OBNh20LOVZhvuSZ6EGVH0Sg@mail.gmail.com>
Message-ID: <CAK8P3a0dOMOzP6GF-T4eR38=pG2OBNh20LOVZhvuSZ6EGVH0Sg@mail.gmail.com>
Subject: Re: [PATCH] staging: rtl8723bs: fix unmet dependency on CRYPTO for CRYPTO_LIB_ARC4
To:     Julian Braha <julianbraha@gmail.com>
Cc:     gregkh <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        fazilyildiran@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:+CQdnrpAhrX07JnyVZkcLCqtuo2c2R0g3XihVdTVxW7q6J/L+Xj
 v61TUyyScfNw2EJt7raLRiNTJVy0eDqE0RB0pbxqC1gf/fYtarMkIbkoyLZxGyhCwr+ramV
 Fw1+j7U5tk+Okl0Ki4itHXyLKTXUn5Ag8x/bBl2pzc3Jep5fvUAshhDKiM2+dgbFCO4VFyB
 lwVrAPqDe3S5M2wLyc+ZQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Kcb9vyc0ITI=:Hs0Yn8RB6A6kNDGjN6M6z9
 WTSuV3PKay05StzdYY+wyIFjOYOXi9SBZbjLKkwh4JMxDvfioXFbDMNgJ36IvDaSJXz/Xg5kY
 Gm4KhxfM8AWbdjMcMkLERovIEiJrxSSTyg6T3X/2/6RrfgGjIUfIauuEHFlFV3zD1lgaQr6Ys
 qIm6zlKdJklqv3x3fDYgZLunozSpmRdWhn1G7JqQG6uI37HZQmfY+SY8N7JugIJhc/IEix9ox
 MaNS2NGOhql7ezIfjg0J6RJrYcd37HlTlov9KmFLP6bNeeKNub8wy9WXaqCjt/Qpn4F1Nv4gf
 mMpWmlrOpQnW6KfewWQiDDHTKHvV7tP5ERhPS5QdjKcAdKkizcUrahlWjyTgNVUgR837ILH7o
 bXo+qNX0fu195Cgi6lmF0gAcKGhxpVAQEmtJNG2DGXrIue1lVUM1TtxuNI8o8WvPizalMI3bG
 JbXJpPZ8OJOjmePO2nmO2qCi7lgDbI44lafHVkmldHZKT7NY49H/x0hbZ90peMZ8lQcbaRRKh
 g+PO4iB4SwGcXB8ObZ7CzZVCDnL4qThNYzUyl95hgtVqkNVvfmmApQNaR06GKNYs0RJJzmg2x
 sSten5X0Yw7RXCq0tt8FqIQi3WIpFQOArIqjXfzk264eO6LEBtkfXnh5ZurizDBf6nCCZg9A8
 DiAmOWQ1DyansRbo7OUPH5x4YhYFZiFSkuM9+HOyca39nrkmfhe9kMlJkv/oS7eju6NbZik6k
 ISq7W8iBL+jG+2T9UhOFxSVM18HgPCG85vnr0kMFY8+dXDJPsBdLWNkCBmgDNVol8yfmz1pfY
 Q0CoQ426npLFpTjuikDSOxKxrfCYNQC0Th49QIhtIE1tBiDpP4=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2021 at 11:42 PM Julian Braha <julianbraha@gmail.com> wrote:
>
> When RTL8723BS is selected, and CRYPTO is not selected,
> Kbuild gives the following warning:
>
> WARNING: unmet direct dependencies detected for CRYPTO_LIB_ARC4
>   Depends on [n]: CRYPTO [=n]
>   Selected by [m]:
>   - RTL8723BS [=m] && STAGING [=y] && WLAN [=y] && MMC [=y] && CFG80211 [=y] && m && MODULES [=y]
>   - RTLLIB_CRYPTO_WEP [=m] && STAGING [=y] && RTLLIB [=m]
>
> This is because RTL8723BS selects CRYPTO_LIB_ARC4
> without selecting CRYPTO, despite CRYPTO_LIB_ARC4
> depending on CRYPTO.
>
> This unmet dependency bug was detected by Kismet,
> a static analysis tool for Kconfig. Please advise
> if this is not the appropriate solution.
>
> Signed-off-by: Julian Braha <julianbraha@gmail.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
