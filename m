Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3663E2CF0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 16:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbhHFOwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 10:52:22 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:58923 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbhHFOwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 10:52:21 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M42Ss-1mC1Ce0iLw-0007mA for <linux-kernel@vger.kernel.org>; Fri, 06 Aug
 2021 16:52:04 +0200
Received: by mail-wr1-f50.google.com with SMTP id b13so11437422wrs.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 07:52:04 -0700 (PDT)
X-Gm-Message-State: AOAM530i+MDVvDkDoFbTqM/ildS2nGThNI3AiC8fR/e3nrtIIYSGk+3m
        G2T8K9k+/gvtT5sCP/1KdF1lD5OD+iV5nmnWwME=
X-Google-Smtp-Source: ABdhPJzaR6qJfePFLgCHPEvS2rl+ctcdCp7KoQ3Fcdv85XiJXg5JdFJiE2fEE5Q5uLbt8pe01lz22DOOlzKs3X1rUrA=
X-Received: by 2002:adf:f446:: with SMTP id f6mr11689710wrp.361.1628261523856;
 Fri, 06 Aug 2021 07:52:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210806030138.123479-1-xianting.tian@linux.alibaba.com> <20210806030138.123479-2-xianting.tian@linux.alibaba.com>
In-Reply-To: <20210806030138.123479-2-xianting.tian@linux.alibaba.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 6 Aug 2021 16:51:47 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2=BmVv0tvUKaca+LYxuAussAJtAJW9O3fRN2CbV2-9aw@mail.gmail.com>
Message-ID: <CAK8P3a2=BmVv0tvUKaca+LYxuAussAJtAJW9O3fRN2CbV2-9aw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] tty: hvc: pass DMA capable memory to put_chars()
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     gregkh <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Amit Shah <amit@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Omar Sandoval <osandov@fb.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:DuTto7kTHONKfiGCgAJejg3DLsCVVBUeFiGoJnb9xvfdOo7xrIM
 eNwunxdMv6eTZmqn2f59Rix3H5l1J3LcK88TIf0Y/lQhU6g7QUYjv6Vp8RdlXIZbP8Rebad
 ISzo0vr9P5R5VIXjvnFhVjwjM2CXz98fdNsoyYB5wVN+TGWiI+7ZtD+04W65nsoHzyGawcV
 4RArcs0f8TPApUtVmLkXg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ubePW391dT4=:3EGI5fK9+AfIrYBqm9Mpbt
 Kr46qGeuHAc7VCc9wEfh3IBS+FS+2P8fUyI9KbOqKq6rXXWrPTxNoZZTRTO83n8dyP8zCyhSI
 2WalzlHfdaIfXvgekXIr+lA4tpwdTCIbAmq3CqWLtlUqIQMdj8kXq+uFz175Dh+XhAyOQUjBB
 PX6RQtOc5UmJuyeQ2nLVxBn3cpb9fluuoFOGvDOUZBGuWMIESfSWNcJ9/WS+ybSVAAdsTOB2+
 L74mykklgJO13ZBoLwu//TciX7W5atD1NWIgZL5bNMpCkym1TJogdO7AyEDMjbTOJuY6y4pGw
 P4rwYHN1TFwcqz/8l5kUUSn0c1De+KGHoQXT25Rr5uysAWwLa0NjB1OFjopX+LEXLuNGdgygm
 29FXmjFCzbnifBiOIA1V3WCPd6lS3bt+9e5WSrI7zg7kWvRouh2VVCbQpzUpYTDrIlFRypex8
 rRVnbqvqqcR/QRpxyHdf3+yZtMJ11ya4QiMYYhx+743vQpYEJgdl8M4WJnt9Mr6kY+H7eOBAH
 Bvl1T+cvB9+A631ZjiY9FVq/eLZ4n7MbZyV/Z9Mv4yhHsREO/FXBL4hCaWo9v2M9jlLcJwdFU
 eJK1+jO4r44uMOOLw3h64pHoKXJ3gekPDJ+T76oWrbt6E+m4LMHW6CYo15mqx3vfmp1Aa/mof
 q0xfpIt8pdpxZev/RoYy96ypqCr81ljX86cqwWykUuVpBOXDByhuKrkRNWHv/ga87Pas+ywqV
 f2TbZVfnLAwaldb1DZ6tyolB1bro6QE7ox4D0XCXojPkHLkMNpaXLNevzMkXVbk681+GRB8mB
 FRxfO9t/IgK81JXfjcdWFA4Oe4O50SQl6KJhW+tkysnAHmpXT9KAqUmlij7yJnI5GtQAoyp
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 6, 2021 at 5:01 AM Xianting Tian
<xianting.tian@linux.alibaba.com> wrote:
> @@ -163,6 +155,13 @@ static void hvc_console_print(struct console *co, const char *b,
>         if (vtermnos[index] == -1)
>                 return;
>
> +       list_for_each_entry(hp, &hvc_structs, next)
> +               if (hp->vtermno == vtermnos[index])
> +                       break;
> +
> +       c = hp->c;
> +
> +       spin_lock_irqsave(&hp->c_lock, flags);

The loop looks like it might race against changes to the list. It seems strange
that the print function has to actually search for the structure here.

It may be better to have yet another array for the buffer pointers next to
the cons_ops[] and vtermnos[] arrays.

> +/*
> + * These sizes are most efficient for vio, because they are the
> + * native transfer size. We could make them selectable in the
> + * future to better deal with backends that want other buffer sizes.
> + */
> +#define N_OUTBUF       16
> +#define N_INBUF                16
> +
> +#define __ALIGNED__ __attribute__((__aligned__(sizeof(long))))

I think you need a higher alignment for DMA buffers, instead of sizeof(long),
I would suggest ARCH_DMA_MINALIGN.

       Arnd
