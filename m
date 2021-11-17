Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B88A84548F0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 15:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237862AbhKQOh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 09:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbhKQOhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 09:37:55 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F5AC061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 06:34:57 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id g1so2165752qvd.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 06:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ocPkUYDtkHc91oWafd4Oazfe6tpFxzXgAa1N0WhMJnI=;
        b=R3paQPi3oRNORd53lY4Z9ZPldhCtktt3qOcW/z/BCPgJ08z/EIj/xePa64zqKcQ6uN
         0ErhW8nMTkxezGe5N5U9UsZmgn57woB1jh5hejnUktOsCoADBTC27VI548nJjXEeYjDC
         mdZecnFCbU/9SIIFwvp4XlAMefFX2Vuwkxh2IyqS20DwvbsrZcDP7IWgV0N5hg1N5UnE
         pwLxsM8ULWtZOnYoet9LAxHYn9xA8d7ZTAy1rDGYht1jLg+v+0wKesLJ68bSZmFmZHCY
         CXXTQi/RPUmHU7axEMi2vSbJiqwX9OZIFFGRdpnHXQIB1zD3mwF+R8drSCHj77J2ZFpf
         F+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ocPkUYDtkHc91oWafd4Oazfe6tpFxzXgAa1N0WhMJnI=;
        b=563b8Kp4l62c35rRjIysoMIXb4kkYCSK2c2F0wR8xI2QBUexe4lwAc/TQk24MWoibq
         RFgq5D6+9mjrdt80cq5GlpT6qoQyNYz9AWDRdYUwjKkaceG2Sm4nGVCml/9wlWPrvEAS
         N/i20XqoZ0ZwQz/PG2fWRVGG8zw0P/DqgNQim/o8rXRxNPJ0gnIgQL3XBwxgxzWh19AZ
         sVXe+Kv4gTdQrTQsOlmm7D2ZxW1HfwBWRsosEtdVbfZU/+wGbMQr8jyo8y0MxaV82GfF
         u2eRtP/KO6qfemfim3eUBCrYN0kFt0gWot0OjkKrpetEW3RrD4+nCctpj4NHl7D4rbwQ
         O8sg==
X-Gm-Message-State: AOAM530FJ+suK+I5NHR4YgoIfk+7td8Kg6Q+tZkX+5DEaRIlHU8nbwsf
        JtshnYsFODBPbigCAwoTerw=
X-Google-Smtp-Source: ABdhPJzfi8xYg6/N+gugUb8m8Rrt6YUa163J0zlh+OmLicPGs2URlGOuRggFSwvma5V2zTvdjn1LBA==
X-Received: by 2002:ad4:5f88:: with SMTP id jp8mr55145063qvb.57.1637159696162;
        Wed, 17 Nov 2021 06:34:56 -0800 (PST)
Received: from localhost.localdomain (pool-98-113-42-30.nycmny.fios.verizon.net. [98.113.42.30])
        by smtp.googlemail.com with ESMTPSA id m19sm10068171qkn.129.2021.11.17.06.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 06:34:55 -0800 (PST)
From:   Zameer Manji <zmanji@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Zameer Manji <zmanji@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: 8188eu: remove unused code in ieee80211.h
Date:   Wed, 17 Nov 2021 14:32:18 +0000
Message-Id: <20211117143234.1508695-1-zmanji@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This header file contains lots of code that is unused
and safe to remove.

Signed-off-by: Zameer Manji <zmanji@gmail.com>
---
 drivers/staging/r8188eu/include/ieee80211.h | 357 --------------------
 1 file changed, 357 deletions(-)

diff --git a/drivers/staging/r8188eu/include/ieee80211.h b/drivers/staging/r8188eu/include/ieee80211.h
index 6c8206bd5466..58858e7e66c2 100644
--- a/drivers/staging/r8188eu/include/ieee80211.h
+++ b/drivers/staging/r8188eu/include/ieee80211.h
@@ -39,28 +39,10 @@
 #define IEEE_CMD_SET_ENCRYPTION			3
 #define IEEE_CMD_MLME						4
 
