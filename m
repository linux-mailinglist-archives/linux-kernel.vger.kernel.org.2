Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 801C33632FD
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 03:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236688AbhDRBxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 21:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbhDRBxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 21:53:07 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D35EC06175F
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 18:52:38 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id e2so11604219plh.8
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 18:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=GxoIInSPTnlTloB8xIvHIuDbP6pt0D67FGLryBAMQuc=;
        b=Rpl1dv/tIOIdjhehKoDHJdmXOcYKJ4o8++Pvt2k77fcucdO40cAw77WhulIapJ9JNE
         4p9btKD7TiibS+P2X5C2dHkDHREX1eQ2PuYDgjubkXoKnnCQF7SpWrvsM7kWQl9nc12j
         7RPGhuNsXnIgaGgq3lL0VHVlr71w46fH56OZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=GxoIInSPTnlTloB8xIvHIuDbP6pt0D67FGLryBAMQuc=;
        b=KrvHRdAsHqvFaxwOgng1W8MSJejYhVGynJTesLe+CUTDOfkkW9ZNmnYm1m20kRcKHP
         oJG5HjNZfZ4ggEuaJfdVeQMpJ719Fijz7Sm4AyBkPP0rV6SR0KS8pRIqxWHVX0W8Nzzx
         MGwyzrgnlSHbLIGUm71VOAl4SA7lv2bM5Z7LJMhlq4ilqKpvS472NnRNeb6klU8hA4vc
         9AlQ7A+yUe4HJ+zfBdh+3GEwZsgK3Vqzn7CnKIkazNZCkV3b4OYq5UnSgsOGHrv7lzkG
         OE/tOMhFikcVt0pnA1XXdslEECS1w2er/U71YqmXpF5FNAsxsj8idExDoKQxEinT+kfc
         Vy5A==
X-Gm-Message-State: AOAM531xFet7bZh0X4GSNkYUS3w1EYgZI7dd+L6XMxDOBtwFIXZi1n96
        nVI+6khTIaHTCTs1DP5AK54WmQ==
X-Google-Smtp-Source: ABdhPJwe6cGQvz0Y6erB49Yh8Keam0M80iy1Rf6p/uyPuMeqGo6O+xTW8JSMYB+NR323LBSY9iyN6Q==
X-Received: by 2002:a17:90a:7896:: with SMTP id x22mr16966446pjk.182.1618710757952;
        Sat, 17 Apr 2021 18:52:37 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:e47c:5232:82d9:6d3f])
        by smtp.gmail.com with ESMTPSA id n52sm8778713pfv.13.2021.04.17.18.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Apr 2021 18:52:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YHg541E24iy5nddg@gunter>
