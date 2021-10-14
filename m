Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF73642DDFF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 17:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbhJNPXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 11:23:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:36678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229994AbhJNPXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 11:23:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CCE5F610D2;
        Thu, 14 Oct 2021 15:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634224898;
        bh=rEK/VWOhZgM2XoVbXWeSO+RMa5SjAakp1b9O+nSmqqk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=n8Ab9CzeF1s4VwTfHgncgoWjFiXijHTye2Br8hLUDB96WWALxLTUJU81R5cZJSqlq
         4dDues1kuECr0oJe5OLFy3dkKmEVyrO6Utb0QYVnhjIDlyXXpwJtJ0f4stf+fr1Amn
         rtykrFxx4AwbLQ0JvfgIqBKP3Znj0jcLhWxFwvIN18Blpa4wvylNQS/FD0Ssj+7X7V
         goyG+ra0118S1jLp+K2a7haQKZ2lY10eMlsVuiuOkuRmtZ3mRh51VxOmhWXC1IClc6
         o1vCDrRI9SkZsXbES1bB1mSzg74mJPLmti6br57WzpGqJbS+U/6VgUWkaEMDnLvc0h
         feqJd5FteifDA==
Received: by mail-ed1-f53.google.com with SMTP id i20so24995718edj.10;
        Thu, 14 Oct 2021 08:21:38 -0700 (PDT)
X-Gm-Message-State: AOAM532sk4gxUcgBHyIY1dDobfSh43OnQNyaiPxf+kp/Hpnf8keaH3Xu
        zxZ90ocVArsmnfNja7JY+aWS1OaahbtIZeH2Ig==
X-Google-Smtp-Source: ABdhPJw6fDI4d1yDtbKWcAnwG0AbdWetWSUWwf3nralo48w/QQFF/1QyX48DD+f2O4rq4fbVBBqblPumvNht+wCsk0Q=
X-Received: by 2002:a50:da06:: with SMTP id z6mr9644913edj.355.1634224801843;
 Thu, 14 Oct 2021 08:20:01 -0700 (PDT)
MIME-Version: 1.0
References: <20211012181500.5309-1-david@ixit.cz> <20211012181500.5309-4-david@ixit.cz>
In-Reply-To: <20211012181500.5309-4-david@ixit.cz>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 14 Oct 2021 10:19:50 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLFsyUPd+yMB2gCbT2zc2BjeHwrdSF0r7uXV5g2EtJeZQ@mail.gmail.com>
Message-ID: <CAL_JsqLFsyUPd+yMB2gCbT2zc2BjeHwrdSF0r7uXV5g2EtJeZQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] dt-bindings: reserved-memory: ramoops: Convert txt
 bindings to yaml
To:     David Heidelberg <david@ixit.cz>
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        ~okias/devicetree@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 3:39 PM David Heidelberg <david@ixit.cz> wrote:
>
> Convert ramoops driver to the YAML syntax.

I don't have the rest of the series except patch 1 and neither does
lore it seems. The dependency for this is in my tree.

> v2:
>  - inherit reserved-memory properties
>  - switch to unevaluatedProperties
>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../bindings/reserved-memory/ramoops.txt      |  66 ---------
>  .../bindings/reserved-memory/ramoops.yaml     | 129 ++++++++++++++++++
>  2 files changed, 129 insertions(+), 66 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/reserved-memory/ramoops.txt
>  create mode 100644 Documentation/devicetree/bindings/reserved-memory/ramoops.yaml
>
> diff --git a/Documentation/devicetree/bindings/reserved-memory/ramoops.txt b/Documentation/devicetree/bindings/reserved-memory/ramoops.txt
> deleted file mode 100644
> index b571ef6dab0f..000000000000
> --- a/Documentation/devicetree/bindings/reserved-memory/ramoops.txt
> +++ /dev/null
> @@ -1,66 +0,0 @@
> -Ramoops oops/panic logger
> -=========================
> -
> -ramoops provides persistent RAM storage for oops and panics, so they can be
> -recovered after a reboot. This is a child-node of "/reserved-memory", and
> -is named "ramoops" after the backend, rather than "pstore" which is the
> -subsystem.
> -
> -Parts of this storage may be set aside for other persistent log buffers, such
> -as kernel log messages, or for optional ECC error-correction data.  The total
> -size of these optional buffers must fit in the reserved region.
> -
> -Any remaining space will be used for a circular buffer of oops and panic
> -records.  These records have a configurable size, with a size of 0 indicating
> -that they should be disabled.
> -
> -At least one of "record-size", "console-size", "ftrace-size", or "pmsg-size"
> -must be set non-zero, but are otherwise optional as listed below.
> -
> -
> -Required properties:
> -
> -- compatible: must be "ramoops"
> -
> -- reg: region of memory that is preserved between reboots
> -
> -
> -Optional properties:
> -
> -- ecc-size: enables ECC support and specifies ECC buffer size in bytes
> -  (defaults to 0: no ECC)
> -
> -- record-size: maximum size in bytes of each kmsg dump.
> -  (defaults to 0: disabled)
> -
> -- console-size: size in bytes of log buffer reserved for kernel messages
> -  (defaults to 0: disabled)
> -
> -- ftrace-size: size in bytes of log buffer reserved for function tracing and
> -  profiling (defaults to 0: disabled)
> -
> -- pmsg-size: size in bytes of log buffer reserved for userspace messages
> -  (defaults to 0: disabled)
> -
> -- mem-type: if present, sets the type of mapping is to be used to map the
> -  reserved region. mem-type: 0 = write-combined (default), 1 = unbuffered,
> -  2 = cached.
> -
> -- unbuffered: deprecated, use mem_type instead. If present, and mem_type is
> -  not specified, it is equivalent to mem_type = 1 and uses unbuffered mappings
> -  to map the reserved region (defaults to buffered mappings mem_type = 0). If
> -  both are specified -- "mem_type" overrides "unbuffered".
> -
> -- max-reason: if present, sets maximum type of kmsg dump reasons to store
> -  (defaults to 2: log Oopses and Panics). This can be set to INT_MAX to
> -  store all kmsg dumps. See include/linux/kmsg_dump.h KMSG_DUMP_* for other
> -  kmsg dump reason values. Setting this to 0 (KMSG_DUMP_UNDEF), means the
> -  reason filtering will be controlled by the printk.always_kmsg_dump boot
> -  param: if unset, it will be KMSG_DUMP_OOPS, otherwise KMSG_DUMP_MAX.
> -
> -- no-dump-oops: deprecated, use max_reason instead. If present, and
> -  max_reason is not specified, it is equivalent to max_reason = 1
> -  (KMSG_DUMP_PANIC).
> -
> -- flags: if present, pass ramoops behavioral flags (defaults to 0,
> -  see include/linux/pstore_ram.h RAMOOPS_FLAG_* for flag values).
> diff --git a/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml b/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml
> new file mode 100644
> index 000000000000..a21a27e84a6d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml
> @@ -0,0 +1,129 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/reserved-memory/ramoops.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Ramoops oops/panic logger
> +
> +description: |
> +  ramoops provides persistent RAM storage for oops and panics, so they can be
> +  recovered after a reboot. This is a child-node of "/reserved-memory", and
> +  is named "ramoops" after the backend, rather than "pstore" which is the
> +  subsystem.
> +
> +  Parts of this storage may be set aside for other persistent log buffers, such
> +  as kernel log messages, or for optional ECC error-correction data.  The total
> +  size of these optional buffers must fit in the reserved region.
> +
> +  Any remaining space will be used for a circular buffer of oops and panic
> +  records.  These records have a configurable size, with a size of 0 indicating
> +  that they should be disabled.
> +
> +  At least one of "record-size", "console-size", "ftrace-size", or "pmsg-size"
> +  must be set non-zero, but are otherwise optional as listed below.
> +
> +maintainers:
> +  - Kees Cook <keescook@chromium.org>
> +
> +allOf:
> +  - $ref: "reserved-memory.yaml"
> +
> +properties:
> +  compatible:
> +    const: ramoops
> +
> +  reg:
> +    description: region of memory that is preserved between reboots
> +
> +  ecc-size:

