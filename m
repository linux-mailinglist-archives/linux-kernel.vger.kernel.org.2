Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 861F63DA1AA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 12:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236499AbhG2K77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 06:59:59 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:43963 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbhG2K75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 06:59:57 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MrQMz-1mwCQJ1oSl-00oY22 for <linux-kernel@vger.kernel.org>; Thu, 29 Jul
 2021 12:59:52 +0200
Received: by mail-wr1-f41.google.com with SMTP id b7so6397700wri.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 03:59:52 -0700 (PDT)
X-Gm-Message-State: AOAM531CruWoqRLWuC2lgVF62Pena830Bl740rW9rJpHjVwkVPOsvSNV
        AKryFmFFZrWJafGQ3Sw4a/p0zfUW227J8ZtzjTo=
X-Google-Smtp-Source: ABdhPJyfHFwoDCiliMDLp2MJiz6KzH4M87EILJlQ5GDLCg6lY4W0sYnWv1uVwFaJCZT/LhekBdeYNAbwEBVkVu9hMNQ=
X-Received: by 2002:adf:e107:: with SMTP id t7mr4171760wrz.165.1627556392130;
 Thu, 29 Jul 2021 03:59:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210729102803.46289-1-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210729102803.46289-1-krzysztof.kozlowski@canonical.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 29 Jul 2021 12:59:36 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1NBa6JWrhpxq5x9Hd63oz-p1woeG2-UMjYCxEvhq=HTg@mail.gmail.com>
Message-ID: <CAK8P3a1NBa6JWrhpxq5x9Hd63oz-p1woeG2-UMjYCxEvhq=HTg@mail.gmail.com>
Subject: Re: [PATCH] mei: constify passed buffers and structures
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:hGgl56iKCoDEzL8C9s768OlDWDq2bzGERvz2BtMDFbY/qE5+TRw
 ry8qLoTVhBMiWGDvYVj1+YaGh+CyvjXpUq1kI+1YnyIcfntimgP66R7A35SOKYW7fXSmUEw
 xQ+20LDmqa51ucKaiOoZlHtO2zUCbeFovRC/ubZUKfbhzBgy3ck1upxq7wvFP1NnsWORHxN
 YqKXRqb5f45Y7YhnlPCSQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WUufVWe7aUQ=:7sxABTwZIe1VkX3cSXakBx
 idXaisQFgQqvnKM243vxozoS99EgsTHne95T7ObELdiH9ckdnYYVFSfKMv9043561hVL6CYtm
 1vGyOMKrfTDdbCWFeWVGBXJ7UuaY2W13gISzOPfABv7w/GJ++hM6cO1yaVSudvWZ/RD+ijn76
 c1zzPFcoNGKTTwgbPFB3AQsbYX/4JbUiKQ3HmZMkgXYFDvN6wnNoQfa7aJSzsdaXIN4q86Mt7
 amlrLZZbP6iQJkJjvyQdYVt7vrAMK6AmMDffnithFGVw5VkietEwDt9g3Ywy4eam+RGMDEvqc
 BtLAVFZ5ZeU4/3Osffdqs2jiR6Dt6wGg0n3AzAx44y/Az+oWFEFFb1pQrYBVOzsmCXhcU2fQZ
 3QUr1YhmUI7IVCU3CgvoCRbvEEtewRxcndoJ13ngrmsoG8UN/85KXrqx93ztJ9HZYyG5D/F4X
 ULUWfu5BjFFKxEvMYk4gDwQ+dIc4WBwkJ7gm1shQKUg+HUs62o9mALy4GPBxbbnXb/d27DRJI
 Smp1Anvai8eNoEygqbOgiu95BTy9cX5FcLP0g55z58x7CGL61dNUKpGIwwiPYWPyifbcQZE92
 /1noU7MEqspXdfaJBybw7X7f4vbX28caS633slS+3Z7DI89pAK5BvX/npyz22KUBr7QRsMrxk
 tzlutuxIzpYCcQHGVmXV2Ub+DTc54JdXZ7NBwORzybA4o7Pp5jJl06oZy5ZI6K9NCO6ybArYu
 DCAk7FOfzR4ROmMmETvvEpnr29QZ0HYdQwHqpgQl+PewR4+386wwrLU+X2g3v9PDxWQ2ms3ev
 6U8xPr/kLTQuAHgDmAByInecqI7TrNIv+H4k/tK/46J+q7HOvG/IgDnAxJwAoFyFs53F7jz
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2021 at 12:28 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> Buffers and structures passed to MEI bus and client API can be made
> const for safer code and clear indication that it is not modified.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Looks good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>
