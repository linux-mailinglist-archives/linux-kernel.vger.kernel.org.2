Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679033A49BB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 22:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbhFKUCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 16:02:23 -0400
Received: from mail-il1-f177.google.com ([209.85.166.177]:38407 "EHLO
        mail-il1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbhFKUCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 16:02:16 -0400
Received: by mail-il1-f177.google.com with SMTP id d1so6235731ils.5;
        Fri, 11 Jun 2021 13:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DzmVIjfzBD5jhfScoy5heM8EH5uUqlFxXkGnXNxuSAY=;
        b=EAlQXWtcMrJ2bz1esZAId98s8VchBRA5uC3bv/EOY9irYlfrsYB3VLvr275jM9FLis
         Vc5WJTcLDMODiVYT10W8VzUlfHo+JvCEzJOmCJG1+UrS/ZHvIlMLvOSCQSEJbltjYzn3
         n9qmrYLZ7aMUSInWa4bR2k78lX/h9945Dx9vK/ZE0pQbcI1h1T1iuL7OvKumGC+0R2Un
         LrPvED7sMo1UvSjdRg2GQbanpEaKXHLyZ3Habjn7wJfuA+ZyAlmRqy1ajAoIgrgj6pBl
         3n30b07lANwNIcVvt9CX/EYnaJFH6vYSYy5/pG+MTzoFAY/xMcMS3w5rHhAPQfF62O9t
         p6eA==
X-Gm-Message-State: AOAM533+DuEOG2g98bwrrVS8Sgjv7j1zVZNKNxnioH7V/Ey70cNuFXnk
        VJEOKwl8Xg1ExEs/UYZVQQ==
X-Google-Smtp-Source: ABdhPJzVeNzzrXgrr9Ha2gZ9pD2XPuSKMASquAuSOHl4eL8kE92/WuTc4NVmGrPRmMyxKaJYaaVogw==
X-Received: by 2002:a92:7d07:: with SMTP id y7mr4480835ilc.68.1623441617690;
        Fri, 11 Jun 2021 13:00:17 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id 14sm3830076ilx.61.2021.06.11.13.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 13:00:16 -0700 (PDT)
Received: (nullmailer pid 1583052 invoked by uid 1000);
        Fri, 11 Jun 2021 20:00:15 -0000
Date:   Fri, 11 Jun 2021 14:00:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        broonie@kernel.org, lgirdwood@gmail.com
Subject: Re: [PATCH] ASoC: dt-bindings: fsl,spdif: Add compatible string for
 imx8ulp
Message-ID: <20210611200015.GA1582999@robh.at.kernel.org>
References: <1622613849-10271-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622613849-10271-1-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Jun 2021 14:04:09 +0800, Shengjiu Wang wrote:
> Add compatible string for imx8ulp, which supports spdif module
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl,spdif.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
