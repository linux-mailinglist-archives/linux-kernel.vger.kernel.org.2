Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC00B332D7B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 18:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbhCIRmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 12:42:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:46318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229691AbhCIRmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 12:42:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5A5946523A;
        Tue,  9 Mar 2021 17:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615311767;
        bh=9GvvHE/FUuaHjAoFl5s/o4xB1kKuNNQZsvQhUv5aVSw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AkerNW1oXISUkhOs9q8Jhfqw8K6nO2FO9SkqY0nCKXn7/vXfFHJHiy9iqoUMd+9ZE
         BGSMCWNa0Q5DkCHvLrkodbWG6CKOYkcID70/4l9H7dqqR4cP7Yhw0qUuZNb5GRnayw
         11CXrB8M4F71zldK3V7rY3jHLHeBwQ5NkpGPOBS9QWWR4xgdyMy/Cnke3AJekfYmEA
         3eZ8bYp8B4xfZINvd8+H1iLJvxhETW3xhUEsOMUnZYHIzYgDwsSAQNOlPupri4u8Fq
         xvjAXjHLerB5NP9kuqsm+fSXNW+PYc8XBl6PQeTRTEoQxP+MAQ3OTL/PR2qJS59tB2
         6MSPRbACsQ37A==
Received: by mail-ed1-f51.google.com with SMTP id b7so21940370edz.8;
        Tue, 09 Mar 2021 09:42:47 -0800 (PST)
X-Gm-Message-State: AOAM533P0lhS/Iqi5hiGLqQY+vSPBlkjyTgcBRrhyuWx/0yh8zY5Kpt5
        l1OhLEVTkZVz8SPC9Tym8rveEsdRMxQLd+bqyg==
X-Google-Smtp-Source: ABdhPJwA8ze9bW79kEZbbGheWQdv1hjU1cMbhf/mMIkz0VfVcK8mWozBwRu5cE7382PmePafSrdW35bQG7aPk/ZcNzA=
X-Received: by 2002:a05:6402:c88:: with SMTP id cm8mr5497065edb.62.1615311765955;
 Tue, 09 Mar 2021 09:42:45 -0800 (PST)
MIME-Version: 1.0
References: <20210309112148.2309116-1-geert+renesas@glider.be>
In-Reply-To: <20210309112148.2309116-1-geert+renesas@glider.be>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 9 Mar 2021 10:42:34 -0700
X-Gmail-Original-Message-ID: <CAL_JsqJzfoSubkKQ+aGYGbuH2=vLG2Sf_nQShxJ8DLirALff5g@mail.gmail.com>
Message-ID: <CAL_JsqJzfoSubkKQ+aGYGbuH2=vLG2Sf_nQShxJ8DLirALff5g@mail.gmail.com>
Subject: Re: [PATCH] [RFC] dt-bindings: Consider DT_SCHEMA_FILES when finding
 all json-schema
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Masahiro Yamada <masahiroy@kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 9, 2021 at 4:21 AM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> Setting DT_SCHEMA_FILES allows the user to restrict the
> "dt_binding_check" make target to a specified set of DT binding files.
> However, yamllint is still run on all available files, which can take
> quite some time.
>
> Fix this by changing "find_cmd" to only return the specified files.
> Note that this also affects the "cmd_chk_bindings" and "cmd_mk_schema"
> rules.
>
> This reduces the execution time of
>
>     make dt_binding_check DT_SCHEMA_FILES=/path/to/json/schema/file
>
> from ca. 22 to less than 2 seconds on an i7-8700K.

We could use xargs sharding like 'chk_bindings' does. That goes from
18s to 5s for me (i7-7700HQ). Good enough? Not sure why I didn't other
than thinking 20sec was fast enough.

Another option would be doing yamllint as part of cmd_extract_ex or we
could have a command line variable to disable yamllint.

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Should this be restricted to cmd_yamllint?
> I'm not sure which users of find_cmd do and do not need all files.

cmd_chk_bindings always does. cmd_mk_schema needs both. So I think
this doesn't work for all cases.

> ---
>  Documentation/devicetree/bindings/Makefile | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
> index 780e5618ec0ae2fc..60ac03bade2da0ad 100644
> --- a/Documentation/devicetree/bindings/Makefile
> +++ b/Documentation/devicetree/bindings/Makefile
> @@ -22,10 +22,18 @@ $(obj)/%.example.dts: $(src)/%.yaml check_dtschema_version FORCE
>  # Use full schemas when checking %.example.dts
>  DT_TMP_SCHEMA := $(obj)/processed-schema-examples.json
>
> +ifeq ($(DT_SCHEMA_FILES),)
> +
>  find_cmd = find $(srctree)/$(src) \( -name '*.yaml' ! \
>                 -name 'processed-schema*' ! \
>                 -name '*.example.dt.yaml' \)
>
> +else
> +
> +find_cmd = echo $(addprefix $(srctree)/, $(DT_SCHEMA_FILES))
> +
> +endif
> +
>  quiet_cmd_yamllint = LINT    $(src)
>        cmd_yamllint = ($(find_cmd) | \
>                       xargs $(DT_SCHEMA_LINT) -f parsable -c $(srctree)/$(src)/.yamllint) || true
> --
> 2.25.1
>