References: <20210410015300.3764485-1-swboyd@chromium.org> <20210410015300.3764485-6-swboyd@chromium.org> <YHg541E24iy5nddg@gunter>
Subject: Re: [PATCH v4 05/13] module: Add printk formats to add module build ID to stacktraces
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-doc@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
To:     Jessica Yu <jeyu@kernel.org>
Date:   Sat, 17 Apr 2021 18:52:34 -0700
Message-ID: <161871075477.46595.10848605889976259732@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jessica Yu (2021-04-15 06:04:35)
> +++ Stephen Boyd [09/04/21 18:52 -0700]:
> >diff --git a/include/linux/module.h b/include/linux/module.h
> >index 59f094fa6f74..4bf869f6c944 100644
> >--- a/include/linux/module.h
> >+++ b/include/linux/module.h
> >@@ -11,6 +11,7 @@
> >
> > #include <linux/list.h>
> > #include <linux/stat.h>
> >+#include <linux/buildid.h>
> > #include <linux/compiler.h>
> > #include <linux/cache.h>
> > #include <linux/kmod.h>
> >@@ -367,6 +368,9 @@ struct module {
> >       /* Unique handle for this module */
> >       char name[MODULE_NAME_LEN];
> >
> >+      /* Module build ID */
> >+      unsigned char build_id[BUILD_ID_SIZE_MAX];
>=20
> Hi Stephen,
>=20
> Since this field is not used when !CONFIG_STACKTRACE_BUILD_ID, I
> would prefer to wrap this in an ifdef, similar to the other
> CONFIG-dependent fields in struct module. This makes it explicit under
> what conditions (i.e. config) the field is meant to be used.

Ok will do.

> >diff --git a/kernel/module.c b/kernel/module.c
> >index 30479355ab85..6f5bc1b046a5 100644
> >--- a/kernel/module.c
> >+++ b/kernel/module.c
> >@@ -2770,6 +2771,20 @@ static void add_kallsyms(struct module *mod, cons=
t struct load_info *info)
> >       }
> >       mod->core_kallsyms.num_symtab =3D ndst;
> > }
> >+
> >+static void init_build_id(struct module *mod, const struct load_info *i=
nfo)
> >+{
> >+      const Elf_Shdr *sechdr;
> >+      unsigned int i;
> >+
> >+      for (i =3D 0; i < info->hdr->e_shnum; i++) {
> >+              sechdr =3D &info->sechdrs[i];
> >+              if (!sect_empty(sechdr) && sechdr->sh_type =3D=3D SHT_NOT=
E &&
> >+                  !build_id_parse_buf((void *)sechdr->sh_addr, mod->bui=
ld_id,
> >+                                      sechdr->sh_size))
> >+                      break;
> >+      }
>=20
> If mod->build_id is not used when !CONFIG_STACKTRACE_BUILD_ID, then we
> don't need to look for it. I would be fine with wrapping the function
> body in an ifdef (similar to what we currently do in
> del_usage_links() and do_mod_ctors()).

Ok, done.

>=20
> >+}
> > #else
> > static inline void layout_symtab(struct module *mod, struct load_info *=
info)
> > {
> >@@ -2778,6 +2793,10 @@ static inline void layout_symtab(struct module *m=
od, struct load_info *info)
> > static void add_kallsyms(struct module *mod, const struct load_info *in=
fo)
> > {
> > }
> >+
> >+static void init_build_id(struct module *mod, const struct load_info *i=
nfo)
> >+{
> >+}
> > #endif /* CONFIG_KALLSYMS */
> >
> > static void dynamic_debug_setup(struct module *mod, struct _ddebug *deb=
ug, unsigned int num)
> >@@ -4004,6 +4023,7 @@ static int load_module(struct load_info *info, con=
st char __user *uargs,
> >               goto free_arch_cleanup;
> >       }
> >
> >+      init_build_id(mod, info);
> >       dynamic_debug_setup(mod, info->debug, info->num_debug);
> >
> >       /* Ftrace init must be called in the MODULE_STATE_UNFORMED state =
*/
> >@@ -4235,7 +4255,7 @@ void * __weak dereference_module_function_descript=
or(struct module *mod,
> > const char *module_address_lookup(unsigned long addr,
> >                           unsigned long *size,
> >                           unsigned long *offset,
> >-                          char **modname,
> >+                          char **modname, const unsigned char **modbuil=
did,
> >                           char *namebuf)
> > {
> >       const char *ret =3D NULL;
> >@@ -4246,6 +4266,8 @@ const char *module_address_lookup(unsigned long ad=
dr,
> >       if (mod) {
> >               if (modname)
> >                       *modname =3D mod->name;
> >+              if (modbuildid)
> >+                      *modbuildid =3D mod->build_id;
>=20
> Then maybe we can set *modbuildid =3D NULL in the case of
> !CONFIG_STACKTRACE_BUILD_ID, similar to the kernel case in
> kallsyms_lookup_buildid().
>=20

Sounds good. It means that some more ifdefs are probably required vs.
making the array size be 0 when the config is disabled but that isn't a
big problem for me. I'm reworking the code now and will test and then
send v5 shortly. Thanks!
