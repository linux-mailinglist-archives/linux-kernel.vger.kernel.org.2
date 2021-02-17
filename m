Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C83131E1F2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 23:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbhBQWRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 17:17:19 -0500
Received: from mail-oo1-f44.google.com ([209.85.161.44]:36147 "EHLO
        mail-oo1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233406AbhBQWQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 17:16:44 -0500
Received: by mail-oo1-f44.google.com with SMTP id x10so3448266oor.3;
        Wed, 17 Feb 2021 14:16:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XKet1JbM+aJWADXeIYWLp2l1i6qo86WODE/HKMEcGRM=;
        b=JrmB2jHIH2C+krYfLgMd7V8uOR6GS41EYH5FI1l7hLAbkD1kx02n9oigdBe/4ucf18
         FDjcYsWRNrN8mFeL+lkKNy6CEPadMseKmj83NPHUR4FwSkx9Rc5yBUmJaj8VO+RHEACv
         A55NcxAicVelYPyectjti7sNSVuzcaOOdcnNdFBLcbmWyvVu6ZqghAfEs2yRfSfJEhVz
         Np42IEW6BFd8I1XEwfldWoX2s7byED9FxqrVwnlWffSLYB98GB41ZRgBNdB3mEDCWA6G
         fb8cyzuMZfbayf9xu1U/ZOaYujK9RSklCJ5AI7FIJInV1jQcscrZo9sHUKqA9K2e0VWB
         ib7Q==
X-Gm-Message-State: AOAM530WQ2kDCesZSuLtxoXKM39PKQ6en3cjObTqcURw9YyI/ukLTReE
        TmgdxptTLHZvuY9qmGFoOQ==
X-Google-Smtp-Source: ABdhPJzeCJN1pl29elqGMNL4gAn3VJZ+rgOoSIImtIilty1e0pKS5JtbIVKZ/wYBq0EXkODORBV37w==
X-Received: by 2002:a4a:98a3:: with SMTP id a32mr836135ooj.51.1613600163894;
        Wed, 17 Feb 2021 14:16:03 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 69sm660528otc.76.2021.02.17.14.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 14:16:02 -0800 (PST)
Received: (nullmailer pid 2878020 invoked by uid 1000);
        Wed, 17 Feb 2021 22:16:01 -0000
Date:   Wed, 17 Feb 2021 16:16:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, a.hajda@samsung.com,
        narmstrong@baylibre.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: display: bridge: Add documentation
 for LT8912
Message-ID: <20210217221601.GA2872814@robh.at.kernel.org>
References: <20210214232904.1142706-1-adrien.grassein@gmail.com>
 <20210214232904.1142706-2-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210214232904.1142706-2-adrien.grassein@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 12:29:03AM +0100, Adrien Grassein wrote:
> Lontium LT8912 is a DSI to HDMI bridge.
> 
> Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> ---
>  .../display/bridge/lontium,lt8912.yaml        | 102 ++++++++++++++++++
>  MAINTAINERS                                   |   5 +
>  2 files changed, 107 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/lontium,lt8912.yaml

Other than needing to wait for 5.12-rc1 to be merged into drm-misc,

Reviewed-by: Rob Herring <robh@kernel.org>
