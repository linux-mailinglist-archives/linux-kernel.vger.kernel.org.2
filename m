Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E3A424BF2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 04:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239876AbhJGCzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 22:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbhJGCzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 22:55:25 -0400
Received: from dnyon.com (unknown [IPv6:2001:ba0:1800:12f::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD63AC061746;
        Wed,  6 Oct 2021 19:53:32 -0700 (PDT)
Received: from dnyon.com (55.red-81-39-194.dynamicip.rima-tde.net [81.39.194.55])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dnyon.com (Postfix) with ESMTPSA id 067AE3FD76;
        Thu,  7 Oct 2021 02:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dnyon.com; s=mail;
        t=1633574695; bh=yXdyabDfjZ+A/RncXyoHHMmlJkHBFE+VzZdU52kMq60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FttTzjp5tZcPDEDtWtG8vxozXND13c9yZCVON+ZIGwbPu+sPC4kpChGIBva9TmLYG
         ayyCxQvmsEJF3zDOku9CLaFW3EsAUcz+o+jSR9m/81xybYWav66u5CPxGvJT0a4On4
         0N9zJfCoOtxjPOjxBURICf1qn33EKuviLFl6Lu5V795aa4LMI6AdI50Vq0GanAw6NL
         0CutSADQV3JcnMdNW/sRODXaDyTBZSJW/sKLe1xnM5fJ9jVX745EbXi4atP7a1y8FR
         0GKyhSQR2umIn40SBNETounjF5qRQEox5+ElRodwMlXyFtpdRvRyW+z2fg0nwE7Zzc
         2VKo5Z/pXYGRg==
From:   Alejandro Tafalla <atafalla@dnyon.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?ISO-8859-1?Q?P=E9ter?= Ujfalusi 
        <peter.ujfalusi@linux.intel.com>,
        ~postmarketos/upstreaming@lists.sr.ht, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/2] dt-bindings: sound: max98927: Add reset-gpios optional property
Date:   Thu, 07 Oct 2021 04:44:49 +0200
Message-ID: <4682758.31r3eYUQgx@alexpc>
In-Reply-To: <5004d52da527bf1dd9e5b17e20b2ce50a0b57b5a.1633572679.git.atafalla@dnyon.com>
References: <cover.1633572679.git.atafalla@dnyon.com> <5004d52da527bf1dd9e5b17e20b2ce50a0b57b5a.1633572679.git.atafalla@dnyon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/21 4:38 Alejandro Tafalla wrote:
> Signed-off-by: Alejandro Tafalla <atafalla@dnyon.com>
> ---
>  Documentation/devicetree/bindings/sound/max9892x.txt | 3 +++
>  1 file changed, 3 insertions(+)

Sorry, I forgot to add:  Acked-by: Rob Herring <robh@kernel.org>

-- 
Alejandro Tafalla


