Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A62DB443890
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 23:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbhKBWkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 18:40:43 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:37335 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhKBWkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 18:40:42 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M76jv-1mpz2Q32oJ-008cTA for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021
 23:38:05 +0100
Received: by mail-wr1-f54.google.com with SMTP id d24so815730wra.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 15:38:05 -0700 (PDT)
X-Gm-Message-State: AOAM532lPbJHijRge0zJnQICD2u/ECbSZTeYfN/IHhm7fMN7vydfpd0H
        9b6bnVjQ0DVyd/jPqosmdkWVmjFSe6A1ZVyoC64=
X-Google-Smtp-Source: ABdhPJyIreu0e/juJ7sM+azf8hGD9ZA1ERFc8xrmEMd8EnHyfzAgXsF/wVSN66cVAtI/P1LC8ies8Br0rDAnd3YVwE0=
X-Received: by 2002:a05:6000:18c7:: with SMTP id w7mr50932714wrq.411.1635892685429;
 Tue, 02 Nov 2021 15:38:05 -0700 (PDT)
MIME-Version: 1.0
References: <20211102220203.940290-1-corbet@lwn.net> <20211102220203.940290-9-corbet@lwn.net>
In-Reply-To: <20211102220203.940290-9-corbet@lwn.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 2 Nov 2021 23:37:49 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3nSxX+U4LnKbvyjx=7sFphvkqEu4JyaZCBXNkKkBqV7g@mail.gmail.com>
Message-ID: <CAK8P3a3nSxX+U4LnKbvyjx=7sFphvkqEu4JyaZCBXNkKkBqV7g@mail.gmail.com>
Subject: Re: [PATCH 8/9] spi: remove unused header file <linux/platform_data/spi-clps711x.h>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Signed-off-by : Arnd Bergmann" <arnd@arndb.de>,
        "Signed-off-by : Mark Brown" <broonie@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Z03GcCnSOtdM1IWGLB/fF89BJgK1DkvPHUEU9fNFrsJfUQ/vOj/
 +8N6hS5iY3HytbHRcLL2uoHn8G9AvyxLqMwEvC014OTgE91Ytp2/IS1G4Oqhc0JOuMvw823
 pXP91FbmxLMBE4rtSBOknLtIk4UjcnuwBIhRsaQt2w1IWtH3fzBRTP0uheKsuCzbE/92Zs7
 gu1z3jhF8oUz3Xyc6e4Bw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6FZfRlV0BUw=:8LfjqYuBayHqTMIy+vpSRQ
 v4aQqS7PUy2dngpYS+P+PmwxUPzjBil+EnwIa5V/TRTHbHD2LdmAymkgmk+bc4zq3aAOt/G3X
 4YODi7dLAK4thwMX1S1L/J8A1gasYUrC4aCunFYTCjLPri1BfxHeCdupaGzV48SBFmPjEIvsw
 +x0Bxzs9Sw5DVaK0ZitKGb5GKi19/S8wrgo1xEgi656yuvsAbLtoOaL//bmx38ezNYRs2jbxX
 fKUVGy+LPNbZgNd6VxNQ/iF99ZXUWjNjl6tZ3N3yl0BtQxC2sPmo9uZ7MzoGwjdznQM0JqRf+
 nI+fMdHvE32TaFXs/Dq3U/CWOq5BgXvQtT9o4Dttb2Gl1ZapQyyrqcS3A6ns+MFNqApKTkbCR
 z3z95tZ7J9uo2Oee5ANbfXi2Kgo0YTXmCNNIDcaWQ3ehqc0gmwDUf45u9JZPklY6hyYFBjgAd
 5f2cdfQayrIAWdW/VwM9NO/awuPyPQARPzdl+/KX0VlYvY5F3YknU7foS/V4r+UC+yTFO5LtH
 gXQprodZcdSs7vV39yypPY/TEK0TR2uASgEx4tcXtPKghhXDTIqVhmgMwDYswK9icFJVJC6Hk
 ih/9iyKu07xPfaVaKC32mzD3hTWbeKPqfEK3NbzEmx/CPMNGOJPBlu0Enru3kNKNI5dbm+R/C
 ayRt6ildoapjCWJ1bl+65WzYeAJO+b8UxargjHkgD96z7KCOy6uX6vOgBCSKWDZp8Eig=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 2, 2021 at 11:02 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> Commit 6acaadc852f1 ("spi: clps711x: Driver refactor") removed the only use
> of <linux/platform_data/spi-clps711x.h>, but left the header file behind.
> This file is unused, delete it.
>
> Cc: Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Signed-off-by: Mark Brown <broonie@kernel.org>

Aside from the misplaced Signed-off-by, the patch looks good

> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Acked-by: Arnd Bergmann <arnd@arndb.de>
