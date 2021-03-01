Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3B7328824
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 18:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238565AbhCARdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 12:33:51 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:44320 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbhCAQ2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 11:28:55 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2195D8A1;
        Mon,  1 Mar 2021 17:28:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1614616092;
        bh=zIQKsEQSeYt0vM1IDXx2S6ybJAbk8gSLvOd303Cl3/w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JO2+atOWKb+gad3wBZ7G6cybVMCz5eLCxzSGspZ+gSeelTmdfnGHY9kTcLfA3KjbD
         pPwLjF0CnSLZThDUGGQ3YSiJc18Wo13Yp4mWb6Gnzuk3/Ov8Rqa+LXLyssboPmxorZ
         +rJtWmfB1u5Wca+dxML/R8OLpRxBBelyi4qBa/9M=
Date:   Mon, 1 Mar 2021 18:27:44 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Parshuram Raju Thombare <pthombar@cadence.com>
Cc:     "robert.foss@linaro.org" <robert.foss@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "a.hajda@samsung.com" <a.hajda@samsung.com>,
        "narmstrong@baylibre.com" <narmstrong@baylibre.com>,
        "nikhil.nd@ti.com" <nikhil.nd@ti.com>,
        "kishon@ti.com" <kishon@ti.com>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
        Milind Parab <mparab@cadence.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: drm/bridge: MHDP8546 bridge binding
 changes for HDCP
Message-ID: <YD0WAMySrv53lxFR@pendragon.ideasonboard.com>
References: <1614597685-4192-1-git-send-email-pthombar@cadence.com>
 <1614597746-4563-1-git-send-email-pthombar@cadence.com>
 <YD0LKg3Jl5nauMqF@pendragon.ideasonboard.com>
 <DM5PR07MB319661E8BFEB251CE17AF587C19A9@DM5PR07MB3196.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM5PR07MB319661E8BFEB251CE17AF587C19A9@DM5PR07MB3196.namprd07.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Parshuram,

On Mon, Mar 01, 2021 at 04:14:54PM +0000, Parshuram Raju Thombare wrote:
> Hi Laurent,
> 
> > Is this a property of the hardware, that is, are there multiple versions
> > of this IP core covered by the same compatible string that support HDCP
> > 1.4 only, DHCP 2.2 only or both ? Or is it a way to select what a given
> > system will offer ?[] 
> 
> MHDP hardware supports both HDCP 2.2 and 1.4. So, this is a way
> to select the version of HDCP, system wish to support.

Then I'm not sure this qualifies as a DT property, which should describe
the system, not configure it. A way for userspace to configure this
would be better.

-- 
Regards,

Laurent Pinchart
