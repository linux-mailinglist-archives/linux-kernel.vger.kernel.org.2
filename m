Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA454320944
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 09:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhBUI4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 03:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhBUI4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 03:56:32 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE65C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 00:55:52 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id c19so6272667pjq.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 00:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=george-graphics-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c8A/oMWjXqTCpUMaTP6/pnUw+IWu6z60c9rE8Yo1Hio=;
        b=YvG0AjZ2//0bwYamuylSZJlmt2ZapHp4kLMvvjDhWbydvIyK5bE+zSBM1InoPj96zi
         nWP03odv6mSgRqcQK8HnHsx3qR7QSAlTeLYtPLA43WUVnJt0h3j/8DLz1wdw8j/0m131
         qVlTfSZxC6hRzcHDUlTRPwq7eY5iGe8rmBLRz8uUnBkXHaaf2T0nMH7CekRLhR9ZVjfD
         SDWEx1d74k43XOhItWaybZ6HPJE4nRuRmlr1FegJuz4rsHDMxDbiex6VA51znmy1AWJ4
         kk+NEzwx0QAWLDJ+dNHAOuDF+eowsd3d4BOylG7/hsjoqyxhW1fC6vKiD1sYh7nA4jQU
         PI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c8A/oMWjXqTCpUMaTP6/pnUw+IWu6z60c9rE8Yo1Hio=;
        b=pRjclKwthLAc2WblI4XGyIIHJl1ZVDKYCxsmFvMu89rmK1CB/SygPdvNj2s5DzZgf4
         cSWp+2p8PI6fgbpyKSqSMjfstu63gKVtOZjk2vYFbZNIqfF50yDABAUdPoQ4Ba0iCrrI
         0EctVOyHKzb1VVAv3hL2818etH90A8gX4d6ptCIQPvdBnR29t3YB2M09AL1Xi1pH9J9g
         fPWDjUk0Yw2TIet83NbmhEgrqIF70ULR71HxJb3oT94TOYhkBXOXqKjZ5G6khqKw7rm1
         Aiy7mLKRSg8rN3G9zwQIG4yLlPiEy6L+EnHEA4E8LVZgaBxt6XhVhWMS4gc155VkriBP
         Zixg==
X-Gm-Message-State: AOAM531cIz2ZXOzGwhar90Vdy5YOhUTiK1YkQPeWaojgqn3DQHKkr15l
        2DjkoEedlfOX+aiorQ0pxNCIN0ovtYfZ7Y/tEGk=
X-Google-Smtp-Source: ABdhPJwKxWt5anSUjSFWYGVM7XqPJegiwNDZoU2QRI9p6qvQC27hNmeJG7Roo++SXB6oFP7fOtSERg==
X-Received: by 2002:a17:902:ba92:b029:e3:8358:34c5 with SMTP id k18-20020a170902ba92b02900e3835834c5mr17256541pls.9.1613897752076;
        Sun, 21 Feb 2021 00:55:52 -0800 (PST)
Received: from sequencer.hsd1.wa.comcast.net (c-174-61-159-125.hsd1.wa.comcast.net. [174.61.159.125])
        by smtp.gmail.com with ESMTPSA id 74sm15209131pfw.53.2021.02.21.00.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 00:55:51 -0800 (PST)
From:   George Harker <george@george-graphics.co.uk>
To:     alsa-devel@alsa-project.org
Cc:     George Harker <george@george-graphics.co.uk>,
        Clemens Ladisch <clemens@ladisch.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] sound/usb generate midi streaming substream names from jack names
Date:   Sun, 21 Feb 2021 08:53:35 +0000
Message-Id: <20210221085336.29788-1-george@george-graphics.co.uk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A number of devices have named substreams which are hard to remember /
decypher from <device> MIDI n names.  Eg. Korg puts a pass through on
one substream and iConnectivity devices name the connections.

This makes it easier to connect to the correct device.  Devices which
handle naming through quirks are unaffected by this change.

Addresses TODO comment in sound/usb/midi.c

Signed-off-by: George Harker <george@george-graphics.co.uk>
---
 sound/usb/midi.c | 122 ++++++++++++++++++++++++++++++++++++++---------
 sound/usb/midi.h |   2 +
 2 files changed, 101 insertions(+), 23 deletions(-)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index 0c23fa6d8..c6651a566 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -47,6 +47,7 @@
 #include <linux/usb.h>
 #include <linux/wait.h>
 #include <linux/usb/audio.h>
+#include <linux/usb/midi.h>
 #include <linux/module.h>
 
 #include <sound/core.h>
@@ -77,23 +78,6 @@ MODULE_AUTHOR("Clemens Ladisch <clemens@ladisch.de>");
 MODULE_DESCRIPTION("USB Audio/MIDI helper module");
 MODULE_LICENSE("Dual BSD/GPL");
 
