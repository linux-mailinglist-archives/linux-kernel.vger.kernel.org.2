Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E71346D37
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 23:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbhCWWeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 18:34:04 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:40563 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233944AbhCWWbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 18:31:51 -0400
Received: by mail-io1-f54.google.com with SMTP id n21so19460514ioa.7;
        Tue, 23 Mar 2021 15:31:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ADJOQE6rRZGFPRgrhEG6DzF/Fsvk9oc1m1438uMe3rc=;
        b=DGJyephPBjDru8KDTSeLCgslB41rf/GEevH+ROJM4f8o4M774LFxY4QH7iUA4nLP2S
         KsK0mwkUK9bfMt0PrTks87J5BGL4b7uIpJqQbbk0JwX8efUpWHhGzq5vGKdYZxkTv652
         NqhpkHLU9ouerWerGO+AKFAJRZRCZY2bjpsoc5VgTIlZdV3AGarqJhRjanadnsajb//q
         ikiJOpmT7eujQTf+P/W+WbhryeGSDPYy3eH9RIkTnIhynKaTGZceh/9ExGWx7oLPRKfG
         pqiECSLHcqohBNDRHbs5vmgMmiKmkNtcRjNmxSUt5V56lSg5PVvrPPR+fCKgHJg+bXef
         p8yg==
X-Gm-Message-State: AOAM532zVgpWqbiuYg2pe+KpIRCL6quuxhaVSMaTnPRLGd8v4eqlArIi
        ldCF/4DpQRYAAGpipUIgJA==
X-Google-Smtp-Source: ABdhPJyQXi0EFkGQwsLFtkgk7o5qUS8AFJcKo/rS1/0FHagpbUOKycPea+AB7L1IJYJ6hAxCxOFkOw==
X-Received: by 2002:a5e:c911:: with SMTP id z17mr248834iol.153.1616538697665;
        Tue, 23 Mar 2021 15:31:37 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id x20sm103383ilc.88.2021.03.23.15.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 15:31:36 -0700 (PDT)
Received: (nullmailer pid 1464678 invoked by uid 1000);
        Tue, 23 Mar 2021 22:31:34 -0000
Date:   Tue, 23 Mar 2021 16:31:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
        linux-kernel@vger.kernel.org,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 08/13] phy: cadence-torrent: Use a common header file
 for Cadence SERDES
Message-ID: <20210323223134.GA1464641@robh.at.kernel.org>
References: <20210319124128.13308-1-kishon@ti.com>
 <20210319124128.13308-9-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319124128.13308-9-kishon@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Mar 2021 18:11:23 +0530, Kishon Vijay Abraham I wrote:
> No functional change. In order to have a single header file for all
> Cadence SERDES move phy-cadence-torrent.h to phy-cadence.h. This is
> in preparation for adding Cadence Sierra SERDES specific macros.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Reviewed-by: Swapnil Jakhade <sjakhade@cadence.com>
> ---
>  .../devicetree/bindings/phy/phy-cadence-torrent.yaml     | 2 +-
>  drivers/phy/cadence/phy-cadence-torrent.c                | 2 +-
>  .../phy/{phy-cadence-torrent.h => phy-cadence.h}         | 9 +++++----
>  3 files changed, 7 insertions(+), 6 deletions(-)
>  rename include/dt-bindings/phy/{phy-cadence-torrent.h => phy-cadence.h} (51%)
> 

Acked-by: Rob Herring <robh@kernel.org>
