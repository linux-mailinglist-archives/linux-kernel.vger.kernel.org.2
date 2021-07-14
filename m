Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1BBE3C91C0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 22:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238408AbhGNUGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 16:06:41 -0400
Received: from mail-il1-f176.google.com ([209.85.166.176]:41526 "EHLO
        mail-il1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240115AbhGNTxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 15:53:22 -0400
Received: by mail-il1-f176.google.com with SMTP id p3so2768073ilg.8;
        Wed, 14 Jul 2021 12:50:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GXEHJejGn1ciGcfB32iWJ0BIASIbGh0gamjk36RQ2EY=;
        b=nwpRdn7u+J1bwLyK2w4JCWppnejK0dX69gqNBBs9xG9sRldAFwOH+5kFwyNH8xEiKn
         gfMQpjuar83Y7AVQi+qiugfqtEMxw1Wyx4sJ5CUoYir4+1pSHorY8X7LVbE/NVcGqSzY
         rYuUZpmW1XQxZe1xVYO5Iea/vQOm3UNy9iS6XXiVRML6yRTVdGhyw4OEtKl0Da5A1QyR
         +KL/wrdBfz72RHEAwy6o6agUvqlEOQ+B1S51ROE9Wdd2alf3TrjaDcpUL2rs5gWt4p+8
         0r5J6DGCQy0cRw+Kid9Ieo7q9cpww77au78lpvOrq883bxMp6GPr6iemyNShOzqqSE2M
         yUhw==
X-Gm-Message-State: AOAM532ix7TYnVtcJODABTa6bsVncbZlb5g7o6f4FiF1iTTL+7Q5NLAe
        ZTOJHoJ+qeh9072INU0Gnw==
X-Google-Smtp-Source: ABdhPJwaZdTKTj53AvPt2+MZF0Huyvhd8uH4C19eS4gHeBdEwzGfXu3iI9Gkbo0t/DM4q+x0b2DRnw==
X-Received: by 2002:a92:d84a:: with SMTP id h10mr7537924ilq.55.1626292228919;
        Wed, 14 Jul 2021 12:50:28 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id m12sm1769891iln.43.2021.07.14.12.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 12:50:27 -0700 (PDT)
Received: (nullmailer pid 3279579 invoked by uid 1000);
        Wed, 14 Jul 2021 19:50:26 -0000
Date:   Wed, 14 Jul 2021 13:50:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, heiko@sntech.de
Subject: Re: [PATCH v2 2/4] dt-bindings: soc: rockchip: add
 rockchip-io-domain.yaml object to grf.yaml
Message-ID: <20210714195026.GA3279545@robh.at.kernel.org>
References: <20210625111746.6269-1-jbx6244@gmail.com>
 <20210625111746.6269-2-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625111746.6269-2-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jun 2021 13:17:44 +0200, Johan Jonker wrote:
> The rockchip-io-domain.txt file was converted to YAML.
> IO Voltage Domain nodes are sub nodes of grf and pmugrf nodes.
> Add rockchip-io-domain.yaml object to the grf.yaml file.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  .../devicetree/bindings/soc/rockchip/grf.yaml          | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
