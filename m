Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0BD3F451B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 08:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbhHWGmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 02:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbhHWGl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 02:41:59 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A2FC061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 23:41:17 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 2so416723pfo.8
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 23:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SA1pmWF2qmbrThVAO5HO6VbHJIaFjRgTvnxO1kanh8w=;
        b=O8VtoYOq0WKGCLqs7WgmHXHRnCc2DO6HUyFYnp14xuj8XWla6y4bUMjZtZpVhLHMNI
         Z9Z4qEiNQ4+rr/mKALBZQPl+O65wEQhYUIt4dnWiVIKc3YcaP5zMxDYIduVP9wsTKqjW
         7A7ulrecC/PQt+m1uUfX8+pTL0rOSqVm8ie8Szetz9u5t63BP+UeuZheS7T2m18CjMMA
         7BL68jlDQN53ZDOYdYBnUydQ8tPcOSqByCvmcwSk2MTbqYJDsbzUBOx8vNmhjnUZ3emW
         px7Ecc11aOUTJwMI91dkUX7/Lq704jgj69VIM5HxfHFdEiIuJ42DdOfQ8gjE88Y6vhyY
         mQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SA1pmWF2qmbrThVAO5HO6VbHJIaFjRgTvnxO1kanh8w=;
        b=Qam0C6+PEjqKnl7m4q1Iuf41teaQH5ktfaklJzubzzQjlpn9FTry+J2sEPzLxmZWQr
         NKk0dN4cQAxfqat9Y0M8h2dLT7wdwrl+SY0eciJyHjMKZtPsgWMJqeccrx/NrGPd6kze
         /teP75WvrgnXnO7kP6i27EA8iccIE0L56q+yM91Wauo5bb2RQqsaeE7H+xIsYtjNsF6P
         2jkirNy9GIsXRQvrS6MCinvOrGz70vdzVXD3M43piLg8UGzLQrvlEG//wiUxngUJJkLC
         pYqFspiDpYi/Bar4BnCfPJ7VF2SUQebAJSFQY5Pa7LtvlGD02xqho6Aoibi9FghRjAs2
         TQ4Q==
X-Gm-Message-State: AOAM531c/vjY4NhqS12CATsCccSqHZPh8Gp1qhog44bfi3nnPyfCqNYr
        ikiYXpRWSiQvqy5FPGd9n3OJmoWCeygCyEquYkQ=
X-Google-Smtp-Source: ABdhPJzcQnYcKVppXmJ+YgRoDfVUlxdR1TYKibURNhi30cs5ST8FH6ZK8TbHq8KkbNRLRvR3DqQkL23iR1d8X3DqwP4=
X-Received: by 2002:a65:45c3:: with SMTP id m3mr30703325pgr.203.1629700876672;
 Sun, 22 Aug 2021 23:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210822222009.2035788-1-jim.cromie@gmail.com> <20210822222009.2035788-3-jim.cromie@gmail.com>
In-Reply-To: <20210822222009.2035788-3-jim.cromie@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 23 Aug 2021 09:40:40 +0300
Message-ID: <CAHp75VeGGRX-LWfDg_6+p2b27LMLSy+8gdH8ApqGchR=QDyEqA@mail.gmail.com>
Subject: Re: [PATCH v6 02/11] dyndbg: add DEFINE_DYNAMIC_DEBUG_CATEGORIES and callbacks
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     Jason Baron <jbaron@akamai.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sean Paul <seanpaul@chromium.org>,
        Jessica Yu <jeyu@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 1:21 AM Jim Cromie <jim.cromie@gmail.com> wrote:
