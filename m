Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACDEF35FCE6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 23:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbhDNVBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 17:01:48 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:52011
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229463AbhDNVBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 17:01:39 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A91hWm6CpwVf2e03lHejDsseALOonbusQ8zAX?=
 =?us-ascii?q?/mhrQx1UbcCU0+iy9c5rlSPcojAXRX0mhJSkMK6PXXvT+fdOkPcsFJ2lWxTrv3?=
 =?us-ascii?q?btEZF64eLZskLdMgD36+I179YaT4FSBNjxElRggcu/3Q/QKbod6fWd66ayn6Pi?=
 =?us-ascii?q?yR5WPHVXQo566QMRMHf8LmRXQ018CYM9BN6g4KN81kadUFEWdNn+LmIOXujdq7?=
 =?us-ascii?q?Tw5dPbSDsHHQNiyQWKlFqTmfTHOj2ZxApbcz4n+8ZozUHhkxblooO8tP2hoyWs?=
 =?us-ascii?q?mVP7ypRNhZ/ZzMFfbfb8xfQ9DzX3l0KTeI96UaaDtzxdmpDj1H8OkMPQ5ysmJd?=
 =?us-ascii?q?h58XnLfmq4yCGdlzXI9BYLxzvcxUSDgX3lyPaJOQ4SL8Zan4pWfl/4xiMbzalB?=
 =?us-ascii?q?+ZtR02iUupZRBx+oplWLlq71fipnnEa1vnYu+NR75xc0PuV/GdwhyLA3x09bHI?=
 =?us-ascii?q?wNGyj38ukcYY1TJfrR/fNHNW6dBkqpzVVH+tCqU3gpdy32C3QqgNCf0DRdgRlC?=
 =?us-ascii?q?vjsl7fEY901wk64Vd4NJ/KDtPKhuidh1P7UrRJM4K+EbX8OtB2DBBTbBKnibL1?=
 =?us-ascii?q?iiNKxvAQO1l7fHpJAy4vjCQu178LIC3LLbUF1ZsmY2P3/pYPfi4LR7tjbXQGu8?=
 =?us-ascii?q?WjzxysZRo7hB04eMJobDAGm4REgzn8yrr5wkc7jmcsf2B5pSA/LqMGvpHsJDz2?=
 =?us-ascii?q?TFKuhvAEhbb80Ppsx+YViHpcXGJ+TR19DzQbLVIv7kCjwkWnzya0FzFATOGA?=
 =?us-ascii?q?=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.82,223,1613430000"; 
   d="scan'208";a="378682693"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 23:01:16 +0200
Date:   Wed, 14 Apr 2021 23:01:15 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
cc:     outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [Outreachy patch] [PATCH v3 1/2] staging: rtl8723bs: Remove
 useless led_blink_hdl()
In-Reply-To: <20210414192750.4974-2-fmdefrancesco@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2104142300550.33347@hadrien>
References: <20210414192750.4974-1-fmdefrancesco@gmail.com> <20210414192750.4974-2-fmdefrancesco@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 14 Apr 2021, Fabio M. De Francesco wrote:

> Removed useless led_blink_hdl() prototype and definition. In wlancmds[]
> the slot #60 is now set to NULL using the macro GEN_MLME_EXT_HANDLER. This
> change has not unwanted side effects because the code in rtw_cmd.c checks
> if the function pointer is valid before using it.

When you send the series again, you can change not to no in the above.

julia
