Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1AF44EEF5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 22:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235698AbhKLWBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 17:01:18 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]:37536 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbhKLWBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 17:01:17 -0500
Received: by mail-ot1-f49.google.com with SMTP id h19-20020a9d3e53000000b0056547b797b2so15020314otg.4;
        Fri, 12 Nov 2021 13:58:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ujggLbBDEkfrqujMAD0QbtGbSj6ls97bFcIKgu53BaI=;
        b=7eq7LdvNZzsWRE7sbuBwhPLX175GweTD69s8w4hIAwvDcG4qZwEpgD9uFspfBEGmMM
         CbZ6OX+aU2nk5VW+mNskDn77n1nTySIAQCnzlGXU0hLA+5rJESdEk9gAqoiHfnPVXQf7
         7KOWxUKxFG4xwQ8O8BILDAfFl/HccxfMYkz1kHumWhKI2VTjh3LTxAC9eg3QG+wZ/CY6
         V6g8q+JvXrNR0+QNZx3EgSB5KaT17hHIqwqV+vR1is0njexEip6O7YdtJzCEhJW5Wnut
         uz7iaW7dBXMNQF/UTx4uc9i3h6N6FJbU9ny/JTANDHVXQlhsZ5hkdQNDzI8mC1mScouH
         fKag==
X-Gm-Message-State: AOAM533vgSKR/O4H6iCUnQLkyJ1w60ETrwsesv4z3otjJ2Tr5i70H/VB
        fbPRxbqXLsi91DysXyORQQ==
X-Google-Smtp-Source: ABdhPJxGbJ4uLX2lU52O6Fdz64eVlCqS58ED2KL2ipgQUUbCA1bFUsB8koXZKcm8LGvWo91vI86DVw==
X-Received: by 2002:a05:6830:441f:: with SMTP id q31mr8784939otv.164.1636754305459;
        Fri, 12 Nov 2021 13:58:25 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x8sm1440181otg.31.2021.11.12.13.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 13:58:24 -0800 (PST)
Received: (nullmailer pid 3445679 invoked by uid 1000);
        Fri, 12 Nov 2021 21:58:23 -0000
Date:   Fri, 12 Nov 2021 15:58:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     l.stach@pengutronix.de, ariel.dalessandro@collabora.com,
        tharvey@gateworks.com, aford@beaconembedded.com,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        krzk@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH V3 3/9] dt-bindings: power: imx8mn: add defines for DISP
 blk-ctrl domains
Message-ID: <YY7jf2NYmF8kO9wC@robh.at.kernel.org>
References: <20211104161804.587250-1-aford173@gmail.com>
 <20211104161804.587250-4-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104161804.587250-4-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Nov 2021 11:17:58 -0500, Adam Ford wrote:
> This adds the defines for the power domains provided by the DISP
> blk-ctrl.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 

Acked-by: Rob Herring <robh@kernel.org>
