Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C0C419F69
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 21:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236008AbhI0TuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 15:50:12 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:46741 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235711AbhI0TuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 15:50:08 -0400
Received: by mail-oi1-f182.google.com with SMTP id s69so26996821oie.13;
        Mon, 27 Sep 2021 12:48:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AuxQQJbmAE0wiMu8TirI3HoWUSXRi8ZVxX3PpApnFpo=;
        b=W4nTIH82Rw6OuskxfvgZwK8XgpLwK8kq8wWpEf6GhiyuTK+Es+8IwE0K2MgWPpgFHq
         lL8Gji3YwKhI/SWyeZKPi0r6LTTojrhVAud+Ooq50VlRK8gPjLZYutM04w85UMRDCCrO
         LXNN9CCOlkMUpwbhX5x2sAsJzqx2Zo++Z9jpDUxuQakeR/jt1pkbwTV813fzEgXRha/z
         Yl6Y5CF/TXcHWdxX9THE70GmNtpVGvOiTGr76YMY13mL15est8VEAKkLqqPc/3KtK+/8
         Su7qs/+l+CgIemhH7/OH9fQQIqH04p4sNKwGYU96BSQXOvvwQNbrqxP+p4VYeaKwWwvk
         J9hg==
X-Gm-Message-State: AOAM530wm1MpeQmQfv9BaTyew6zOLXFzmDA9eyDdOwHeTsZI0RpmoD73
        Lq+MEK+czb/oRI7nKhZRoBBAjbc3Lw==
X-Google-Smtp-Source: ABdhPJzwmRdrLzZJ/rSFTm3SzH5EAk/9FKnL+MykIjYhuIQqKRHRYbhGK84jXFVSn7CrCrXr+hhUCQ==
X-Received: by 2002:a54:4688:: with SMTP id k8mr688267oic.70.1632772110031;
        Mon, 27 Sep 2021 12:48:30 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bg36sm1253267oib.2.2021.09.27.12.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 12:48:29 -0700 (PDT)
Received: (nullmailer pid 3765977 invoked by uid 1000);
        Mon, 27 Sep 2021 19:48:28 -0000
Date:   Mon, 27 Sep 2021 14:48:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Orson Zhai <orsonzhai@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Baolin Wang <baolin.wang7@gmail.com>,
        linux-clk@vger.kernel.org,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v4 1/4] dt-bindings: clk: sprd: Add bindings for ums512
 clock controller
Message-ID: <YVIgDNbesvIC4SE1@robh.at.kernel.org>
References: <20210923064137.60722-1-zhang.lyra@gmail.com>
 <20210923064137.60722-2-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923064137.60722-2-zhang.lyra@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sep 2021 14:41:34 +0800, Chunyan Zhang wrote:
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> 
> Add a new bindings to describe ums512 clock compatible strings.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  .../bindings/clock/sprd,ums512-clk.yaml       | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
