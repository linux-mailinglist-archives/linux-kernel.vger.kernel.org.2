Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F74B398483
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 10:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbhFBIuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 04:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbhFBIuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 04:50:21 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85090C061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 01:48:38 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id v14so1672168pgi.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 01:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LQdQi3xStl6Kr9DOForz1o5XSG8IKxBs+ngu1dz9KSs=;
        b=OTRt/idIXhe9VA58KVbJvM0YuSyxVWgActj1oPwYR7IDy2O74J8VE5Cbr6wSX5ivk1
         +eoZN/8K5kodQUyC4q/hz+UPga7t6YvIXixghnkVBriKErw7LySUc/SO3HMQdbuBp7Hf
         YNagvPpNlMLrmFL91hCXD1SE4qLX+zKNIS25JaDvvNnjE6ZE9fWV3FtR2fxfmiFotNsU
         8+dPaeHjNocaxbRZdLE+Y10Nen12pNKCfRTAotnt2IX5cZufJr9F7ta4x8wRCxn6T2+y
         cO22BVOpRC3oBv2+ttPWwmP/v2wBu7OjBdk10f41Y3cektK3jtXYOuS1BFCb9TZYm0zC
         0ndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LQdQi3xStl6Kr9DOForz1o5XSG8IKxBs+ngu1dz9KSs=;
        b=gQJM0mksJQJhNKLcltnBY42fH1tldgCtn8TKpBwxRfOzTYWKW9DjJtofJ0whHLP8qK
         uJ7GMZEYGrm51VgufZPpAKl3sdyNFUMQm+32tlojtEiaBCoRfZdYpl53kWhVDu1tni60
         AY6u5tTL3ukaF6j13kAv9Nh/SeA/d8V9XE2W5Os8QhRYDS29USXP6OcD5EVm77gF8GUw
         v5BVz4Y9+QtJug0Hv/ld2ki0De3kyT4abq0OByk4VK6yenBPotXqsOOkmxWOb6VuBnL1
         /Vr36kdJDaT2DQ/l6/TLb8IqhxoTVoMcgyKXtoNEDABrgWjA6unr3M/QqNqWABP3wpb9
         RaiA==
X-Gm-Message-State: AOAM532uWzuGlQZqzknXcfOC+m1YR14EtMTugyCeLBmET+XNWtyOzRP0
        FuP9t7HlApHtYj+nMy5CAY4buFqmYYCsBBLTiDw=
X-Google-Smtp-Source: ABdhPJxjL9C4tSb2zUJgAwp5n6Rr+jyC5ruY0xAfVp4VfO3FncrMwqipDFS/yFDeFN2cRMNPeHI5uZU9TR07urK6dpU=
X-Received: by 2002:a63:b507:: with SMTP id y7mr32751739pge.74.1622623717966;
 Wed, 02 Jun 2021 01:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <1622516210-10886-1-git-send-email-tiantao6@hisilicon.com>
 <1622516210-10886-2-git-send-email-tiantao6@hisilicon.com>
 <YLW+hZwoImx2wjwS@kroah.com> <4c9c7c17-e8d1-d601-6262-8064293a06a9@huawei.com>
 <YLcivXNwm75V+I2m@kroah.com> <d3c1ec35-fa62-46ed-9227-866e0a3c96b8@huawei.com>
In-Reply-To: <d3c1ec35-fa62-46ed-9227-866e0a3c96b8@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 2 Jun 2021 11:48:22 +0300
Message-ID: <CAHp75VeL4UMFX6oZWaFscTX6Ta5s714NeisR=vTh6mYMjyPi6w@mail.gmail.com>
Subject: Re: [PATCH 1/2] topology: use bin_attribute to avoid buff overflow
To:     "tiantao (H)" <tiantao6@huawei.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Tian Tao <tiantao6@hisilicon.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 2, 2021 at 9:45 AM tiantao (H) <tiantao6@huawei.com> wrote:
> =E5=9C=A8 2021/6/2 14:18, Greg KH =E5=86=99=E9=81=93:
> > On Wed, Jun 02, 2021 at 02:14:49PM +0800, tiantao (H) wrote:
> >> =E5=9C=A8 2021/6/1 12:58, Greg KH =E5=86=99=E9=81=93:
> >>> On Tue, Jun 01, 2021 at 10:56:49AM +0800, Tian Tao wrote:

