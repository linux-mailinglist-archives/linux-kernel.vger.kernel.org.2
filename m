Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBED4376C50
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 00:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbhEGWOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 18:14:08 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:43924 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhEGWNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 18:13:55 -0400
Received: by mail-oi1-f174.google.com with SMTP id j75so10032056oih.10;
        Fri, 07 May 2021 15:12:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/8r+Lbr0DfTNwnY+IjwEBCPWL05D0ozGUpSsW0fUkTA=;
        b=JepHx4HIcmthz5R7BwckRCZWCPSa1k3Fz2LJtAqIC777zviu6F3fXU4CXRZ1oFV09N
         jxAKdyjEnSGrq3HqVT2CBnd09/46dfc9GrXE7aKYW6tQDqiptmVj/XROSDJlJfNyr5GX
         WbhBgJQF92ZHGTD8gAEuQXIY8O6D1T7uq2Noeg5sIGMCeUl93Pi1+XdKuODSVyZplyK0
         39v32vFSiC0jXoN5F3R3fqmxDZolmxtswA5tYlPYyO8WgMLruRqteAo8n56oL/avAkf4
         3XCxNKPE4lxRiXUY4lrQOVLNpupKEiSxTI6k1CScjyd72I/agP4Ti2vFfZ/5ukZVog5n
         /AIg==
X-Gm-Message-State: AOAM532CVtqPYFpEyqRyVbxBcGwzw5lKdN1wLlntgKJcDQBT3mnpZGSY
        wpihRf3OcQYpaR5e4k6kFhSddvf7jg==
X-Google-Smtp-Source: ABdhPJxzRsysvH1mVPYlJJZQwPKP4H/r7r7SGEWfJPxQDIkZwWiZcYqZIO62Qahjy+LCSFmPQbFMZg==
X-Received: by 2002:aca:4dc3:: with SMTP id a186mr10715266oib.22.1620425575033;
        Fri, 07 May 2021 15:12:55 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 88sm1445861otx.2.2021.05.07.15.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 15:12:53 -0700 (PDT)
Received: (nullmailer pid 2989456 invoked by uid 1000);
        Fri, 07 May 2021 22:12:52 -0000
Date:   Fri, 7 May 2021 17:12:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Yuti Amonkar <yamonkar@cadence.com>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        kael_w@yeah.net, Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH] dt-bindings: phy: cadence-torrent: update reference file
 of docs
Message-ID: <20210507221252.GA2989400@robh.at.kernel.org>
References: <20210506114940.22215-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506114940.22215-1-wanjiabing@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 May 2021 19:49:39 +0800, Wan Jiabing wrote:
> In commit fd7abc3c5b87 ("phy: cadence-torrent: Use a common header
> file for Cadence SERDES"), phy-cadence-torrent.h was renamed to
> phy-cadence.h. Fix it of the Documentation.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