-#define IEEE_PARAM_WPA_ENABLED				1
-#define IEEE_PARAM_TKIP_COUNTERMEASURES		2
-#define IEEE_PARAM_DROP_UNENCRYPTED			3
-#define IEEE_PARAM_PRIVACY_INVOKED			4
-#define IEEE_PARAM_AUTH_ALGS					5
-#define IEEE_PARAM_IEEE_802_1X				6
-#define IEEE_PARAM_WPAX_SELECT				7
-
 #define AUTH_ALG_OPEN_SYSTEM			0x1
 #define AUTH_ALG_SHARED_KEY			0x2
 #define AUTH_ALG_LEAP				0x00000004
 
-#define IEEE_MLME_STA_DEAUTH				1
-#define IEEE_MLME_STA_DISASSOC			2
-
-#define IEEE_CRYPT_ERR_UNKNOWN_ALG			2
-#define IEEE_CRYPT_ERR_UNKNOWN_ADDR			3
-#define IEEE_CRYPT_ERR_CRYPT_INIT_FAILED		4
-#define IEEE_CRYPT_ERR_KEY_SET_FAILED			5
-#define IEEE_CRYPT_ERR_TX_KEY_SET_FAILED		6
-#define IEEE_CRYPT_ERR_CARD_CONF_FAILED		7
-
 #define	IEEE_CRYPT_ALG_NAME_LEN			16
 
 #define WPA_CIPHER_NONE		BIT(0)
@@ -182,40 +164,6 @@ struct ieee_param {
 	} u;
 };
 
-struct ieee_param_ex {
-	u32 cmd;
-	u8 sta_addr[ETH_ALEN];
-	u8 data[0];
-};
-
-struct sta_data {
-	u16 aid;
-	u16 capability;
-	int flags;
-	u32 sta_set;
-	u8 tx_supp_rates[16];
-	u32 tx_supp_rates_len;
-	struct ieee80211_ht_cap ht_cap;
-	u64	rx_pkts;
-	u64	rx_bytes;
-	u64	rx_drops;
-	u64	tx_pkts;
-	u64	tx_bytes;
-	u64	tx_drops;
-};
-
-#define IEEE80211_DATA_LEN		2304
-/* Maximum size for the MA-UNITDATA primitive, 802.11 standard section
-   6.2.1.1.2.
-
-   The figure in section 7.1.2 suggests a body size of up to 2312
-   bytes is allowed, which is a bit confusing, I suspect this
-   represents the 2304 bytes of real data, plus a possible 8 bytes of
-   WEP IV and ICV. (this interpretation suggested by Ramiro Barreiro) */
-
-#define IEEE80211_HLEN			30
-#define IEEE80211_FRAME_LEN		(IEEE80211_DATA_LEN + IEEE80211_HLEN)
-
 /* this is stolen from ipw2200 driver */
 #define IEEE_IBSS_MAC_HASH_SIZE 31
 
@@ -246,17 +194,6 @@ struct rtw_ieee80211_hdr_3addr {
 	u16 seq_ctl;
 } __packed;
 
