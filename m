Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B12643958BB
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 12:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhEaKIU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 31 May 2021 06:08:20 -0400
Received: from mga06.intel.com ([134.134.136.31]:3713 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230521AbhEaKHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 06:07:16 -0400
IronPort-SDR: ETwz2zJfRC58yyaNv8vEmhKLK5GorxVMZgXJij27B0C7ympMDbrFevSyvuiVsLZwIfUtTzTAkW
 5o6jxcOkEh/Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10000"; a="264523884"
X-IronPort-AV: E=Sophos;i="5.83,236,1616482800"; 
   d="scan'208";a="264523884"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 03:05:36 -0700
IronPort-SDR: aiEekzZjHSD7NbXYCaWUaCjaPWTrU5fbNnwzeXalSbsjlVmoyla3MzplSTYaxNjeXYNX37Rg25
 ebkyyQn5meYA==
X-IronPort-AV: E=Sophos;i="5.83,236,1616482800"; 
   d="scan'208";a="478858881"
Received: from masayag-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.52.77])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 03:05:32 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>, Hector Martin <marcan@marcan.st>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-kernel@vger.kernel.org,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Subject: Re: [PATCH v2 2/2] maintainers: Update freedesktop.org IRC channels
In-Reply-To: <20210531031029.4642-2-alyssa@rosenzweig.io>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20210531031029.4642-1-alyssa@rosenzweig.io> <20210531031029.4642-2-alyssa@rosenzweig.io>
Date:   Mon, 31 May 2021 13:05:29 +0300
Message-ID: <87zgwbqkuu.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 May 2021, Alyssa Rosenzweig <alyssa@rosenzweig.io> wrote:
> Like many free software projects, freedesktop.org issued a non-binding
> recommendation for projects to migrate from Freenode to OFTC [1]. As
> such, freedesktop.org entries in the MAINTAINERS file are out-of-date as
> the respective channels have moved. Update the file to point to the
> right network.
>
> v2: Correct typo in commit message pointed out by Lukas and Jonathan.
> Add Hector's ack.
>
> [1] https://lists.freedesktop.org/archives/dri-devel/2021-May/307605.html
>
> Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> Acked-By: Hector Martin <marcan@marcan.st>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> Cc: linux-kernel@vger.kernel.org

Acked-by: Jani Nikula <jani.nikula@intel.com>

> ---
>  MAINTAINERS | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 49091fbfa..7f992125a 100644
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
> @@ -5969,7 +5969,7 @@ M:	Daniel Vetter <daniel@ffwll.ch>
>  L:	dri-devel@lists.freedesktop.org
>  S:	Maintained
>  B:	https://gitlab.freedesktop.org/drm
> -C:	irc://chat.freenode.net/dri-devel
> +C:	irc://irc.oftc.net/dri-devel
>  T:	git git://anongit.freedesktop.org/drm/drm
>  F:	Documentation/devicetree/bindings/display/
>  F:	Documentation/devicetree/bindings/gpu/
> @@ -9116,7 +9116,7 @@ S:	Supported
>  W:	https://01.org/linuxgraphics/
>  Q:	http://patchwork.freedesktop.org/project/intel-gfx/
>  B:	https://gitlab.freedesktop.org/drm/intel/-/wikis/How-to-file-i915-bugs
> -C:	irc://chat.freenode.net/intel-gfx
> +C:	irc://irc.oftc.net/intel-gfx
>  T:	git git://anongit.freedesktop.org/drm-intel
>  F:	Documentation/gpu/i915.rst
>  F:	drivers/gpu/drm/i915/

-- 
Jani Nikula, Intel Open Source Graphics Center
