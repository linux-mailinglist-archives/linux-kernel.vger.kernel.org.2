Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4F1357729
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 23:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbhDGVs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 17:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234355AbhDGVsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 17:48:25 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B489C061760;
        Wed,  7 Apr 2021 14:48:14 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id a8so1929oic.11;
        Wed, 07 Apr 2021 14:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BE+qPX3NhxQx1aHtbrNi4KhKSFDD3erRMcHkAYz762g=;
        b=VAOMGwTroNS/SfZ3GzKpRHnC5BS43NcMdoWP1hQWouXIZO5e7E/wuUgMk1oXjgaV1A
         U2mM15APcZ+Dn12c142Hb7t3pBcs965yr6nStEemxfclq51zCqTPI074k4e8+mECb4XZ
         kyXkn2Q5BrTQDBwO3e/BOD04aqTtTfMqyeJ0+ndyjN0SxqrCY4EbcYac8prJJd/51xTw
         KMB/2lHvqLmgrg+4IVenpTVbTmeBlCWcdMF9qtDjlKIl6nYHeIaDUrUX1LU/hm4XObhm
         z701DYGRBbspTQRgZFXZaO1hVWPMgX2ysii4DP3pzqfMTHcRMNgB6T1tZt6uXQhRbaSL
         wAeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=BE+qPX3NhxQx1aHtbrNi4KhKSFDD3erRMcHkAYz762g=;
        b=rQ5izs/ZEm1zJ90B5UfRVVJz+jyy2fS5i+klM35h1l5ru7LyhJZpZO1MJ4oCnepnWL
         riaRoOj9MzHISsE4U+O3O52qvezkGe6tu/iHXgdXPulzfGD/xLKAChKJzuJDX8o9eqCR
         pmE1az6rcvp1grXq8UfrJ2ybWnFpCvpN1BdG4e8Jgc98oYQXMn9TKCYZd+DuYmJ56dl4
         IVr3bSfr2Vs8yjaMWthqxP7vzolNehfeF1bLJSKmG8VwvziRQt99FU1KM11pXUwmA66u
         7qNpkl13GOPLnsrmxPZurelL3Li4WPOTUhrzadF/AQKjhpjKZSzXTXCXyj0w1/M3wndZ
         KCbg==
X-Gm-Message-State: AOAM530bQRR2uPVVNv/i8ImVGR9EP2sXGd75dSaYNYtjCJLlqUc/WCB7
        NtW6EbgMvOqbThNqdgBoxnLjKTeXs7o=
X-Google-Smtp-Source: ABdhPJx8uNzQ8Kf8jGwkbKmZPnGIq4DBkRcK6/KCxv5SzzufKWHwWamrBu1DM51jUu+bKksfU0Xe6A==
X-Received: by 2002:aca:90a:: with SMTP id 10mr3736846oij.35.1617832093900;
        Wed, 07 Apr 2021 14:48:13 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d24sm5449952otf.12.2021.04.07.14.48.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Apr 2021 14:48:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 7 Apr 2021 14:48:11 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        michal.simek@xilinx.com, balbi@kernel.org, p.zabel@pengutronix.de,
        git@xilinx.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] usb: dwc3: Add driver for Xilinx platforms
Message-ID: <20210407214811.GA260719@roeck-us.net>
References: <1615963949-75320-1-git-send-email-manish.narani@xilinx.com>
 <1615963949-75320-3-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615963949-75320-3-git-send-email-manish.narani@xilinx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 12:22:29PM +0530, Manish Narani wrote:
> Add a new driver for supporting Xilinx platforms. This driver is used
> for some sequence of operations required for Xilinx USB controllers.
> This driver is also used to choose between PIPE clock coming from SerDes
> and the Suspend Clock. Before the controller is out of reset, the clock
> selection should be changed to PIPE clock in order to make the USB
> controller work. There is a register added in Xilinx USB controller
> register space for the same.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>

Trying this driver with qemu (v6.0.0-rc2) results in:

