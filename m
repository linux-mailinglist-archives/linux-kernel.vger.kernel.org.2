Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D35B322C0F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 15:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbhBWOSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 09:18:24 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:43653 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbhBWOSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 09:18:18 -0500
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mdvyi-1lnKzS3eCM-00b0aU; Tue, 23 Feb 2021 15:15:24 +0100
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id 73AB41E01EB;
        Tue, 23 Feb 2021 14:15:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VmzJgTaF5xPP; Tue, 23 Feb 2021 15:15:22 +0100 (CET)
Received: from pflmari.corp.cetitec.com (21-usr-pf-main.vpn.it.cetitec.com [10.8.5.21])
        by mail.cetitecgmbh.com (Postfix) with ESMTPSA id 2CA121E01EA;
        Tue, 23 Feb 2021 15:15:22 +0100 (CET)
Received: by pflmari.corp.cetitec.com (Postfix, from local account)
Date:   Tue, 23 Feb 2021 15:15:21 +0100
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau@lists.freedesktop.org, Martin Peres <martin.peres@free.fr>,
        Jeremy Cline <jcline@redhat.com>,
        Simon Ser <contact@emersion.fr>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Takashi Iwai <tiwai@suse.de>, James Jones <jajones@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] drm/nouveau/kms/nv50-: Report max cursor size to
 userspace
Message-ID: <YDUN+Re/alMVL0Zn@pflmari>
References: <20210119015415.2511028-1-lyude@redhat.com>
 <20210119015415.2511028-2-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119015415.2511028-2-lyude@redhat.com>
X-Provags-ID: V03:K1:OyqQZwzOO6IF8d6ExZM9WpBmYey37Dqo2pTpIaNdzhHny21aso9
 h9QRW0YUsgsKhN2jbE1zQlEowesa1sbZjl74BpdeCiwCjsHcDZCfjho0irbPPx1/QDzq+K0
 tyMd+mno2hxFag40eKo36u+8W6EfsthzItJotElpVDj3/DHoL1e8MLwPNtqkEISL8uW4s/U
 xQTFFT0qoIwQAZcfUUirA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TJHtvNtb7g8=:8384eCnJpXz5HeD1Prztbo
 UDwbYnh0+eY779QgS4xAqdrRhUO5J+U1jC/lc1UC15opcUmaDBjAWuw5meMJbaMnp88mkKM5B
 VTIV4IKCTTBhzqBXSPRWF+55fAInU1Dy6KDM45//ZI2vVsNhmrSYc1SQ+drpdMou+hNCgbYX0
 17gtRnG1D8kouAlcb3vvallL9jZhUlS2lrXD9Aoqu2L/SJFxqYL4FgbT5jR8wsk85mXy3cXu+
 nKLGePSzS4V5FXqSF2191SmfuwS/6yIKDlftgMtPZEYFXLFG7ZL65ML3TK777lvUY7jFq+oMf
 uSU0bKpgoQAUAoeg4DdpkHUQEsr5WE0bPwg6y7JLmCwQ/Ygc8+JVmJv2IKKybSfjFGaxo3qzF
 e4tieRefWi9yT8pYuUgPMX0s8c0tfDHIBYIuhlyvy7k63SdE39qCsu4rOy6G/AbtdvgGID6OG
 PUNAYSPSNw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lyude Paul, Tue, Jan 19, 2021 02:54:13 +0100:
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> index c6367035970e..5f4f09a601d4 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> @@ -2663,6 +2663,14 @@ nv50_display_create(struct drm_device *dev)
>  	else
>  		nouveau_display(dev)->format_modifiers = disp50xx_modifiers;
>  
> +	if (disp->disp->object.oclass >= GK104_DISP) {
> +		dev->mode_config.cursor_width = 256;
> +		dev->mode_config.cursor_height = 256;
> +	} else {
> +		dev->mode_config.cursor_width = 64;
> +		dev->mode_config.cursor_height = 64;
> +	}
> +
>  	/* create crtc objects to represent the hw heads */
>  	if (disp->disp->object.oclass >= GV100_DISP)
>  		crtcs = nvif_rd32(&device->object, 0x610060) & 0xff;

This change broke X cursor in my setup, and reverting the commit restores it.

Dell Precision M4800, issue ~2014 with GK106GLM [Quadro K2100M] (rev a1).
libdrm 2.4.91-1 (Debian 10.8 stable).
There are no errors or warnings in Xorg logs nor in the kernel log.

Regards,
Alex
