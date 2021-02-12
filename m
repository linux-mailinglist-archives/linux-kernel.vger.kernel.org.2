Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0EE1319896
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 04:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhBLDHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 22:07:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:53556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229756AbhBLDHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 22:07:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7BCC564D8F;
        Fri, 12 Feb 2021 03:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613099193;
        bh=Y5jlZ1AxNHbt3YDm7bqmvIY0oj4JfdcMXAG3Sn9zFww=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=LUYfOHY5xWeHN5nIymwETMGQtD84vyNSuj+XDv/VGEX+hqHmfnzXIthcbeZyWqMjW
         QeVDX23eU689XSQdw9ePn3JohaTJn3Xxsra5o1D0Ll3UWfmK+IW5vjlH5l2W3tsGLf
         bku87/bIuj4QkmbmUX6k62E2TBqIFCHBMyg0gSquH3vmN9Qpz69f3+PqOs8H5LnfRX
         JOHwou6cPmbJxWVBS5k6us+DXe26owh6u/Jh00mvNVhcGo+XccaIVDP6tF4dVBJ4x9
         VKSHLcbizp351h5j7mhEkQduqNEZG5t+ndFUNEqsAszCgrr/W37xmDl4Ty+bTt0yuW
         bI/RrooWldyTQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210209175900.7092-2-jernej.skrabec@siol.net>
References: <20210209175900.7092-1-jernej.skrabec@siol.net> <20210209175900.7092-2-jernej.skrabec@siol.net>
Subject: Re: [PATCH v3 1/5] clk: sunxi-ng: mp: fix parent rate change flag check
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, airlied@linux.ie, daniel@ffwll.ch,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com, Andre Heider <a.heider@gmail.com>
To:     Jernej Skrabec <jernej.skrabec@siol.net>, mripard@kernel.org,
        wens@csie.org
Date:   Thu, 11 Feb 2021 19:06:32 -0800
Message-ID: <161309919221.1254594.13394926523127979721@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jernej Skrabec (2021-02-09 09:58:56)
> CLK_SET_RATE_PARENT flag is checked on parent clock instead of current
> one. Fix that.
>=20
> Fixes: 3f790433c3cb ("clk: sunxi-ng: Adjust MP clock parent rate when all=
owed")
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> Tested-by: Andre Heider <a.heider@gmail.com>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---

Ok, Applied to clk-fixes
