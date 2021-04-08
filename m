Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0376357E02
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 10:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhDHIZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 04:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhDHIZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 04:25:05 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0D8C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 01:24:53 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id t7so632399plg.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 01:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=lqMgkJQYoqUfp1WF2Os45zue5ybF7IcJCuRBI7bg4uQ=;
        b=SZEDIXirS114Eb5GuJte8T+YJ1JDlEOJA+5LURSp3329dYgjNRwKOFe8hpzPorkHsd
         6/fBAaKNwmmiZQ5FU41qlajiInFScWcb3dRvNPSFbwFAfWNI5WIwuBAeAGjdyOyoptYp
         TgwJpZXSTRbzepwiPB3qsQ2cRhHLsX4YkKBF7aL2yvxwPYYYmcBWqd8/lodjLuwRny2g
         tJBmGxe268XgBB04t4BTB+mzBx8xSJINkYBdk5w7r6hr2SrfOOxCfdL0vMEBEFZnmmOh
         ckOV8W8Rp85n7F4fCleVO6ZnKUHzSVhJH0RFtojqfYBbqlGTm8SPYUM7cjj7LsTgiFWV
         PjEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=lqMgkJQYoqUfp1WF2Os45zue5ybF7IcJCuRBI7bg4uQ=;
        b=XLpSi09/1vv4bTEoBdnm7ufFd3jjdAJ2qj59jEoQXXo42LQahwqmAkOGMBjiXKpx4N
         U8j6y1Fnf3YmodljG+Hxr4B2PlsPzRzQsySCUHq26n/stJkQu4scjKj1P652LqsEzHKQ
         MeHO1VNE2/eYsj73qjIfhrxC99WZWGmAoEdRNDHIzxVOJvXSM9BC6445xR78QkkgP9SG
         GLpIDWT+kiEGygWj4hZcCMF/7Lo/dBWZrVJxWPlZgWo6ZyH6gzlYFAuzm5GxlcLTpvoC
         MYTrXFJtlNf9/l2KPNpUMWwXQesA78ygSiTs0/xxYkR9ScQGvYeHNA1eE/jNqzIcBvkq
         Jg1g==
X-Gm-Message-State: AOAM530KO/Cd4jO7qDpbXmrazI9w4qTRLz2BJ0XIj7lkvR16yMDRA+Tt
        hfbb1WFAD3IZsyJJNDP8RYo=
X-Google-Smtp-Source: ABdhPJw2QAU2YRijtKDvsrutrmbGTgXpCV+OXgSBNfEzuLUC0368gUUZciRAsm8sgJdM1C3pQkmNqA==
X-Received: by 2002:a17:902:d645:b029:e8:ec90:d097 with SMTP id y5-20020a170902d645b02900e8ec90d097mr6680046plh.47.1617870293084;
        Thu, 08 Apr 2021 01:24:53 -0700 (PDT)
Received: from kali ([152.57.40.190])
        by smtp.gmail.com with ESMTPSA id 205sm24424032pfc.201.2021.04.08.01.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 01:24:52 -0700 (PDT)
Date:   Thu, 8 Apr 2021 13:54:49 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: [PATCH] staging: rtl8712: added spaces around '+'
Message-ID: <YG690ZIRdCEcjoM6@kali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up Check:spaces preferred around that '+' (ctx:VxV)
Reported by checkpatch

Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
---
 drivers/staging/rtl8712/wlan_bssdef.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/wlan_bssdef.h b/drivers/staging/rtl8712/wlan_bssdef.h
index b54ccaacc527..ec3749813728 100644
--- a/drivers/staging/rtl8712/wlan_bssdef.h
+++ b/drivers/staging/rtl8712/wlan_bssdef.h
@@ -176,7 +176,7 @@ struct NDIS_802_11_WEP {
 #define MIC_CHECK_TIME	60000000
 
 #ifndef Ndis802_11APMode
-#define Ndis802_11APMode (Ndis802_11InfrastructureMax+1)
+#define Ndis802_11APMode (Ndis802_11InfrastructureMax + 1)
 #endif
 
 struct	wlan_network {
-- 
2.30.2