These all need a type reference.

> +    description: enables ECC support and specifies ECC buffer size in bytes
> +    default: 0 # no ECC
> +
> +  record-size:
> +    description: maximum size in bytes of each kmsg dump
> +    default: 0
> +
> +  console-size:
> +    description: size in bytes of log buffer reserved for kernel messages
> +    default: 0
> +
> +  ftrace-size:
> +    description: size in bytes of log buffer reserved for function tracing and profiling
> +    default: 0
> +
> +  pmsg-size:
> +    description: size in bytes of log buffer reserved for userspace messages
> +    default: 0
> +
> +  mem-type:
> +    description: if present, sets the type of mapping is to be used to map the reserved region.
> +    default: 0
> +    enum:

s/enum/oneOf/

Or drop 'const' below and make the descriptions comments.

> +      - const: 0
> +        description: write-combined
> +      - const: 1
> +        description: unbuffered
> +      - const: 2
> +        description: cached
> +
> +  unbuffered:
> +    deprecated: true
> +    description: |
> +      use mem_type instead. If present, and mem_type is not specified,
> +      it is equivalent to mem_type = 1 and uses unbuffered mappings to map
> +      the reserved region (defaults to buffered mappings mem_type = 0).
> +      If both are specified -- "mem_type" overrides "unbuffered".
> +
> +  max-reason:
> +    default: 2 # log oopses and panics
> +    description: |
> +      If present, sets maximum type of kmsg dump reasons to store.
> +      This can be set to INT_MAX to store all kmsg dumps.

maximum: 0x7fffffff

> +      See include/linux/kmsg_dump.h KMSG_DUMP_* for other
> +      kmsg dump reason values. Setting this to 0 (KMSG_DUMP_UNDEF), means the
> +      reason filtering will be controlled by the printk.always_kmsg_dump boot
> +
> +  param:
> +    description: if unset, it will be KMSG_DUMP_OOPS, otherwise KMSG_DUMP_MAX.

Define names are nice, but not helpful for defining constraints.

> +
> +  no-dump-oops:
> +    deprecated: true
> +    description: |
> +      Use max_reason instead. If present, and max_reason is not specified,
> +      it is equivalent to max_reason = 1 (KMSG_DUMP_PANIC).
> +
> +  flags:
> +    default: 0
> +    description: |
> +      If present, pass ramoops behavioral flags
> +      (see include/linux/pstore_ram.h RAMOOPS_FLAG_* for flag values).
> +
> +unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +
> +anyOf:
> +  - required: [record-size]
> +  - required: [console-size]
> +  - required: [ftrace-size]
> +  - required: [pmsg-size]
> +
> +examples:
> +  - |

Add '/ { ' so the example is created at the root node.

> +    reserved-memory {
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +      ranges;
> +
> +      ramoops@bfdf0000 {
> +        compatible = "ramoops";
> +        reg = <0xbfdf0000 0x10000>; /* 64kB */
> +        console-size = <0x8000>;    /* 32kB */
> +        record-size = <0x400>;      /*  1kB */
> +        ecc-size = <16>;
> +      };
> +    };
> +
> --
> 2.33.0
>
