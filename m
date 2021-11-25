Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6E3D45E2BE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 22:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245470AbhKYVxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 16:53:13 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:36683 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244566AbhKYVvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 16:51:12 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MacWq-1mK3yn2jak-00c5kB for <linux-kernel@vger.kernel.org>; Thu, 25 Nov
 2021 22:47:59 +0100
Received: by mail-wm1-f48.google.com with SMTP id az34-20020a05600c602200b0033bf8662572so5573990wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 13:47:59 -0800 (PST)
X-Gm-Message-State: AOAM533vQQIFOHMYuqOD7zwlvbPRyDC91YjrFosqOHTyAAZfHMTfJyZ5
        XLWUFTqGnPGBfmd2atg34cMnwexl9AzanSjpHio=
X-Google-Smtp-Source: ABdhPJziezUzB2lD0LoTjZgL52NUFrj7N5lR6EIpnICGP/Kc7IhAGz7CYt54oH2qMVwLWTJ4gR1dbWeoJd7bMl/uchk=
X-Received: by 2002:a05:600c:6d2:: with SMTP id b18mr11594351wmn.98.1637876879348;
 Thu, 25 Nov 2021 13:47:59 -0800 (PST)
MIME-Version: 1.0
References: <20211125212729.86585-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20211125212729.86585-1-andriy.shevchenko@linux.intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 25 Nov 2021 22:47:43 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3Z5o-hJu1LfeZrD2dps+WTTa6U8vCDoQK2aMAO1WEaBw@mail.gmail.com>
Message-ID: <CAK8P3a3Z5o-hJu1LfeZrD2dps+WTTa6U8vCDoQK2aMAO1WEaBw@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] misc: at25: Fix issues brought with FRAM support
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Prchal <jiri.prchal@aksignal.cz>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:jRvmSzGokWV9b+E8AJ0s09IZJ+na7HqWopCK4IQsRg2GmEP2hGR
 UBrO5rMrAiqSPoDb4lF9OhQdAYFy0BJxJ5n7QGigS86gqvHtpaaVfK27Nkthc2/X5ZUjNYT
 i1SBDkGAqA0f/HSk3kaKSP4z42zU2Iw0Jtcee8YARdwHYM9dXj42wQsRtlLjz/eU3Q7AdKN
 niIJNo1FjmhTCWgC+UN8w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4LrH3s/XzvY=:riNgYmM2n/wOOpJOy2zYg6
 bxU5YqyDjo8DGyCCjbp3K5cC1eOgkPjioXeuRwYqh9vQqkhtKSQtlpwtaWjL1Fa4o4e8+G4ic
 kwN+Il/uL0clFtLnerY9kg7GrhDHYRsSspRIhXEXKxa6rh5GEbl2nJCYUae5IwetwawO/xqrR
 MFHOm3gfkwDYPKXaqz6itQ1iAY3utR2zxJMD8ac0jFb7uXk4QE4imaoO/MHQVJHWbPuHZH3c9
 h78RwkIyf832qydq70hkfRWLq5rZH2sPA59Nk563pKIERFQvZDK57dZ0L/zoS79AfHbLJDNmk
 WIS0483jh+k+wHY27pEpKToIKsM8q6ZtT7TUmKGoW5B2iTQYYiaNamlT4/U1upwWaRRYgFpja
 vSt6nhZBVNFM0M2JlFgQvQSV0FnEYILDrOX2Grj11u0pAbmNzva3XkQtyc2GoKQvfaEDTTP7v
 Jd/SN4yAYia0VErZNoDGp1QEgwDYjN21QRY8dtOcgAkA9Cw1FVmHmMOV4/Y1leV73ffFdxL3j
 eIGXSE/kRMnsVUi7Hwv3XO8uU30bixhJNlFYj+6340VEZmfA4NtBrD++yKLycw33lZ5Dz/zlR
 WLqKXSJxTp45v10sC4dS0ohNOlhb16Go+j/261BdxDxjMZkmNFye7xgREQ1+iLKTI/vBMbo1D
 um5a9BEpTAxPwLbrY3sAE3mwTTQK5Q9trC7fhdAPPNOGg3YdJzFn4Jk/MWihHbQrRx7GrgodG
 Sk9p63JMc+L5f2OUHs5ubmy0OTNNzQdjFM2JthVDFiq1tYQsh9iQ3HYmWpl9SI8bn2KHw8OPS
 +TxgNnePNrSR9ufAgjj11pCrLcAS1iaZWF6CM5ZXnyjSldkO10=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 10:27 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> A few fixes to the AT25 driver that have been brought by FRAM support series.
>
> Andy Shevchenko (3):
>   misc: at25: Make driver OF independent again
>   misc: at25: Don't copy garbage to the at25->chip in FRAM case
>   misc: at25: Check proper value of chip length in FRAM case

Looks all good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>
