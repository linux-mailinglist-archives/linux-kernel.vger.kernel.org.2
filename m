Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10DAC3C6684
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 00:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbhGLWxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 18:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhGLWxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 18:53:01 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D47C0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 15:50:11 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id m68so4232065qke.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 15:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8tOmeaxzU/5dyAkLckhWnlSYiFgBI+kaI21VHEF/b6M=;
        b=WwrkoVhPitQE1NPvoRg0jQh5uLWZl4xztQED2mdlBOjC9JnGmCOdR+CPHjyB9ySlOY
         guBSMeK0L+P3SXT1a2riPV2ygwdtcPR1UHy3FFE632ui92g5BlZCx7vOY+8kZqHg+5QQ
         +EKh1b4r7t3psWAmdABE2CtLszeE14NWh4xnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8tOmeaxzU/5dyAkLckhWnlSYiFgBI+kaI21VHEF/b6M=;
        b=Sz+9uYprOuSEoeFDPbYMtMLkNn1aFfki+bCrc9dpQBsQS6Ss39JnPY355r47EtMFQW
         PCHlOaz3GrLMZFpmYFKe4s3iDd/0OperBAhFSosL1zCpi+EEtswBnXMiK/k/ClNoh7D8
         ktWQsHVlzyLZG5GzczQb4ZQ2xZmQmX6Wh0TxR6zKSmaVXRIbyVAG1dpjqSiSHtun5G1s
         uNMsZfSSWcno9LLC2CbCVqg4thptcM0ZHaY2zG0CabrUCBv0Lf6bggSR+jb4gdpfXzq5
         UabqLyBeTHls0e37gjFxwl9O+GetnNZdV7HK9G38h+fpxpuN1WJ0KIEQJerHlnAhwyCV
         MyXA==
X-Gm-Message-State: AOAM530sI6wziPfhN/RzaO6J2OfIg7uw3lefSkyx4MdjEauKvAX4m65y
        wP8ez3jO02lfMwTruVWO0fIp7a/hu78noQ==
X-Google-Smtp-Source: ABdhPJz8Yyr2fK/SWEAVm4W8XHEtGKuwtPadh9sbg4SURAAr2ic96T2U9S0BZ2BDG7F4cFrAmdljVw==
X-Received: by 2002:ae9:f447:: with SMTP id z7mr1083086qkl.294.1626130210015;
        Mon, 12 Jul 2021 15:50:10 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id d16sm6087033qtj.69.2021.07.12.15.50.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 15:50:09 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id t186so12692746ybf.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 15:50:09 -0700 (PDT)
X-Received: by 2002:a25:6088:: with SMTP id u130mr1760382ybb.257.1626130208512;
 Mon, 12 Jul 2021 15:50:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210708122447.3880803-1-sumit.garg@linaro.org>
