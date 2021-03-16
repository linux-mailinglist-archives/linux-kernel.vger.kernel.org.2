Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D293333D770
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 16:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236895AbhCPPaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 11:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236818AbhCPP3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 11:29:45 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA398C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 08:29:44 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 124-20020a1c00820000b029010b871409cfso1681978wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 08:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ktNAwTlvxfid44xGOaNhTbS/R1RBktam9MRYoKsMOPY=;
        b=bApAdIJXw+IMYQonD10JnUzZU9PsXhkEiPEL5M7B/dzXpiCZnJUEc9/uwvi243zIsJ
         4rueYD3sxXFf2iiGifsAHTWxDc2qVgQmD+XjrLil0fuHvGd6Y/pdYkFO/qhQx/1vwNZu
         AQZgdY9rrqyyj+lIlFwmrshm7GPipUKIrCWczd14n9Xk4hshtiUazqul72ukhw1IVWtP
         aMdbSPvGI8KVynj/MXrbqQYEKyHjPI76f2s/jTKgIfZ+tHe2zTpRChyTLnNLSmsBTYa9
         BKRwoDt+9iuWKzZ6gmR64/rZ+dLI/EfjKglW1hs2C87bMOK2HnJ7zZxiwIh7SnZnvdPs
         cdNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ktNAwTlvxfid44xGOaNhTbS/R1RBktam9MRYoKsMOPY=;
        b=GqMdjC3v+cezB5Bi9fgRnxdbXYhk8hKbMA9yB1xjCFKL7/TUkH7CiYote0TLttdEQD
         u4MyM6mFOtlElDov0QAmi5ktPBXc23zqesQvKADAkt53PvqG5kz/MME1WVliuUmRLpQ9
         8h0RyeRDEPGCSK8W0bXFAI9vJ2FK/tBoeBfxrCLfaovnWduuOaWolkjGEMzUEBq34kVf
         5bij3BZ+JagcsTuiQ0VlI+ySOTJQ9zoVqdX96ha6Ume8EtDv5jZALM1pZ6syQ5Es2DFn
         6xw0WDXulSf15OhYwnHibDbXC84c1BjlHEcqPFoNs5VDzxO5vJEPUGTXVTyCqnYv97/V
         Kb/A==
X-Gm-Message-State: AOAM532gYNFLct+51kWNxw7+G8yS+CLOq+ZbOnQzl7bHe/p+qpAS6Q40
        NDWIg3C3IUEBPYnt4pC8JQ4=
X-Google-Smtp-Source: ABdhPJwuTZnFJLUBP11jsbmi45bNqn/w/uf9WruOmUv2ktLIUNmyxmTCJuD1AUVozmLu4DM1zSs/NQ==
X-Received: by 2002:a1c:a5cb:: with SMTP id o194mr171923wme.129.1615908583486;
        Tue, 16 Mar 2021 08:29:43 -0700 (PDT)
Received: from agape.jhs ([5.171.72.71])
        by smtp.gmail.com with ESMTPSA id v9sm22798352wrn.86.2021.03.16.08.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:29:43 -0700 (PDT)
Date:   Tue, 16 Mar 2021 16:29:40 +0100
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/12] Remove more unused code blocks
Message-ID: <cover.1615907632.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused code clocks, as required in TODO list:

	find and remove code blocks guarded by never set CONFIG_FOO defines

Fabio Aiuto (12):
  staging: rtl8723bs: remove unused code blocks
    conditioned by never set CONFIG_CMCC_TEST
  staging: rtl8723bs: remove unused code blocks conditioned by never set
    CONFIG_INTERRUPT_BASED_TXBCN*
  staging: rtl8723bs: remove unused code blocks conditioned by never set
    CONFIG_DISABLE_MCS13TO15
  staging: rtl8723bs: remove unused code blocks conditioned by never set
    CONFIG_UPDATE_INDICATE_SEQ_WHILE_PROCESS_ADDBA_REQ
  staging: rtl8723bs: remove unused code blocks conditioned by never set
    CONFIG_VALIDATE_SSID
  staging: rtl8723bs: remove unused code blocks conditioned by never set
    CONFIG_LAYER2_ROAMING_ACTIVE
  staging: rtl8723bs: remove unused code blocks conditioned by never set
    CONFIG_USB_VENDOR*
  staging: rtl8723bs: remove unused code blocks conditioned by never set
    CONFIG_SINGLE_RECV_BUF
  staging: rtl8723bs: remove unused code blocks conditioned by never set
    CONFIG_RX_INDICATE_QUEUE
  staging: rtl8723bs: remove unused code blocks conditioned by never set
    CONFIG_BSD_RX_USE_MBUF
  staging: rtl8723bs: remove unused code blocks conditioned by never set
    CONFIG_R871X_TEST
  staging: rtl8723bs: remove unused code blocks conditioned by never set
    CONFIG_MULTI_VIR_IFACES

 drivers/staging/rtl8723bs/core/rtw_ap.c       | 30 ++------------
 .../staging/rtl8723bs/core/rtw_ioctl_set.c    | 11 -----
 drivers/staging/rtl8723bs/core/rtw_mlme.c     | 19 +--------
 .../staging/rtl8723bs/core/rtw_wlan_util.c    | 15 -------
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c | 40 -------------------
 drivers/staging/rtl8723bs/include/drv_conf.h  | 10 -----
 drivers/staging/rtl8723bs/include/drv_types.h |  3 --
 .../staging/rtl8723bs/include/osdep_intf.h    |  6 ---
 drivers/staging/rtl8723bs/include/rtw_recv.h  | 17 +-------
 9 files changed, 6 insertions(+), 145 deletions(-)

-- 
2.20.1

