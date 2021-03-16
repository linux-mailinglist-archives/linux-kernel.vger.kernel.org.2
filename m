Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B50F33E192
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 23:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbhCPWlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 18:41:36 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:37546 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbhCPWlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 18:41:32 -0400
Received: by mail-io1-f42.google.com with SMTP id y20so20653233iot.4;
        Tue, 16 Mar 2021 15:41:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n6iaW6R/Ou2nVNxzsZFhh+Uzu7+sbe7aTkLbd42ME7M=;
        b=ApNpWnf4G7ol57AG1IYyo7OrgF+tXA1q+rIHPtx3yt3gXiE5O3jrDhvieS8IhAy5y6
         tdSGHCiASBhxaKSn/naqgwPKn77+1NoROtgtWL09gQtW5dV4UIYH2YV3JpyHsL2uK3VH
         Ofq0iWiewm3LcgQzx1K8Yq+9a5bdfGAtGjhLz9o84+lMabp79PFIbnunyyLh4mBl1+nU
         Y8WffftFKHtus4BOyS1aTF9EgnsRY03WOAe53QnbAePgDoFqWr08pGC6/qleazZUhe10
         I34631kgVuBUtT9jC2NRVWTvBuMHCW04zUjRzrm9xNNP7O8LTEZ8MQpyXUiwKabzSsVT
         4wfg==
X-Gm-Message-State: AOAM530qLdVxzeGLxUvoaD2rh1m/4NyQniWpbIacqgVKV1KsGbjjq8n5
        lAXrYfuZUxhts8PaCy+znA==
X-Google-Smtp-Source: ABdhPJzkqghq80/cEWhNhPJYYohoaRfwEgkLoTXu/A6g4/JpKUugazwm+0CeFbawjedz5NlAplcNEw==
X-Received: by 2002:a05:6602:3144:: with SMTP id m4mr5010416ioy.103.1615934492229;
        Tue, 16 Mar 2021 15:41:32 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id b9sm9494464iof.54.2021.03.16.15.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 15:41:31 -0700 (PDT)
Received: (nullmailer pid 3819684 invoked by uid 1000);
        Tue, 16 Mar 2021 22:41:29 -0000
Date:   Tue, 16 Mar 2021 16:41:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        devicetree@vger.kernel.org, Nishanth Menon <nm@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 1/3] dt-bindings: phy: ti,phy-j721e-wiz: Add bindings for
 AM64 SERDES Wrapper
Message-ID: <20210316224129.GA3819655@robh.at.kernel.org>
References: <20210310112745.3445-1-kishon@ti.com>
 <20210310112745.3445-2-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310112745.3445-2-kishon@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2021 16:57:43 +0530, Kishon Vijay Abraham I wrote:
> Add bindings for AM64 SERDES Wrapper.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../bindings/phy/ti,phy-j721e-wiz.yaml        |  4 ++++
>  include/dt-bindings/phy/phy-ti.h              | 21 +++++++++++++++++++
>  2 files changed, 25 insertions(+)
>  create mode 100644 include/dt-bindings/phy/phy-ti.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
