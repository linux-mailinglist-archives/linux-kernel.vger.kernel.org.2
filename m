Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF87443895
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 23:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbhKBWl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 18:41:26 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:50657 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhKBWlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 18:41:25 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MHG0U-1mvBZA0rku-00DGVB for <linux-kernel@vger.kernel.org>; Tue, 02 Nov
 2021 23:38:48 +0100
Received: by mail-wm1-f45.google.com with SMTP id v127so500836wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 15:38:48 -0700 (PDT)
X-Gm-Message-State: AOAM533YY/ajf1BEmtnweqTubbL+MArBQY+olwcdC/X+akSioNK8/k0k
        stwAj+WR7LTqFj0bOwpEGVdTJP05e8pIgBG+siU=
X-Google-Smtp-Source: ABdhPJybARp6PDun8/zoaUvWMY0Nc3qQSGjuiDp4tQ9ueLsmRsthCc7D5TCv1oDz25AqqkBPUwMvrFWmK08kymr5S7E=
X-Received: by 2002:a05:600c:1548:: with SMTP id f8mr10479346wmg.35.1635892727957;
 Tue, 02 Nov 2021 15:38:47 -0700 (PDT)
MIME-Version: 1.0
References: <20211102220203.940290-1-corbet@lwn.net> <20211102220203.940290-4-corbet@lwn.net>
In-Reply-To: <20211102220203.940290-4-corbet@lwn.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 2 Nov 2021 23:38:32 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2ek7VuB00MBojJrbqJxLj5K4O-ehKvSPeM9mhQcrkv4A@mail.gmail.com>
Message-ID: <CAK8P3a2ek7VuB00MBojJrbqJxLj5K4O-ehKvSPeM9mhQcrkv4A@mail.gmail.com>
Subject: Re: [PATCH 3/9] Remove unused header <linux/cnt32_to_63.h>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicolas Pitre <npitre@baylibre.com>,
        Mike Rapoport <rppt@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:lnovUi3m7aS/VZpiDV/DveU6dt/LpCbQT8BrFpeXvMDdC8+td7r
 fXCoW5oOOKIJqIg3a2kpjIL1oqspiRJtH0drXCTplLekQunGKqmOg1/N7mDifhSYxKYsxqs
 GGdY7Qp1cA0p+kfGcu3M0fPhYJoWyXK2v03FR/MLhatIszchgAzutbQNmnnwGw5fw2guPK9
 /iIOXXzqQhmjtiw/8IbiQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yiXoR5bBXkk=:fNnROTzoN8kxa3GsSlQ282
 qgH7W7VVyVqt4O0uc15lvVw1ZlnUb7b6UBGiKmW1ELA1Xi9C2EViiWziTCywYAlz3CK8DPhP/
 uHRVP+7SrfuZrCrNrG6LYBSLNPtsaGSWbhmVkA8TABuoBmomu98asMY1iiPbhGkxRSdJ3MMme
 /U3fNS1V72defezQIhTbcJeWUWaOx/rgNSCX7oOcCfsSRSPmN1MbnBfbdEfEhDK5nkU++H1ih
 LkOXu6q6DS1j0zd9BHJyA1LsWWHdOn8cYBaBctVwiVoP5B2j0xWmAye4qA1ZJVZovPwcjKEzG
 5eLsJq7cI8v9lKyWC3gxeSJMBWa0pEOUiFXbyKI1UcY13gIklzuUN2ygecxXJUec6XVws6+aY
 Y+jKSVdiuy/7hEYS/2QZril1wABLYHs9fAa4jlZTLXDlp5gM5THwVOXGBARTCaJOLuSFlWniU
 f30kTT5sMOQ/73CYsMcq1HsHRRhboiuzK65OBpBdXw2Jv58Y5wrJh3iqZ6x1PQ23edsty/4FQ
 IIKO+W13v70bqZ8sevGbzaHOme1LNShGzqXUuImhHRB8eKj6Liuvknj4/CzWDMuuIyzBLz0h8
 U1hwyjUcYYlly3yEtjrimnA8DGL/sp7PlGnjXOqEzkiQRNZxBxrltnMsiKO/1EVracMR1tGLN
 ZjpGE55FxHYZNkcQGCtCOko81hhqIGJ8QiBPfmehmCD8Nhc2TLU2WgFlf21QRpK+WUCUOaDke
 j1BupSIdQjB1EBcpC0fB5FAGjNkkU/BRJSIIwW3zlVmrNB3NsRpRET2TvChOF/BlQegm3w2ey
 dgiu2HwRTf73yCT/yfvHuaGAIW27pljE99jabYRBDIHmnUQ1ug=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 2, 2021 at 11:01 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> Commit fb37409a01b0 ("arch: remove unicore32 port) deleted the last file
> that included <linux/cnt32_to_63.h>, but left that header file behind.
> Nothing uses it, delete it now.
>
> Cc: Nicolas Pitre <npitre@baylibre.com>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Acked-by: Arnd Bergmann <arnd@arndb.de>
