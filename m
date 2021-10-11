Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB25429375
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 17:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239162AbhJKPfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 11:35:39 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:44525 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234930AbhJKPfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 11:35:33 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M4rkF-1mZgaR44Gt-001wyI for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021
 17:33:25 +0200
Received: by mail-wr1-f50.google.com with SMTP id r18so57582494wrg.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 08:33:24 -0700 (PDT)
X-Gm-Message-State: AOAM530IyQO+9yDEC5yYyWWvpAHNhuSALrLJWL3UjqmgQhDnmTekdvUy
        A7YLA3VUge2dlBz3mbxeYuewJoXihSd9qGZi+GQ=
X-Google-Smtp-Source: ABdhPJy2A6HBi/onwVTlmsFJfr6VmebTxbZgG9XlAgv0nFqg/aGbaJfD2epEYF1A+wTO/Ety2rJRs/MuBgbSQdOpOIE=
X-Received: by 2002:adf:b1c4:: with SMTP id r4mr25714356wra.428.1633966404628;
 Mon, 11 Oct 2021 08:33:24 -0700 (PDT)
MIME-Version: 1.0
References: <20211011151443.12040-1-vegard.nossum@oracle.com>
In-Reply-To: <20211011151443.12040-1-vegard.nossum@oracle.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 11 Oct 2021 17:33:08 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2+dU53PMJZvkDDGUyv=EiHuc03njGf6SXTxw9A4ByeHw@mail.gmail.com>
Message-ID: <CAK8P3a2+dU53PMJZvkDDGUyv=EiHuc03njGf6SXTxw9A4ByeHw@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: select CRC32
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Oded Gabbay <ogabbay@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:jS8H6+8c9aEzbfJGfvbZ7FRjBUHtOyMILu86YAkp/Fe1f75H5G0
 jObyMZDmbNhMwNNWPmM7Zh5Q1fGWZNinIQ+MdG26bnMPoHci9Y304t5NZlY3EPoLN/kM1/K
 plkR4SOmCXNPDZxR4BG+ZFp/EVR2TJrVC0CoI0eD1ILaMm8d7SyG+LZp71VhZO72MMWb2W0
 UK5Rw0ZVEU6RH3og6+Eew==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:f9JlVrfxYbc=:IFNbehV/61j5sI1Bo+8B3Z
 KG09WRvP+SCIvmZxEbIsvi6oDpqQBIu/RxXeAikfJgxK94jY6zkuxN/a8D7QjVHb9XRmBLbS6
 6cnGRBvuGiGAFsYZVQbmr/CuP+qmZr737DhtNXI5Q0HXy5kLNCagVD5JNmAXmEYuqrqc9OXD6
 ARM3eGtH57G8UqTeNpSPxb/LhtECZWlbFRdodDMuN/+9ihBxNo/mK5YsEkAsCEz14veRwtV5u
 +kYWdCtaPj6pwKe96an3jvxVRJJy9bHmmapKD2xMNYv1AY/ECW9Yinv/Wb2QKgSzCyuf0wZ3q
 YsXMMQdm4voxY9WGYRSyK8cKBSNI7WnXruPBeqgtaa4jj82n/wYotl5Z/VXhORWluYbvsTOKS
 MZp/qgjyphwSPncrHdAJ3Q3QZxVj34rbQ7yzCnPXQnYM/oCG8cAkYRs4oUx3ouCbjwOXKY6dB
 DLxepyTqCqLtmStgKFfBgrZEypoX7q6FqF+H4MK/xIuUXNR1ZSPu1n6wZ9ZEuGw8nn/Az62Es
 qMckzmBwtl5BtLNh/cfu+4/xsGjZqE+SgYBgx0M2X5vfSI+47EYqoD3wSwjv8QImWEdqz++gE
 KSb4ag7054KrMO0jRg2/5l0Efv21AupEWhpWhz7YhojdPk79d8WAwC/Nq2uhNXIQ1pENuQsVc
 oxbHTTkrmF3XspmQBLtJ1b3Fqnq+AH998OcQ9phJxLv1nF5KGkY/tchss7rt48Xk8lp8glnU9
 XPju4uoQdtgsvq4/hYmQ85trj4QEFC3zQUFQrA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 5:14 PM Vegard Nossum <vegard.nossum@oracle.com> wrote:
>
> Fix the following build/link error by adding a dependency on the CRC32
> routines:
>
>   ld: drivers/misc/habanalabs/common/firmware_if.o: in function `hl_fw_dynamic_request_descriptor':
>   firmware_if.c:(.text.unlikely+0xc89): undefined reference to `crc32_le'
>
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>

Patch looks good to me, I wonder how I never caught that with my own randconfig
build testing. May I ask how you found it?

Fixes: 8a43c83fec12 ("habanalabs: load boot fit to device")
Acked-by: Arnd Bergmann <arnd@arndb.de>
