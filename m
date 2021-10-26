Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7CF643BDFF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 01:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240322AbhJZXkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 19:40:00 -0400
Received: from mail-oo1-f49.google.com ([209.85.161.49]:35825 "EHLO
        mail-oo1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237440AbhJZXj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 19:39:58 -0400
Received: by mail-oo1-f49.google.com with SMTP id 64-20020a4a0d43000000b002b866fa13eeso307992oob.2;
        Tue, 26 Oct 2021 16:37:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4670SkK0w4/UKayAjq/weXcDXPpJisLvckFdsXwxx04=;
        b=Abo3NDUy+sbrifDp6NC9swVbri9rLOlM11aaN2oPQlI/gURJ80eqOoMvyUxdcOoeLB
         iUPToTLk0p3aRW0PKCP/wFrZJAjOJVVzYjVjSj2edzTKQMvJJT0VgIiCTUvOrS4pMw8M
         ewCCyZR9rmsiLNWNv0j1vPyLr95PBW1UyS1xMUzI4hyo1U4EdSlaSBiVvFl3dO/huNmt
         VeDI5daSuPsBfWT4+aQabQWLA4Ms4pL9WvS8KzKni6wDaTBvVdCZ0HIzpCiHFwSFzQ0k
         wMSuC0XHTly7A3tfCOYllfKqKeGhtXby7tQIgyYEhp60W5j0u4TZs6Uw9mc+lwomVF6k
         lvGA==
X-Gm-Message-State: AOAM5301qYP7OckYU8sTuA4qUeEAARISPh5GzVYtKNYN/dPvjf9sBv9q
        MxrM1v2hxwdJMqFmWXr3GQ==
X-Google-Smtp-Source: ABdhPJxnyG3zeEG3Iobe/YeC916tooCWbnqCtO5S93XiblBa1sANXubXQFNKt6o3YDt3tRPr5TpcrA==
X-Received: by 2002:a4a:aacd:: with SMTP id e13mr4618686oon.67.1635291454223;
        Tue, 26 Oct 2021 16:37:34 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w9sm4977235otp.64.2021.10.26.16.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 16:37:33 -0700 (PDT)
Received: (nullmailer pid 3544534 invoked by uid 1000);
        Tue, 26 Oct 2021 23:37:32 -0000
Date:   Tue, 26 Oct 2021 18:37:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, monstr@monstr.eu,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, git@xilinx.com,
        devicetree@vger.kernel.org, Hyun Kwon <hyun.kwon@xilinx.com>
Subject: Re: [PATCH] dt-bindings: display: xilinx: Fix example with psgtr
Message-ID: <YXiRPKSKSUpfsh+y@robh.at.kernel.org>
References: <a291be294dea6e580ad9acd436742a48b7cd00a2.1634539210.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a291be294dea6e580ad9acd436742a48b7cd00a2.1634539210.git.michal.simek@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2021 08:40:12 +0200, Michal Simek wrote:
> Commit cea0f76a483d ("dt-bindings: phy: Add DT bindings for Xilinx ZynqMP
> PSGTR PHY") clearly defines #phy-cells as 4. In past 5 cells were used by
> it never went to upstream. That's why fix example by using only 4 cells
> instead of 5.
> 
> Fixes: e7c7970a678d ("dt-bindings: display: xlnx: Add ZynqMP DP subsystem bindings")
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
>  .../devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml   | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Applied, thanks!
