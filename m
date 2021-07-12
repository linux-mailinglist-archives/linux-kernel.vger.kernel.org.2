Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B748E3C5D83
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 15:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbhGLNoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 09:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbhGLNoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 09:44:06 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB19BC0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 06:41:16 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id x24so13849007qts.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 06:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xh0/hl3rEaM0oE3+jbjU5+PdwxFL2+pFn2TrMvbM6jg=;
        b=YBte8QnlpAinhGxAXgFETYp8h/u4RH5EU5HSraJkrGuMlD0GHW4UagAdFKfhz9iNKU
         jXajwJPWxl1XBeXs6ykJMgy7I+iym12hbFZQmugKXe/7sVZE9z8U88MvpyCe616z8tqp
         Ry5/zbfGU66TjbGODAmaUJSvyDNir9iFAosO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xh0/hl3rEaM0oE3+jbjU5+PdwxFL2+pFn2TrMvbM6jg=;
        b=hm2xzuWNNhzQyf9O2LSP5PO8Gu/wXt+mOS9LHQXXJSjWeqaIdt+lktD83QS8xlh+f+
         yqPvPn+thA87blbKvKJSZTxwV5JGalA0SjbkUK9EvHZp/bm3nsFLsMf+HV8+gmgGa3Jv
         qrkeG5zrSJhIlARvZDwd09qmLGJUAoHsd/jPR4NuJLevXx9aYgJBEXA2e9ayZv3mm8lv
         YoxaBGu6ZUsqlaKUHV13BVSvCTqCtTRNACV4PT//yJAcEaplEl+lgQgEFx/OqZHrXc8y
         Kn4+DjaazxLy8sPsJFtxF66BPQgLbHXcu6s64j+txnj+GjDGxjzZG6v7nZgzKHnk4OK6
         3D1A==
X-Gm-Message-State: AOAM5322/jrlkc1wUr5BKrqag0Swc4oM+sLEdg1HrTzfa+CP23Bp8eHT
        cIIKGKIaUfe4vM4sY+ADMWyTRfNQXIZkOA==
X-Google-Smtp-Source: ABdhPJwLqjOj72OFWJ3ChvARBO96TG/JP5kTPTzpQGn+gUY2qkciYULwYU71IH6HAGhafGa5x184Mw==
X-Received: by 2002:ac8:65d1:: with SMTP id t17mr3218933qto.180.1626097275704;
        Mon, 12 Jul 2021 06:41:15 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id z17sm5622325qts.24.2021.07.12.06.41.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 06:41:14 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id r132so29033976yba.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 06:41:14 -0700 (PDT)
X-Received: by 2002:a25:8082:: with SMTP id n2mr64512160ybk.79.1626097274290;
 Mon, 12 Jul 2021 06:41:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210709104320.101568-1-sumit.garg@linaro.org>
 <20210709104320.101568-2-sumit.garg@linaro.org> <CAD=FV=W4zMtf-Cmu1KcboJTx=G52rr6Z7hy3LvT3fS76XEbtSw@mail.gmail.com>
 <CAFA6WYOYin8v6y+Pk4mqLHjENkhyGvmX_pqWVvT1TifTahJwYQ@mail.gmail.com>
In-Reply-To: <CAFA6WYOYin8v6y+Pk4mqLHjENkhyGvmX_pqWVvT1TifTahJwYQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 12 Jul 2021 06:40:59 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XJAAz1a0DJF0f23e+6SPWrNW2EbhWp5xiq40OCLu4m5w@mail.gmail.com>
Message-ID: <CAD=FV=XJAAz1a0DJF0f23e+6SPWrNW2EbhWp5xiq40OCLu4m5w@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] kdb: Rename struct defcmd_set to struct kdb_macro_t
To:     Sumit Garg <sumit.garg@linaro.org>
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

Hi,

On Mon, Jul 12, 2021 at 12:13 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> > > @@ -671,7 +671,7 @@ static int kdb_exec_defcmd(int argc, const char **argv);
> > >
> > >  static int kdb_defcmd2(const char *cmdstr, const char *argv0)
> > >  {
> > > -       struct defcmd_set *s = defcmd_set + defcmd_set_count - 1;
> > > +       struct kdb_macro_t *s = kdb_macro + kdb_macro_count - 1;
> >
> > I guess the variable "s" was short for "set". Should it change to "m"
> > ? Here and in other places below.
> >
>
> This variable is dropped in patch #3. Can we bear this variable name
> until that patch?

Sure.

-Doug
