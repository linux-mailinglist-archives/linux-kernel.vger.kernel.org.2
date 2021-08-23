Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F873F4BBE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 15:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236874AbhHWNbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 09:31:02 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:33352 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236749AbhHWNbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 09:31:01 -0400
Received: by mail-ot1-f49.google.com with SMTP id 61-20020a9d0d430000b02903eabfc221a9so36368221oti.0;
        Mon, 23 Aug 2021 06:30:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=XGH/N+L2+U1AK/PyLB02W0HR4smVzphBSVo0yrwHj3w=;
        b=ne5ddfI7YTrJ8T7+64+fxKyyeBfMBc9k69+kKnktMF3xhnafWnj8YDpBjxpiz825CV
         2WZ7kexCU09EQoo7KMzYVUJI0qZi5Eo8WerAHjXiS9I9miaVQzBLvTHoUCj266F6jP7/
         wyfAGNwf5vTi02CR+oJ9LSTgsNTbTEq1oCkeqx66JB7PvhteEGlkWiL8EfOf6tOogq6v
         t65bSYr8ZwsYSQ/cq9uL69XFL9ya1PFGGR3OwSnzwZ+0ssnzLSeXKVYXzGSH+4eQFicu
         evRTTfLVNJvmzCrXLLBPg+dou3rCoOnCCPIZcZKtQXz4Kwpd811hQvt7jxrtJm01EvNt
         x8Lw==
X-Gm-Message-State: AOAM5314h7WTeNqH+CMz0Fj+wpRa5Ng6DlfsLUleS/qkxu9N48XUHrm+
        ip3qR09oOagM50Xb6H1MyA==
X-Google-Smtp-Source: ABdhPJx8MpP3QPsG5GX1aNHO4CPWW9ZkwZhCZKv98klIVnxne4wAuE8z6lu9K5L2pzMB/LMgJwCh2Q==
X-Received: by 2002:a05:6808:21a3:: with SMTP id be35mr11438422oib.31.1629725418110;
        Mon, 23 Aug 2021 06:30:18 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id u15sm2015752oor.34.2021.08.23.06.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 06:30:17 -0700 (PDT)
Received: (nullmailer pid 1982770 invoked by uid 1000);
        Mon, 23 Aug 2021 13:30:13 -0000
From:   Rob Herring <robh@kernel.org>
To:     yangcong <yangcong5@huaqin.corp-partner.google.com>
Cc:     daniel@ffwll.ch, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, thierry.reding@gmail.com,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        dianders@google.com, sam@ravnborg.org
In-Reply-To: <20210823115125.1070257-3-yangcong5@huaqin.corp-partner.google.com>
References: <20210823115125.1070257-1-yangcong5@huaqin.corp-partner.google.com> <20210823115125.1070257-3-yangcong5@huaqin.corp-partner.google.com>
Subject: Re: [v2 2/2] dt-bindngs: display: panel: Add BOE tv110c9m-ll3 panel bindings
Date:   Mon, 23 Aug 2021 08:30:13 -0500
Message-Id: <1629725413.512809.1982769.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Aug 2021 19:51:25 +0800, yangcong wrote:
> Add documentation for boe tv110c9m-ll3 panel.
> 
> Signed-off-by: yangcong <yangcong5@huaqin.corp-partner.google.com>
> ---
>  .../display/panel/boe,tv110c9m-ll3.yaml       | 83 +++++++++++++++++++
>  1 file changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/boe,tv110c9m-ll3.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/display/panel/boe,tv110c9m-ll3.example.dts:25.42-43 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:380: Documentation/devicetree/bindings/display/panel/boe,tv110c9m-ll3.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1419: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1519635

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

