Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE6E3C543E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 12:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348176AbhGLH51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 03:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344059AbhGLHUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 03:20:18 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A9AC0A3BD1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 00:13:52 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id q18so41420508lfc.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 00:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yq/UFrenbn5U27nZi+t65ATCq+LrRUcdfasK6Zxp/ek=;
        b=szfxyjjZC/FZPUsEC7d5zZzKMZwmmNkUxH3ct32p4YWsNhdN6Qq8R+Bbn8ko0Z8+ZU
         IfAvRWcwVIJfUDQP6ZaVLFjy+/LDtuqI5dsB+c2IzykvnVOxKxKsyv+oqzW9UgY1dq/i
         gNyiFXtY8s+hW2mSPg6reMHy8p42mLwSh0a6AmzHlNujdxTtjPm9LIHU4OqrEWJgpt1x
         5MbEWzNWeQoqoS183YEkzAtr+VaY63wldK1112tjbzlbiw45EJsCIKa+u/bBKCADM7D6
         2KlElO+tUVXSgFqsvydwLfbcWhP26QI61LgCWr/FYpqlXeM8PDrMkGRrAtI/ujykztLe
         DwlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yq/UFrenbn5U27nZi+t65ATCq+LrRUcdfasK6Zxp/ek=;
        b=Wz2NXlWGYB/xUCm6Q1F1uZaNFwMv0yCMqjP0tZWuL3g92zwj470vUSzXW1cneKsQFW
         BLm4US1yHAGhkkbRt8VMknUaYummpD1zNuqjSBbs9PxqQOdHaza7tGl+pWAtWcyratcv
         XUlMnnNtVD0BQAVHEPVPzyQgN9TCal77fJeARvIwV4osSWvpvKxGf+4XyB21ClnYEASG
         2s1fX3xhpNoqE9ja+qMUN6B3R662QNNFUdlASEkXeHU1+UnpOm7FQAL9LtMS7h7I6dUe
         DIuNn1gTopuprL8Tg2JQ9rGg6u77iojuPbxwuY33Ma0IfFj0fdE7ysjdMCXQK+L1tqkm
         WDmg==
X-Gm-Message-State: AOAM531Jo4TXWT/+QYWxgMWPkxVmc1GQwcVRVwx3gTM7PII20mzzyOz2
        jQQOuHemppSUD5bCyxKNioU/3c2zhNAHQ/t+E1Oamg==
X-Google-Smtp-Source: ABdhPJxVgmNhaAarbqoA52awVhTBexPODPrFqxiuWhd7DhMyCQD5fftKcjZCWM0T1HDjUSEqf+pWwmFwp5lPuHJiDLA=
X-Received: by 2002:a05:6512:3ca8:: with SMTP id h40mr39934181lfv.302.1626074031094;
 Mon, 12 Jul 2021 00:13:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210709104320.101568-1-sumit.garg@linaro.org>
 <20210709104320.101568-2-sumit.garg@linaro.org> <CAD=FV=W4zMtf-Cmu1KcboJTx=G52rr6Z7hy3LvT3fS76XEbtSw@mail.gmail.com>
In-Reply-To: <CAD=FV=W4zMtf-Cmu1KcboJTx=G52rr6Z7hy3LvT3fS76XEbtSw@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 12 Jul 2021 12:43:40 +0530
Message-ID: <CAFA6WYOYin8v6y+Pk4mqLHjENkhyGvmX_pqWVvT1TifTahJwYQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] kdb: Rename struct defcmd_set to struct kdb_macro_t
To:     Doug Anderson <dianders@chromium.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

Thanks for your review.

On Sat, 10 Jul 2021 at 03:07, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Fri, Jul 9, 2021 at 3:43 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > as that sounds more appropriate given its purpose.
>
> nit: Personally I prefer this to be a whole sentence that isn't just a
> continuation of the patch subject.
>

Okay I will use the whole sentence instead.

>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  kernel/debug/kdb/kdb_main.c | 38 ++++++++++++++++++-------------------
> >  1 file changed, 19 insertions(+), 19 deletions(-)
> >
> > diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> > index d8ee5647b732..d4897fbc9d2e 100644
> > --- a/kernel/debug/kdb/kdb_main.c
> > +++ b/kernel/debug/kdb/kdb_main.c
> > @@ -654,7 +654,7 @@ static void kdb_cmderror(int diag)
> >   * Returns:
> >   *     zero for success, a kdb diagnostic if error
> >   */
> > -struct defcmd_set {
> > +struct kdb_macro_t {
>
> Why the "_t" at the end? To me that implies that this is a typedef, so
> you'd declare a variable of this as:
>
> kdb_macro_t my_macro;
>
> ...instead of:
>
> struct kdb_macro_t my_macro;
>
> Not that I'm suggesting adding a typedef for this structure. It seems
> kernel convention is not to do typedefs for structures unless there's
> a strong reason to. Rather, I'm just suggesting removing the "_t" from
> the end.
>

Ack.

>
> > @@ -671,7 +671,7 @@ static int kdb_exec_defcmd(int argc, const char **argv);
> >
> >  static int kdb_defcmd2(const char *cmdstr, const char *argv0)
> >  {
> > -       struct defcmd_set *s = defcmd_set + defcmd_set_count - 1;
> > +       struct kdb_macro_t *s = kdb_macro + kdb_macro_count - 1;
>
> I guess the variable "s" was short for "set". Should it change to "m"
> ? Here and in other places below.
>

This variable is dropped in patch #3. Can we bear this variable name
until that patch?

>
> > @@ -727,13 +727,13 @@ static int kdb_defcmd(int argc, const char **argv)
> >                 kdb_printf("Command only available during kdb_init()\n");
> >                 return KDB_NOTIMP;
> >         }
> > -       defcmd_set = kmalloc_array(defcmd_set_count + 1, sizeof(*defcmd_set),
> > +       kdb_macro = kmalloc_array(kdb_macro_count + 1, sizeof(*kdb_macro),
> >                                    GFP_KDB);
>
> nit: the indentation is now off for the GFP_KDB since you changed the
> length of the previous line.

Okay, I will correct it.

>
> Sorry for not noticing those things in the previous version. I guess
> having this part of the change split out really did make it easier to
> review! ;-) Those are all pretty much just nits, so if they're fixed
> feel free to add my Reviewed-by tag.

Thanks.
-Sumit
