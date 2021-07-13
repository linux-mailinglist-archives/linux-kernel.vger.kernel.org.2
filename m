Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F89B3C6FAF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 13:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235879AbhGML1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 07:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235572AbhGML1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 07:27:06 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A02DC0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 04:24:16 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id n14so49633826lfu.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 04:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NHt/FAPTgdkn/SCe9iIi6CS+dHhhoK3TCnPN2KGs+7Q=;
        b=lmDlWFric5SOGHr8CKmkpMY3KyZMfDnA9ZalS30heq3oOLSas+s5EtHgQez5BBCC9F
         DzFzGOv6MeewWI83AWbc3YktnJCFJ/Row9Z7OZMSVUK8FwO0iQi79MrTXQO1DsXOp3ST
         VYkF1RfC3AbsHrC5WAipTewBjrLT8sXS3lkMEvYDyojecG+3Kn5SirWRgEnV4ZU0OS9U
         GPghg3Ofx04dFWveWSqu1VAhFsjXzQBthuZH6dXPKo+QvX2P1FKpwaTqV5yChDS9nDNB
         jCZddxIdhhKZ7P5AuGwXbdGJoilOCj6byThBU81tPabnsc19ijMjYrqnFKl+9sfHyapn
         czLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NHt/FAPTgdkn/SCe9iIi6CS+dHhhoK3TCnPN2KGs+7Q=;
        b=DRaFas87SveECJKpCXpWkiqdnDQbzGtQmrKp5fyrBcAIrdIXXIsvHtsLMB5FYPULou
         Dl5nsvhL2vgD4K8lTO5rPHq8eOyV9UiEAHgvpO7BQYjPBh7MrrQSdJqvSsiXcEai8xt2
         Tj39lfUHgrQ/6d5RbA8P2Cq9S6bF4ERehaLbZVgGjmQmS74/TSNyjToWzz8gGofijSg2
         j+bMTM85XYHub4m0NQu14bFT2ZMcyqp9biWgZ5vsJjUTmqmfn3KO/hRBrSH1PCT6xcu4
         uOy5+mizQLrBX8rpyqBYaKL8pnD8vfpD4VdJAzc+XUD+VRL1HIcDSjWaXimeUzH8d4P4
         PAnQ==
X-Gm-Message-State: AOAM531s1cQ8rqNo0vaIXGU0jwYWID0/jzWBhT3XdJOYjqlB7FM83yB3
        1MgT4eIpvbDIHNH4kOJ0GKoKm3qwbTR92e9PfgUF1Q==
X-Google-Smtp-Source: ABdhPJz6PSHuCCjPY2PtMT1jbw39ipBG5mD8rGosrIASuHXyjj6I47h50G3MX5yNF0RJcO/qWIa+sjdRXRUwHZWa+2M=
X-Received: by 2002:a19:e002:: with SMTP id x2mr3175379lfg.84.1626175454465;
 Tue, 13 Jul 2021 04:24:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210708122447.3880803-1-sumit.garg@linaro.org> <CAD=FV=UhL32e7spQjr38Lwng0D7mUK+R7iGnmBah=tXzzXsO5g@mail.gmail.com>
In-Reply-To: <CAD=FV=UhL32e7spQjr38Lwng0D7mUK+R7iGnmBah=tXzzXsO5g@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 13 Jul 2021 16:54:03 +0530
Message-ID: <CAFA6WYN4gMv9Hkuq=3v_UKg+Y1OvFfbOqgZxt7yGSd2RnVBdJw@mail.gmail.com>
Subject: Re: [PATCH v3] kdb: Get rid of custom debug heap allocator
To:     Doug Anderson <dianders@chromium.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

Thanks for your review.

