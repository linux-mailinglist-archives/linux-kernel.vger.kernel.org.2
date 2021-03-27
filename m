Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBCA034B896
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 18:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbhC0Rq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 13:46:26 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:46054 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbhC0Rpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 13:45:55 -0400
Received: by mail-ot1-f44.google.com with SMTP id 91-20020a9d08640000b0290237d9c40382so8280023oty.12;
        Sat, 27 Mar 2021 10:45:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9ooGD/C58x+bJu76y0Ni0r7fz4vHIdrkciSIWIc/t9Y=;
        b=QYCCRfjm43Gx3EZdWHZt9xAIpYhoFGyV/RDxWU3/StUQNYfVUilr2Zuh45mbcAEHGX
         GCAIkE5qEexBPtZqlEiVYRn0w6qo2JONDPVzWrpKYh2fvTiUNpA0ZEnF+yko+u+F7ajF
         Sk02Tls9RJ96ksmbGFjYDHSp7zvs8Z5A+dvhD9PBM+ueTLfjEvCMnlmlAZqNQf8gY0Po
         ioeDJVvzcg0KvTB7EoHeJgVHNG4jAZbTihJM3lIgC/TVuJCSdSKwza55nKbBoNIpkcHn
         OhNQaDalUMoBgJxWNRkaFFXOK8HgAteGHgASxx9O3i3ikEsIGsJNFFSEcWDwK6Losu+N
         zKMw==
X-Gm-Message-State: AOAM531CPErFuX0HSqUlXjwuXzRW2+Uh1YC/Nlet+qRk791KrjwFenw4
        jhM0VEP9cQLqZTC2PMTLBg==
X-Google-Smtp-Source: ABdhPJw7FRZE7s3ldbj3fFvvmf1Kgwvl76ML3Z1FFAQbzUPmyGLJBFmr7+VFOlWtlF4zF4l1I9N2Ww==
X-Received: by 2002:a05:6830:1546:: with SMTP id l6mr16936996otp.139.1616867154690;
        Sat, 27 Mar 2021 10:45:54 -0700 (PDT)
Received: from robh.at.kernel.org ([172.58.107.88])
        by smtp.gmail.com with ESMTPSA id r20sm3032569otd.26.2021.03.27.10.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 10:45:53 -0700 (PDT)
Received: (nullmailer pid 301818 invoked by uid 1000);
        Sat, 27 Mar 2021 17:43:45 -0000
Date:   Sat, 27 Mar 2021 11:43:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alain Volmat <avolmat@me.com>
Cc:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 03/16] dt-bindings: clock: st: flexgen: add new
 introduced compatible
Message-ID: <20210327174345.GA301770@robh.at.kernel.org>
References: <20210325075018.6598-1-avolmat@me.com>
 <20210325075018.6598-4-avolmat@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325075018.6598-4-avolmat@me.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Mar 2021 08:50:05 +0100, Alain Volmat wrote:
> New compatible are added, supporting various kind of flexgen in
> STiH407, STiH410 and STiH418
> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---
>  .../devicetree/bindings/clock/st/st,flexgen.txt        | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
