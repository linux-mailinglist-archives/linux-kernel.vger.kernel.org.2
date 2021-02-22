Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 184F83210A6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 07:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbhBVGCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 01:02:50 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:41335 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbhBVGCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 01:02:45 -0500
Received: by mail-ed1-f50.google.com with SMTP id i14so20037536eds.8
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 22:02:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ykFLf5yWwe+sB4RX2ZVcOTxdgfkTPnzYuHv9v6HvKj8=;
        b=n+Dt9N6ZQ1YishDO0EPv9GqxLtb7k6ZJr/LmZz1GZbL7diq4jDUt2oASVP3x++/nfg
         C1nNAGTlss/i+YFwaIPuxI6TSIjwh2I7ilIX8ovxbhQ+UMlTXx+Bzo9S9NBKs0UDMyoh
         W2/4A42x0DWmUEMWZTyceS2wgHieh3pVTzN5BPp9D7vOpuhmxvM+dBOtqXplz2gq4W24
         76OLZ7dEqXdeZiQnzTypEFkWViWGCGtLXrO7PpZeSwcqXh9EUuGTir7LrIKKEtgZvOE7
         NH205DZu2VHZHEtnVWhYKRoYwTB50e2yyO672gpYrLyRrBaHHTSH535Wasu7xtLKcVhN
         UzyQ==
X-Gm-Message-State: AOAM533OIVyxHrpNjnE+BhqiOxQNgIp3i88d6s31kvVTcEm+e8RpHR8n
        b43UNGHUgIPa+KtXK3BUXnkEqIk2LdWGag==
X-Google-Smtp-Source: ABdhPJzabnI0F6DfCtQ4D4xyOTBjMWapP51lOn+alTlsxC4mWZenWXPRTdKd851xPSGilab+7FUcUA==
X-Received: by 2002:aa7:d34e:: with SMTP id m14mr21048973edr.223.1613973722769;
        Sun, 21 Feb 2021 22:02:02 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id f22sm9551826eje.34.2021.02.21.22.02.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Feb 2021 22:02:02 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id h10so20289926edl.6
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 22:02:02 -0800 (PST)
X-Received: by 2002:aa7:d8da:: with SMTP id k26mr20950996eds.364.1613973722162;
 Sun, 21 Feb 2021 22:02:02 -0800 (PST)
MIME-Version: 1.0
References: <YDDzqPT81QBGpTBB@karthik-strix-linux.karthek.com> <20210222054029.GF2087@kadam>
In-Reply-To: <20210222054029.GF2087@kadam>
From:   karthek <mail@karthek.com>
Date:   Mon, 22 Feb 2021 11:31:48 +0530
X-Gmail-Original-Message-ID: <CAJ5zXr0_QE6JLZ+rGeoaETexqvhS7LXdtAH3fqpZ=i1zxQJUYg@mail.gmail.com>
Message-ID: <CAJ5zXr0_QE6JLZ+rGeoaETexqvhS7LXdtAH3fqpZ=i1zxQJUYg@mail.gmail.com>
Subject: Re: [PATCH] staging: wimax: fix sparse incorrect type issue
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mukul Mehar <mukulmehar02@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 11:10 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Sat, Feb 20, 2021 at 05:04:00PM +0530, karthik alapati wrote:
> > fix sparse warning by casting to explicit user address-space
> > pointer type
> >
> > Signed-off-by: karthik alapati <mail@karthek.com>
> > ---
> >  drivers/staging/wlan-ng/p80211netdev.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/wlan-ng/p80211netdev.c b/drivers/staging/wlan-ng/p80211netdev.c
> > index 6f9666dc0..70570e8a5 100644
> > --- a/drivers/staging/wlan-ng/p80211netdev.c
> > +++ b/drivers/staging/wlan-ng/p80211netdev.c
> > @@ -569,7 +569,7 @@ static int p80211knetdev_do_ioctl(struct net_device *dev,
> >               goto bail;
> >       }
> >
> > -     msgbuf = memdup_user(req->data, req->len);
> > +     msgbuf = memdup_user((void __user *)req->data, req->len);
>
> This doesn't fix anything it just silences the warning.  Linus Torvalds
> worked very hard to create Sparse for the express purpose of printing
> the warning.  People don't realize that warnings are very valuable
> because they show where the bugs are.
>
> Please look at this some more and figure out how to fix the warning.
>
> To be honest, I'm tempted to not accept any patch which doesn't also fix
> the buffer overflows when we pass:
>
>         result = p80211req_dorequest(wlandev, msgbuf);
>
> How do we know that "msgbuf" is large enough?
>
> regards,
> dan carpenter
>

Thanks dan but right after sending this patch i immediately replied to
it stating
to ignore this patch as i found this already applied in staging-testing branch
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/commit/?h=staging-testing&id=3a8a144d2a754df45127c74e273fa166f690ba43
