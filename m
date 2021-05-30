Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1254395087
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 13:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbhE3LDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 07:03:20 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:40955 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhE3LDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 07:03:19 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id E84782800B3CA;
        Sun, 30 May 2021 13:01:39 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id DB36B197A; Sun, 30 May 2021 13:01:39 +0200 (CEST)
Date:   Sun, 30 May 2021 13:01:39 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH 2/2] maintainers: Update freedesktop.org IRC channels
Message-ID: <20210530110139.GA2678@wunner.de>
References: <20210529141638.5921-1-alyssa@rosenzweig.io>
 <20210529141638.5921-2-alyssa@rosenzweig.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210529141638.5921-2-alyssa@rosenzweig.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 29, 2021 at 10:16:38AM -0400, Alyssa Rosenzweig wrote:
> Like many free software projects, freedesktop.org issued a non-binding
> recommendation for projects to migrate from OFTC to Freenode [1]. As
> such, freedesktop.org entries in the MAINTAINERS file are out-of-date as
> the respective channels have moved. Update the file to point to the
> right network.
> 
> [1] https://lists.freedesktop.org/archives/dri-devel/2021-May/307605.html
[...]
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1651,7 +1651,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
>  W:	https://asahilinux.org
>  B:	https://github.com/AsahiLinux/linux/issues
> -C:	irc://chat.freenode.net/asahi-dev
> +C:	irc://irc.oftc.net/asahi-dev
>  T:	git https://github.com/AsahiLinux/linux.git
>  F:	Documentation/devicetree/bindings/arm/apple.yaml
>  F:	Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml

This isn't a freedesktop.org project, so either needs to be dropped
from the patch or the patch needs an ack from Hector Martin (+cc).

Thanks,

Lukas
