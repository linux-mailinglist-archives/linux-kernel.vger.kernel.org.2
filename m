Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3833B3D88C6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 09:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbhG1HZg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 28 Jul 2021 03:25:36 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:57791 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbhG1HZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 03:25:35 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MNbtD-1mXD4o0kdn-00P2zg for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021
 09:25:33 +0200
Received: by mail-wr1-f43.google.com with SMTP id b9so1234011wrx.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 00:25:33 -0700 (PDT)
X-Gm-Message-State: AOAM532JBVxaxsZLJTGnKV1I5RruXUpMnWG1DxY2QlUOY84+1j34drMr
        JYsg3MrhnCTIsSFDXqYlA3WIT35iiRdY3RoC3qs=
X-Google-Smtp-Source: ABdhPJxRtBMlwAWq2x2oW4ouDDNGxilMuC5slRThWpCJx/8ezTD4ks0L6nleI6zL5AuFJ1FQqnpb2Wkpoc+jh716+ts=
X-Received: by 2002:a5d:44c7:: with SMTP id z7mr19772907wrr.286.1627457132895;
 Wed, 28 Jul 2021 00:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210727131217.15092-1-xianting.tian@linux.alibaba.com>
 <CAK8P3a15ykABd61Rad5iaZtGN=-+Guk0CNyCMK3XD7TgubG7hg@mail.gmail.com> <be29127d-8cec-c7b8-ac96-4da94198dc03@linux.alibaba.com>
In-Reply-To: <be29127d-8cec-c7b8-ac96-4da94198dc03@linux.alibaba.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 28 Jul 2021 09:25:16 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1O02Ho2dM3F+bUXf9Ze8uRKYzY5fFmRGpszUXg_nrH4w@mail.gmail.com>
Message-ID: <CAK8P3a1O02Ho2dM3F+bUXf9Ze8uRKYzY5fFmRGpszUXg_nrH4w@mail.gmail.com>
Subject: Re: [PATCH] virtio-console: avoid DMA from vmalloc area
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Amit Shah <amit@kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Omar Sandoval <osandov@fb.com>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:vRJWoNCBlmgvl5yKfDMi+GLxuLJUL6s+QRViReWZ+ih0bTRK7md
 iac8e0EVmC1IZOtXYe/L+s34WH/3jXi+yS7GAfZy5HrzJ06lpY+goWXpWnKtW/4w0ypkyYj
 k0vze3SdFVQ4vwfX+jTTPH3PWjIRhwvN3zpVgjrCDUJOKRbL9ar+Fv7SPSyXgUN6F8qlInS
 txr2CcueNWQuI5mgQ2tJQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:NOSFvX/8Edk=:ArroLqTi/lvuHZn3tyMwcr
 uIYwoERIMwvOE3Ay9QR/Iro5HLYofYd55xbYudiYHnyvHGcRtHWrQgsBDNMWxw8F8ZdNZapqa
 8OBOYT8kUgeq5YkZTBqaQziP/MJFDqWQmf+a5Y/ebtp+KvZSdkBne4EjIDOxZNNtTJ+KGKg95
 nFCcyxCU/r4vuE0qiKWu2w9lNHe5V6gBGAdUhiz1mZlEJr+LTwNYBifbqJ6a1yexKakdMbIPA
 xq2pNU0DrcypccXd06oKiuq7RmN223FyXspuwa0AzYkG6Z87eXl5nZih4/A3mmNirCDZzcJn7
 pw+TBQ1g0XXMMUjs9A3fAkP89XcUtrQ3N02DrY1axPWKAOUmWwYC/1zFqmKJ9F3C6Rvdim/6w
 g1JP/DXhuvaG7l1kHw4mmjWwaj7nNiLnB+QDz4P/kgpq1u33F2pnaWcD71wUdilnOXVd3XitH
 +p8TctUm5LOmaxtxGySQYJXXlvrRUn70iG6/4OXZH0Z52AUu5hmtAYihy4xw1egcwLKY7b58m
 lkDlkkqxXD6jvUE4q/ahBHp6FgM0WZHPjT0cXRuj4VUJOsv7RcuU8GodlTZwmDKf/XCcakEwu
 Mr4ixAS/4FZfowUi+AmWKKZYCoN3XDoMxvqv0BG0u8q7q1NGDRQEKxGA9ti27+4Xep20z6oPN
 m2EEPNWHeDSvbc18Qtsdg02tui6hdpP5cu83WEpUJRQAqOIgWUnyYoIw3W87Jo7rdNibInAlx
 jt3nsszrTgyxW0T0MIWMO9ZRVJy0sf/0cMobMybvebH8uZWWbemVv2YBAflGfzx5RUF1MQmnf
 fjZvgOjy9gF5IedXaXIL1KtIykulSN5jIhQG4VOm7jJn9n6Dg7p+MOKSWJm/rtVNH4TXQ+Ll9
 cWAcAEM8yDc/AqBu/wcneBgsy6ALnkCJBnJawTsS1VptAWJQ0BHNioEOw4Sx0gqbePzKpx1WN
 w1ANjYvUyqc42yAZ3DcxyzwMTzZr6Iu3+WexhGXYi/ak/xIRHlet8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 4:59 AM Xianting Tian
<xianting.tian@linux.alibaba.com> wrote:
>
> Arnd, thanks for your quick reply,
>
> As we know put_chars() of virtio-console is registered to hvc framework.
> I go throughed the code, actually there are totally three places that
> put_chars() is called in hvc driver,  but only 1 has issue which is
> fixed by commit c4baad5029.

Ah, good. Knowing what the callers are definitely helps. ;-)

> So I think the scenario that the buf is from "ioremap(), kmap_atomic() ,
> fixmap, loadable module" doesn't exist for virtio-console.
> If there is something wrong about above description, please correct me,
> thanks.

The description is good then.

> Three places that put_chars() is called in hvc driver:
> 1， it is on stack buf,  it is not ok for dma
>      hvc_console_print():
>          char c[N_OUTBUF] __ALIGNED__;
>          cons_ops[index]->put_chars(vtermnos[index], c, i);
>
> 2， just one byte, no issue for dma
>      static void hvc_poll_put_char(struct tty_driver *driver, int line,
> char ch)
>      {
>          struct tty_struct *tty = driver->ttys[0];
>          struct hvc_struct *hp = tty->driver_data;
>          int n;
>
>          do {
>              n = hp->ops->put_chars(hp->vtermno, &ch, 1);
>          } while (n <= 0);
>      }

This is actually the same as the first, taking the address of a
function argument forces it onto the stack.

> 3,  hp->outbuf is allocated in hvc_alloc() via kzalloc(), no issue for dma
>      static int hvc_push(struct hvc_struct *hp)
>      {
>          int n;
>
>          n = hp->ops->put_chars(hp->vtermno, hp->outbuf, hp->n_outbuf);
>          …
>      }

ok.

I have a new question then: are there any other hvc backends that do
DMA, or is the virtio-console driver the only one? If there are any others,
I think this should better be fixed in the hvc framework, by changing it
to never pass stack data into the put_chars() function in the first place.

It may be possible to just use the 'hp->n_outbuf' buffer in all three cases.

       Arnd
