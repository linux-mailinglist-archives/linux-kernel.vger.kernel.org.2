Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69A7F3F8B7E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 18:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243040AbhHZQFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 12:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbhHZQFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 12:05:40 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071CAC061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 09:04:53 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id i21so7446628ejd.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 09:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DHporovZFmU9bKIyyJNWmrcH7b2P9x/EJE1cZCgvzmE=;
        b=ZKR3h+4OuOJBh6n6Czcd/iH6qvH4Nc351hAm6h8GVLk3BQatJDXXMCXVseyppIX/oJ
         BiHz4f+MzeBOEx+zSyAZN4Lqk30KxBosecXNMLPR4QbHEkg/veOBBJ/sTDFinL7HPGYl
         21OSiSit6q6n3Z1pbcLK3sYuf5MhONsxjkfnQfjMNxjgTfZ0wpwx76HJ16zO4Mm848VY
         Caen7T+8NvYRx0an7JLDe5NNEANck3QGxL3NBVSOCP8tnofQ6dw87QQlaFrB9naOjKnC
         c+rs37YHPJQjd6ywboYWR7ZfnC0RCUGw0mAfodR6FwEt6pTijQ+qXezOO8x2NccKzmH6
         r17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DHporovZFmU9bKIyyJNWmrcH7b2P9x/EJE1cZCgvzmE=;
        b=sju8+DplGs/IYQqAJAyF84vbkt2860sazNlWE+z6KsWQHw2z6HEtuleDdsZEcgbqWj
         wQ+CrhIBGKrdqzHzZGjA/aVD49GP0tb2dSX+5G6APhk5iHeUipFZ2N5FZw+y5GYPVGIA
         bJ2Z4OfImpcxc9ZdKUAAWMlpru9GKRqCVe5Crq9NQxP55mbfjrxwwMTmk+lMcditXSgD
         Rb0QJcO3oQLaGnTxlY5eF5Iuit3b060jylMNLBLxy7eQvKJOIxao8M9uWDjR4XVikf5I
         gsl8Ce/XEpK4OLxi4zYt8xOKiD3332wjrtZr7+uk1DolY78PG1M9cfM82koXykUb+66W
         gCzQ==
X-Gm-Message-State: AOAM530I3Ekph2O2c41SWLrXk0gVBm1/nJlChHda35mh7z6KwPQXRFwh
        YJ6VMh5Eix2YoJuMhi39BL0=
X-Google-Smtp-Source: ABdhPJxm8FA85dZ0nT6zHXMTe3zlBCHLbl6lt6GGnhCEn+uuOpcKNVBPRg28wwyWHRySkNFQporPSA==
X-Received: by 2002:a17:906:8297:: with SMTP id h23mr5076951ejx.168.1629993891637;
        Thu, 26 Aug 2021 09:04:51 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id kk2sm153240ejc.114.2021.08.26.09.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 09:04:51 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, Fabio Aiuto <fabioaiuto83@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: r8188eu: Provide a TODO file for this driver
Date:   Thu, 26 Aug 2021 18:04:49 +0200
Message-ID: <1738388.hbRm42UXh6@localhost.localdomain>
In-Reply-To: <20210826135413.GA1931@kadam>
References: <20210826130342.9552-1-fmdefrancesco@gmail.com> <20210826135413.GA1931@kadam>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, August 26, 2021 3:54:13 PM CEST Dan Carpenter wrote:
> Another thing to fix are some of the sleeping in atomic bugs.
> 
> drivers/staging/r8188eu/core/rtw_ap.c:139 update_BCNTIM() warn: sleeping in atomic context
> drivers/staging/r8188eu/core/rtw_ap.c:1296 update_bcn_wps_ie() warn: sleeping in atomic context
> drivers/staging/r8188eu/core/rtw_ap.c:1361 update_beacon() warn: sleeping in atomic context
> drivers/staging/r8188eu/core/rtw_ap.c:1725 ap_free_sta() warn: sleeping in atomic context
> drivers/staging/r8188eu/core/rtw_pwrctrl.c:79 ips_leave() warn: sleeping in atomic context
> drivers/staging/r8188eu/core/rtw_pwrctrl.c:81 ips_leave() warn: sleeping in atomic context
> drivers/staging/r8188eu/core/rtw_mlme_ext.c:6764 receive_disconnect() warn: sleeping in atomic context
> drivers/staging/r8188eu/core/rtw_mlme_ext.c:7083 report_del_sta_event() warn: sleeping in atomic context
> drivers/staging/r8188eu/core/rtw_mlme_ext.c:8133 set_tx_beacon_cmd() warn: sleeping in atomic context
> drivers/staging/r8188eu/os_dep/mlme_linux.c:117 rtw_report_sec_ie() warn: sleeping in atomic context
> 
> There are a few in rtl8723bs as well since the code came from the same
> place.
> 
> drivers/staging/rtl8723bs/core/rtw_ap.c:1601 update_beacon() warn: sleeping in atomic context
> drivers/staging/rtl8723bs/core/rtw_ap.c:1919 ap_free_sta() warn: sleeping in atomic context
> drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:4270 receive_disconnect() warn: sleeping in atomic context
> drivers/staging/rtl8723bs/hal/hal_intf.c:100 rtw_hal_init() warn: sleeping in atomic context
> 
> regards,
> dan carpenter

Thanks for your suggestion, I'll add this too to next version.

However I prefer to wait until tomorrow because it is probable that someone else 
have think of more tasks to add to the list.

Regards,

Fabio


