Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28FBA4352B8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 20:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbhJTSgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 14:36:16 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:43553 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbhJTSgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 14:36:15 -0400
Received: by mail-ot1-f44.google.com with SMTP id y15-20020a9d460f000000b0055337e17a55so1887024ote.10;
        Wed, 20 Oct 2021 11:34:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xnBryV4oUKQXd619YT8sGTDtpc9ycu5jUG/DjRiH8XU=;
        b=uLCpKczqGefFophjTVw2ebxpfW+B4Q6W/uFwYvVm2LUIWBOkvGSKoCuxqDJ46TfBgu
         NTUF6nRyEYFjv2g5q7UWD7N73wIyqPCrlw8BmgGveMDvBFZ3hHZVGvPO6UDpuUN6SRdl
         GUtIbf/vtEa3X7k9COVpLT35S6nd6JfZEqcUcCOKzM3wV3N92KLDFuhSnnaeQcukY7QA
         Zk4iaMPPG4RsNaHZivkcGd63l05NBrixPFDpd97vLYuybCdoSJdAsSffLAoCJKZT1bKC
         +HRYgqO0jwoqNahASFMGIHNd+7M5PkFxn9A07xOIVT2TNH6GOFCZgrtMJYlEpqY2Nbrb
         kblw==
X-Gm-Message-State: AOAM533Wt+AHqKJD5c+QB9dcYT9/BeaLlJ0wtcAmi8wGVVhRKDNStggS
        HPYbuXQmGgMhyEC5k0rHwCcRBDz4Ww==
X-Google-Smtp-Source: ABdhPJxFJm6XC+UQ6kJR5DV/BrsYgXhz8Z4xwoLFsAOPSCFc9ygxbLexEvfXjwyP83HCdpkRpp7QdA==
X-Received: by 2002:a05:6830:788:: with SMTP id w8mr819981ots.72.1634754840619;
        Wed, 20 Oct 2021 11:34:00 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w9sm597696otp.64.2021.10.20.11.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 11:33:59 -0700 (PDT)
Received: (nullmailer pid 2651673 invoked by uid 1000);
        Wed, 20 Oct 2021 18:33:57 -0000
Date:   Wed, 20 Oct 2021 13:33:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Joey Gouly <joey.gouly@arm.com>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: Consider DT_SCHEMA_FILES when finding
 all json-schema
Message-ID: <YXBhFUAgpXaxCK3y@robh.at.kernel.org>
References: <cover.1634551582.git.geert+renesas@glider.be>
 <174ab1d791b7bc65f3b0f11b72be13af1748c731.1634551582.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174ab1d791b7bc65f3b0f11b72be13af1748c731.1634551582.git.geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2021 12:54:48 +0200, Geert Uytterhoeven wrote:
> Setting DT_SCHEMA_FILES allows the user to restrict the
> "dt_binding_check" make target to a specified set of DT binding files.
> However, yamllint is still run on all available files, which not only
> takes time, but also outputs warnings for other binding files the
> developer is not interested in.
> 
> Fix this by renaming "find_cmd" to "find_all_cmd", introducing a new
> "find_cmd" to only return the files specified by DT_SCHEMA_FILES (if
> present), and using the latter for yamllint.

We can also do the same thing on dt-doc-validate since checking and 
preprocessing schemas are separate steps, so I did while applying. 

> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - Introduce find_all_cmd,
>   - Only use the restricted set for yamllint.
> ---
>  Documentation/devicetree/bindings/Makefile | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
