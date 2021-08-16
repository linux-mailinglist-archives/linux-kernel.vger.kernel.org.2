Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B093EDAA0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 18:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhHPQQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 12:16:06 -0400
Received: from smtprelay0229.hostedemail.com ([216.40.44.229]:59390 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229517AbhHPQQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 12:16:04 -0400
Received: from omf04.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id C81ED180B61C5;
        Mon, 16 Aug 2021 16:15:31 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id 710B3D1516;
        Mon, 16 Aug 2021 16:15:30 +0000 (UTC)
Message-ID: <c30b9e08b7df2bade93d217c0bf6eb4b416eb2ec.camel@perches.com>
Subject: Re: [PATCH v2 1/4] staging: r8188eu: refactor
 rtw_is_cckrates_included()
From:   Joe Perches <joe@perches.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        gregkh@linuxfoundation.org,
        Michael Straube <straube.linux@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Mon, 16 Aug 2021 09:15:29 -0700
In-Reply-To: <22319347.s0ZA6q4zN9@localhost.localdomain>
References: <20210816115430.28264-1-straube.linux@gmail.com>
         <22319347.s0ZA6q4zN9@localhost.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Stat-Signature: epdxq7bmgezzohbgp1da31bhs9qbxs3r
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 710B3D1516
X-Spam-Status: No, score=2.10
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19dp04TCbVUYxX1N7ARIBKo1zZyVexZ75M=
X-HE-Tag: 1629130530-102685
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-08-16 at 14:59 +0200, Fabio M. De Francesco wrote:
> On Monday, August 16, 2021 1:54:27 PM CEST Michael Straube wrote:
> > Refactor function rtw_is_cckrates_included(). Improves readability
> > and slightly reduces object file size.
> > 
> > Signed-off-by: Michael Straube <straube.linux@gmail.com>
> > ---
> > v1 -> v2
> > Refactored to more compact code as suggested by Joe Perches.
> > 
> >  drivers/staging/r8188eu/core/rtw_ieee80211.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> > 
> 
> Thanks for redoing the series as suggested by Joe Perches.
> This is a perfect case where conciseness and readability don't clash and 
> instead the former enhances the latter. 

Perhaps do the whole thing in one go (moving the & 0x7f into the helper
avoids an early loop exit defect when the rate being indexed is 0x80)

---
 drivers/staging/r8188eu/core/rtw_ieee80211.c | 33 +++++++++++++++-------------
 drivers/staging/r8188eu/include/ieee80211.h  |  5 ++---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c |  4 ++--
 3 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
index ff77e686721ce..f02863caddde7 100644
--- a/drivers/staging/r8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/r8188eu/core/rtw_ieee80211.c
@@ -68,28 +68,31 @@ int rtw_get_bit_value_from_ieee_value(u8 val)
 	return 0;
 }
 
-uint	rtw_is_cckrates_included(u8 *rate)
+static bool rtw_is_cckrate(u8 rate)
 {
-	u32	i = 0;
+	rate &= 0x7f;
+	return rate == 2 || rate == 4 || rate == 11 || rate == 22;
+}
+
+bool rtw_is_cckrates_included(u8 *rate)
+{
+	u8 r;
 
-	while (rate[i] != 0) {
-		if  ((((rate[i]) & 0x7f) == 2) || (((rate[i]) & 0x7f) == 4) ||
-		     (((rate[i]) & 0x7f) == 11)  || (((rate[i]) & 0x7f) == 22))
+	while ((r = *rate++)) {
+		if (rtw_is_cckrate(r))
 			return true;
-		i++;
 	}
+
 	return false;
 }
 
-uint	rtw_is_cckratesonly_included(u8 *rate)
+bool rtw_is_cckratesonly_included(u8 *rate)
 {
-	u32 i = 0;
+	u8 r;
 
-	while (rate[i] != 0) {
-		if  ((((rate[i]) & 0x7f) != 2) && (((rate[i]) & 0x7f) != 4) &&
-		     (((rate[i]) & 0x7f) != 11)  && (((rate[i]) & 0x7f) != 22))
+	while ((r = *rate++)) {
+		if (!rtw_is_cckrate(r))
 			return false;
-		i++;
 	}
 
 	return true;
@@ -98,14 +101,14 @@ uint	rtw_is_cckratesonly_included(u8 *rate)
 int rtw_check_network_type(unsigned char *rate, int ratelen, int channel)
 {
 	if (channel > 14) {
-		if ((rtw_is_cckrates_included(rate)) == true)
+		if ((rtw_is_cckrates_included(rate)))
 			return WIRELESS_INVALID;
 		else
 			return WIRELESS_11A;
 	} else {  /*  could be pure B, pure G, or B/G */
-		if ((rtw_is_cckratesonly_included(rate)) == true)
+		if ((rtw_is_cckratesonly_included(rate)))
 			return WIRELESS_11B;
-		else if ((rtw_is_cckrates_included(rate)) == true)
+		else if ((rtw_is_cckrates_included(rate)))
 			return	WIRELESS_11BG;
 		else
 			return WIRELESS_11G;
diff --git a/drivers/staging/r8188eu/include/ieee80211.h b/drivers/staging/r8188eu/include/ieee80211.h
index 4dfa817175e77..890419d201903 100644
--- a/drivers/staging/r8188eu/include/ieee80211.h
+++ b/drivers/staging/r8188eu/include/ieee80211.h
@@ -1225,9 +1225,8 @@ int rtw_generate_ie(struct registry_priv *pregistrypriv);
 
 int rtw_get_bit_value_from_ieee_value(u8 val);
 
-uint	rtw_is_cckrates_included(u8 *rate);
-
-uint	rtw_is_cckratesonly_included(u8 *rate);
+bool rtw_is_cckrates_included(u8 *rate);
+bool rtw_is_cckratesonly_included(u8 *rate);
 
 int rtw_check_network_type(unsigned char *rate, int ratelen, int channel);
 
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index a94946ad11fce..37ab633acb982 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -784,12 +784,12 @@ static int rtw_wx_get_name(struct net_device *dev,
 
 		prates = &pcur_bss->SupportedRates;
 
-		if (rtw_is_cckratesonly_included((u8 *)prates) == true) {
+		if (rtw_is_cckratesonly_included((u8 *)prates)) {
 			if (ht_cap)
 				snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11bn");
 			else
 				snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11b");
-		} else if ((rtw_is_cckrates_included((u8 *)prates)) == true) {
+		} else if ((rtw_is_cckrates_included((u8 *)prates))) {
 			if (ht_cap)
 				snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11bgn");
 			else

