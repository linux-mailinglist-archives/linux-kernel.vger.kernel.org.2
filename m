Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3789D4132DC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 13:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbhIULx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 07:53:57 -0400
Received: from todd.t-8ch.de ([159.69.126.157]:40719 "EHLO todd.t-8ch.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232387AbhIULxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 07:53:55 -0400
Date:   Tue, 21 Sep 2021 13:52:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1632225146;
        bh=8eMTdJKgrTU/j4CDQr38gY0ihDGwVWqp14X73FihxXE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AcCNVUGlj56KMOAsGg62bdDDEBsv3gyYnimTvb17Da9iJL84WU89sG7oOxQB3KF6s
         7iNIYrAmm3/dRJVhVfON+oYCQ1vJZJKUXDJjQks+9JbXWKH4Vt+kNyROb4CMeYofDK
         ltd+o0gkkJ8TfaasHpUqxEj4IjQ9/8vv+8foAHeU=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@weissschuh.net>
To:     Tobias Jakobi <cubic2k@gmail.com>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        Tobias Jakobi <tjakobi@math.uni-bielefeld.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: gigabyte-wmi: add support for B550I Aorus
 Pro AX
Message-ID: <2643586e-cfda-4273-9ebe-585696eac755@t-8ch.de>
References: <20210921100702.3838-1-tjakobi@math.uni-bielefeld.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210921100702.3838-1-tjakobi@math.uni-bielefeld.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-21T12:07+0200, Tobias Jakobi wrote:
> - tested with a AMD Ryzen 7 5800X
> 
> Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> ---
>  drivers/platform/x86/gigabyte-wmi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/gigabyte-wmi.c b/drivers/platform/x86/gigabyte-wmi.c
> index 7f3a03f937f6..d53634c8a6e0 100644
> --- a/drivers/platform/x86/gigabyte-wmi.c
> +++ b/drivers/platform/x86/gigabyte-wmi.c
> @@ -144,6 +144,7 @@ static const struct dmi_system_id gigabyte_wmi_known_working_platforms[] = {
>  	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B550 AORUS ELITE"),
>  	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B550 AORUS ELITE V2"),
>  	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B550 GAMING X V2"),
> +	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B550I AORUS PRO AX"),
>  	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B550M AORUS PRO-P"),
>  	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B550M DS3H"),
>  	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("Z390 I AORUS PRO WIFI-CF"),
> -- 
> 2.32.0

Thanks!

Ack-by: Thomas Weißschuh <thomas@weissschuh.net>

FYI you should also Cc LKML to all patches.
