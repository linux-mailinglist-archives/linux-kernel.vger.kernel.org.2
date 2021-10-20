Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7FD3435027
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 18:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhJTQbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 12:31:47 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:41483 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhJTQbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 12:31:43 -0400
Received: by mail-oi1-f174.google.com with SMTP id bk18so1373359oib.8;
        Wed, 20 Oct 2021 09:29:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SgZ2SGAw4NuGbgZRap5S1n26mVnUxowbhP1sRsZrx/0=;
        b=fNCA4rRYb3hDo4vDLpwNQ4bA0IZDGnyRhmPSH1/Fa2PXyF06Xl+he7YxiXSnxXRDia
         JX4UFA5D8EMBSyrYJdtDLlh2fJrMX00ML3vF17os9/NxI+mAwtD7PFTjxw6opmHm7l9W
         CaADkM99Sy+c05wv7j2YM7iQdMK3YoK0U8txN+BWXLLb7TxoNp5zWTHBxq+HHTx8AWtb
         6BE83piOofNzbEPIcLh8wwk8C71aKU842A6UZdTcMcZVJ1VgnUyVxwy8sCpkW23N+pzZ
         R+0LFyAgg0Aubi3Urexot8wEt1h8Uz+/eApMSk2i5/ELEMt7HIUf4aP4FGL++vabyqO2
         8OZg==
X-Gm-Message-State: AOAM531ToLtplpoeZFKAXAwxzqeKGU4JAMihogReQfV23b/t30MxwCSC
        glxdKMz2+gzTS1kK4g/YmQ==
X-Google-Smtp-Source: ABdhPJyoI3KGHPdhMchrMdoXPRlPbbT6Lb2uOlhJs1AYwd3SvLDfFlKnL2oVsvu2bSt/UB40dX9ENA==
X-Received: by 2002:aca:3bd7:: with SMTP id i206mr71470oia.166.1634747368281;
        Wed, 20 Oct 2021 09:29:28 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id z83sm531301oiz.41.2021.10.20.09.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 09:29:26 -0700 (PDT)
Received: (nullmailer pid 2474290 invoked by uid 1000);
        Wed, 20 Oct 2021 16:29:25 -0000
Date:   Wed, 20 Oct 2021 11:29:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nathan Lynch <nathanl@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, frowand.list@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] of: kobj: make of_node_is_(initialized|attached)
 parameters const
Message-ID: <YXBD5fM43e2PLY2E@robh.at.kernel.org>
References: <20211014173023.2117799-1-nathanl@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014173023.2117799-1-nathanl@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2021 12:30:23 -0500, Nathan Lynch wrote:
> of_node_is_initialized() and of_node_is_attached() don't modify the node
> objects passed to them, so those parameters should be const.
> 
> Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
> ---
>  drivers/of/kobj.c       | 4 ++--
>  drivers/of/of_private.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 

Applied, thanks!
