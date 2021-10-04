Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0B96421583
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 19:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbhJDRwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 13:52:41 -0400
Received: from mail-oo1-f52.google.com ([209.85.161.52]:37686 "EHLO
        mail-oo1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233793AbhJDRwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 13:52:39 -0400
Received: by mail-oo1-f52.google.com with SMTP id h11-20020a4aa74b000000b002a933d156cbso5649099oom.4;
        Mon, 04 Oct 2021 10:50:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+zC+9JjryvwDtMGz0rvDmz9oHTnshjJfExDGt6+S9Q8=;
        b=5K+V2DZQO4i3mRz7Ie+A9jvkOfwtHtqnasAH1o3quP+Vgdrpp8BUI9yerncrQ5FApW
         0AmxocHZo52aqSJEhPf+peWQD/dqfFFVt0tVgAAnMNzgF1p0ph/P3Q2AJGbsHgwSdrPV
         RAUkP0g5J+ae9iWg179etlYiLwJEKSRR50GjnFSeFn0YGOSOuYq26xMB3PvjN35k5I1H
         msrmkvlVAw7wGYc7Bpg+zg/K8W2KGrDpw5jkhWiZhPtUwmlvHlqT9szH8AYGaeB8Dlry
         VtA5pqqnHT7P9ja2ONG4kRDcrn+smNiFPK4Gh+LJAgSbXfAXssBb5V+kGb8paHWWB/AP
         nQcQ==
X-Gm-Message-State: AOAM532eWm10oMwZ8TYuFXl9HJ3+GOSy8RDX4jr2JCYdLNqbLpPMkzIM
        A+vr5rgUXU3Z+X1BPDR0ug==
X-Google-Smtp-Source: ABdhPJwtLOj0GQvoRwKaaX9S0QQStXq70Uo/EtSf5edm8922Oyvtqwgn0+jF78EGdqN9fM3fzHM0FA==
X-Received: by 2002:a4a:de57:: with SMTP id z23mr10076843oot.70.1633369850186;
        Mon, 04 Oct 2021 10:50:50 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id d7sm2996775otl.19.2021.10.04.10.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 10:50:49 -0700 (PDT)
Received: (nullmailer pid 1552189 invoked by uid 1000);
        Mon, 04 Oct 2021 17:50:48 -0000
Date:   Mon, 4 Oct 2021 12:50:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, jbx6244@gmail.com,
        lee.jones@linaro.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: rockchip: add rk3368 compatible
 string to pmu.yaml
Message-ID: <YVs++GqW6ZXoI4/g@robh.at.kernel.org>
References: <20210925090405.2601792-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210925090405.2601792-1-heiko@sntech.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Sep 2021 11:04:03 +0200, Heiko Stuebner wrote:
> Add the compatible for the pmu mfd on rk3368.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
> changes in v2:
> - new patch
> 
>  Documentation/devicetree/bindings/arm/rockchip/pmu.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
