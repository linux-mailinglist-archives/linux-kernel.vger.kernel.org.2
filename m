Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504143F4092
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 18:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbhHVQqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 12:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhHVQqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 12:46:33 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C99C061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 09:45:51 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id h13so22477549wrp.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 09:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8lzePtopTRMlOiriE6H7mFlvfme0tBsWN8cD99HXUTo=;
        b=Jc2yq+L9vmYLjxAmiYSBmSn0fnWjDTp16nnp91Vp9cEe0fmHmvNiJ32LdQ0k3eqzNg
         QgFCymm/cjxwCWawyufExOqU6P/s8vdt7YHc4GnrDN4rwcC6HrxuCUj7Sfz5R2FKoN7l
         yziAZqGO3KTQWs0kXA16SiSFrISY1qLEw64X2A6Vfb/RbHGRrzH0aPZTFQ9uKz9SPgRH
         uOIMx26trgl+lI5wQWdZKNhM2CsIFZ2KV6SfNqwn8mFdB6iwofClpO4CitiQ/CcvlFwj
         vr5XCHZn+jEfWa90iG7hFm1KtBWhcFkJ9RM7lrGG7PakG8eQFqbkZynIMkyae5kFnKNl
         3NCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8lzePtopTRMlOiriE6H7mFlvfme0tBsWN8cD99HXUTo=;
        b=CxCdVMkseIk+1QkYqm6QW8s5Robzl2H+ilrUF4QJEfhC0XgK8F0Iwpsr1mAyGmm7SH
         Cm6YTmY1zDre+IhVnpoYPSdNJyWwzIziL0vUC8oVWYxaEHZIGJBxsP7W1gaWe7iQbYg7
         NoKPLRHCaYn9WlmEtyfX+kAd5nE5QOv9r4e9S4zuM4JbzpnhIhTq6bWabp9hYuBhBHIc
         BTumqqf5K2qM4KRsOcNmlIcLr1iAmk8ap6CQXCoQw+gRZntaoPmmXaej8h2nU8JjLxIi
         wWOTc8gKxlB9iEG8GGx6MpNS6aqIlcEnUrj5o0p5JeknlbWdiwsadF2QsuFVokqW6lV2
         bsAA==
X-Gm-Message-State: AOAM532ekOYpHnKvuIBW/WxAYu/yssWk/5RCm6PGTvji/IBeKbmnP5uJ
        coXZenZOIZsrLFLl+hZ+kX4=
X-Google-Smtp-Source: ABdhPJxnVSpHHYncIn8JQFJp9hLN2tLT0V687fGM5hBbMGBp+YyqW0CLaRrbBIxi2hwV2NipAjsjVA==
X-Received: by 2002:a5d:4bc7:: with SMTP id l7mr9752794wrt.146.1629650750521;
        Sun, 22 Aug 2021 09:45:50 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::687e])
        by smtp.gmail.com with ESMTPSA id i9sm15213741wre.36.2021.08.22.09.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 09:45:50 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: r8188eu: remove if_ether.h header file
Date:   Sun, 22 Aug 2021 18:44:35 +0200
Message-Id: <20210822164435.16266-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All constants, declarations and macros in if_ether.h are either
duplicated from <uapi/linux/if_ether.h> or unused. Remove the file
if_ether.h and its includes.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_recv.c      |  1 -
 drivers/staging/r8188eu/hal/rtl8188eu_recv.c |  1 -
 drivers/staging/r8188eu/include/if_ether.h   | 94 --------------------
 drivers/staging/r8188eu/os_dep/xmit_linux.c  |  1 -
 4 files changed, 97 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/include/if_ether.h

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 52236bae8693..08066c9587f9 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -8,7 +8,6 @@
 #include "../include/recv_osdep.h"
 #include "../include/mlme_osdep.h"
 #include "../include/ip.h"
-#include "../include/if_ether.h"
 #include "../include/ethernet.h"
 #include "../include/usb_ops.h"
 #include "../include/wifi.h"
diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_recv.c b/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
index a44c9598186c..3a2c7090cd7b 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
@@ -7,7 +7,6 @@
 #include "../include/recv_osdep.h"
 #include "../include/mlme_osdep.h"
 #include "../include/ip.h"
-#include "../include/if_ether.h"
 #include "../include/ethernet.h"
 
 #include "../include/usb_ops.h"
