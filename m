Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F21E421590
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 19:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbhJDRyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 13:54:10 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:41898 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233597AbhJDRyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 13:54:08 -0400
Received: by mail-ot1-f54.google.com with SMTP id 97-20020a9d006a000000b00545420bff9eso22656284ota.8;
        Mon, 04 Oct 2021 10:52:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pCk+WteoJ4Ql9iJLHdcU9i/mA+NmSdPVlxjxSYcSevE=;
        b=vh7l0a7AosyMgtdnymeRUTZUV+mqL1pEZCjk7WYGErlDQm3ftcDdSBEM7np3CZQIob
         Y3+tkurKX9Ma65c9lkM3CcYMIY8JC5v6cvKdEbfoNtA+uUp9j2e7QqF753cbZ150MvSR
         SOr/HjFLfpoa/34/rFAWY8drnp6AIhrHZ9osWCGjfa265igaSQ9YjX5oDShtXUE7KNhw
         SkzdjbxjOxM2syCDXpgqwr+TVh+789QBz/dy8AiXoxdVCWPOkR1ovNskzMipeoStOC3R
         CpS6fdkiSXm/3tZXM2qwzOsLfX1Iat+/aM9dkFdjKLTv1UI5o7WbzulL78FAmCZW3bmw
         jBlQ==
X-Gm-Message-State: AOAM531WMqsCrkzzV60TrLYQCdf0LtUSJMBt36oZR+35LCHkMi8iAX6B
        m0tj2Av6jN469gsnKeCmDQ==
X-Google-Smtp-Source: ABdhPJx2MYqLCUXb7aPlehMQIvJmqPvcsMtr4caQZX8loQ7DUpvZ2wg0rkhYL8tgOH7tQzBTsze81w==
X-Received: by 2002:a9d:6399:: with SMTP id w25mr10643277otk.53.1633369939222;
        Mon, 04 Oct 2021 10:52:19 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id d7sm2997419otl.19.2021.10.04.10.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 10:52:18 -0700 (PDT)
Received: (nullmailer pid 1554740 invoked by uid 1000);
        Mon, 04 Oct 2021 17:52:17 -0000
Date:   Mon, 4 Oct 2021 12:52:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nishanth Menon <nm@ti.com>
Cc:     Sinthu Raja <sinthu.raja@mistralsolutions.com>,
        Suman Anna <s-anna@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Sinthu Raja <sinthu.raja@ti.com>, linux-kernel@vger.kernel.org,
        Hari Nagalla <hnagalla@ti.com>, Tero Kristo <kristo@kernel.org>
Subject: Re: [PATCH V2 1/4] dt-bindings: arm: ti: Add missing compatibles for
 j721e/j7200 evms
Message-ID: <YVs/UTZjzwjypf1e@robh.at.kernel.org>
References: <20210925201430.11678-1-nm@ti.com>
 <20210925201430.11678-2-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210925201430.11678-2-nm@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Sep 2021 15:14:27 -0500, Nishanth Menon wrote:
> Add compatibles for j721e and j7200 evms to allow for newer platforms
> to distinguish themselves.
> 
> While doing this, maintain support for older style of description where
> the board compatibility was not required.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> 
> Changes in V2:
> * Modified such that legacy style of compatibles (of just SoC alone) is
>   still valid
> * Made the capability of providing a board specific compatible as an
>   alternate scheme
> * No longer dependent on rproc cleanup and platforms hosted in
>   downstream trees remain compatible
> 
> V1: https://lore.kernel.org/all/20210915121937.27702-2-nm@ti.com/
> 
>  Documentation/devicetree/bindings/arm/ti/k3.yaml | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
