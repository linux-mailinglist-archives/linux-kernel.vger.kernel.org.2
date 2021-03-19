Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A394C3419C9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbhCSKSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:18:43 -0400
Received: from muru.com ([72.249.23.125]:44706 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229879AbhCSKSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:18:25 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 6330F80CE;
        Fri, 19 Mar 2021 10:19:14 +0000 (UTC)
Date:   Fri, 19 Mar 2021 12:18:19 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCHv2 02/38] dt-bindings: power: supply: cpcap-battery:
 Convert to DT schema format
Message-ID: <YFR6azU6YlEvfdtJ@atomide.com>
References: <20210317134904.80737-1-sebastian.reichel@collabora.com>
 <20210317134904.80737-3-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317134904.80737-3-sebastian.reichel@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Sebastian Reichel <sebastian.reichel@collabora.com> [210317 13:50]:
> Convert the binding to DT schema format. I also added the missing bits
> used by the only in-tree user and implemented in the driver.

Reviewed-by: Tony Lindgren <tony@atomide.com>