>
> DEFINE_DYNAMIC_DEBUG_CATEGORIES(name, var, bitmap_desc, @bit_descs)
> allows users to define a drm.debug style (bitmap) sysfs interface, and
> to specify the desired mapping from bits[0-N] to the format-prefix'd
> pr_debug()s to be controlled.
>
> DEFINE_DYNAMIC_DEBUG_CATEGORIES(debug_gvt, __gvt_debug,
>         "i915/gvt bitmap desc",
>         /**
>          * search-prefixes, passed to dd-exec_queries
>          * defines bits 0-N in order.
>          * leading ^ is tacitly inserted (by callback currently)
>          * trailing space used here excludes subcats.
>          * helper macro needs more work
>          * macro to autogen ++$i, 0x%x$i ?
>          */
>         _DD_cat_("gvt:cmd: "),
>         _DD_cat_("gvt:core: "),
>         _DD_cat_("gvt:dpy: "),
>         _DD_cat_("gvt:el: "),
>         _DD_cat_("gvt:irq: "),
>         _DD_cat_("gvt:mm: "),
>         _DD_cat_("gvt:mmio: "),
>         _DD_cat_("gvt:render: "),
>         _DD_cat_("gvt:sched: "));
>
> dynamic_debug.c: add 3 new elements:
>
>  - int param_set_dyndbg()
>  - int param_get_dyndbg()
>  - struct kernel_param_ops param_ops_dyndbg
>
> Following the model of kernel/params.c STANDARD_PARAM_DEFS, All 3 are
> non-static and exported.
>
> dynamic_debug.h:
>
> Add DEFINE_DYNAMIC_DEBUG_CATEGORIES() described above, and a do-nothing stub.
>
> Note that it also calls MODULE_PARM_DESC for the user, but expects the
> user to catenate all the bit-descriptions together (as is done in
> drm.debug), and in the following uses in amdgpu, i915.
>
> This in the hope that someone can offer an auto-incrementing
> label-generating macro, producing "\tbit-4 0x10\t" etc, and can show
> how to apply it to __VA_ARGS__.
>
> Also extern the struct kernel_param param_ops_dyndbg symbol, as is
> done in moduleparams.h for all the STANDARD params.
>
> USAGE NOTES:
>
> Using dyndbg to query on "format ^$prefix" requires that the prefix be
> present in the compiled-in format string; where run-time prefixing is
> used, that format would be "%s...", which is not usefully selectable.
>
> Adding structural query terms (func,file,lineno) could help (module is
> already done), but DEFINE_DYNAMIC_DEBUG_CATEGORIES can't do that now,
> adding it needs a better reason imo.
>
> Dyndbg is completely agnostic wrt the categorization scheme used, to
> play well with any prefix convention already in use.  Ad-hoc
> categories and sub-categories are implicitly allowed, author
> discipline and review is expected.
>
> Here are some examples:
>
> "1","2","3"             2 doesn't imply 1.
>                         otherwize, sorta like printk levels
> "1:","2:","3:"          are better, avoiding [1-9]\d+ ambiguity
> "hi:","mid:","low:"     are reasonable, and imply independence
> "todo:","rfc:","fixme:" might be handy
> "A:".."Z:"              uhm, yeah
>
> Hierarchical classes/categories are natural:
>
> "drm:<CAT>:"            is used in later commit
> "drm:<CAT>:<SUB>:"      is a natural extension.
> "drm:atomic:fail:"      has been proposed, sounds directly useful
>
> Some properties of a hierarchical category deserve explication:
>
> Trailing spaces matter !
>
> With 1..3-space ("drm: ", "drm:atomic: ", "drm:atomic:fail: "), the
> ":" doesn't terminate the search-space, the trailing space does.  So a
> "drm:" search spec will match all DRM categories & subcategories, and
> will not be useful in an interface where all categories are already
> controlled together.  That said, "drm:atomic:" & "drm:atomic: " are
> different, and both are useful in cases.
>
> Ad-Hoc sub-categories:
>
> These have a caveat wrt wrapper macros adding prefixes like
> "drm:atomic: "; the trailing space in the prefix means that
> drm_dbg_atomic("fail: ...") pastes as "drm:atomic: fail: ", which
> obviously isn't ideal wrt clear and simple bitmaps.
>
> A possible solution is to have a FOO_() version of every FOO() macro
> which (anti-mnemonically) elides the trailing space, which is normally
> inserted by a modified FOO().  Doing this would enforce a policy
> decision that "debug categories will be space terminated", with an
> pressure-relief valve.
>
> Summarizing:
>
>  - "drm:kms: " & "drm:kms:" are different
>  - "drm:kms"            also different - includes drm:kms2:
>  - "drm:kms:\t"         also different
>  - "drm:kms:*"          doesn't work, no wildcard on format atm.
>
> Order matters in DEFINE_DYNAMIC_DEBUG_CATEGORIES(... @bit_descs)
>
> @bit_descs (array) position determines the bit mapping to the prefix,
> so to keep a stable map, new categories or 3rd level categories must
> be added to the end.
>
> Since bits are/will-stay applied 0-N, the later bits can countermand
> the earlier ones, but its tricky - consider;

it's

>     DD_CATs(... "drm:atomic:", "drm:atomic:fail:" ) // misleading
>
> The 1st search-term is misleading, because it includes (modifies)
> subcategories, but then 2nd overrides it.  So don't do that.
>
> For "drm:atomic:fail:" in particular, its best not to add it into an
> existing bitmap, because the current setting would be lost at every
> (unrelated) write, and a separate bitmap is much more stable.
>
> There is still plenty of bikeshedding to do.

...

> @@ -51,8 +51,6 @@ struct _ddebug {
>  #endif
>  } __attribute__((aligned(8)));
>
> -
> -

stray change.

...

> +static inline int param_set_dyndbg(const char *instr, const struct kernel_param *kp)
> +       { return 0; }
> +static inline int param_get_dyndbg(char *buffer, const struct kernel_param *kp)
> +       { return 0; }

Not sure if it's aligned with the style in this file, but usually we
put { at the very beginning of the line.

...

> -/* handle multiple queries in query string, continue on error, return
> -   last error or number of matching callsites.  Module name is either
> -   in param (for boot arg) or perhaps in query string.
> -*/
> +/*
> + * handle multiple queries in query string, continue on error, return
> + * last error or number of matching callsites.  Module name is either
> + * in param (for boot arg) or perhaps in query string.
> + */

Doesn't belong to the patch, split it separately.

...

> +               vpr_info("query %d: \"%s\" %s\n", i, query, (modname) ? modname : "");

too many parentheses. Also may use

  modname ?: ""

form (but not all maintainers are happy with it).

...

> +       if (!bitmap) {
> +               pr_err("set_dyndbg: no bits=>queries map\n");
> +               return -EINVAL;
> +       }
> +       rc = kstrtoul(instr, 0, &inbits);
> +       if (rc) {
> +               pr_err("set_dyndbg: failed\n");
> +               return rc;
> +       }
> +       vpr_info("set_dyndbg: input 0x%lx\n", inbits);
> +
> +       for (i = 0; bitmap->prefix; i++, bitmap++) {
> +               snprintf(query, FMT_QUERY_SIZE, "format '^%s' %cp", bitmap->prefix,
> +                        test_bit(i, &inbits) ? '+' : '-');
> +
> +               matches = ddebug_exec_queries(query, KP_MOD_NAME);
> +
> +               v2pr_info("bit-%d: %d matches on '%s'\n", i, matches, query);
> +               totct += matches;
> +       }

I'm wondering if there is a room to parse a bitmap as a bitmap.

...

> +int param_get_dyndbg(char *buffer, const struct kernel_param *kp)
> +{
> +       return scnprintf(buffer, PAGE_SIZE, "%u\n",
> +                        *((unsigned int *)kp->arg));

One line?

> +}

-- 
With Best Regards,
Andy Shevchenko