-
-struct usb_ms_header_descriptor {
-	__u8  bLength;
-	__u8  bDescriptorType;
-	__u8  bDescriptorSubtype;
-	__u8  bcdMSC[2];
-	__le16 wTotalLength;
-} __attribute__ ((packed));
-
-struct usb_ms_endpoint_descriptor {
-	__u8  bLength;
-	__u8  bDescriptorType;
-	__u8  bDescriptorSubtype;
-	__u8  bNumEmbMIDIJack;
-	__u8  baAssocJackID[];
-} __attribute__ ((packed));
-
 struct snd_usb_midi_in_endpoint;
 struct snd_usb_midi_out_endpoint;
 struct snd_usb_midi_endpoint;
@@ -1756,12 +1740,68 @@ static void snd_usbmidi_get_port_info(struct snd_rawmidi *rmidi, int number,
 	}
 }
 
+static struct usb_midi_in_jack_descriptor *find_usb_in_jack_descriptor(
+					struct usb_host_interface *hostif, uint8_t jack_id)
+{
+	unsigned char *extra = hostif->extra;
+	int extralen = hostif->extralen;
+
+	while (extralen > 4) {
+		struct usb_midi_in_jack_descriptor *injd =
+				(struct usb_midi_in_jack_descriptor *)extra;
+
+		if (injd->bLength > 4 &&
+		    injd->bDescriptorType == USB_DT_CS_INTERFACE &&
+		    injd->bDescriptorSubtype == UAC_MIDI_IN_JACK &&
+				injd->bJackID == jack_id)
+			return injd;
+		if (!extra[0])
+			break;
+		extralen -= extra[0];
+		extra += extra[0];
+	}
+	return NULL;
+}
+
+static struct usb_midi_out_jack_descriptor *find_usb_out_jack_descriptor(
+					struct usb_host_interface *hostif, uint8_t jack_id)
+{
+	unsigned char *extra = hostif->extra;
+	int extralen = hostif->extralen;
+
+	while (extralen > 4) {
+		struct usb_midi_out_jack_descriptor *outjd =
+				(struct usb_midi_out_jack_descriptor *)extra;
+
+		if (outjd->bLength > 4 &&
+		    outjd->bDescriptorType == USB_DT_CS_INTERFACE &&
+		    outjd->bDescriptorSubtype == UAC_MIDI_OUT_JACK &&
+				outjd->bJackID == jack_id)
+			return outjd;
+		if (!extra[0])
+			break;
+		extralen -= extra[0];
+		extra += extra[0];
+	}
+	return NULL;
+}
+
 static void snd_usbmidi_init_substream(struct snd_usb_midi *umidi,
-				       int stream, int number,
+				       int stream, int number, int jack_id,
 				       struct snd_rawmidi_substream **rsubstream)
 {
 	struct port_info *port_info;
 	const char *name_format;
+	struct usb_interface *intf;
+	struct usb_host_interface *hostif;
+	struct usb_midi_in_jack_descriptor *injd;
+	struct usb_midi_out_jack_descriptor *outjd;
+	uint8_t jack_name_buf[32];
+	uint8_t *default_jack_name = "MIDI";
+	uint8_t *jack_name = default_jack_name;
+	uint8_t iJack;
+	size_t sz;
+	int res;
 
 	struct snd_rawmidi_substream *substream =
 		snd_usbmidi_find_substream(umidi, stream, number);
@@ -1771,11 +1811,35 @@ static void snd_usbmidi_init_substream(struct snd_usb_midi *umidi,
 		return;
 	}
 
-	/* TODO: read port name from jack descriptor */
+	intf = umidi->iface;
+	if (intf && jack_id >= 0) {
+		hostif = intf->cur_altsetting;
+		iJack = 0;
+		if (stream != SNDRV_RAWMIDI_STREAM_OUTPUT) {
+			/* in jacks connect to outs */
+			outjd = find_usb_out_jack_descriptor(hostif, jack_id);
+			if (outjd) {
+				sz = USB_DT_MIDI_OUT_SIZE(outjd->bNrInputPins);
+				iJack = *(((uint8_t *) outjd) + sz - 1);
+			}
+		} else {
+			/* and out jacks connect to ins */
+			injd = find_usb_in_jack_descriptor(hostif, jack_id);
+			if (injd)
+				iJack = injd->iJack;
+		}
+		if (iJack != 0) {
+			res = usb_string(umidi->dev, iJack, jack_name_buf, 32);
+			if (res)
+				jack_name = jack_name_buf;
+		}
+	}
+
 	port_info = find_port_info(umidi, number);
-	name_format = port_info ? port_info->name : "%s MIDI %d";
+	name_format = port_info ? port_info->name :
+		(jack_name != default_jack_name  ? "%s %s" : "%s %s %d");
 	snprintf(substream->name, sizeof(substream->name),
-		 name_format, umidi->card->shortname, number + 1);
+		 name_format, umidi->card->shortname, jack_name, number + 1);
 
 	*rsubstream = substream;
 }
