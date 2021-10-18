Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A066432797
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 21:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbhJRTb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 15:31:56 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:38468 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbhJRTby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 15:31:54 -0400
Received: by mail-ot1-f51.google.com with SMTP id l10-20020a056830154a00b00552b74d629aso1161503otp.5;
        Mon, 18 Oct 2021 12:29:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uxaQFenmJzGwC+IUubS4cWsAXC6ECKn16PE13Pm+TzQ=;
        b=Gg7U2MzWtdxGsPtGYbHLfC1l/7DZPVbRn6e/B52InHZF2LVrzHSOL8p6GP8NXYM1NK
         xtkD2r+qivLk7cDlPf2zsD53nySeKwqr7YPOvKuvOxYpFjOfsPh4HRqDBhMtijT3bEv2
         vZTAUKZXsDf6xBMcnhplzzpSfeQFBjdykHPj8DvP4daWy+jXCrzy0EvvDapBV4r++AmP
         JiOr9ZkfdXgTltaaF7rldmVnKu+wMsw2AWUP327jfBoyw3rIYmfW//92hp9sS5sXgWGE
         qq87ZtWV5j1NoUyGrkquzJ7rGUKi1EgR52KRiDqESWNnwKOug88ZVwIm18MoBH03AQvA
         wQqA==
X-Gm-Message-State: AOAM530sqtH9PObtiS//DRh166L2g+hmrvwduDGJbhMq8KGeeXyqVXLj
        7S5Ok5fQLQ6pi9rWTSvEJBXmFNKlmQ==
X-Google-Smtp-Source: ABdhPJxQt1AtyRJgxbShImCdxQMW79KrP3k81bFkVpuAM4lbP8oIQTaSCyu7Ectm95KWhvJBq11R4Q==
X-Received: by 2002:a9d:842:: with SMTP id 60mr1466167oty.302.1634585383054;
        Mon, 18 Oct 2021 12:29:43 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id u21sm3104983oiv.25.2021.10.18.12.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 12:29:42 -0700 (PDT)
Received: (nullmailer pid 2805582 invoked by uid 1000);
        Mon, 18 Oct 2021 19:29:41 -0000
Date:   Mon, 18 Oct 2021 14:29:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>, devicetree@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: phy: phy-stm32-usbphyc: add optional
 phy tuning properties
Message-ID: <YW3LJWOCzZm3jxuJ@robh.at.kernel.org>
References: <20211015161427.220784-1-amelie.delaunay@foss.st.com>
 <20211015161427.220784-3-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015161427.220784-3-amelie.delaunay@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Oct 2021 18:14:26 +0200, Amelie Delaunay wrote:
> This patch adds the description of new optional phy tuning properties
> for usbphyc phy sub nodes.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
> ---
> Changes in v3:
> - Use -microamp instead of undocumented -milliamp
> - Add '|' after 'description:' on each property needing this
> Changes in v2:
> - st,phy-tuning property removed
> - tuning properties are now put directly in each child node
> - tuning properties are no more free form text and their name reworked
> ---
>  .../bindings/phy/phy-stm32-usbphyc.yaml       | 129 ++++++++++++++++++
>  1 file changed, 129 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
