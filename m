Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B80FA34B89C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 18:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbhC0RrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 13:47:03 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:45573 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbhC0Rqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 13:46:30 -0400
Received: by mail-ot1-f42.google.com with SMTP id 91-20020a9d08640000b0290237d9c40382so8280791oty.12;
        Sat, 27 Mar 2021 10:46:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MvdlNB4rrh5cXUbkT13MasdcOB0zjm5lzGT4lbEJIpU=;
        b=NoMcW0jvfAXJf2zORWwM4MKubvPJV0P5+Qo1xKiMtbEZrQf2rO3aY0REEcxF0rQ/sL
         fZVHdcb+00PLo0gFuv6Z5h8mcGKpi3/fFHDZcVPcc7r9gjhW3OPhZtyE0t/0k48V8xg1
         z3qvoRmUtqD08SAI+2WXPJvZDKcxuftlJ3ZwY16uJnJ18ggN+VGMYM5l4U4iHB/9AgfI
         xQiSJBQMz4u3FnNgbfcPP1KujTRXz0xypM0ZkGFd4xuIv8AaviU7arcakZjOhJhFGzSQ
         NeYM19PlHwrJa0ha+45r9k9USH1jjw7HtpUx797bcYGs2yM04ng0wh1fPX00R3s2EDDW
         AzXg==
X-Gm-Message-State: AOAM531GszlSdWmGyRiCv1t07xWJwglVndyRzyxsxoIH/allR1GTb2nZ
        npCXSKvqVGzqvcptdxbmEg==
X-Google-Smtp-Source: ABdhPJxtFyB4ZA46BkndEOd0gTTaFYH6ZjcKqbMiAWLj7IA5CckMcUOlz/Gvjbt/gmSlS/KlcbeEDw==
X-Received: by 2002:a05:6830:1dfd:: with SMTP id b29mr16433356otj.48.1616867189474;
        Sat, 27 Mar 2021 10:46:29 -0700 (PDT)
Received: from robh.at.kernel.org ([172.58.107.88])
        by smtp.gmail.com with ESMTPSA id i4sm2466697oik.21.2021.03.27.10.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 10:46:28 -0700 (PDT)
Received: (nullmailer pid 305346 invoked by uid 1000);
        Sat, 27 Mar 2021 17:46:24 -0000
Date:   Sat, 27 Mar 2021 11:46:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alain Volmat <avolmat@me.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2 05/16] dt-bindings: clock: st: clkgen-pll: add new
 introduced compatible
Message-ID: <20210327174624.GA305299@robh.at.kernel.org>
References: <20210325075018.6598-1-avolmat@me.com>
 <20210325075018.6598-6-avolmat@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325075018.6598-6-avolmat@me.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Mar 2021 08:50:07 +0100, Alain Volmat wrote:
> New compatible are added, supporting various kind of clkgen-pll
> used for STiH407, STiH410 and STiH418
> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---
>  Documentation/devicetree/bindings/clock/st/st,clkgen-pll.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
