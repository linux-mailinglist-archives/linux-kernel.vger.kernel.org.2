Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42032410075
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 22:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243655AbhIQU7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 16:59:40 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:46990 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243817AbhIQU7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 16:59:39 -0400
Received: by mail-oi1-f180.google.com with SMTP id s69so8196381oie.13;
        Fri, 17 Sep 2021 13:58:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h2nvr9WySpUfoUUOMesCSZna6xZu3VYn2QdrgFpGv/g=;
        b=vbEJx4oBqZEAAuFnj+0WQk7bdRb2pCRG0aYsqFymVRiiyxfXCd+aWJQ6nuinlSc5h2
         mOVBBWT0V7M9Ol0fl0H0m5fcno3lb3OAt94WFhkvJsVrIVIgVP1H18lEDpuRzuYxerqP
         ydDirplvg/I1ncqUxhfmb+PlN4DM1gOD8f7nlNIaempM6FRXyexVYSYKm/w43r1+6mbL
         IDD9B3SWJ8OU5bljM605alx3jYYUnwG5WWV0XSTGxH8wQfa+1fovKDEYG1n+FwA3kw4a
         3PoLhAeLz/AIhYeujk0tW1mdDU+xTFr7V9dEV5rWHD78G4f3pVy+9YqYfpLlW2afJEyA
         Oc6w==
X-Gm-Message-State: AOAM533zp7p+jCwBIMo49hp+u+UCRSwtu3DGyNvgVECCTydU+rcwr/Zr
        p2BdIuaCKmHqSBRXT6RNgw==
X-Google-Smtp-Source: ABdhPJwydEOAYBxgQx86qLyGG4a09V4cQkiUoZcCtBoBkuTbIV4Yb0NldnGGiWeu+bj/32qE7SHiIg==
X-Received: by 2002:aca:2b05:: with SMTP id i5mr5522594oik.55.1631912296452;
        Fri, 17 Sep 2021 13:58:16 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id b2sm1786450ook.46.2021.09.17.13.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 13:58:12 -0700 (PDT)
Received: (nullmailer pid 2146896 invoked by uid 1000);
        Fri, 17 Sep 2021 20:58:11 -0000
Date:   Fri, 17 Sep 2021 15:58:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     David Brazdil <dbrazdil@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: restricted dma: Fix condition for rmem init
Message-ID: <YUUBYx7qiwYjxhIG@robh.at.kernel.org>
References: <20210917131423.2760155-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917131423.2760155-1-dbrazdil@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Sep 2021 14:14:23 +0100, David Brazdil wrote:
> of_dma_set_restricted_buffer fails to handle negative return values from
> of_property_count_elems_of_size, e.g. when the property does not exist.
> This results in an attempt to assign a non-existent reserved memory
> region to the device and a warning being printed. Fix the condition to
> take negative values into account.
> 
> Fixes: f3cfd136aef0 ("of: restricted dma: Don't fail device probe on
> rmem init failure")
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
>  drivers/of/device.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

Applied, thanks!