...

> >>>>    /**
> >>>> + * bitmap_print_to_buf - convert bitmap to list or hex format ASCII=
 string
> >>>> + * @list: indicates whether the bitmap must be list
> >>>> + * @buf: page aligned buffer into which string is placed
> >>>> + * @maskp: pointer to bitmap to convert
> >>>> + * @nmaskbits: size of bitmap, in bits
> >>>> + * @off: offset in buf
> >>>> + * @count: count that already output
> >>>> + *
> >>>> + * the role of bitmap_print_to_buf and bitmap_print_to_pagebuf is
> >>>> + * the same, the difference is that the second parameter of
> >>>> + * bitmap_print_to_buf can be more than one pagesize.
> >>>> + */
> >>>> +int bitmap_print_to_buf(bool list, char *buf, const unsigned long *=
maskp,
> >>>> +                  int nmaskbits, loff_t off, size_t count)
> >>>> +{
> >>>> +  int len, size;
> >>>> +  void *data;
> >>>> +  char *fmt =3D list ? "%*pbl\n" : "%*pb\n";
> >>>> +
> >>>> +  len =3D snprintf(NULL, 0, fmt, nmaskbits, maskp);
> >>>> +
> >>>> +  data =3D kvmalloc(len+1, GFP_KERNEL);
> >>>> +  if (!data)
> >>>> +          return -ENOMEM;
> >>>> +
> >>>> +  size =3D scnprintf(data, len+1, fmt, nmaskbits, maskp);
> >>>> +  size =3D memory_read_from_buffer(buf, count, &off, data, size);
> >>>> +  kvfree(data);
> >>>> +
> >>>> +  return size;
> >>> Why is this so different from bitmap_print_to_pagebuf()?  Can't you j=
ust
> >>> use this function as the "real" function and then change
> >>> bitmap_print_to_pagebuf() to call it with a size of PAGE_SIZE?
> >> Do you mean do following change, is that correct? :-)
> > Maybe, it is whitespace corrupted, and it still feels like this functio=
n
> > is much bigger than it needs to be given the function it is replacing i=
s
> > only a simple sprintf() call.
> >
> >> +int bitmap_print_to_buf(bool list, char *buf, const unsigned long *ma=
skp,
> >> +                       int nmaskbits, loff_t off, size_t count)
> >> +{
> >> +       int len, size;
> >> +       void *data;
> >> +       const char *fmt =3D list ? "%*pbl\n" : "%*pb\n";
> >> +
> >> +       if (off =3D=3D LLONG_MAX && count =3D=3D PAGE_SIZE - offset_in=
_page(buf))
> >> +               return scnprintf(buf, count, fmt, nmaskbits, maskp);
> >> +
> >> +       len =3D snprintf(NULL, 0, fmt, nmaskbits, maskp);
> >> +
> >> +       data =3D kvmalloc(len+1, GFP_KERNEL);
> > Why do you need to allocate more memory?  And why kvmalloc()?
>
> Because the memory here will exceed a pagesize and we don't know the
> exact size, we have to call
>
> snprintf first to get the actual size. kvmalloc() is used because when
> physical memory is tight, kmalloc
>
> may fail, but vmalloc will succeed. It is not so bad that the memory is
> not requested here.

To me it sounds like the function is overengineered / lacks thought
through / optimization.
Can you provide a few examples that require the above algorithm?

> >> +       if (!data)
> >> +               return -ENOMEM;
> >> +
> >> +       size =3D scnprintf(data, len+1, fmt, nmaskbits, maskp);
> >> +
> >> +       size =3D memory_read_from_buffer(buf, count, &off, data, size)=
;
> >> +       kvfree(data);
> >> +
> >> +       return size;
> >> +}


--
With Best Regards,
Andy Shevchenko
