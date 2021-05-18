Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4D9387B9C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 16:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240034AbhEROqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 10:46:44 -0400
Received: from mail-40131.protonmail.ch ([185.70.40.131]:28465 "EHLO
        mail-40131.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238737AbhEROqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 10:46:43 -0400
Date:   Tue, 18 May 2021 14:45:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanbrattlof.com;
        s=protonmail3; t=1621349123;
        bh=7SqQ0z/yC4RMI5cS8AVUWXVYMaQLT2hax05NR/DcuiY=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=HXJrOc1cH5zHv5kORllo13xEMHOu/WkmzWOZwTV3mmMXcAns8T0Cq1GQ2LMElOrL6
         x3BXl7S9Dhlsz+26bBI4A19KJZZxDMvXprGbroZBd6ZPej4Y764VGkDpwK5QGOE8ld
         7OF/1/CFbuVND6wjEgSqrbFICvWkkUe7teLGMwi+BnD6ZNr0u7iqnjBwJDM/K/hCqu
         2sNVHKfqRHSq763+VOoctmBSZ1DGWaMmworcWd5wOvLFq7tzlPAKCsNdjFvRS8JdMq
         wDyFJ3qoiey66tIb1WF+BpsjbI6iB4fPw+x17Yg3EIu5gYRZXSog5t/8qMDMv0aQrG
         8gGmrxDETYX6Q==
To:     Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     Bryan Brattlof <hello@bryanbrattlof.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Reply-To: Bryan Brattlof <hello@bryanbrattlof.com>
Subject: [PATCH] staging: rtl8723bs: remove if (true) statement
Message-ID: <20210518144335.1677320-1-hello@bryanbrattlof.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'if (true) { ... }' will always evaluate to true. Remove it and
save a few tabs for somewhere else.

Signed-off-by: Bryan Brattlof <hello@bryanbrattlof.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c | 159 ++++++++++++------------
 1 file changed, 78 insertions(+), 81 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8=
723bs/core/rtw_ap.c
index 9df4476b2e2d..98b1bec67999 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -59,112 +59,109 @@ static void update_BCNTIM(struct adapter *padapter)
 =09unsigned char *pie =3D pnetwork_mlmeext->IEs;

 =09/* update TIM IE */
-=09/* if (pstapriv->tim_bitmap) */
-=09if (true) {
-=09=09u8 *p, *dst_ie, *premainder_ie =3D NULL, *pbackup_remainder_ie =3D N=
ULL;
-=09=09__le16 tim_bitmap_le;
-=09=09uint offset, tmp_len, tim_ielen, tim_ie_offset, remainder_ielen;
-
-=09=09tim_bitmap_le =3D cpu_to_le16(pstapriv->tim_bitmap);
-
-=09=09p =3D rtw_get_ie(pie + _FIXED_IE_LENGTH_,
-=09=09=09       WLAN_EID_TIM,
-=09=09=09       &tim_ielen,
-=09=09=09       pnetwork_mlmeext->IELength - _FIXED_IE_LENGTH_
-=09=09);
-=09=09if (p && tim_ielen > 0) {
-=09=09=09tim_ielen +=3D 2;
+=09u8 *p, *dst_ie, *premainder_ie =3D NULL, *pbackup_remainder_ie =3D NULL=
;
+=09__le16 tim_bitmap_le;
+=09uint offset, tmp_len, tim_ielen, tim_ie_offset, remainder_ielen;

-=09=09=09premainder_ie =3D p + tim_ielen;
+=09tim_bitmap_le =3D cpu_to_le16(pstapriv->tim_bitmap);

-=09=09=09tim_ie_offset =3D (signed int)(p - pie);
+=09p =3D rtw_get_ie(pie + _FIXED_IE_LENGTH_,
+=09=09       WLAN_EID_TIM,
+=09=09       &tim_ielen,
+=09=09       pnetwork_mlmeext->IELength - _FIXED_IE_LENGTH_
+=09);
+=09if (p && tim_ielen > 0) {
+=09=09tim_ielen +=3D 2;

-=09=09=09remainder_ielen =3D pnetwork_mlmeext->IELength - tim_ie_offset - =
tim_ielen;
+=09=09premainder_ie =3D p + tim_ielen;

-=09=09=09/* append TIM IE from dst_ie offset */
-=09=09=09dst_ie =3D p;
-=09=09} else {
-=09=09=09tim_ielen =3D 0;
+=09=09tim_ie_offset =3D (signed int)(p - pie);

-=09=09=09/* calculate head_len */
-=09=09=09offset =3D _FIXED_IE_LENGTH_;
+=09=09remainder_ielen =3D pnetwork_mlmeext->IELength - tim_ie_offset - tim=
_ielen;

-=09=09=09/* get ssid_ie len */
-=09=09=09p =3D rtw_get_ie(pie + _BEACON_IE_OFFSET_,
-=09=09=09=09       WLAN_EID_SSID,
-=09=09=09=09       &tmp_len,
-=09=09=09=09       (pnetwork_mlmeext->IELength - _BEACON_IE_OFFSET_)
-=09=09=09);
-=09=09=09if (p)
-=09=09=09=09offset +=3D tmp_len + 2;
+=09=09/* append TIM IE from dst_ie offset */
+=09=09dst_ie =3D p;
+=09} else {
+=09=09tim_ielen =3D 0;

-=09=09=09/*  get supported rates len */
-=09=09=09p =3D rtw_get_ie(pie + _BEACON_IE_OFFSET_,
-=09=09=09=09       WLAN_EID_SUPP_RATES, &tmp_len,
-=09=09=09=09       (pnetwork_mlmeext->IELength - _BEACON_IE_OFFSET_)
-=09=09=09);
-=09=09=09if (p)
-=09=09=09=09offset +=3D tmp_len + 2;
+=09=09/* calculate head_len */
+=09=09offset =3D _FIXED_IE_LENGTH_;

-=09=09=09/* DS Parameter Set IE, len =3D3 */
-=09=09=09offset +=3D 3;
+=09=09/* get ssid_ie len */
+=09=09p =3D rtw_get_ie(pie + _BEACON_IE_OFFSET_,
+=09=09=09       WLAN_EID_SSID,
+=09=09=09       &tmp_len,
+=09=09=09       (pnetwork_mlmeext->IELength - _BEACON_IE_OFFSET_)
+=09=09);
+=09=09if (p)
+=09=09=09offset +=3D tmp_len + 2;

-=09=09=09premainder_ie =3D pie + offset;
+=09=09/*  get supported rates len */
+=09=09p =3D rtw_get_ie(pie + _BEACON_IE_OFFSET_,
+=09=09=09       WLAN_EID_SUPP_RATES, &tmp_len,
+=09=09=09       (pnetwork_mlmeext->IELength - _BEACON_IE_OFFSET_)
+=09=09);
+=09=09if (p)
+=09=09=09offset +=3D tmp_len + 2;

-=09=09=09remainder_ielen =3D pnetwork_mlmeext->IELength - offset - tim_iel=
en;
+=09=09/* DS Parameter Set IE, len =3D3 */
+=09=09offset +=3D 3;

-=09=09=09/* append TIM IE from offset */
-=09=09=09dst_ie =3D pie + offset;
-=09=09}
+=09=09premainder_ie =3D pie + offset;

-=09=09if (remainder_ielen > 0) {
-=09=09=09pbackup_remainder_ie =3D rtw_malloc(remainder_ielen);
-=09=09=09if (pbackup_remainder_ie && premainder_ie)
-=09=09=09=09memcpy(pbackup_remainder_ie, premainder_ie, remainder_ielen);
-=09=09}
+=09=09remainder_ielen =3D pnetwork_mlmeext->IELength - offset - tim_ielen;

-=09=09*dst_ie++ =3D WLAN_EID_TIM;
+=09=09/* append TIM IE from offset */
+=09=09dst_ie =3D pie + offset;
+=09}

-=09=09if ((pstapriv->tim_bitmap & 0xff00) && (pstapriv->tim_bitmap & 0x00f=
e))
-=09=09=09tim_ielen =3D 5;
-=09=09else
-=09=09=09tim_ielen =3D 4;
+=09if (remainder_ielen > 0) {
+=09=09pbackup_remainder_ie =3D rtw_malloc(remainder_ielen);
+=09=09if (pbackup_remainder_ie && premainder_ie)
+=09=09=09memcpy(pbackup_remainder_ie, premainder_ie, remainder_ielen);
+=09}

-=09=09*dst_ie++ =3D tim_ielen;
+=09*dst_ie++ =3D WLAN_EID_TIM;

-=09=09*dst_ie++ =3D 0;/* DTIM count */
-=09=09*dst_ie++ =3D 1;/* DTIM period */
+=09if ((pstapriv->tim_bitmap & 0xff00) && (pstapriv->tim_bitmap & 0x00fe))
+=09=09tim_ielen =3D 5;
+=09else
+=09=09tim_ielen =3D 4;

-=09=09if (pstapriv->tim_bitmap & BIT(0))/* for bc/mc frames */
-=09=09=09*dst_ie++ =3D BIT(0);/* bitmap ctrl */
-=09=09else
-=09=09=09*dst_ie++ =3D 0;
+=09*dst_ie++ =3D tim_ielen;

-=09=09if (tim_ielen =3D=3D 4) {
-=09=09=09__le16 pvb;
+=09*dst_ie++ =3D 0;/* DTIM count */
+=09*dst_ie++ =3D 1;/* DTIM period */

-=09=09=09if (pstapriv->tim_bitmap & 0xff00)
-=09=09=09=09pvb =3D cpu_to_le16(pstapriv->tim_bitmap >> 8);
-=09=09=09else
-=09=09=09=09pvb =3D tim_bitmap_le;
+=09if (pstapriv->tim_bitmap & BIT(0))/* for bc/mc frames */
+=09=09*dst_ie++ =3D BIT(0);/* bitmap ctrl */
+=09else
+=09=09*dst_ie++ =3D 0;

-=09=09=09*dst_ie++ =3D le16_to_cpu(pvb);
+=09if (tim_ielen =3D=3D 4) {
+=09=09__le16 pvb;

-=09=09} else if (tim_ielen =3D=3D 5) {
-=09=09=09memcpy(dst_ie, &tim_bitmap_le, 2);
-=09=09=09dst_ie +=3D 2;
-=09=09}
+=09=09if (pstapriv->tim_bitmap & 0xff00)
+=09=09=09pvb =3D cpu_to_le16(pstapriv->tim_bitmap >> 8);
+=09=09else
+=09=09=09pvb =3D tim_bitmap_le;

-=09=09/* copy remainder IE */
-=09=09if (pbackup_remainder_ie) {
-=09=09=09memcpy(dst_ie, pbackup_remainder_ie, remainder_ielen);
+=09=09*dst_ie++ =3D le16_to_cpu(pvb);

-=09=09=09kfree(pbackup_remainder_ie);
-=09=09}
+=09} else if (tim_ielen =3D=3D 5) {
+=09=09memcpy(dst_ie, &tim_bitmap_le, 2);
+=09=09dst_ie +=3D 2;
+=09}
+
+=09/* copy remainder IE */
+=09if (pbackup_remainder_ie) {
+=09=09memcpy(dst_ie, pbackup_remainder_ie, remainder_ielen);

-=09=09offset =3D  (uint)(dst_ie - pie);
-=09=09pnetwork_mlmeext->IELength =3D offset + remainder_ielen;
+=09=09kfree(pbackup_remainder_ie);
 =09}
+
+=09offset =3D  (uint)(dst_ie - pie);
+=09pnetwork_mlmeext->IELength =3D offset + remainder_ielen;
 }

 u8 chk_sta_is_alive(struct sta_info *psta);
--
2.27.0


