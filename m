Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5CCC347535
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 10:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbhCXJ65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 05:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235285AbhCXJ6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 05:58:32 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5835C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 02:58:29 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id o16so23794795wrn.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 02:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4IAizyz2Z8XBPiRZXX7HoIXc5iBlfx6vmHmpCSg2ErI=;
        b=DugpnjoWYYb/RRr0XkYUd7rw/VTVh0IKX2MtqhYuqjRT2kUTGK5XFhCAobCMPFRr/Z
         KyVRs6Xtw99fy/r6AZZ4oPGG8G+maxoJ9fgeD9gfwVesIwlqUcbyG/chMQOqvnqr5J2F
         PJVih8t8F3alpJRpEVZWYAWjXN8h3wfCIpNqdDWfQaRKdfHhQwGJ6SF2D2ldVH3yax8q
         l926lDJv94B12xqF7Bw+g6klWPrJYRBsE1gDvU+R0A4j1hSIX/cBJwRBKw2d6IJD+j7b
         gtcJ/bIOUoPjRXAMtphqbp5R39m0sgjDioEWtQ8HIgjX2VztXvDUJYNQZQYi+6U7SlbX
         pL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4IAizyz2Z8XBPiRZXX7HoIXc5iBlfx6vmHmpCSg2ErI=;
        b=Q6mOGtZRJI3kxwcTqiRnQW7M4v7A5zR0Vs+j/zu5YHvbBLU4Vj937gtArCiGXS64Ai
         bQjTmxzQZbshEYkIBffmiREzHtslzLXjiQA7zOqUkt2epEHTO2qH+p7IMVdQBnWIWSDq
         NqoFbkkXG05B63VrMON5o3QppRyYx+gaTfKmJXTco0xd7s0K0e6csj5ku5Eq3MEuzUaK
         lIJwAJU9MKqPMgSA55aSthuW5n9MpmkPR2F1PnP9OEQWHstBKRhGoC1J0gMroRtabKL5
         cpeqdmUVCw8m9dvn8zwe/pWuCqmhCeNVDu9Ly3XfAFGI8OUxB5eh5zspX293MBvEv8xA
         ffSA==
X-Gm-Message-State: AOAM530vKsxIl0/ub41VQd/fpAiqa8FE8p5LVei1E+PElbcLE4N0wQf8
        tUCcx3UmhLGpmVd4TxGzYSJdFLXjECs=
X-Google-Smtp-Source: ABdhPJyaKM8k/Qfk0w0ggcQCOmDe/PyRhryEmODm3bmXXbl3lJHyY4HGCLh7TMkWB0JGix/oMHU9kw==
X-Received: by 2002:adf:b345:: with SMTP id k5mr2628459wrd.14.1616579907759;
        Wed, 24 Mar 2021 02:58:27 -0700 (PDT)
Received: from agape.jhs ([5.170.80.89])
        by smtp.gmail.com with ESMTPSA id n6sm2542229wrt.1.2021.03.24.02.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 02:58:27 -0700 (PDT)
Date:   Wed, 24 Mar 2021 10:58:24 +0100
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org, joe@perches.com
Cc:     dan.carpenter@oracle.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: CHECKPATCH: missing a warning soon after include files decl -c
Message-ID: <20210324095820.GA2259@agape.jhs>
References: <20210320105424.GA3698@agape.jhs>
 <YFXVoHvk/VesFn14@kroah.com>
 <c27ae8926ccbc0f520045fea9127811f6e8fa706.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c27ae8926ccbc0f520045fea9127811f6e8fa706.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2021 at 04:28:51AM -0700, Joe Perches wrote:
