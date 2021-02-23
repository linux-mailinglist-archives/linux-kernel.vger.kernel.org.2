Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4E432235F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 02:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbhBWBMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 20:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbhBWBMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 20:12:06 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F06C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 17:11:26 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id q7so15432557iob.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 17:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pxy3fWqnHXSmeJ/dQM3CI4wtPt6Zw1lUR2mc3ToJ5/U=;
        b=M8F6iblXQybOLnVOmmxssZ95gs5WM3Mkswy2mvjKceLanmgSFTpdoTLL9rzFP/zgn/
         koxPEgzm+G/MloTKcpih+xM/3SAVmV2lPBjsKnIn77ZUdkS017idJOWt6/akFMBhk5KE
         xAWLjPdhFiQpN3/PfUxjqrm8hRE1qPBnzOO4iAc1gh+p7mSUWt58Uw5sCJ5YYS/UklEk
         F/iEZsp8OFkkSpuZB37NA/Y7Z5ECBrw+KxLXtQgq3eZeEIDoGGabhdrhlau1rbu1809s
         pZccHcVybvPwdRx7+Uz3U5KRHPkDb/dV9H3I788/iAmwGcbwRxOMsWmx1RFk+p7NPwbI
         acng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pxy3fWqnHXSmeJ/dQM3CI4wtPt6Zw1lUR2mc3ToJ5/U=;
        b=XqgH15g/uueuZNZ60EaoFGdIdyKeDrdBMzzrxVas7qQCCfr6uh3yFyOikOuq6XQ4ik
         hoH/caxCJk81GWAYQBzJwui0EspiYIkcZvGSAgiDz0w0ML2gQCB/YqtEwOUzaF1klP/V
         qywZQXfQdlhKcIevwk4XZEJCD/JvBNahv2ErYan+XkFIu0KNXexS7dtmUF+CRP17mK38
         KyGcDQ3zquC/usH0ObTIL5ueNqWduTK2iRSwSZznqTxEJomzt/5a6KCZ2rMW2G5U7z7G
         qWwfXNFD2bQ5kzIeRvhlXuwc2XCSCjtRoLvU4QNIOq1QLaHjXFAJEC7Zq4sRvA8F5PT7
         GCfg==
X-Gm-Message-State: AOAM533SA3pYV7IvtPjlVEhlmR6LSe9mYSG6mar8PvU2D4S1WgA0KwBh
        xkQc0tTqVrFfNz9HM0US7cJiTM6ybxL1YYMkgpw=
X-Google-Smtp-Source: ABdhPJzPK/u7Ujb2x3bbp+XmeDgOyG4RhdiosVYeJg+U+4wRS+v45yBrXadC3+gmtPi82gnqgG8KdB1pUaeG671I3Kw=
X-Received: by 2002:a5d:9510:: with SMTP id d16mr17604451iom.81.1614042685855;
 Mon, 22 Feb 2021 17:11:25 -0800 (PST)
MIME-Version: 1.0
References: <20210215155141.47432-1-laoar.shao@gmail.com> <20210215155141.47432-4-laoar.shao@gmail.com>
 <YDOluaRK2CHtQyQD@alley>
In-Reply-To: <YDOluaRK2CHtQyQD@alley>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 23 Feb 2021 09:10:49 +0800
Message-ID: <CALOAHbBYruMHyHGXcnjt8wyDokE+pvFwLTW0i=XrMSatDUVLFA@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] vsprintf: dump full information of page flags in pGp
To:     Petr Mladek <pmladek@suse.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>, penberg@kernel.org,
        David Rientjes <rientjes@google.com>, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Joe Perches <joe@perches.com>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 8:38 PM Petr Mladek <pmladek@suse.com> wrote:
>
> Hello,
>
> first, I am sorry for the late reply. I have marked the thread as
> proceed by mistake last week...
>
>
> On Mon 2021-02-15 23:51:41, Yafang Shao wrote:
> > Currently the pGp only shows the names of page flags, rather than
> > the full information including section, node, zone, last cpupid and
> > kasan tag. While it is not easy to parse these information manually
> > because there're so many flavors. Let's interpret them in pGp as well.
> >
> > To be compitable with the existed format of pGp, the new introduced ones
> > also use '|' as the separator, then the user tools parsing pGp won't
> > need to make change, suggested by Matthew. The new information is
> > tracked onto the end of the existed one.
> >
> > One example of the output in mm/slub.c as follows,
> > - Before the patch,
> > [ 6343.396602] Slab 0x000000004382e02b objects=33 used=3 fp=0x000000009ae06ffc flags=0x17ffffc0010200(slab|head)
> >
> > - After the patch,
> > [ 8448.272530] Slab 0x0000000090797883 objects=33 used=3 fp=0x00000000790f1c26 flags=0x17ffffc0010200(slab|head|node=0|zone=2|lastcpupid=0x1fffff)
> >
> > The documentation and test cases are also updated. The output of the
> > test cases as follows,
> > [11585.830272] test_printf: loaded.
> > [11585.830454] test_printf: all 388 tests passed
> > [11585.831401] test_printf: unloaded.
> >
> > --- a/lib/vsprintf.c
> > +++ b/lib/vsprintf.c
> > +static
> > +char *format_page_flags(char *buf, char *end, unsigned long flags)
> > +{
> > +     unsigned long main_flags = flags & (BIT(NR_PAGEFLAGS) - 1);
> > +     bool append = false;
> > +     int i;
> > +
> > +     /* Page flags from the main area. */
> > +     if (main_flags) {
> > +             buf = format_flags(buf, end, main_flags, pageflag_names);
> > +             append = true;
> > +     }
> > +
> > +     /* Page flags from the fields area */
> > +     for (i = 0; i < ARRAY_SIZE(pff); i++) {
> > +             /* Skip undefined fields. */
> > +             if (!pff[i].width)
> > +                     continue;
> > +
> > +             /* Format: Flag Name + '=' (equals sign) + Number + '|' (separator) */
> > +             if (append) {
> > +                     if (buf < end)
> > +                             *buf = '|';
> > +                     buf++;
> > +             }
> > +
> > +             buf = string(buf, end, pff[i].name, *pff[i].spec);
>
> I have found one more small issue.
>
> The purpose of the flag-specific printk_spec is to define the format
> how the value is printed. The name of the flag should be printed
> using default_str_spec.
>
> It works because the string is printed as-is with both
> default_dec_spec and default_flag_spec. But it would be better
> to use the string format.
>

Thanks for the explanation.

> > +             if (buf < end)
> > +                     *buf = '=';
> > +             buf++;
> > +             buf = number(buf, end, (flags >> pff[i].shift) & pff[i].mask,
> > +                          *pff[i].spec);
> > +
> > +             append = true;
> > +     }
> > +
> > +     return buf;
> > +}
>
> Otherwise, the patch looks to me. The issue is cosmetic and might be
> fixed either by re-spinning just this patch or by a followup patch.

I will send a separate followup patch.

> Either way, feel free to use:
>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
>

Thanks

> Another question where to push this change. It is pity the we
> finalized it in the middle of the merge window. It has to spend
> at least few days in linux-next.
>
> I would like to hear from Andy before I push it into linux-next.
> There is still theoretical chance to get it into 5.12 when Linus
> prolongs the merge window by one week. it has been delayed by
> a long lasting power outage.
>
> Best Regards,
> Petr



-- 
Thanks
Yafang
