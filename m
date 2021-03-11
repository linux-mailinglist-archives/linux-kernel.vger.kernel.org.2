Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F997337F7D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 22:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbhCKVP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 16:15:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:40144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231241AbhCKVOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 16:14:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 69E0A600CC;
        Thu, 11 Mar 2021 21:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615497256;
        bh=1Gq9ClTTzgzgBZrG50VQRaLjdSNMezZBgYskj+ev9t4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KjAKhaFqiLiecSpTo5ZepN/OtyJd8I3xqccgVeu2ykHABm0CrX9FiBiaAxtOZARzX
         EPAkAJ6R2TfC4+bEJnS8FLuxcgYBfFhYAn+yd3IiJIXRRkaK9SovrOzHeF+Am6sLEv
         jOgIsPmMjw63ZGnXdQFy3DYnyC2ZgWtykHEnucOPDmbBTlVVnTSKb9FLD5/kyzcKdc
         c8uSaCbtu4FT7NWw0o+TyHr0blY7tttNmOxf7zsvZk2AVISUx7cGhj+tc3YIeVRTzg
         MYfAvkaEhKd4MjNEep56EzahPsYD8Uc/psVkLNnWCq2x0i2y031Hh3mWT8TmmVTDVq
         eRfd78i9W9blA==
Received: by mail-ed1-f54.google.com with SMTP id j3so4945230edp.11;
        Thu, 11 Mar 2021 13:14:16 -0800 (PST)
X-Gm-Message-State: AOAM5308UxFV19CwB+YWhABXbcWIWaLAvPSDE4KZ4hDYFqvykCIr3h1J
        QKuQ9GzJpxTuG/LzUGTHXUtDHZb31C/mQqEuBg==
X-Google-Smtp-Source: ABdhPJwFGvXWlsCMvQVrIbfRFd9CXv7s7D8vCbthspQTNwPv26dQf5jf0GKdzQ2+oyoD0yzw8TW3mdFVhV5l6ZRj0yM=
X-Received: by 2002:aa7:c403:: with SMTP id j3mr10559731edq.137.1615497254841;
 Thu, 11 Mar 2021 13:14:14 -0800 (PST)
MIME-Version: 1.0
References: <20210309112148.2309116-1-geert+renesas@glider.be>
 <CAL_JsqJzfoSubkKQ+aGYGbuH2=vLG2Sf_nQShxJ8DLirALff5g@mail.gmail.com> <CAMuHMdWqo7WVsiNk2xyTM=cqi883v0_-jh1Ry9R7yLBaoOYxoA@mail.gmail.com>
In-Reply-To: <CAMuHMdWqo7WVsiNk2xyTM=cqi883v0_-jh1Ry9R7yLBaoOYxoA@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 11 Mar 2021 14:14:02 -0700
X-Gmail-Original-Message-ID: <CAL_Jsq+n6DVpoSkym3E4yG7BcUu6jS8O51tCpFD4-CeCtPesqA@mail.gmail.com>
Message-ID: <CAL_Jsq+n6DVpoSkym3E4yG7BcUu6jS8O51tCpFD4-CeCtPesqA@mail.gmail.com>
Subject: Re: [PATCH] [RFC] dt-bindings: Consider DT_SCHEMA_FILES when finding
 all json-schema
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 1:43 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Rob,
>
> On Tue, Mar 9, 2021 at 6:42 PM Rob Herring <robh+dt@kernel.org> wrote:
> > On Tue, Mar 9, 2021 at 4:21 AM Geert Uytterhoeven
> > <geert+renesas@glider.be> wrote:
> > > Setting DT_SCHEMA_FILES allows the user to restrict the
> > > "dt_binding_check" make target to a specified set of DT binding files.
> > > However, yamllint is still run on all available files, which can take
> > > quite some time.
> > >
> > > Fix this by changing "find_cmd" to only return the specified files.
> > > Note that this also affects the "cmd_chk_bindings" and "cmd_mk_schema"
> > > rules.
> > >
> > > This reduces the execution time of
> > >
> > >     make dt_binding_check DT_SCHEMA_FILES=/path/to/json/schema/file
> > >
> > > from ca. 22 to less than 2 seconds on an i7-8700K.
> >
> > We could use xargs sharding like 'chk_bindings' does. That goes from
> > 18s to 5s for me (i7-7700HQ). Good enough? Not sure why I didn't other
> > than thinking 20sec was fast enough.
>
> Sounds better, but yamllint (on all files) would still take 80% of the
> time for a single binding check, assuming a reasonably fast multi-core
> machine.  My main objection is that while working on a new binding, and
> using DT_SCHEMA_FILES, I don't want to waste time on checking other
> bindings, and being bothered with warnings about them.

We could move yamllint to when we extract the example. Then it only
runs on modified schema files. The problem with that is we have to
watch out for slow python start-up times. I get about 25sec for the
whole tree 1 by 1 with a quick test:

$ time find Documentation/devicetree/bindings/ -name '*.yaml' | xargs
-P8 -n1 yamllint -f parsable -c
Documentation/devicetree/bindings/.yamllint

real    0m24.939s
user    2m55.846s
sys     0m12.738s

Of course, that's a parallel build compared to 18sec single threaded.
I'm seeing about 8 min for full dt_binding_check without yamllint.

Here's what the kbuild changes would look like(whitespace damaged):

diff --git a/Documentation/devicetree/bindings/Makefile
b/Documentation/devicetree/bindings/Makefile
index 780e5618ec0a..3a213343d587 100644
--- a/Documentation/devicetree/bindings/Makefile
+++ b/Documentation/devicetree/bindings/Makefile
@@ -16,8 +16,13 @@ check_dtschema_version:
 quiet_cmd_extract_ex = DTEX    $@
       cmd_extract_ex = $(DT_EXTRACT_EX) $< > $@

+define rule_extract_ex
+       $(if $(DT_SCHEMA_LINT),$(call cmd,yamllint),)
+       $(call cmd,extract_ex)
+endef
+
 $(obj)/%.example.dts: $(src)/%.yaml check_dtschema_version FORCE
-       $(call if_changed,extract_ex)
+       $(call if_changed_rule,extract_ex)

 # Use full schemas when checking %.example.dts
 DT_TMP_SCHEMA := $(obj)/processed-schema-examples.json
@@ -26,9 +31,8 @@ find_cmd = find $(srctree)/$(src) \( -name '*.yaml' ! \
                -name 'processed-schema*' ! \
                -name '*.example.dt.yaml' \)

-quiet_cmd_yamllint = LINT    $(src)
-      cmd_yamllint = ($(find_cmd) | \
-                     xargs $(DT_SCHEMA_LINT) -f parsable -c
$(srctree)/$(src)/.yamllint) || true
+quiet_cmd_yamllint = LINT    $(patsubst $(srctree)/%,%,$<)
+      cmd_yamllint = $(DT_SCHEMA_LINT) -f parsable -c
$(srctree)/$(src)/.yamllint $(real-prereqs) || true

 quiet_cmd_chk_bindings = CHKDT   $@
       cmd_chk_bindings = ($(find_cmd) | \
@@ -43,7 +47,6 @@ quiet_cmd_mk_schema = SCHEMA  $@
                      rm -f $$f

 define rule_chkdt
-       $(if $(DT_SCHEMA_LINT),$(call cmd,yamllint),)
        $(call cmd,chk_bindings)
        $(call cmd,mk_schema)
 endef
