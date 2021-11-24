Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5523A45CDAC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 21:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245219AbhKXUOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 15:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244929AbhKXUOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 15:14:53 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64518C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 12:11:43 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id bu18so10439221lfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 12:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p7+nz+d0O2KsjI45EJDPKEH22C4YsE6p71ZBSyN6O34=;
        b=qE8Z007HokAZKK5WJ3/ggWkoeHTPrnv53wPZA4dOawT7uYth8b4e2Jbbi/eLD+JYAW
         8J9yDisDSo9RsSbBenbFP180nKbmZU3mOUW3/ITqiKtJScJ/F7qJ5m14o7hj/rlomqD1
         DuwBjcUUX0j0Fy0ZZ9qgZXghV3MKmLVmeXUcq+ofPjMRYma2bKVeMkFb5Aehf7cdeOmY
         MHr1Vi8a3IJwGB4aJ+4yhRTb0Sm/Hoy51XLvHscmwtgocX2MIKIm/27umFtC26RuLLEs
         wLwyILx3Oy+iP2LjDqYzrFjbE4g2/Hr50Pi5AZvTOlJhokRqgBqca3BYdFCOvkMcYAFp
         WQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p7+nz+d0O2KsjI45EJDPKEH22C4YsE6p71ZBSyN6O34=;
        b=w50MoNprmjES0njZerStAYTaIXcncb7dxHomO0H/fynFEYY7cs4u03t21slTUae7Ml
         PcmY5ApExh7K5ujLG44yfHHOlvRIx9KNYmLcLKoEIYIb72su4o6T1jy40cuFJUZZK86R
         D7EG8jl8K3XYfnPpGqxXWuXh9yGgFg6LwXg32Vh4uB7FDhMwfPx0MNb/Bpo6zgYEkRz9
         mXfbn09qeI2kxI5FGHjEbRpAxJr1Qarhoe/bqHGxCdaCaLWI4Nr0kulHtP4LYGRpMDij
         oUY2+2NZTwa/qEqhcnUNbTCsS/epFGI8mV69geRAw4B2FjZ2bjqyOluVS7g9m7Ip1rcs
         QGeA==
X-Gm-Message-State: AOAM531PtDC0WBJ4dfjCFOocZiANFrXXDVh+Xm+JOogJx9xSd74u6r71
        7fIciM+qNpl5AebIeQ6xzY3M0EgTdKVrmhfQGRoLUPVcNMdOvQ==
X-Google-Smtp-Source: ABdhPJzpcVU/KymiI6k3iLbMjLX31V/8O0TsCpf1d6Lsp75R7AlqzB55CN7UWmmrxpEXx+e27qWr5uwUHh7JKO1vEl8=
X-Received: by 2002:a19:7417:: with SMTP id v23mr18329865lfe.19.1637784701487;
 Wed, 24 Nov 2021 12:11:41 -0800 (PST)
MIME-Version: 1.0
References: <20211123191737.1296541-1-tkjos@google.com> <20211123191737.1296541-2-tkjos@google.com>
 <20211124130104.GI6514@kadam>
In-Reply-To: <20211124130104.GI6514@kadam>
From:   Todd Kjos <tkjos@google.com>
Date:   Wed, 24 Nov 2021 12:11:29 -0800
Message-ID: <CAHRSSEzKbKuuoUi1DkH6e7mbUSawt0Zi591TsiYBt1b9j69CFQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] binder: avoid potential data leakage when copying txn
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, christian@brauner.io, arve@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        maco@google.com, joel@joelfernandes.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 5:01 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Tue, Nov 23, 2021 at 11:17:35AM -0800, Todd Kjos wrote:
> > Transactions are copied from the sender to the target
> > first and objects like BINDER_TYPE_PTR and BINDER_TYPE_FDA
> > are then fixed up. This means there is a short period where
> > the sender's version of these objects are visible to the
> > target prior to the fixups.
> >
> > Instead of copying all of the data first, copy data only
> > after any needed fixups have been applied.
> >
>
> This patch needs a fixes tag.

Sure, it goes back to the original submission, so I'll add:

Fixes: 457b9a6f09f0 ("Staging: android: add binder driver")

>
> So this patch basically fixes the simple part of the info leak and
> patch 3 fixes the complicated part.  Have I understood that correctly?

Yes.

>
> > @@ -2956,7 +2984,11 @@ static void binder_transaction(struct binder_proc *proc,
> >                       }
> >                       ret = binder_translate_fd_array(fda, parent, t, thread,
> >                                                       in_reply_to);
> > -                     if (ret < 0) {
> > +                     if (ret < 0 ||
> > +                         binder_alloc_copy_to_buffer(&target_proc->alloc,
> > +                                                     t->buffer,
> > +                                                     object_offset,
> > +                                                     fda, sizeof(*fda))) {
> >                               return_error = BR_FAILED_REPLY;
> >                               return_error_param = ret;
>
> "ret" is not a negative error code if binder_translate_fd_array()
> succeeds but binder_alloc_copy_to_buffer() fails.

You are right. return_error_param would be 0 in this case. Will
capture the return of binder_alloc_copy_to_buffer(). Thanks.

>
>
> >                               return_error_line = __LINE__;
> > @@ -3028,6 +3060,19 @@ static void binder_transaction(struct binder_proc *proc,
> >                       goto err_bad_object_type;
> >               }
> >       }
>
> regards,
> dan carpenter
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
