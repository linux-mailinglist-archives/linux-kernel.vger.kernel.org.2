Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2170643BB6D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 22:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239121AbhJZURo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 16:17:44 -0400
Received: from mail-oo1-f48.google.com ([209.85.161.48]:38513 "EHLO
        mail-oo1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236912AbhJZURl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 16:17:41 -0400
Received: by mail-oo1-f48.google.com with SMTP id z11-20020a4a870b000000b002b883011c77so137219ooh.5;
        Tue, 26 Oct 2021 13:15:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eChjXqVmD/2S1Kk/P6xJUUmWCCVL/iUhUMXzvw2HvLQ=;
        b=x9GcBqWhsGJMXCxLlSKNRn5C2J57afV1D0Cf1nztJ+aZCQrtPGVHE/X8sUWi/f+pp3
         hW1gjYl1dBO8PyYkW0tVhOvjHy8y0jxmFTHIs1Y97SNS5sCt/36FM2fzonFf6jGE+VE7
         ixdEnTm91SxvvrDAqG+xMUTc0E63Zdf1oEybJOpiUAjzLkg1AnIkIfR/MO35xBAE+wsq
         wCtyZp51xTP3rsjp2EcrTTtU6o4v7scKhvJdDiEYjNein1OLS1S7LhGuPF5vwE6h3wQA
         8I+n0ABw/fFRlFUjiYuD6qmERGLBBvIEbPAmhjAUIZTs9ntOfa7nKAte8bGkPCH/P3ut
         dgPg==
X-Gm-Message-State: AOAM532RleuOORGEXlHa+3M4iU4BG2zQvp5eSJStbElu1dPxZOnky2z0
        EPIV6fr7WyXzJudganXJSA==
X-Google-Smtp-Source: ABdhPJzzqhQIh2vYCnJETmgXjC24lTk9GOpV2O7XyYk2o2VA3IlTFB34WbMrLf+EeYbFvBvtsFY4XQ==
X-Received: by 2002:a4a:e75a:: with SMTP id n26mr18929530oov.1.1635279314452;
        Tue, 26 Oct 2021 13:15:14 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id b9sm4806713ots.77.2021.10.26.13.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 13:15:13 -0700 (PDT)
Received: (nullmailer pid 3163764 invoked by uid 1000);
        Tue, 26 Oct 2021 20:15:12 -0000
Date:   Tue, 26 Oct 2021 15:15:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>
Subject: Re: [PATCH 3/3] ARM: dts: imx6qdl: add TQ-Systems MBa6x device trees
Message-ID: <YXhh0B3xX3Gx6vTM@robh.at.kernel.org>
References: <20211013111202.6231-1-matthias.schiffer@ew.tq-group.com>
 <20211013111202.6231-3-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013111202.6231-3-matthias.schiffer@ew.tq-group.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 01:12:02PM +0200, Matthias Schiffer wrote:
> From: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> 
> Add device trees for the MBa6x mainboard with TQMa6Q/QP/DL SoMs.
> 
> Files are imported with (GPL-2.0-or-later OR MIT) license where the
> copyright is held fully by TQ-Systems. Other files with less clear
> copyright ownership use their original GPL-2.0-or-later license.

Thanks for giving it some thought, but I don't think 'or-later' works 
given imx6dl.dtsi is GPL-2.0-only. It's kind of a mess though:

$ git grep -ho 'SPDX.*' arch/arm/boot/dts/imx6dl* | sort -u
SPDX-License-Identifier: GPL-2.0
SPDX-License-Identifier: GPL-2.0+
SPDX-License-Identifier: GPL-2.0-only
SPDX-License-Identifier: GPL-2.0-only */
SPDX-License-Identifier: GPL-2.0-or-later
SPDX-License-Identifier: GPL-2.0-or-later OR MIT
SPDX-License-Identifier: (GPL-2.0 or MIT)
SPDX-License-Identifier: GPL-2.0 or MIT
SPDX-License-Identifier: (GPL-2.0 OR MIT)
SPDX-License-Identifier: GPL-2.0 OR MIT
SPDX-License-Identifier: (GPL-2.0+ OR MIT)
SPDX-License-Identifier: GPL-2.0+ OR MIT
SPDX-License-Identifier: GPL-2.0 OR X11

The dts files are all too intertwined to be different licenses IMO.

Rob
