Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E21583C6059
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 18:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbhGLQYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 12:24:55 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:39793 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhGLQYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 12:24:54 -0400
Received: by mail-io1-f48.google.com with SMTP id h6so23438091iok.6;
        Mon, 12 Jul 2021 09:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OQl5lHjb/OmsBGI/gFWR8f+atDzQ3WELfz4e0zefRf0=;
        b=oLYOGoytmKMQn1hvs2rYeDqS4/j1vpQ2La9Lmd/aSchqYZzSOkWgmfqOIAjwDAk7Fl
         bhuJR9/D/EADIkSJmn8V/8PaX41HcZ5FIkl7GZ2taIV4D0+5TFVjV7nuC/UUZaYeVwY8
         fUZ4pqGF96Qz0MGs8k9MRfrCJnW4H/tlax6PGiq9DC3VIlmFPLUjOMBAx/FIMBEtRPcP
         6pVfwsDdqMpryIKZKEOrTqYN7EK2DRuehpkicZu8MHl1x818jCCRlZRNHaXERpIF7ABl
         /yUfVZ2LzwG3XHVOFmuG49kXBkL4ouWy40qPgsv2nYveiw5LsQBtHBgxAhhqchFM2eAS
         vxnw==
X-Gm-Message-State: AOAM530E/DfirtU2fTr9RDOmiraZd8XVPR4Bo5lkulZ3N4/XdPHsRda1
        gLQt5xOsqSPVwdnS/sJ0Wg==
X-Google-Smtp-Source: ABdhPJyHGSGtKgV06NdfXbbA53qEMa67Bq7B7JXq4S+FQYGqUQKOvc+lJo/dXqUW5FAdXIcYbFJ0/g==
X-Received: by 2002:a05:6638:348c:: with SMTP id t12mr40409897jal.1.1626106924794;
        Mon, 12 Jul 2021 09:22:04 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id z7sm2994991iox.4.2021.07.12.09.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 09:22:04 -0700 (PDT)
Received: (nullmailer pid 2050122 invoked by uid 1000);
        Mon, 12 Jul 2021 16:22:02 -0000
Date:   Mon, 12 Jul 2021 10:22:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     linux-kernel@vger.kernel.org, airlied@linux.ie, hjc@rock-chips.com,
        heiko@sntech.de, algea.cao@rock-chips.com,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        andy.yan@rock-chips.com, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        daniel@ffwll.ch, kernel@collabora.com
Subject: Re: [PATCH v2 1/2] dt-bindings: display: rockchip: Add compatible
 for rk3568 HDMI
Message-ID: <20210712162202.GA2050063@robh.at.kernel.org>
References: <20210707120323.401785-1-benjamin.gaignard@collabora.com>
 <20210707120323.401785-2-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707120323.401785-2-benjamin.gaignard@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Jul 2021 14:03:22 +0200, Benjamin Gaignard wrote:
> Define a new compatible for rk3568 HDMI.
> This version of HDMI hardware block needs two new clocks hclk_vio and hclk
> to provide phy reference clocks.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
> version 2:
> - Add the clocks needed for the phy.
> 
>  .../bindings/display/rockchip/rockchip,dw-hdmi.yaml         | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
