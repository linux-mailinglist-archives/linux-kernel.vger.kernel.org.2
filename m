Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC0683B5081
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 01:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhFZXc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 19:32:57 -0400
Received: from fgw20-4.mail.saunalahti.fi ([62.142.5.107]:13793 "EHLO
        fgw20-4.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230363AbhFZXcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 19:32:55 -0400
Received: from macbook.musicnaut.iki.fi (85-76-11-157-nat.elisa-mobile.fi [85.76.11.157])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id 3ec9cd77-d6d4-11eb-ba24-005056bd6ce9;
        Sun, 27 Jun 2021 02:14:25 +0300 (EEST)
Date:   Sun, 27 Jun 2021 02:14:23 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     gustavoars@kernel.org, sam@ravnborg.org, tomi.valkeinen@ti.com,
        linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] OMAP: DSS2: OMAPFB: fix potential GPF
Message-ID: <20210626231423.GA38365@macbook.musicnaut.iki.fi>
References: <20210625223323.13930-1-paskripkin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625223323.13930-1-paskripkin@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Jun 26, 2021 at 01:33:23AM +0300, Pavel Skripkin wrote:
> In case of allocation failures, all code paths was jumping
> to this code:
> 
> err:
> 	kfree(fbi);
> 	kfree(var);
> 	kfree(fbops);
> 
> 	return r;
> 
> Since all 3 pointers placed on stack and don't initialized, they
> will be filled with some random values, which leads to
> deferencing random pointers in kfree(). Fix it by rewriting
> error handling path.

They are initialized before the first goto:

[...]
	fbi = NULL;
	var = NULL;
	fbops = NULL;

	fbi = kzalloc(sizeof(*fbi), GFP_KERNEL);
	if (fbi == NULL) {
		r = -ENOMEM;
		goto err;
	}
[...]

A.