[   15.184242] dwc3-xilinx ff9d0000.usb: error -ENODEV: failed to assert Reset
[   15.185754] Unable to handle kernel paging request at virtual address 006b6b6b6b6b6b9b
[   15.185994] Mem abort info:
[   15.186065]   ESR = 0x96000004
[   15.186317]   EC = 0x25: DABT (current EL), IL = 32 bits
[   15.186414]   SET = 0, FnV = 0
[   15.186498]   EA = 0, S1PTW = 0
[   15.186579] Data abort info:
[   15.186666]   ISV = 0, ISS = 0x00000004
[   15.186756]   CM = 0, WnR = 0
[   15.186887] [006b6b6b6b6b6b9b] address between user and kernel address ranges
[   15.187436] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[   15.187777] Modules linked in:
[   15.188060] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.12.0-rc6-next-20210406-00006-g05407f068fc9-dirty #1
[   15.188265] Hardware name: Xilinx Versal Virtual development board (DT)
[   15.188495] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO BTYPE=--)
[   15.188614] pc : __clk_put+0x24/0x138
[   15.188716] lr : __clk_put+0x24/0x138
[   15.188791] sp : ffff80001326bac0
[   15.188853] x29: ffff80001326bac0 x28: ffff00000644ed00
[   15.188982] x27: ffff00000421ecd0 x26: ffff00000421e810
[   15.189076] x25: ffff00000644f100 x24: 0000000000000000
[   15.189170] x23: ffff8000126a2570 x22: 0000000000000005
[   15.189271] x21: ffff00000644ed00 x20: ffff000006449970
[   15.189367] x19: 6b6b6b6b6b6b6b6b x18: 0000000000000010
[   15.189456] x17: 0000000000000001 x16: 0000000000000000
[   15.189546] x15: ffff000003af0490 x14: 00000000000001b7
[   15.189642] x13: ffff000003af0490 x12: 00000000ffffffea
[   15.189729] x11: ffff8000123b6460 x10: 0000000000000080
[   15.189815] x9 : 00000000676993c6 x8 : 00000000676993c6
[   15.189941] x7 : 000000007d152ab3 x6 : ffff800012768480
[   15.190047] x5 : 0000000000000000 x4 : 000000007f97631e
[   15.190139] x3 : 00000000d5bdf2c2 x2 : 000000000000000b
[   15.190233] x1 : ffff000003af0040 x0 : 0000000000000001
[   15.190432] Call trace:
[   15.190506]  __clk_put+0x24/0x138
[   15.190588]  clk_put+0x10/0x20
[   15.190653]  clk_bulk_put+0x3c/0x60
[   15.190724]  devm_clk_bulk_release+0x1c/0x28
[   15.190806]  release_nodes+0x1c0/0x2b0
[   15.190887]  devres_release_all+0x38/0x60
[   15.190963]  really_probe+0x1e4/0x3a8
[   15.191042]  driver_probe_device+0x64/0xc8
...

because of ...

> +
> +	ret = devm_clk_bulk_get_all(priv_data->dev, &priv_data->clks);
> +	if (ret < 0)
> +		return ret;
> +
...
> +
> +err_clk_put:
> +	clk_bulk_disable_unprepare(priv_data->num_clocks, priv_data->clks);
> +	clk_bulk_put_all(priv_data->num_clocks, priv_data->clks);

clk_bulk_put_all() is not necessary because of devm_clk_bulk_get_all(),
and results in a double free.

> +static int dwc3_xlnx_remove(struct platform_device *pdev)
> +{
> +	struct dwc3_xlnx	*priv_data = platform_get_drvdata(pdev);
> +	struct device		*dev = &pdev->dev;
> +
> +	of_platform_depopulate(dev);
> +
> +	clk_bulk_disable_unprepare(priv_data->num_clocks, priv_data->clks);
> +	clk_bulk_put_all(priv_data->num_clocks, priv_data->clks);

Same here. This will likely crash the driver on unload.

Guenter