-struct rtw_ieee80211_hdr_qos {
-	__le16 frame_ctl;
-	__le16 duration_id;
-	u8 addr1[ETH_ALEN];
-	u8 addr2[ETH_ALEN];
-	u8 addr3[ETH_ALEN];
-	u16 seq_ctl;
-	u8 addr4[ETH_ALEN];
-	u16	qc;
-}  __packed;
-
 struct rtw_ieee80211_hdr_3addr_qos {
 	__le16 frame_ctl;
 	__le16 duration_id;
@@ -290,68 +227,6 @@ enum eap_type {
 #define MIN_FRAG_THRESHOLD     256U
 #define	MAX_FRAG_THRESHOLD     2346U
 
-/* Frame control field constants */
-#define RTW_IEEE80211_FCTL_VERS		0x0003
-#define RTW_IEEE80211_FCTL_FTYPE	0x000c
-#define RTW_IEEE80211_FCTL_STYPE	0x00f0
-#define RTW_IEEE80211_FCTL_TODS		0x0100
-#define RTW_IEEE80211_FCTL_FROMDS	0x0200
-#define RTW_IEEE80211_FCTL_MOREFRAGS	0x0400
-#define RTW_IEEE80211_FCTL_RETRY	0x0800
-#define RTW_IEEE80211_FCTL_PM		0x1000
-#define RTW_IEEE80211_FCTL_MOREDATA	0x2000
-#define RTW_IEEE80211_FCTL_PROTECTED	0x4000
-#define RTW_IEEE80211_FCTL_ORDER	0x8000
-#define RTW_IEEE80211_FCTL_CTL_EXT	0x0f00
-
-#define RTW_IEEE80211_FTYPE_MGMT	0x0000
-#define RTW_IEEE80211_FTYPE_CTL		0x0004
-#define RTW_IEEE80211_FTYPE_DATA	0x0008
-#define RTW_IEEE80211_FTYPE_EXT		0x000c
-
-/* management */
-#define RTW_IEEE80211_STYPE_ASSOC_REQ	0x0000
-#define RTW_IEEE80211_STYPE_ASSOC_RESP	0x0010
-#define RTW_IEEE80211_STYPE_REASSOC_REQ	0x0020
-#define RTW_IEEE80211_STYPE_REASSOC_RESP	0x0030
-#define RTW_IEEE80211_STYPE_PROBE_REQ	0x0040
-#define RTW_IEEE80211_STYPE_PROBE_RESP	0x0050
-#define RTW_IEEE80211_STYPE_BEACON	0x0080
-#define RTW_IEEE80211_STYPE_ATIM	0x0090
-#define RTW_IEEE80211_STYPE_DISASSOC	0x00A0
-#define RTW_IEEE80211_STYPE_AUTH	0x00B0
-#define RTW_IEEE80211_STYPE_DEAUTH	0x00C0
-#define RTW_IEEE80211_STYPE_ACTION	0x00D0
-
-/* control */
-#define RTW_IEEE80211_STYPE_CTL_EXT	0x0060
-#define RTW_IEEE80211_STYPE_BACK_REQ	0x0080
-#define RTW_IEEE80211_STYPE_BACK	0x0090
-#define RTW_IEEE80211_STYPE_PSPOLL	0x00A0
-#define RTW_IEEE80211_STYPE_RTS		0x00B0
-#define RTW_IEEE80211_STYPE_CTS		0x00C0
-#define RTW_IEEE80211_STYPE_ACK		0x00D0
-#define RTW_IEEE80211_STYPE_CFEND	0x00E0
-#define RTW_IEEE80211_STYPE_CFENDACK	0x00F0
-
-/* data */
-#define RTW_IEEE80211_STYPE_DATA	0x0000
-#define RTW_IEEE80211_STYPE_DATA_CFACK	0x0010
-#define RTW_IEEE80211_STYPE_DATA_CFPOLL	0x0020
-#define RTW_IEEE80211_STYPE_DATA_CFACKPOLL	0x0030
-#define RTW_IEEE80211_STYPE_NULLFUNC	0x0040
-#define RTW_IEEE80211_STYPE_CFACK	0x0050
-#define RTW_IEEE80211_STYPE_CFPOLL	0x0060
-#define RTW_IEEE80211_STYPE_CFACKPOLL	0x0070
-#define RTW_IEEE80211_STYPE_QOS_DATA	0x0080
-#define RTW_IEEE80211_STYPE_QOS_DATA_CFACK	0x0090
-#define RTW_IEEE80211_STYPE_QOS_DATA_CFPOLL	0x00A0
-#define RTW_IEEE80211_STYPE_QOS_DATA_CFACKPOLL	0x00B0
-#define RTW_IEEE80211_STYPE_QOS_NULLFUNC	0x00C0
-#define RTW_IEEE80211_STYPE_QOS_CFACK		0x00D0
-#define RTW_IEEE80211_STYPE_QOS_CFPOLL		0x00E0
-#define RTW_IEEE80211_STYPE_QOS_CFACKPOLL	0x00F0
-
 /* sequence control field */
 #define RTW_IEEE80211_SCTL_FRAG	0x000F
 #define RTW_IEEE80211_SCTL_SEQ	0xFFF0
@@ -366,12 +241,6 @@ enum eap_type {
 #define NON_EXPLICIT_ACK		2
 #define BLOCK_ACK			3
 
-#ifndef ETH_P_PAE
-#define ETH_P_PAE 0x888E /* Port Access Entity (IEEE 802.1X) */
-#endif /* ETH_P_PAE */
-
-#define ETH_P_PREAUTH 0x88C7 /* IEEE 802.11i pre-authentication */
-
 #define ETH_P_ECONET	0x0018
 
 #ifndef ETH_P_80211_RAW
@@ -391,9 +260,6 @@ struct ieee80211_snap_hdr {
 
 #define SNAP_SIZE sizeof(struct ieee80211_snap_hdr)
 
-#define WLAN_FC_GET_TYPE(fc) ((fc) & RTW_IEEE80211_FCTL_FTYPE)
-#define WLAN_FC_GET_STYPE(fc) ((fc) & RTW_IEEE80211_FCTL_STYPE)
-
 #define WLAN_QC_GET_TID(qc) ((qc) & 0x0f)
 
 #define WLAN_GET_SEQ_FRAG(seq) ((seq) & RTW_IEEE80211_SCTL_FRAG)
@@ -487,18 +353,9 @@ struct ieee80211_snap_hdr {
 #define IEEE80211_DATA_HDR3_LEN 24
 #define IEEE80211_DATA_HDR4_LEN 30
 
-#define IEEE80211_STATMASK_SIGNAL (1<<0)
-#define IEEE80211_STATMASK_RSSI (1<<1)
-#define IEEE80211_STATMASK_NOISE (1<<2)
-#define IEEE80211_STATMASK_RATE (1<<3)
-#define IEEE80211_STATMASK_WEMASK 0x7
-
 #define IEEE80211_CCK_MODULATION    (1<<0)
 #define IEEE80211_OFDM_MODULATION   (1<<1)
 
-#define IEEE80211_24GHZ_BAND     (1<<0)
-#define IEEE80211_52GHZ_BAND     (1<<1)
-
 #define IEEE80211_CCK_RATE_LEN			4
 #define IEEE80211_NUM_OFDM_RATESLEN	8
 
@@ -549,172 +406,23 @@ struct ieee80211_snap_hdr {
 	IEEE80211_OFDM_RATE_36MB_MASK |					\
 	IEEE80211_OFDM_RATE_48MB_MASK |					\
 	IEEE80211_OFDM_RATE_54MB_MASK)
-#define IEEE80211_DEFAULT_RATES_MASK					\
-	(IEEE80211_OFDM_DEFAULT_RATES_MASK |				\
-	 IEEE80211_CCK_DEFAULT_RATES_MASK)
 
 #define IEEE80211_NUM_OFDM_RATES	8
 #define IEEE80211_NUM_CCK_RATES		4
 #define IEEE80211_OFDM_SHIFT_MASK_A	4
 
-/* NOTE: This data is for statistical purposes; not all hardware provides this
- *       information for frames received.  Not setting these will not cause
- *       any adverse affects. */
-struct ieee80211_rx_stats {
-	/* u32 mac_time[2]; */
-	s8 rssi;
-	u8 signal;
-	u8 noise;
-	u8 received_channel;
-	u16 rate; /* in 100 kbps */
-	/* u8 control; */
-	u8 mask;
-	u8 freq;
-	u16 len;
-};
-
 /* IEEE 802.11 requires that STA supports concurrent reception of at least
  * three fragmented frames. This define can be increased to support more
  * concurrent frames, but it should be noted that each entry can consume about
  * 2 kB of RAM and increasing cache size will slow down frame reassembly. */
 #define IEEE80211_FRAG_CACHE_LEN 4
 
-struct ieee80211_frag_entry {
-	u32 first_frag_time;
-	uint seq;
-	uint last_frag;
-	uint qos;   /* jackson */
-	uint tid;	/* jackson */
-	struct sk_buff *skb;
-	u8 src_addr[ETH_ALEN];
-	u8 dst_addr[ETH_ALEN];
-};
-
-struct ieee80211_stats {
-	uint tx_unicast_frames;
-	uint tx_multicast_frames;
-	uint tx_fragments;
-	uint tx_unicast_octets;
-	uint tx_multicast_octets;
-	uint tx_deferred_transmissions;
-	uint tx_single_retry_frames;
-	uint tx_multiple_retry_frames;
-	uint tx_retry_limit_exceeded;
-	uint tx_discards;
-	uint rx_unicast_frames;
-	uint rx_multicast_frames;
-	uint rx_fragments;
-	uint rx_unicast_octets;
-	uint rx_multicast_octets;
-	uint rx_fcs_errors;
-	uint rx_discards_no_buffer;
-	uint tx_discards_wrong_sa;
-	uint rx_discards_undecryptable;
-	uint rx_message_in_msg_fragments;
-	uint rx_message_in_bad_msg_fragments;
-};
-
-struct ieee80211_softmac_stats {
-	uint rx_ass_ok;
-	uint rx_ass_err;
-	uint rx_probe_rq;
-	uint tx_probe_rs;
-	uint tx_beacons;
-	uint rx_auth_rq;
-	uint rx_auth_rs_ok;
-	uint rx_auth_rs_err;
-	uint tx_auth_rq;
-	uint no_auth_rs;
-	uint no_ass_rs;
-	uint tx_ass_rq;
-	uint rx_ass_rq;
-	uint tx_probe_rq;
-	uint reassoc;
-	uint swtxstop;
-	uint swtxawake;
-};
-
-#define SEC_KEY_1	(1<<0)
-#define SEC_KEY_2	(1<<1)
-#define SEC_KEY_3	(1<<2)
-#define SEC_KEY_4	(1<<3)
-#define SEC_ACTIVE_KEY  (1<<4)
-#define SEC_AUTH_MODE   (1<<5)
-#define SEC_UNICAST_GROUP (1<<6)
-#define SEC_LEVEL	(1<<7)
-#define SEC_ENABLED     (1<<8)
-
-#define SEC_LEVEL_0      0 /* None */
-#define SEC_LEVEL_1      1 /* WEP 40 and 104 bit */
-#define SEC_LEVEL_2      2 /* Level 1 + TKIP */
-#define SEC_LEVEL_2_CKIP 3 /* Level 1 + CKIP */
-#define SEC_LEVEL_3      4 /* Level 2 + CCMP */
-
 #define WEP_KEYS 4
 #define WEP_KEY_LEN 13
 
-struct ieee80211_security {
-	u16 active_key:2,
-	enabled:1,
-	auth_mode:2,
-	auth_algo:4,
-	unicast_uses_group:1;
-	u8 key_sizes[WEP_KEYS];
-	u8 keys[WEP_KEYS][WEP_KEY_LEN];
-	u8 level;
-	u16 flags;
-} __packed;
-
-/*
-
- 802.11 data frame from AP
-
-      ,-------------------------------------------------------------------.
-Bytes |  2   |  2   |    6    |    6    |    6    |  2   | 0..2312 |   4  |
-      |------|------|---------|---------|---------|------|---------|------|
-Desc. | ctrl | dura |  DA/RA  |   TA    |    SA   | Sequ |  frame  |  fcs |
-      |      | tion | (BSSID) |	 |	 | ence |  data   |      |
-      `-------------------------------------------------------------------'
-
-Total: 28-2340 bytes
-
-*/
-
-struct ieee80211_header_data {
-	u16 frame_ctl;
-	u16 duration_id;
-	u8 addr1[6];
-	u8 addr2[6];
-	u8 addr3[6];
-	u16 seq_ctrl;
-};
 
 #define BEACON_PROBE_SSID_ID_POSITION 12
 
-/* Management Frame Information Element Types */
-#define MFIE_TYPE_SSID		0
-#define MFIE_TYPE_RATES		1
-#define MFIE_TYPE_FH_SET	2
-#define MFIE_TYPE_DS_SET	3
-#define MFIE_TYPE_CF_SET	4
-#define MFIE_TYPE_TIM		5
-#define MFIE_TYPE_IBSS_SET	6
-#define MFIE_TYPE_CHALLENGE	16
-#define MFIE_TYPE_ERP		42
-#define MFIE_TYPE_RSN		48
-#define MFIE_TYPE_RATES_EX	50
-#define MFIE_TYPE_GENERIC	221
-
-struct ieee80211_info_element_hdr {
-	u8 id;
-	u8 len;
-} __packed;
-
-struct ieee80211_info_element {
-	u8 id;
-	u8 len;
-	u8 data[0];
-} __packed;
 
 /*
  * These are the data types that can make up management packets
@@ -733,42 +441,7 @@ struct ieee80211_info_element {
 	u16 status;
 */
 
-#define IEEE80211_DEFAULT_TX_ESSID "Penguin"
-#define IEEE80211_DEFAULT_BASIC_RATE 10
 
-struct ieee80211_authentication {
-	struct ieee80211_header_data header;
-	u16 algorithm;
-	u16 transaction;
-	u16 status;
-	/* struct ieee80211_info_element_hdr info_element; */
-} __packed;
-
-struct ieee80211_probe_response {
-	struct ieee80211_header_data header;
-	u32 time_stamp[2];
-	u16 beacon_interval;
-	u16 capability;
-	struct ieee80211_info_element info_element;
-} __packed;
-
-struct ieee80211_probe_request {
-	struct ieee80211_header_data header;
-} __packed;
-
-struct ieee80211_assoc_request_frame {
-	struct rtw_ieee80211_hdr_3addr header;
-	u16 capability;
-	u16 listen_interval;
-	struct ieee80211_info_element_hdr info_element;
-} __packed;
-
-struct ieee80211_assoc_response_frame {
-	struct rtw_ieee80211_hdr_3addr header;
-	u16 capability;
-	u16 status;
-	u16 aid;
-} __packed;
 
 struct ieee80211_txb {
 	u8 nr_frags;
@@ -794,25 +467,10 @@ struct ieee80211_txb {
 /* HZ / 2) */
 #define IEEE80211_SOFTMAC_ASSOC_RETRY_TIME (HZ * 2)
 
-#define CRC_LENGTH		 4U
-
 #define MAX_WPA_IE_LEN (256)
 #define MAX_WPS_IE_LEN (512)
 #define MAX_P2P_IE_LEN (256)
-#define MAX_WFD_IE_LEN (128)
 
-#define NETWORK_EMPTY_ESSID (1<<0)
-#define NETWORK_HAS_OFDM    (1<<1)
-#define NETWORK_HAS_CCK     (1<<2)
-
-#define IEEE80211_DTIM_MBCAST 4
-#define IEEE80211_DTIM_UCAST 2
-#define IEEE80211_DTIM_VALID 1
-#define IEEE80211_DTIM_INVALID 0
-
-#define IEEE80211_PS_DISABLED 0
-#define IEEE80211_PS_UNICAST IEEE80211_DTIM_UCAST
-#define IEEE80211_PS_MBCAST IEEE80211_DTIM_MBCAST
 #define IW_ESSID_MAX_SIZE 32
 /*
 join_res:
@@ -883,11 +541,6 @@ struct tx_pending {
 
 #define MAXTID	16
 
-#define IEEE_A	    (1<<0)
-#define IEEE_B	    (1<<1)
-#define IEEE_G	    (1<<2)
-#define IEEE_MODE_MASK    (IEEE_A|IEEE_B|IEEE_G)
-
 /* Action category code */
 enum rtw_ieee80211_category {
 	RTW_WLAN_CATEGORY_SPECTRUM_MGMT = 0,
@@ -1113,16 +766,6 @@ u8 *rtw_get_wps_attr(u8 *wps_ie, uint wps_ielen, u16 target_attr_id,
 u8 *rtw_get_wps_attr_content(u8 *wps_ie, uint wps_ielen, u16 target_attr_id,
 			     u8 *buf_content, uint *len_content);
 
-/**
- * for_each_ie - iterate over continuous IEs
- * @ie:
- * @buf:
- * @buf_len:
- */
-#define for_each_ie(ie, buf, buf_len) \
-	for (ie = (void *)buf; (((u8 *)ie) - ((u8 *)buf) + 1) < buf_len;	\
-		ie = (void *)(((u8 *)ie) + *(((u8 *)ie)+1) + 2))
-
 u8 *rtw_get_p2p_ie(u8 *in_ie, int in_len, u8 *p2p_ie, uint *p2p_ielen);
 u8 *rtw_get_p2p_attr(u8 *p2p_ie, uint p2p_ielen, u8 target_attr_id,
 		     u8 *buf_attr, u32 *len_attr);
-- 
2.25.1

