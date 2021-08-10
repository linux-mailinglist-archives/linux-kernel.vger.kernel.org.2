Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9073E54BD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 10:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236378AbhHJIJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 04:09:22 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:41681 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhHJIJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 04:09:11 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MsZ3N-1n6J761bwp-00u2tZ for <linux-kernel@vger.kernel.org>; Tue, 10 Aug
 2021 10:08:47 +0200
Received: by mail-wm1-f42.google.com with SMTP id u1so2383899wmm.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 01:08:47 -0700 (PDT)
X-Gm-Message-State: AOAM532mCPQnfNq8ytvNF8W/0zJBSCd8/ZyMobZk1ZUZFjFk5F7RPIxm
        Vl1llw+P3DsqGcbZHT+zkasZOSumlsfBp89nQsA=
X-Google-Smtp-Source: ABdhPJxkzP4Q2zQTEo3s9UPxx301gGDi4/OLRtRPtP7wUJ3xntwom9/Bot4PT6DXh3WIsPvwtIFBWvBhemZBAenjobc=
X-Received: by 2002:a05:600c:414b:: with SMTP id h11mr3253750wmm.120.1628582926964;
 Tue, 10 Aug 2021 01:08:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210810074504.957-1-phil@philpotter.co.uk>
In-Reply-To: <20210810074504.957-1-phil@philpotter.co.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 10 Aug 2021 10:08:31 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2n6WfsQUKP7W4VytJ6K=CGcfOz-eSc=6FzvkANWkk87A@mail.gmail.com>
Message-ID: <CAK8P3a2n6WfsQUKP7W4VytJ6K=CGcfOz-eSc=6FzvkANWkk87A@mail.gmail.com>
Subject: Re: [PATCH] staging: r8188eu: remove rtw_ioctl function
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     gregkh <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:gCq5XUQx9+WvDgPeoM4QNKQufjDbo7HbaXFOBENxzvUnLfJElsi
 PB/5Z3FNLbTCN48pSUCSB0GgNZf3QXzKvb3KM2Io2WcdjrHUzftk93LVQzFHgeJbvQPUsPF
 g4ZhYzFp3xat/AyHLwakaiyxXTOFxBqJ6rlIWqz7V/4ws70bx0viBbwk0aMeXHUyl7pxizc
 SsSJTS/Ozg04V9AAWbhlg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:32weuby1CTI=:/xPoprUM2SsqLUlp7sK+qY
 Nu62mVTc/Fnw1eX6tvVDN4UJtHDVR/FzVg6lxUogCeFkbM8qhkGlsCOMSFPuQOCHPfr7pskbC
 s7fx3P38ItRE/SlzrxcnqMyyEs73/RAd6+YbsKsUdm/8DhX6bSGHseZ8Upg9xs7hUUOYIsoCe
 T0LguoS1j5tHm31vbirQ+LeDNDno1LDXMFwUJ1ma2IdXGpu+U2ThY5korjJYxYJHyyfHwL7Y7
 J3PNe+lGUgThvFvZVCtkPeyACAe6ccbe33+m9cRdDxKZSGC6zHyA5rVozgw5dKbvIkQaAI2SF
 dSRiInI4zH4I4ojrVQThNwucfEMkqBwQqRqndYteepOuVJf7LC4ctfkwxqONnZwee44UFqi0T
 dlXoH9uUqwo32YWZGxZPmsPug3h+x+O2ZxpcalsP14iJupdbsSwLkhge6SgTJ37T2b80ELP0J
 MMLT468UZpJn98lNPbjFuQBeSEhI9IU3KXBw8LnsneRQKEaBRLAtm7uuoW7d8SYVKcyvkjzZC
 USRLpfExPmnVrkunob5lOK1JU1OyNd5tMsHSUceBwe2i8t65Yijcix3IZvH7wUYCHMvyXdOVk
 sxJ82NT5rKVuhV1QwHSDBdPsxeWp7vOPFwOOl61/8+V2IB/L39oxvwK01mIHNO933V9LG0zwq
 O6buxIdWn7N895AEkbm+rtIJ5PPWXQFEWmWub20+R+/Uvooz15YRU8UKl2S2lkKDJbdOgcSCl
 qZzBk5tBpc4PDNByICOQexZNLYnH5ojdsBYaFboa+239GxAW/Ft9Y+TMouo5K2+3TCkEaPcZJ
 YjHKzFS1yqV61b9jrzgwjvcsyfDlDhFUDJbcIxpYmt7kNIEYpV5lDGWX3RPhBG9m8XV3bq5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 9:45 AM Phillip Potter <phil@philpotter.co.uk> wrote:
> -int rtw_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
> -{
> -       struct iwreq *wrq = (struct iwreq *)rq;
> -       int ret = 0;
> -
> -       switch (cmd) {
> -       case RTL_IOCTL_WPA_SUPPLICANT:
> -               ret = wpa_supplicant_ioctl(dev, &wrq->u.data);
> -               break;
> -#ifdef CONFIG_88EU_AP_MODE
> -       case RTL_IOCTL_HOSTAPD:
> -               ret = rtw_hostapd_ioctl(dev, &wrq->u.data);
> -               break;
> -#endif /*  CONFIG_88EU_AP_MODE */
> -       case SIOCDEVPRIVATE:
> -               ret = rtw_ioctl_wext_private(dev, &wrq->u);
> -               break;


I think these functions are all defined 'static' in the same file, so
removing the
caller will cause a warning about an unused function. Better remove the
called functions along with the caller.

       Arnd
