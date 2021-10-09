Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5456427C06
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 18:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhJIQdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 12:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhJIQdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 12:33:18 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF13CC061570
        for <linux-kernel@vger.kernel.org>; Sat,  9 Oct 2021 09:31:21 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id d3so20980703edp.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Oct 2021 09:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4ZN4LmU5TkDPnpppYR+BVtqRy5brlt6OMMmyuri2dzg=;
        b=nj3ljy19/ZxZV1xG4Hf/xSjDsI0cgkH4tnI6/pOfiwvqyOreHWpOk+hiFuaLR76Gd6
         Wx6QTfNQq4pf4wwU/bpep4Qx74UombBf/1TLFtG6cP6vMixZRFBWRzw0J6WQ8s17JFUH
         EdW4/+PyyjaHAhkjQHsOnWtKr1ZMZHrlN3Kf2aTwHCWB1rP9LcY4UmWGJM+2uP7wozXM
         YRX/WDnd+3d+lAutzgV2eDWyfCM6WrDFxfaILumxNENKcL4Vy78Zll2yjh1cXBT0UW+6
         0nTT84wzNYul/+NJ7R3g8Q1kiugrg6MFUBppGA39zi2W6bYhuktYXTVxs+ZJ1HxOp8tP
         cz0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4ZN4LmU5TkDPnpppYR+BVtqRy5brlt6OMMmyuri2dzg=;
        b=oMBfaUzzpSss1XMgIRuZfUrGOlAwtMyoeVborBD1WJy+cOdsXXQZfykD0E3qwmYU0K
         ZMNepkxsvHHOCSJJkMKBBQ1qtiFfXLa9VuWgFRL10pHwrJwUmOpv8+EP/MDeopXX+uJP
         hydPKiu3vA1oNhRIw4PBYSiVxQLochKOgPMLJTcRiGN2+P5ZQcSJFzT3BmJMVqMFKP60
         ms7TiqUFKwu/r6D4sUbQWhf6QcsnuGR7+fVPM+2w2ODzuMn7D1b5XDDhhPh8xGnAwfCf
         bJQGzSV+qoFjDwofBpkfU5C1dLYD0qwpj7V+ddWd4RmSmkPT+tn+qlgSUIU/BOObq5Uh
         uqyg==
X-Gm-Message-State: AOAM531dZzE9OtniEBTxTf/CkDhd8dJvD0t3tD81D6aafiib3DKDlmhO
        5ig2FKRb+AcZ9D1SnWOM/Ps=
X-Google-Smtp-Source: ABdhPJwlHEcCYDPvmo61YsvLnq394NCUVV4o2DgjnmN/yc2H+OYP5abeJzfsMJPP4OAjz1+QLUVN8w==
X-Received: by 2002:a05:6402:270f:: with SMTP id y15mr20085598edd.126.1633797080297;
        Sat, 09 Oct 2021 09:31:20 -0700 (PDT)
Received: from localhost.localdomain (host-79-43-109-12.retail.telecomitalia.it. [79.43.109.12])
        by smtp.gmail.com with ESMTPSA id v13sm1151965ejh.62.2021.10.09.09.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Oct 2021 09:31:19 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: r8188eu: Provide a TODO file for this driver
Date:   Sat, 09 Oct 2021 18:31:12 +0200
Message-ID: <6435467.SEsBC3EFVD@localhost.localdomain>
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
> drivers/staging/r8188eu/core/rtw_ap.c:139 update_BCNTIM() warn: sleeping in 
atomic context
> drivers/staging/r8188eu/core/rtw_ap.c:1296 update_bcn_wps_ie() warn: 
sleeping in atomic context
> drivers/staging/r8188eu/core/rtw_ap.c:1361 update_beacon() warn: sleeping 
in atomic context
> drivers/staging/r8188eu/core/rtw_ap.c:1725 ap_free_sta() warn: sleeping in 
atomic context
> drivers/staging/r8188eu/core/rtw_pwrctrl.c:79 ips_leave() warn: sleeping in 
atomic context
> drivers/staging/r8188eu/core/rtw_pwrctrl.c:81 ips_leave() warn: sleeping in 
atomic context
> drivers/staging/r8188eu/core/rtw_mlme_ext.c:6764 receive_disconnect() warn: 
sleeping in atomic context
> drivers/staging/r8188eu/core/rtw_mlme_ext.c:7083 report_del_sta_event() 
warn: sleeping in atomic context
> drivers/staging/r8188eu/core/rtw_mlme_ext.c:8133 set_tx_beacon_cmd() warn: 
sleeping in atomic context
> drivers/staging/r8188eu/os_dep/mlme_linux.c:117 rtw_report_sec_ie() warn: 
sleeping in atomic context
> 
> There are a few in rtl8723bs as well since the code came from the same
> place.
> 
> drivers/staging/rtl8723bs/core/rtw_ap.c:1601 update_beacon() warn: sleeping 
in atomic context
> drivers/staging/rtl8723bs/core/rtw_ap.c:1919 ap_free_sta() warn: sleeping 
in atomic context
> drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:4270 receive_disconnect() 
warn: sleeping in atomic context
> drivers/staging/rtl8723bs/hal/hal_intf.c:100 rtw_hal_init() warn: sleeping 
in atomic context
> 
> regards,
> dan carpenter
> 
Hello Dan,

I'd like to address these kind of bugs, but I have a couple of questions 
about them.

1) You've listed what looks like the output of a compiler or static analyzer. 
How did you get the warnings you copy-pasted above?

2) I know that both the execution of interrupt handlers (ISRs) as well as any 
code blocks that are executed holding spinlocks are "atomic contexts". In 
these cases, "sleeping" is not allowed (for obvious reasons). Besides the two 
mentioned above, are there any further cases of "atomic contexts" in the 
kernel? 

Thank you in advance,

Fabio



