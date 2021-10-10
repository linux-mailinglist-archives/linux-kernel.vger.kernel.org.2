Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D890E428358
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 21:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbhJJTeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 15:34:00 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:34476 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbhJJTd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 15:33:59 -0400
Received: by mail-ot1-f48.google.com with SMTP id g62-20020a9d2dc4000000b0054752cfbc59so18984721otb.1;
        Sun, 10 Oct 2021 12:32:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=lK14d/ZxCOum239lAr4qItrjtoQ0V6X7RBleh7jh8eg=;
        b=c/SyI0cvVtHnlgovkJ0+IzoaXyj/Btb/mL4BP8bXMB7sqDpf2flhGpPkc7AVd+Sb/L
         ssRJ9JcULv06RiwHYlnk8yrZvpFmwfA0Puaw4Yw9TcUGpMfn8LBKSCZdHqDkMB6OL4mz
         p+u3kuR1m7sDn1igBjNj1p9f3N6z6pRdvDr2YBN+d73NHuKGAZzRRpT97iLnoKf5Vqik
         4K0S778KBWnBcb1KPjumbSsiRSztbZt/TCT7YRAd+PHLTTMPuuaTUPIcn8YuxH60/l8R
         Y85RfvLDvLlDirX4WDL+YcIrcikEjalrjn3FiAnNxQ6g+j/0YD4bIZ+adL9vvmnhCMDN
         xukQ==
X-Gm-Message-State: AOAM532MAT9vLCVf/oP7Ik1GQve/6X3gqvNoEz/bsRQaum9h84YW9ziW
        MYyGpnfVO8CS0e7z0WVjaQ==
X-Google-Smtp-Source: ABdhPJwW0aMgzz/GfwMzq1eXoLxvdrpZHi4/EMkkLGnSQF7tl1UJgkErU+9e54CkMBCTA71Arq0DQQ==
X-Received: by 2002:a05:6830:1df4:: with SMTP id b20mr6429134otj.19.1633894319844;
        Sun, 10 Oct 2021 12:31:59 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 15sm1297318otf.14.2021.10.10.12.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 12:31:59 -0700 (PDT)
Received: (nullmailer pid 3158666 invoked by uid 1000);
        Sun, 10 Oct 2021 19:31:56 -0000
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Anton Vorontsov <anton@enomsg.org>, linux-kernel@vger.kernel.org,
        Colin Cross <ccross@android.com>, devicetree@vger.kernel.org,
        ~okias/devicetree@lists.sr.ht, Rob Herring <robh+dt@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Kees Cook <keescook@chromium.org>
In-Reply-To: <20211009111927.53280-1-david@ixit.cz>
References: <20211009111927.53280-1-david@ixit.cz>
Subject: Re: [PATCH] dt-bindings: reserved-memory: ramoops: Convert txt bindings to yaml
Date:   Sun, 10 Oct 2021 14:31:56 -0500
Message-Id: <1633894316.420061.3158665.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 09 Oct 2021 13:19:27 +0200, David Heidelberg wrote:
> Convert ramoops driver to the YAML syntax.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../bindings/reserved-memory/ramoops.txt      |  66 ---------
>  .../bindings/reserved-memory/ramoops.yaml     | 126 ++++++++++++++++++
>  2 files changed, 126 insertions(+), 66 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/reserved-memory/ramoops.txt
>  create mode 100644 Documentation/devicetree/bindings/reserved-memory/ramoops.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1538758


ramoops@ac300000: 'devinfo-size' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dt.yaml
	arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dt.yaml

ramoops@ffc00000: 'msg-size' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dt.yaml

ramoops@ffc00000: 'msg-size', 'no-map' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano-bahamut.dt.yaml
	arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano-griffin.dt.yaml
	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dt.yaml
	arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dt.yaml

