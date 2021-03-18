Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A106340BF6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 18:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbhCRRhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 13:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhCRRg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 13:36:56 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21A4C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 10:36:56 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id f19so3155017ion.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 10:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tu9gSWOmC9qi1oLsBayI43v5i3/1uM9fITXIC/EDoi4=;
        b=hM64YBflqL3+APM2OIUOZPpD5Qq243ADFkfIPoCxxWX1LjuBjbMDBD8hIA+uYNQpA8
         PNiRJ/ji+AsmzzpwwkuZT+Eg+/dZ/WobZkLn/9iatpsoIX+dfqJRslKb5VPZLuhUxw0F
         gmHzhJhXYB5cIjIdMrCo4GRJXAaFx6vwc4/oo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tu9gSWOmC9qi1oLsBayI43v5i3/1uM9fITXIC/EDoi4=;
        b=hlNwrEhDXUBR7Wby+rGwsfYL/4uYPHoVDVncoXtbN9yQo1dCX+tW3+f1s0exdrrQT0
         1Ee59Wr/HL/Wxq900zt3B6sesLTCYZKnVM2p27J84/EoFvJAjAG9DSnEM5nIyKBclLbe
         BSAnW6jRX20ToW8VKFTt/4M8YuJneEdEu2FAu0skypkQZBo1cxvJwAJDze6UbD65q5Oy
         /+SvgBa8halbAA411ktgdkC9QOjcyffhRhH6JfZalyLlACr7fNpRBDG78tkiTd5jYhjR
         a/sPnoIZ/XglWMX6iAQfaXW6oRBHfO64sjcYxSf8EFY3a22aC2PNGog6k31akOmGO3CC
         6kTw==
X-Gm-Message-State: AOAM53110eMEKCHUL6JGu8Xy9N+w2wzzge8+MOOIjtCCAEulWCZD1lMY
        G00WUp/7Kw8v3c8z4BT5yMAtSVh3HZkq7A==
X-Google-Smtp-Source: ABdhPJy19Oq/v0ndr+jVXd03U6pM3ZKT/GtEIP7dYeSoY9O2CqAexWMRWyN7+zUecQ19A0eHvyXTsw==
X-Received: by 2002:a6b:c881:: with SMTP id y123mr10798552iof.152.1616089015488;
        Thu, 18 Mar 2021 10:36:55 -0700 (PDT)
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com. [209.85.166.172])
        by smtp.gmail.com with ESMTPSA id d2sm1400485ilm.7.2021.03.18.10.36.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Mar 2021 10:36:54 -0700 (PDT)
Received: by mail-il1-f172.google.com with SMTP id c17so5636339ilj.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 10:36:54 -0700 (PDT)
X-Received: by 2002:a92:c266:: with SMTP id h6mr12784297ild.234.1616089014546;
 Thu, 18 Mar 2021 10:36:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210317104547.442203-1-leon@kernel.org> <CAHk-=wj+Bsc1T41qziHxf9DvrBrYSBWKj27hEL0EbysCGRPzTA@mail.gmail.com>
 <YFMHYUbPmpS+Kzcj@unreal>
In-Reply-To: <YFMHYUbPmpS+Kzcj@unreal>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 18 Mar 2021 10:36:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgdHxuQmhKR9oAS5bhahmo5CFj3x6YdHVPBCGhbSz6rEg@mail.gmail.com>
Message-ID: <CAHk-=wgdHxuQmhKR9oAS5bhahmo5CFj3x6YdHVPBCGhbSz6rEg@mail.gmail.com>
Subject: Re: [PATCH master] module: remove never implemented MODULE_SUPPORTED_DEVICE
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 12:55 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > Also, your email seems to have swallowed spaces at the ends of lines.
> >
> > I can (and did) apply the patch with "--whitespace=fix", but that then
> > causes git to fix some _other_ whitespace too, so the end result isn't
> > quite the same. Oh well.
> >
> > Please check what's up with your email sending client that it seems to
> > remove space at end of lines in patches.
>
> This is strange, I'm sending patches with "git send-email" with pretty
> standard settings:

Hmm. I can't tell whats' wrong, but both my own mailbox and the
lore.kernel.org clearly has missing whitespace at end of lines.

You can see it yourself with a simple

   b4 am 20210317104547.442203-1-leon@kernel.org

(assuming you have b4 installed, of course:

  https://pypi.org/project/b4/

but with a kernel.org address I'm sure you've seen the emails about it
even if you may not be a user).

> Also, I'm using mail.kernel.org as a SMTP especially to make sure that
> my mails are not mangled by our exchange server.

Yeah, the email looks fine in any other way technically, it passes SPF
and DKIM, and I don't see anything else strange going on either.

I think the same VIM issue that caused some whitespace line changes
for you in the patch might have then bitten you when you sent it out -
I know you must have edited the message, becasuse you have that

   "I'm sending this patch to you directly because it is much saner to
    apply it in one place instead of multiple patches saga that will [...]"

below the commit message, that you presumable added with "--annotate".

> Are you sure that such change came from me and not from "--whitespace=fix"?

Yup. See above on how you can just use b4 to download a copy yourself..

         Linus
