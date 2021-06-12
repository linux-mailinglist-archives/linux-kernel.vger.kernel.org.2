Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C66A83A4E17
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 11:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbhFLJ4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 05:56:47 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:56305 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhFLJ4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 05:56:45 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mbies-1lKKIE362I-00dFkY; Sat, 12 Jun 2021 11:54:44 +0200
Received: by mail-wm1-f44.google.com with SMTP id k5-20020a05600c1c85b02901affeec3ef8so10047685wms.0;
        Sat, 12 Jun 2021 02:54:44 -0700 (PDT)
X-Gm-Message-State: AOAM530a7rvG6rXdc+YKD0sSnOIawFnnWgUnwaXSNZiPtOTo9lacYERe
        i1Mzkjlyrj4skK87nMjMTbFWMiIRSmfBryh/4vQ=
X-Google-Smtp-Source: ABdhPJwn2BYTX5/QkNEs0bR510OlVhGDCvA1jD8WEIHjWsisXpME1WyYu5aNpbTe+mRGf89UPeAHmHX4C3mi2ayVlT0=
X-Received: by 2002:a1c:c90f:: with SMTP id f15mr24171181wmb.142.1623491684384;
 Sat, 12 Jun 2021 02:54:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210612003128.372238-1-leoyang.li@nxp.com>
In-Reply-To: <20210612003128.372238-1-leoyang.li@nxp.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 12 Jun 2021 11:52:45 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0K-S+9iHYfs-4AQZOzta6D_jH8Zy32-pfotYncBcJyDg@mail.gmail.com>
Message-ID: <CAK8P3a0K-S+9iHYfs-4AQZOzta6D_jH8Zy32-pfotYncBcJyDg@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: fsl: properly remove remnant of MXC support
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        USB list <linux-usb@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ran.wang_1@nxp.com, Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:5I/qH79G8W4Fw2dZCrD+oWkYGlsmOAfcogW3dYzYhKKKGbwd3XG
 8vOSMswLSp3q+mguTZaKohueFwx0RtQr4ixoDDNnYnO186J7e1NaJwwqi/YBeZ49F7jBm0y
 ujYCWs/1JXGn+smFRAhpe9AHU8qLFVj5Kwo5KR0LrFCcY0vCvZ4Az3DNBeBhWZWBQBWXUTv
 13RN5FlbI6Ce22s2HbGsg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7OO7KzuRSI0=:KZsignqFI6FgXZ2blSBuwH
 GOwS/mH9n2+tj+AXUqq/okN0EN41rwItgRhkYDrNkIvAybfPiojUnIyJOdJBlQraYVPnZfSk5
 gb3fTooUYSbuhJ2MC5OPp4ylt4XZYltmm3LESLh7D4J5XSO5GT3q2dedxseB/iYd4QZT3pWSL
 RGhvH38YOmCWOoWixfTw1rPInVGICveoF9oKCHcRzNWWdoUwhiozfnUR0avkPfJpM0Zp8UYbD
 aoPXZ8qqaPkeVq+eaBMSR0p5GnB4rf2I1+DLqUZ4nECKt8OSmKkvRe4XnyWzDgXXZC/Iw+QPt
 Il78icX570lEsfE3mcj0wt+ji2sYWI9n4LhfRzT4M1L41MTavY24ZgbM+LguXb/dTeXOups+Q
 3KVnAPPXlCqdOnsr1zuPgbpXP+4fVPQ3KR0O9aIimqz0NpxW8Io1/CBoG9w/w6ecGbT9IcR0L
 uHVnt7DfUnk1NJxhlr+8C3ss+XYCk3lc9wslDwRQGVDrsPLMoHdg4qW8Peh1nO3qh+CSBj7XC
 PlcD0vsfKf5pMelFxHhJQX6+A+yIXtaJdMoh2IZ9PNGIKH66Fork4VxYdQn6/kB9b5wjrU7EY
 mXj3SZG36BJJ2AQkst6+rJXbLRO6T8llMeN/L1sjxdbHTDUBNHwKzQBrdyu/CUSS/sYEcl8mC
 K148=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 12, 2021 at 2:31 AM Li Yang <leoyang.li@nxp.com> wrote:
>
> Commit a390bef7db1f ("usb: gadget: fsl_mxc_udc: Remove the driver")
> didn't remove all the MXC related stuff which can cause build problem
> for LS1021 when enabled again in Kconfig.  This patch remove all the
> remnants.
>
> Signed-off-by: Li Yang <leoyang.li@nxp.com>

Looks good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>
