Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64AE940DA5C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 14:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239739AbhIPMxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 08:53:51 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:44094 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230299AbhIPMxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 08:53:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=nz9SAnyk4uCwzrCxIpD9gKIkrhsXN+ugRyhs0aJFah4=; b=djZK+mIJnmE80yWua2B/Rpbgkp
        DWE6lmuL9LiTQIngVv97+h37AYwKlgacrQ5ACWp3EHsHcgx8KuY4lea3jm1p3o3WuR1X9DFO3WhRB
        T/TeFJlATiwC5J0UT/yicduGDN60RSa0tTyfPxgmHAxYMezmOpGgvf4g/eFgNAgORJy8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1mQqsK-006uJU-5W; Thu, 16 Sep 2021 14:52:24 +0200
Date:   Thu, 16 Sep 2021 14:52:24 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Matthew Hagan <mnhagan88@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] ARM: dts: NSP: Fix MDIO mux node names
Message-ID: <YUM+CMjmYpcqTf34@lunn.ch>
References: <20210828112704.2283805-1-mnhagan88@gmail.com>
 <20210828112704.2283805-3-mnhagan88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210828112704.2283805-3-mnhagan88@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2021 at 11:27:01AM +0000, Matthew Hagan wrote:
> This patch fixes the following message by adding "mdio-mux" compatible:
> compatible: ['mdio-mux-mmioreg'] is too short
> 
> Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