> 
> Actually, these would seem to be better as one or multiple functions with
> local statics or even as static inlines functions in the .h file
> 
> $ git grep -w RTW_WPA_OUI drivers/staging/rtl8723bs/core
> drivers/staging/rtl8723bs/core/rtw_ap.c:extern unsigned char RTW_WPA_OUI[];
> drivers/staging/rtl8723bs/core/rtw_ap.c:        if (!memcmp(RTW_WPA_OUI, oui, 4))
> drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:unsigned char RTW_WPA_OUI[] = {0x00, 0x50, 0xf2, 0x01};
> drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:                  if ((!memcmp(pIE->data, RTW_WPA_OUI, 4)) ||
> drivers/staging/rtl8723bs/core/rtw_wlan_util.c:extern unsigned char RTW_WPA_OUI[];
> drivers/staging/rtl8723bs/core/rtw_wlan_util.c:                         if ((!memcmp(pIE->data, RTW_WPA_OUI, 4)) && (!memcmp((pIE->data + 12), WPA_TKIP_CIPHER, 4)))
> 
> $ git grep -w WMM_OUI drivers/staging/rtl8723bs/core
> drivers/staging/rtl8723bs/core/rtw_ap.c:extern unsigned char WMM_OUI[];
> drivers/staging/rtl8723bs/core/rtw_ap.c:        else if (!memcmp(WMM_OUI, oui, 4))
> drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:unsigned char WMM_OUI[] = {0x00, 0x50, 0xf2, 0x02};
> drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:                                  (!memcmp(pIE->data, WMM_OUI, 4)) ||
> drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:                  if (!memcmp(pIE->data, WMM_OUI, 4))
> drivers/staging/rtl8723bs/include/rtw_mlme_ext.h:extern unsigned char WMM_OUI[];
> 
> $ git grep -w WPS_OUI drivers/staging/rtl8723bs/core
> drivers/staging/rtl8723bs/core/rtw_ap.c:extern unsigned char WPS_OUI[];
> drivers/staging/rtl8723bs/core/rtw_ap.c:        else if (!memcmp(WPS_OUI, oui, 4))
> drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:unsigned char WPS_OUI[] = {0x00, 0x50, 0xf2, 0x04};
> drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:                                  (!memcmp(pIE->data, WPS_OUI, 4))) {
> drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:                          if ((!padapter->registrypriv.wifi_spec) && (!memcmp(pIE->data, WPS_OUI, 4))) {
> 
> $ git grep -w P2P_OUI drivers/staging/rtl8723bs/core
> drivers/staging/rtl8723bs/core/rtw_ap.c:extern unsigned char P2P_OUI[];
> drivers/staging/rtl8723bs/core/rtw_ap.c:        else if (!memcmp(P2P_OUI, oui, 4))
> drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:unsigned char P2P_OUI[] = {0x50, 0x6F, 0x9A, 0x09};
> drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:  if (!memcmp(frame_body + 2, P2P_OUI, 4)) {
> 
> So maybe something like the below (written in email client, maybe typos)
> 
> enum oui_type {
> 	RTW_WPA,
> 	WMM,
> 	WPS,
> 	P2P
> };
> 
> bool is_oui_type(const u8 *mem, enum oui_type type)
> {
> 	static const u8 rtw_wpa[] = {0x00, 0x50, 0xf2, 0x01};
> 	static const u8 wmm[] = {0x00, 0x50, 0xf2, 0x02};
> 	static const u8 wps[] = {0x00, 0x50, 0xf2, 0x04};
> 	static const u8 p2p[] = {0x50, 0x6F, 0x9A, 0x09};
> 
> 	const u8 *oui;
> 
> 	if (type == RTW_WPA)
> 		oui = rtw_wpa;
> 	else if (type == WMM)
> 		oui = wmm;
> 	else if (type == WPS)
> 		oui = wps;
> 	else if (type == P2P)
> 		oui = p2p;
> 	else
> 		return false;
> 
> 	return !memcmp(mem, oui, 4);
> }
> 
> so for instance the P2P uses would become
> 
> 	else if (is_oui_type(oui, P2P))
> and
> 	if (is_oui_type(frame_body + 2, P2P)) {
> 
> though I think 4 byte OUIs are just odd.
> 
> https://en.wikipedia.org/wiki/Organizationally_unique_identifier
> 
> An organizationally unique identifier (OUI) is a 24-bit number that uniquely identifies a vendor, manufacturer, or other organization.
> 
> 
> 

Hi,

is that good? May I do the same for others ouis? One small inline for each oui type instead
of a switch...

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 3cd9c61eec99..7d31f359cf37 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -1664,7 +1664,7 @@ static void update_bcn_p2p_ie(struct adapter *padapter)
 
 static void update_bcn_vendor_spec_ie(struct adapter *padapter, u8 *oui)
 {
-	if (!memcmp(RTW_WPA_OUI, oui, 4))
+	if (is_rtw_wpa_oui(oui))
 		update_bcn_wpa_ie(padapter);
 
 	else if (!memcmp(WMM_OUI, oui, 4))
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 8aadcf72a7ba..e05f70e434a2 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -57,7 +57,6 @@ static u8 null_addr[ETH_ALEN] = {0, 0, 0, 0, 0, 0};
 /**************************************************
 OUI definitions for the vendor specific IE
 ***************************************************/
-unsigned char RTW_WPA_OUI[] = {0x00, 0x50, 0xf2, 0x01};
 unsigned char WMM_OUI[] = {0x00, 0x50, 0xf2, 0x02};
 unsigned char WPS_OUI[] = {0x00, 0x50, 0xf2, 0x04};
 unsigned char P2P_OUI[] = {0x50, 0x6F, 0x9A, 0x09};
@@ -3194,7 +3193,7 @@ void issue_assocreq(struct adapter *padapter)
 
 		switch (pIE->ElementID) {
 		case WLAN_EID_VENDOR_SPECIFIC:
-			if ((!memcmp(pIE->data, RTW_WPA_OUI, 4)) ||
+			if ((is_rtw_wpa_oui(pIE->data)) ||
 					(!memcmp(pIE->data, WMM_OUI, 4)) ||
 					(!memcmp(pIE->data, WPS_OUI, 4))) {
 				vs_ie_length = pIE->Length;
diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 760b0ea4e9bd..8c73e44459eb 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -1490,7 +1490,7 @@ unsigned int is_ap_in_tkip(struct adapter *padapter)
 
 			switch (pIE->ElementID) {
 			case WLAN_EID_VENDOR_SPECIFIC:
-				if ((!memcmp(pIE->data, RTW_WPA_OUI, 4)) && (!memcmp((pIE->data + 12), WPA_TKIP_CIPHER, 4)))
+				if ((is_rtw_wpa_oui(pIE->data)) && (!memcmp((pIE->data + 12), WPA_TKIP_CIPHER, 4)))
 					return true;
 
 				break;
diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/staging/rtl8723bs/include/drv_types.h
index 1658450b386e..95ff682ef877 100644
--- a/drivers/staging/rtl8723bs/include/drv_types.h
+++ b/drivers/staging/rtl8723bs/include/drv_types.h
@@ -541,4 +541,10 @@ extern u32 g_wait_hiq_empty;
 extern u8 g_fwdl_wintint_rdy_fail;
 extern u8 g_fwdl_chksum_fail;
 
+/* OUI verification ruotines */
+static inline bool is_rtw_wpa_oui(const u8 *mem)
+{
+	static const char rtw_wpa[] = {0x00, 0x50, 0xf2, 0x01};
+	return !memcmp(mem, rtw_wpa, 4);
+}
 #endif /* __DRV_TYPES_H__ */
diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
index fb283dc04ee2..14b570658b77 100644
--- a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
@@ -96,8 +96,6 @@ MCS rate definitions
 #define MCS_RATE_4R	(0xffffffff)
 #define MCS_RATE_2R_13TO15_OFF	(0x00001fff)
 
-
-extern unsigned char RTW_WPA_OUI[];
 extern unsigned char WMM_OUI[];
 extern unsigned char WPS_OUI[];
 extern unsigned char WFD_OUI[];

thank you in advance,

fabio
