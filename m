Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 397EA392D9D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 14:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbhE0MJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 08:09:49 -0400
Received: from muru.com ([72.249.23.125]:32830 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234941AbhE0MJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 08:09:29 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id DE7D980FE;
        Thu, 27 May 2021 12:08:01 +0000 (UTC)
Date:   Thu, 27 May 2021 15:07:53 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 0/3] ARM: dts: ti: fix ti,no-reset-on-init usage
Message-ID: <YK+LmYCfRawG/Xg4@atomide.com>
References: <20210521222411.17547-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521222411.17547-1-grygorii.strashko@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Grygorii Strashko <grygorii.strashko@ti.com> [210522 01:24]:
> The ti,no-reset-on-init flag need to be at the interconnect target module
> level for the modules that have it defined.
> The ti-sysc driver handles this case, but produces warning, not a critical
> issue.

Thanks for doing this, applying all into omap-for-v5.14/dt.

Tony