@@ -1810,6 +1874,7 @@ static int snd_usbmidi_create_endpoints(struct snd_usb_midi *umidi,
 				snd_usbmidi_init_substream(umidi,
 							   SNDRV_RAWMIDI_STREAM_OUTPUT,
 							   out_ports,
+							   endpoints[i].assoc_out_jacks[j],
 							   &umidi->endpoints[i].out->ports[j].substream);
 				++out_ports;
 			}
@@ -1817,6 +1882,7 @@ static int snd_usbmidi_create_endpoints(struct snd_usb_midi *umidi,
 				snd_usbmidi_init_substream(umidi,
 							   SNDRV_RAWMIDI_STREAM_INPUT,
 							   in_ports,
+							   endpoints[i].assoc_in_jacks[j],
 							   &umidi->endpoints[i].in->ports[j].substream);
 				++in_ports;
 			}
@@ -1862,7 +1928,7 @@ static int snd_usbmidi_get_ms_info(struct snd_usb_midi *umidi,
 	struct usb_host_endpoint *hostep;
 	struct usb_endpoint_descriptor *ep;
 	struct usb_ms_endpoint_descriptor *ms_ep;
-	int i, epidx;
+	int i, j, epidx;
 
 	intf = umidi->iface;
 	if (!intf)
@@ -1875,7 +1941,7 @@ static int snd_usbmidi_get_ms_info(struct snd_usb_midi *umidi,
 	    ms_header->bDescriptorType == USB_DT_CS_INTERFACE &&
 	    ms_header->bDescriptorSubtype == UAC_HEADER)
 		dev_dbg(&umidi->dev->dev, "MIDIStreaming version %02x.%02x\n",
-			    ms_header->bcdMSC[1], ms_header->bcdMSC[0]);
+			    ((uint8_t *)&ms_header->bcdMSC)[1], ((uint8_t *)&ms_header->bcdMSC)[0]);
 	else
 		dev_warn(&umidi->dev->dev,
 			 "MIDIStreaming interface descriptor not found\n");
@@ -1911,6 +1977,10 @@ static int snd_usbmidi_get_ms_info(struct snd_usb_midi *umidi,
 				endpoints[epidx].out_interval = 1;
 			endpoints[epidx].out_cables =
 				(1 << ms_ep->bNumEmbMIDIJack) - 1;
+			for (j = 0; j < ms_ep->bNumEmbMIDIJack; ++j)
+				endpoints[epidx].assoc_out_jacks[j] = ms_ep->baAssocJackID[j];
+			for (; j < 0x10; ++j)
+				endpoints[epidx].assoc_out_jacks[j] = -1;
 			dev_dbg(&umidi->dev->dev, "EP %02X: %d jack(s)\n",
 				ep->bEndpointAddress, ms_ep->bNumEmbMIDIJack);
 		} else {
@@ -1928,6 +1998,10 @@ static int snd_usbmidi_get_ms_info(struct snd_usb_midi *umidi,
 				endpoints[epidx].in_interval = 1;
 			endpoints[epidx].in_cables =
 				(1 << ms_ep->bNumEmbMIDIJack) - 1;
+			for (j = 0; j < ms_ep->bNumEmbMIDIJack; ++j)
+				endpoints[epidx].assoc_in_jacks[j] = ms_ep->baAssocJackID[j];
+			for (; j < 0x10; ++j)
+				endpoints[epidx].assoc_in_jacks[j] = -1;
 			dev_dbg(&umidi->dev->dev, "EP %02X: %d jack(s)\n",
 				ep->bEndpointAddress, ms_ep->bNumEmbMIDIJack);
 		}
@@ -2244,11 +2318,13 @@ static int snd_usbmidi_create_endpoints_midiman(struct snd_usb_midi *umidi,
 			snd_usbmidi_init_substream(umidi,
 						   SNDRV_RAWMIDI_STREAM_OUTPUT,
 						   cable,
+						   -1 /* prevent trying to find jack */,
 						   &umidi->endpoints[cable & 1].out->ports[cable].substream);
 		if (endpoint->in_cables & (1 << cable))
 			snd_usbmidi_init_substream(umidi,
 						   SNDRV_RAWMIDI_STREAM_INPUT,
 						   cable,
+						   -1 /* prevent trying to find jack */,
 						   &umidi->endpoints[0].in->ports[cable].substream);
 	}
 	return 0;
diff --git a/sound/usb/midi.h b/sound/usb/midi.h
index 8c38aec22..3f153195c 100644
--- a/sound/usb/midi.h
+++ b/sound/usb/midi.h
@@ -13,6 +13,8 @@ struct snd_usb_midi_endpoint_info {
 	uint8_t  in_interval;
 	uint16_t out_cables;	/* bitmask */
 	uint16_t in_cables;	/* bitmask */
+	int16_t  assoc_in_jacks[16];
+	int16_t  assoc_out_jacks[16];
 };
 
 /* for QUIRK_MIDI_YAMAHA, data is NULL */
-- 
2.20.1

