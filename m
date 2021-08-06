Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1CB3E2DD8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 17:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244719AbhHFPj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 11:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbhHFPj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 11:39:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31564C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 08:39:40 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jlu@pengutronix.de>)
        id 1mC1wf-0001X6-BW; Fri, 06 Aug 2021 17:39:37 +0200
Received: from localhost ([127.0.0.1])
        by ptx.hi.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <jlu@pengutronix.de>)
        id 1mC1wc-0004j7-SK; Fri, 06 Aug 2021 17:39:34 +0200
Message-ID: <b54325f156eaaa6535667a1a7fb695c7688d2db4.camel@pengutronix.de>
Subject: Re: [PATCH v2 3/3] nvmem: add ONIE nvmem cells parser
From:   Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
To:     Vadym Kochan <vadym.kochan@plvision.eu>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>
Date:   Fri, 06 Aug 2021 17:39:34 +0200
In-Reply-To: <20210608190327.22071-4-vadym.kochan@plvision.eu>
References: <20210608190327.22071-1-vadym.kochan@plvision.eu>
         <20210608190327.22071-4-vadym.kochan@plvision.eu>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 (by Flathub.org) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: jlu@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2021-06-08 at 22:03 +0300, Vadym Kochan wrote:

...
> +	case 0x24: return "mac-address";
...
> +	case 0x2A: return "num-macs";

Is suspect these properties define which range of MACs is assigned to the
device. How would you use them to assign MAC addresses to multiple interfaces?
The nvmem-cells property in the network device's node can only refer to one
cell, and not to i.e the cells value + 1.

I think it would be useful to have a way to express this setup for systems with
many interfaces, but am unsure of where this should be described. Maybe a "mac-
address-offset" property in the generic ethernet controller binding?

Regards,
Jan
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