On Tue, 13 Jul 2021 at 04:20, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Thu, Jul 8, 2021 at 5:25 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > @@ -233,10 +232,6 @@ extern struct task_struct *kdb_curr_task(int);
> >
> > @@ -52,48 +52,48 @@ int kdbgetsymval(const char *symname, kdb_symtab_t *symtab)
> >  }
> >  EXPORT_SYMBOL(kdbgetsymval);
> >
> > -static char *kdb_name_table[100];      /* arbitrary size */
> > -
> >  /*
> > - * kdbnearsym -        Return the name of the symbol with the nearest address
>
> nit: This is now kernel-doc, right? So start with "/**" ?
>

Ack.

> > - *     less than 'addr'.
> > + * kdbnearsym() - Return the name of the symbol with the nearest address
> > + *                less than @addr.
> > + * @addr: Address to check for near symbol
> > + * @symtab: Structure to receive results
> >   *
> > - * Parameters:
> > - *     addr    Address to check for symbol near
> > - *     symtab  Structure to receive results
> > - * Returns:
> > - *     0       No sections contain this address, symtab zero filled
> > - *     1       Address mapped to module/symbol/section, data in symtab
> > - * Remarks:
> > - *     2.6 kallsyms has a "feature" where it unpacks the name into a
> > - *     string.  If that string is reused before the caller expects it
> > - *     then the caller sees its string change without warning.  To
> > - *     avoid cluttering up the main kdb code with lots of kdb_strdup,
> > - *     tests and kfree calls, kdbnearsym maintains an LRU list of the
> > - *     last few unique strings.  The list is sized large enough to
> > - *     hold active strings, no kdb caller of kdbnearsym makes more
> > - *     than ~20 later calls before using a saved value.
> > + * WARNING: This function may return a pointer to a single statically
> > + * allocated buffer (namebuf). kdb's unusual calling context (single
> > + * threaded, all other CPUs halted) provides us sufficient locking for
> > + * this to be safe. The only constraint imposed by the static buffer is
> > + * that the caller must consume any previous reply prior to another call
> > + * to lookup a new symbol.
> > + *
> > + * Note that, strictly speaking, some architectures may re-enter the kdb
> > + * trap if the system turns out to be very badly damaged and this breaks
> > + * the single-threaded assumption above. In these circumstances successful
> > + * continuation and exit from the inner trap is unlikely to work and any
> > + * user attempting this receives a prominent warning before being allowed
> > + * to progress. In these circumstances we remain memory safe because
> > + * namebuf[KSYM_NAME_LEN-1] will never change from '\0' although we do
> > + * tolerate the possibility of garbled symbol display from the outer kdb
> > + * trap.
> > + *
> > + * Return:
> > + * * 0 - No sections contain this address, symtab zero filled
> > + * * 1 - Address mapped to module/symbol/section, data in symtab
> >   */
> >  int kdbnearsym(unsigned long addr, kdb_symtab_t *symtab)
> >  {
> >         int ret = 0;
> >         unsigned long symbolsize = 0;
> >         unsigned long offset = 0;
> > -#define knt1_size 128          /* must be >= kallsyms table size */
> > -       char *knt1 = NULL;
> > +       static char namebuf[KSYM_NAME_LEN];
>
> I guess this also ends up fixing a bug too, right? My greps show that
> "KSYM_NAME_LEN" is 512

I can see "KSYM_NAME_LEN" defined as 128 here [1]. Are you looking at
any other header file?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/kallsyms.h#n18

> and the first thing kallsyms_lookup() does it
> zero out byte 511. Previously we were only allocating 128 bytes so I
> guess we were writing past the end.
>
> Assuming I understood correctly, maybe mention the bugfix in the commit text?
>
>
> > @@ -102,63 +102,14 @@ int kdbnearsym(unsigned long addr, kdb_symtab_t *symtab)
> >         symtab->sym_end = symtab->sym_start + symbolsize;
> >         ret = symtab->sym_name != NULL && *(symtab->sym_name) != '\0';
> >
> > -       if (ret) {
> > -               int i;
> > -               /* Another 2.6 kallsyms "feature".  Sometimes the sym_name is
> > -                * set but the buffer passed into kallsyms_lookup is not used,
> > -                * so it contains garbage.  The caller has to work out which
> > -                * buffer needs to be saved.
> > -                *
> > -                * What was Rusty smoking when he wrote that code?
> > -                */
> > -               if (symtab->sym_name != knt1) {
> > -                       strncpy(knt1, symtab->sym_name, knt1_size);
> > -                       knt1[knt1_size-1] = '\0';
> > -               }
> > -               for (i = 0; i < ARRAY_SIZE(kdb_name_table); ++i) {
> > -                       if (kdb_name_table[i] &&
> > -                           strcmp(kdb_name_table[i], knt1) == 0)
> > -                               break;
> > -               }
> > -               if (i >= ARRAY_SIZE(kdb_name_table)) {
> > -                       debug_kfree(kdb_name_table[0]);
> > -                       memmove(kdb_name_table, kdb_name_table+1,
> > -                              sizeof(kdb_name_table[0]) *
> > -                              (ARRAY_SIZE(kdb_name_table)-1));
> > -               } else {
> > -                       debug_kfree(knt1);
> > -                       knt1 = kdb_name_table[i];
> > -                       memmove(kdb_name_table+i, kdb_name_table+i+1,
> > -                              sizeof(kdb_name_table[0]) *
> > -                              (ARRAY_SIZE(kdb_name_table)-i-1));
> > -               }
> > -               i = ARRAY_SIZE(kdb_name_table) - 1;
> > -               kdb_name_table[i] = knt1;
> > -               symtab->sym_name = kdb_name_table[i];
> > -               knt1 = NULL;
>
> I definitely had a hard time following exactly what all the cases were
> handling and if they were all right, but I agree that we can kill the
> old code (yay!)
>
>
> > @@ -249,6 +200,7 @@ void kdb_symbol_print(unsigned long addr, const kdb_symtab_t *symtab_p,
> >                       unsigned int punc)
> >  {
> >         kdb_symtab_t symtab, *symtab_p2;
> > +
> >         if (symtab_p) {
> >                 symtab_p2 = (kdb_symtab_t *)symtab_p;
> >         } else {
>
> nit: unrelated whitespace change?
>

Will revert.

>
> All comments above are nits and not terribly important, so:
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Thanks,
-Sumit
