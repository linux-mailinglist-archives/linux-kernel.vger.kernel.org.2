Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4548E33AC34
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 08:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhCOH1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 03:27:39 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:40056 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbhCOH1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 03:27:22 -0400
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.2.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 188A920002B;
        Mon, 15 Mar 2021 07:27:21 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 6A46E206F6; Mon, 15 Mar 2021 08:25:38 +0100 (CET)
Date:   Mon, 15 Mar 2021 08:25:38 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, dahinds@users.sourceforge.net,
        Takashi Iwai <tiwai@suse.de>, Tian Tao <tiantao6@hisilicon.com>
Subject: Re: [PATCH 0/6] Rid W=1 warnings from PCMCIA
Message-ID: <YE8L8pO58W6rLN+l@light.dominikbrodowski.net>
References: <20210312110239.2220197-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312110239.2220197-1-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am Fri, Mar 12, 2021 at 11:02:33AM +0000 schrieb Lee Jones:
> This set is part of a larger effort attempting to clean-up W=1
> kernel builds, which are currently overwhelmingly riddled with
> niggly little warnings.
> 
> Lee Jones (6):
>   pcmcia: rsrc_nonstatic: Demote kernel-doc abuses
>   pcmcia: cistpl: Demote non-conformant kernel-doc headers to standard
>     comments
>   pcmcia: pcmcia_cis: Demote non-conforming kernel-doc headers to
>     standard kernel-doc
>   pcmcia: ds: Fix function name disparity in header
>   pcmcia: pcmcia_resource: Fix some kernel-doc formatting/disparities
>     and demote others
>   pcmcia: rsrc_nonstatic: Fix call-back function as reference formatting

Applied the whole series to pcmcia-next, thanks.

	Dominik