In-Reply-To: <20210708122447.3880803-1-sumit.garg@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 12 Jul 2021 15:49:56 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UhL32e7spQjr38Lwng0D7mUK+R7iGnmBah=tXzzXsO5g@mail.gmail.com>
Message-ID: <CAD=FV=UhL32e7spQjr38Lwng0D7mUK+R7iGnmBah=tXzzXsO5g@mail.gmail.com>
Subject: Re: [PATCH v3] kdb: Get rid of custom debug heap allocator
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 8, 2021 at 5:25 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> @@ -233,10 +232,6 @@ extern struct task_struct *kdb_curr_task(int);
>
> @@ -52,48 +52,48 @@ int kdbgetsymval(const char *symname, kdb_symtab_t *symtab)
>  }
>  EXPORT_SYMBOL(kdbgetsymval);
>
> -static char *kdb_name_table[100];      /* arbitrary size */
> -
>  /*
> - * kdbnearsym -        Return the name of the symbol with the nearest address

nit: This is now kernel-doc, right? So start with "/**" ?

> - *     less than 'addr'.
> + * kdbnearsym() - Return the name of the symbol with the nearest address
> + *                less than @addr.
> + * @addr: Address to check for near symbol
> + * @symtab: Structure to receive results
>   *
> - * Parameters:
> - *     addr    Address to check for symbol near
> - *     symtab  Structure to receive results
> - * Returns:
> - *     0       No sections contain this address, symtab zero filled
> - *     1       Address mapped to module/symbol/section, data in symtab
> - * Remarks:
> - *     2.6 kallsyms has a "feature" where it unpacks the name into a
> - *     string.  If that string is reused before the caller expects it
> - *     then the caller sees its string change without warning.  To
> - *     avoid cluttering up the main kdb code with lots of kdb_strdup,
> - *     tests and kfree calls, kdbnearsym maintains an LRU list of the
> - *     last few unique strings.  The list is sized large enough to
> - *     hold active strings, no kdb caller of kdbnearsym makes more
> - *     than ~20 later calls before using a saved value.
> + * WARNING: This function may return a pointer to a single statically
> + * allocated buffer (namebuf). kdb's unusual calling context (single
> + * threaded, all other CPUs halted) provides us sufficient locking for
> + * this to be safe. The only constraint imposed by the static buffer is
> + * that the caller must consume any previous reply prior to another call
> + * to lookup a new symbol.
> + *
> + * Note that, strictly speaking, some architectures may re-enter the kdb
> + * trap if the system turns out to be very badly damaged and this breaks
> + * the single-threaded assumption above. In these circumstances successful
> + * continuation and exit from the inner trap is unlikely to work and any
> + * user attempting this receives a prominent warning before being allowed
> + * to progress. In these circumstances we remain memory safe because
> + * namebuf[KSYM_NAME_LEN-1] will never change from '\0' although we do
> + * tolerate the possibility of garbled symbol display from the outer kdb
> + * trap.
> + *
> + * Return:
> + * * 0 - No sections contain this address, symtab zero filled
> + * * 1 - Address mapped to module/symbol/section, data in symtab
>   */
>  int kdbnearsym(unsigned long addr, kdb_symtab_t *symtab)
>  {
>         int ret = 0;
>         unsigned long symbolsize = 0;
>         unsigned long offset = 0;
> -#define knt1_size 128          /* must be >= kallsyms table size */
> -       char *knt1 = NULL;
> +       static char namebuf[KSYM_NAME_LEN];

I guess this also ends up fixing a bug too, right? My greps show that
"KSYM_NAME_LEN" is 512 and the first thing kallsyms_lookup() does it
zero out byte 511. Previously we were only allocating 128 bytes so I
guess we were writing past the end.

Assuming I understood correctly, maybe mention the bugfix in the commit text?


> @@ -102,63 +102,14 @@ int kdbnearsym(unsigned long addr, kdb_symtab_t *symtab)
>         symtab->sym_end = symtab->sym_start + symbolsize;
>         ret = symtab->sym_name != NULL && *(symtab->sym_name) != '\0';
>
> -       if (ret) {
> -               int i;
> -               /* Another 2.6 kallsyms "feature".  Sometimes the sym_name is
> -                * set but the buffer passed into kallsyms_lookup is not used,
> -                * so it contains garbage.  The caller has to work out which
> -                * buffer needs to be saved.
> -                *
> -                * What was Rusty smoking when he wrote that code?
> -                */
> -               if (symtab->sym_name != knt1) {
> -                       strncpy(knt1, symtab->sym_name, knt1_size);
> -                       knt1[knt1_size-1] = '\0';
> -               }
> -               for (i = 0; i < ARRAY_SIZE(kdb_name_table); ++i) {
> -                       if (kdb_name_table[i] &&
> -                           strcmp(kdb_name_table[i], knt1) == 0)
> -                               break;
> -               }
> -               if (i >= ARRAY_SIZE(kdb_name_table)) {
> -                       debug_kfree(kdb_name_table[0]);
> -                       memmove(kdb_name_table, kdb_name_table+1,
> -                              sizeof(kdb_name_table[0]) *
> -                              (ARRAY_SIZE(kdb_name_table)-1));
> -               } else {
> -                       debug_kfree(knt1);
> -                       knt1 = kdb_name_table[i];
> -                       memmove(kdb_name_table+i, kdb_name_table+i+1,
> -                              sizeof(kdb_name_table[0]) *
> -                              (ARRAY_SIZE(kdb_name_table)-i-1));
> -               }
> -               i = ARRAY_SIZE(kdb_name_table) - 1;
> -               kdb_name_table[i] = knt1;
> -               symtab->sym_name = kdb_name_table[i];
> -               knt1 = NULL;

I definitely had a hard time following exactly what all the cases were
handling and if they were all right, but I agree that we can kill the
old code (yay!)


> @@ -249,6 +200,7 @@ void kdb_symbol_print(unsigned long addr, const kdb_symtab_t *symtab_p,
>                       unsigned int punc)
>  {
>         kdb_symtab_t symtab, *symtab_p2;
> +
>         if (symtab_p) {
>                 symtab_p2 = (kdb_symtab_t *)symtab_p;
>         } else {

nit: unrelated whitespace change?


All comments above are nits and not terribly important, so:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
