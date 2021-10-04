Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 731BB4214A2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 19:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237968AbhJDRCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 13:02:07 -0400
Received: from mail-oo1-f43.google.com ([209.85.161.43]:41681 "EHLO
        mail-oo1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbhJDRCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 13:02:06 -0400
Received: by mail-oo1-f43.google.com with SMTP id b5-20020a4ac285000000b0029038344c3dso5583797ooq.8;
        Mon, 04 Oct 2021 10:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kwtxm5uDJtAtvdkR11+c/kBQtvDw2iewlRIV15Fpib4=;
        b=PQSLjBCJU9Z+TYfMPPD1Cw9p3BGSr3gX7mbA+O1WkJ4Fxk3/KOIXwX2bG2WcXEkc8N
         MNPste5N3d5fXvZsYt/BWkwlHlU8acNpQ4EKacg1waIl3Mh/j7/gYo3gUIz1wU7LF7xj
         Bqbmfy9pQhOytsJpkOjTLHZe8xPwUQc8sgHLnsk62serW+GL7TJbxgTi6pF6mIjlD8xV
         UlZhklWm9ITutqinRpsNSqqI8FtgrPtSu5o4JrwzcjR8f6C+KhBhTemYQ1YvAJgho5ah
         TJwGIc9EEwrWvvBo7FstevjwjGvSfzeo66NodTTBJV0NbAtANqTmcOP0+ETXApiCwyj0
         uTwQ==
X-Gm-Message-State: AOAM532Ty61/ug+kPuDCVjBsrzPpNdnOYlciFqzoz40qis28mjVPS5MP
        BmLZ8NexekW21ZcGGZopGA==
X-Google-Smtp-Source: ABdhPJwI4xNm6SHgfjI/gavg1NLSNvf5DjG7t5FNNOWsZfgfBjBnvi9klDXNE+6vgn1qG1GkQYVSug==
X-Received: by 2002:a4a:7b4b:: with SMTP id l72mr9778665ooc.21.1633366816946;
        Mon, 04 Oct 2021 10:00:16 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id c5sm2965069otb.35.2021.10.04.10.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 10:00:16 -0700 (PDT)
Received: (nullmailer pid 1474180 invoked by uid 1000);
        Mon, 04 Oct 2021 17:00:15 -0000
Date:   Mon, 4 Oct 2021 12:00:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     devicetree@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org,
        Frank Rowand <frowand.list@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v3 2/2] powerpc/powermac: constify device_node in
 of_irq_parse_oldworld()
Message-ID: <YVszH/UPGsrYsDwj@robh.at.kernel.org>
References: <20210924105653.46963-1-krzysztof.kozlowski@canonical.com>
 <20210924105653.46963-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924105653.46963-2-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Sep 2021 12:56:53 +0200, Krzysztof Kozlowski wrote:
> The of_irq_parse_oldworld() does not modify passed device_node so make
> it a pointer to const for safety.  Drop the extern while modifying the
> line.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
> ---
> 
> Changes since v1:
> 1. Drop extern.
> ---
>  arch/powerpc/platforms/powermac/pic.c | 2 +-
>  include/linux/of_irq.h                | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