diff --git a/drivers/staging/r8188eu/include/if_ether.h b/drivers/staging/r8188eu/include/if_ether.h
deleted file mode 100644
index 5bb79fddeec6..000000000000
--- a/drivers/staging/r8188eu/include/if_ether.h
+++ /dev/null
@@ -1,94 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
-/* Copyright(c) 2007 - 2011 Realtek Corporation. */
-
-#ifndef _LINUX_IF_ETHER_H
-#define _LINUX_IF_ETHER_H
-
-/*
- *	IEEE 802.3 Ethernet magic constants.  The frame sizes omit the preamble
- *	and FCS/CRC (frame check sequence).
- */
-
-#define ETH_ALEN	6		/* Octets in one ethernet addr	 */
-#define ETH_HLEN	14		/* Total octets in header.	 */
-#define ETH_ZLEN	60		/* Min. octets in frame sans FCS */
-#define ETH_DATA_LEN	1500		/* Max. octets in payload	 */
-#define ETH_FRAME_LEN	1514		/* Max. octets in frame sans FCS */
-
-/*
- *	These are the defined Ethernet Protocol ID's.
- */
-
-#define ETH_P_LOOP	0x0060		/* Ethernet Loopback packet	*/
-#define ETH_P_PUP	0x0200		/* Xerox PUP packet		*/
-#define ETH_P_PUPAT	0x0201		/* Xerox PUP Addr Trans packet	*/
-#define ETH_P_IP	0x0800		/* Internet Protocol packet	*/
-#define ETH_P_X25	0x0805		/* CCITT X.25			*/
-#define ETH_P_ARP	0x0806		/* Address Resolution packet	*/
-#define	ETH_P_BPQ	0x08FF		/* G8BPQ AX.25 Ethernet Packet  */
-#define ETH_P_IEEEPUP	0x0a00		/* Xerox IEEE802.3 PUP packet   */
-#define ETH_P_IEEEPUPAT	0x0a01		/* Xerox IEEE802.3 PUP		*/
-#define ETH_P_DEC       0x6000          /* DEC Assigned proto           */
-#define ETH_P_DNA_DL    0x6001          /* DEC DNA Dump/Load            */
-#define ETH_P_DNA_RC    0x6002          /* DEC DNA Remote Console       */
-#define ETH_P_DNA_RT    0x6003          /* DEC DNA Routing              */
-#define ETH_P_LAT       0x6004          /* DEC LAT                      */
-#define ETH_P_DIAG      0x6005          /* DEC Diagnostics              */
-#define ETH_P_CUST      0x6006          /* DEC Customer use             */
-#define ETH_P_SCA       0x6007          /* DEC Systems Comms Arch       */
-#define ETH_P_RARP      0x8035		/* Reverse Addr Res packet	*/
-#define ETH_P_ATALK	0x809B		/* Appletalk DDP		*/
-#define ETH_P_AARP	0x80F3		/* Appletalk AARP		*/
-#define ETH_P_8021Q	0x8100          /* 802.1Q VLAN Extended Header  */
-#define ETH_P_IPX	0x8137		/* IPX over DIX			*/
-#define ETH_P_IPV6	0x86DD		/* IPv6 over bluebook		*/
-#define ETH_P_PPP_DISC	0x8863		/* PPPoE discovery messages     */
-#define ETH_P_PPP_SES	0x8864		/* PPPoE session messages	*/
-#define ETH_P_ATMMPOA	0x884c		/* MultiProtocol Over ATM	*/
-#define ETH_P_ATMFATE	0x8884		/* Frame-based ATM Transport
-					 * over Ethernet
-					 */
-
-/*
- *	Non DIX types. Won't clash for 1500 types.
- */
-
-#define ETH_P_802_3	0x0001		/* Dummy type for 802.3 frames  */
-#define ETH_P_AX25	0x0002		/* Dummy protocol id for AX.25  */
-#define ETH_P_ALL	0x0003		/* Every packet (be careful!!!) */
-#define ETH_P_802_2	0x0004		/* 802.2 frames			*/
-#define ETH_P_SNAP	0x0005		/* Internal only		*/
-#define ETH_P_DDCMP     0x0006          /* DEC DDCMP: Internal only     */
-#define ETH_P_WAN_PPP   0x0007          /* Dummy type for WAN PPP frames*/
-#define ETH_P_PPP_MP    0x0008          /* Dummy type for PPP MP frames */
-#define ETH_P_LOCALTALK 0x0009		/* Localtalk pseudo type	*/
-#define ETH_P_PPPTALK	0x0010		/* Dummy type for Atalk over PPP*/
-#define ETH_P_TR_802_2	0x0011		/* 802.2 frames			*/
-#define ETH_P_MOBITEX	0x0015		/* Mobitex (kaz@cafe.net)	*/
-#define ETH_P_CONTROL	0x0016		/* Card specific control frames */
-#define ETH_P_IRDA	0x0017		/* Linux-IrDA			*/
-#define ETH_P_ECONET	0x0018		/* Acorn Econet			*/
-
-/*
- *	This is an Ethernet frame header.
- */
-
-struct ethhdr {
-	unsigned char	h_dest[ETH_ALEN];	/* destination eth addr	*/
-	unsigned char	h_source[ETH_ALEN];	/* source ether addr	*/
-	unsigned short	h_proto;		/* packet type ID field	*/
-};
-
-struct _vlan {
-	unsigned short       h_vlan_TCI;	/*  Encap prio and VLAN ID */
-	unsigned short       h_vlan_encapsulated_proto;
-};
-
-#define get_vlan_id(pvlan)				\
-	((ntohs((unsigned short)pvlan->h_vlan_TCI)) & 0xfff)
-#define get_vlan_priority(pvlan)			\
-	((ntohs((unsigned short)pvlan->h_vlan_TCI))>>13)
-#define get_vlan_encap_proto(pvlan)			\
-	 (ntohs((unsigned short)pvlan->h_vlan_encapsulated_proto))
-
-#endif	/* _LINUX_IF_ETHER_H */
diff --git a/drivers/staging/r8188eu/os_dep/xmit_linux.c b/drivers/staging/r8188eu/os_dep/xmit_linux.c
index 60e0eea7ad84..d35e92c17a5e 100644
--- a/drivers/staging/r8188eu/os_dep/xmit_linux.c
+++ b/drivers/staging/r8188eu/os_dep/xmit_linux.c
@@ -5,7 +5,6 @@
 
 #include "../include/osdep_service.h"
 #include "../include/drv_types.h"
-#include "../include/if_ether.h"
 #include "../include/ip.h"
 #include "../include/wifi.h"
 #include "../include/mlme_osdep.h"
-- 
2.32.0

