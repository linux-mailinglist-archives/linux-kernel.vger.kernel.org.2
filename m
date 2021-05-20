Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B06138AE5C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235811AbhETMfs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 20 May 2021 08:35:48 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:39979 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238456AbhETMfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:35:30 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MEFnR-1la6x80xDJ-00ADRt for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021
 14:34:07 +0200
Received: by mail-wm1-f50.google.com with SMTP id s5-20020a7bc0c50000b0290147d0c21c51so5124870wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:34:07 -0700 (PDT)
X-Gm-Message-State: AOAM532X0l4D+ksw+we4OWg7ugmG+2q56cVKe325ufSy+OJFWnwfWHVL
        zCwBgoYnQ4J+0LNH1QUFRdF+aRyjB1vnoH6iDtc=
X-Google-Smtp-Source: ABdhPJyrziNFiEcc8hNvlzHHZjk2tl71wISWxQ/IcNysd0sG3usqFaGdyw7681Am76IqSOSVwPpybdquaNg7zM4gCEA=
X-Received: by 2002:a1c:c90f:: with SMTP id f15mr3859815wmb.142.1621514046983;
 Thu, 20 May 2021 05:34:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210520121347.3467794-1-lee.jones@linaro.org> <20210520121347.3467794-17-lee.jones@linaro.org>
In-Reply-To: <20210520121347.3467794-17-lee.jones@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 20 May 2021 14:32:52 +0200
X-Gmail-Original-Message-ID: <CAK8P3a03tJbbFAjPVW4ebKA5=ystYrFfVceNSmqcGtZg5K4uWw@mail.gmail.com>
Message-ID: <CAK8P3a03tJbbFAjPVW4ebKA5=ystYrFfVceNSmqcGtZg5K4uWw@mail.gmail.com>
Subject: Re: [PATCH 16/16] char: mem: Provide local prototype for non-static function
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "C. Scott Ananian" <cananian@alumni.princeton.edu>,
        Kanoj Sarcar <kanoj@sgi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:bqgBkLc5n3gYTHgO7NR+VVcfk7Mj1SBT5w2JXJJHpRV5FSqB+n0
 9jdFhpaKQXEkLjJcD9gMPqw3zcQABk8YMrEnv3lEIYiyyb3ffgcR6JZ8E+txoU8Q6lJVNk5
 CJpvediZaRvxiB6/uNyUsDXcemILVU9kWYsbtqNDHIkD4L2rfRAcRtOYjL5TaBR0WIS9dwU
 ucse7dEJ85hScR1NVMGoQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Cwk4I+cgS2A=:vlBbNbScqDY+dUgQ3Tpv9O
 79sT7VxXtUkN0amt9dtvnQaPYVRj9boclvwAlPLwrBAYJt4RFO5p1dm0EfLlh/5GV95hkm9tx
 vFiNz591Ip2zz03txW7lj/7r68NjArWwknwbQCb6MQEgYHySDBndO9i75b7DG3Z3QtW847u/B
 JbHKuN74prxrQwn7FSIFmGWFa/RfwS+UHe+WxBca2xaVGO88/0GDBCIZIzzEVSX+s4V5cxPCE
 rKmDUoO2Qr4NmUgmGhGnWeDy9gJEF195fpUCI5UfMSLrVApxJuGRsX9WnvOQxDuKjOmMQFIU/
 GRqecT12JZ2ljsgHMX1mU3ZOM76/iKxDuYQ7wpoNOAS9ne3GE/YxACnnHF9+GgOg8SuxhW7K/
 2yG207pQIuMMIs7oH7w2ecu/WMokj80rmOvxa+mL1mg5H1yMhRgswHr/UakDiQjei+O0BcLv6
 PiNJl+3DlOKGgm1s+bRLBBF5+pQilZS6oWZH66gyaE3Os903/AX233bxBzsXRGDgCNCwX5du/
 Q8qbnqRprlNOggLXfLO7G40fkhEJny1nqXWFYJbYIMWssvrLqxAeLbF6uJ4fm8LvSZ0YArMzR
 pF+xc/ZVoPkC4fdv9OCTbM3dJmWvO4RJGds9Qo6PBxrSIdquX0i3Yu+i0zGdwait4OjKxOx+2
 xHms=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 2:13 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=1 kernel build warning(s):
>
>  drivers/char/mem.c:95:29: warning: no previous prototype for ‘unxlate_dev_mem_ptr’ [-Wmissing-prototypes]
>  drivers/char/mem.c:96:13: note: in expansion of macro ‘unxlate_dev_mem_ptr’
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "C. Scott Ananian" <cananian@alumni.princeton.edu>
> Cc: Kanoj Sarcar <kanoj@sgi.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/char/mem.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/char/mem.c b/drivers/char/mem.c
> index 95741f93a6cd0..7969ac85491df 100644
> --- a/drivers/char/mem.c
> +++ b/drivers/char/mem.c
> @@ -40,6 +40,8 @@
>  #define DEVMEM_MINOR   1
>  #define DEVPORT_MINOR  4
>
> +void unxlate_dev_mem_ptr(phys_addr_t phys, void *addr);
> +

This one doesn't look quite right to me, won't it break on architectures
that use the static inline unxlate_dev_mem_ptr() definition from
asm-generic?

I think the correct way would be to remove the __weak annotation
as well as the inline definition, and replace the local definition with
a static inline version.

       Arnd
