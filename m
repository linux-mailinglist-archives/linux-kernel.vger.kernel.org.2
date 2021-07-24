Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBDEC3D4A25
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 23:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbhGXVC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 17:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhGXVC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 17:02:27 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407A2C061575
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 14:42:58 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id d3so3184925qvq.6
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 14:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Xubroawzwj5b5qwwsClOnfd6twbJAitiIsQAo4rrsQ=;
        b=QgD3WnqbVmU3Mr8Ylc/G0vDxkmiy2A94zG94MoBLgx1F3HocbImPbitOKNnBo9QOFk
         lAdZuS+nhp2nz0QwaLPAC6O5FGkAP2mC1oBR85sKVoDyrxx9M8yQl2DMDHVjzrlOIEmo
         0KLqsEy9AeYcw1VNv+DERNjp29mybxP+8ZNT/7QLhVZJmEgq0ZdL5Nct0B+hpAfMYDVN
         wqxgut7Qb+gConRtsGDEmlSVkcwAyZE1V1CNphwxdEnpmPwDlAFOewE7c8Fbbr53BG5b
         OUaQ2TY2tA26Qg/uWofLMpw5ILblzF3hgskxi8HTbfIJqckk+05/VaJNAYSnV8fzvjSt
         9GKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Xubroawzwj5b5qwwsClOnfd6twbJAitiIsQAo4rrsQ=;
        b=VLOL0vkNxIPsnhZPZi8gpJmdt57F2zXDRr0yZqTUboANB70xmO11yzVhSUSyn9j1Pd
         ubO9Mwqm2JK2mzDIe6QVslJhO/LGje7dI2iuDfQdEmrdWvredUb/8af2/ktFtp9Mxel0
         7HDtbw8plu96LtUTX/ygWBaGnApBbnDHUeGsUXoFtRrjI21bJl2fIW8Z7DX1/+4jcwT3
         St0iDxOwO1xqvoj9PiwIkGdPsEj7PMOAWPjetXPgn4bC42IkjC0Smc8FvfBl/j7XrEdg
         6EBCPjXz8yZmj4ORa4+Nbp2fgfbKV4mQs5j68HRbny3He0JjS2hgM8HWf/cCIXfAeFJo
         hryw==
X-Gm-Message-State: AOAM532aFXGBKs3IZ0RHB4nA1RPmWvL100j+2pSFBulzgveuQ6VibLxE
        r/SMJzV9NShkOAFCg/6mTU23If14RsKu0Gehrz4=
X-Google-Smtp-Source: ABdhPJzMkwWaAEWUP64MJj/kC4FFv+hFSt1ASdvUpOEersKGdA9TvyW5c+cG79/4TUOzRaguIJnexg77HP4TO27zto0=
X-Received: by 2002:ad4:5ccc:: with SMTP id iu12mr11189760qvb.21.1627162977350;
 Sat, 24 Jul 2021 14:42:57 -0700 (PDT)
MIME-Version: 1.0
References: <1627100621-19225-1-git-send-email-chihhao.chen@mediatek.com>
 <s5h7dhgi1e2.wl-tiwai@suse.de> <CAEsQvcs3P+TqQFzQetPfRycpo66eJFwnzwhk2JyCXFaCLFHmFg@mail.gmail.com>
 <CAEsQvcu3jXa4fXJAu7nvT+G+-S2bZ1BPkcuwnT4VjbrnW1Pkog@mail.gmail.com>
In-Reply-To: <CAEsQvcu3jXa4fXJAu7nvT+G+-S2bZ1BPkcuwnT4VjbrnW1Pkog@mail.gmail.com>
From:   Geraldo Nascimento <geraldogabriel@gmail.com>
Date:   Sat, 24 Jul 2021 18:42:49 +0000
Message-ID: <CAEsQvcuHyaWQQKYqydgv-XhFo7byaARYFGrPmpCu8XSRgTPDTg@mail.gmail.com>
Subject: Re: [PATCH] ALSA: usb-audio: fix incorrect clock source setting
To:     Takashi Iwai <tiwai@suse.de>
Cc:     chihhao.chen@mediatek.com, alsa-devel@alsa-project.org,
        wsd_upstream@mediatek.com, damien@zamaudio.com, tiwai@suse.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to convey in code what I had in mind.

It's a rough sketch and very much untested.

--- clock.5.14-rc2.c    2021-07-24 18:30:09.773718208 -0000
+++ clock-one-to-one.c  2021-07-24 18:35:52.276412366 -0000
@@ -54,6 +54,61 @@ static void *find_uac_clock_desc(struct
        return NULL;
 }

+/* Behringer UFX1604 / UFX1204 have a simple one-to-one
+ * topology where there is only one Clock Selector, only
+ * one Clock Source linked to USB SOF and no Clock Multipliers.
+ *
+ * This function checks for the presence of such a
+ * one-to-one clock selector / clock source topology
+ * so that it's possible to safely set the one and only
+ * Clock Selector to the one and only Clock Source
+ * upon sample rate change without breaking devices
+ * with more complicated topologies.
+ */
+
+static bool one_to_one_clock_topology(struct usb_host_interface
*iface, int proto)
+{
+        int clock_sources, clock_selectors, clock_multipliers = 0;
+       int source_version, selector_version, multiplier_version;
+       int found_count;
+
+       void *cs = NULL;
+
+       if (proto == UAC_VERSION_3) {
+               source_version = UAC3_CLOCK_SOURCE;
+               selector_version = UAC3_CLOCK_SELECTOR;
+               multiplier_version = UAC3_CLOCK_MULTIPLIER;
+       }
+
+       else {
+               source_version = UAC2_CLOCK_SOURCE;
+               selector_version = UAC2_CLOCK_SELECTOR;
+               multiplier_version = UAC2_CLOCK_MULTIPLIER;
+       }
+
+        if ((found_count = snd_usb_count_csint_desc(iface->extra,
iface->extralen,
+                                             cs, source_version)) > 0) {
+               clock_sources = found_count;
+        }
+
+        if ((found_count = snd_usb_count_csint_desc(iface->extra,
iface->extralen,
+                                             cs, selector_version)) > 0) {
+               clock_selectors = found_count;
+        }
+
+        if ((found_count = snd_usb_count_csint_desc(iface->extra,
iface->extralen,
+                                             cs, multiplier_version)) > 0) {
+               clock_multipliers = found_count;
+        }
+
+       if ((clock_sources == 1) && (clock_selectors == 1) &&
(clock_multipliers == 0)) {
+               return true;
+       }
+
+       return false;
+}
+
+
 static bool validate_clock_source(void *p, int id, int proto)
 {
        union uac23_clock_source_desc *cs = p;
@@ -323,7 +378,7 @@ static int __uac_clock_find_source(struc
                ret = __uac_clock_find_source(chip, fmt,
                                              sources[ret - 1],
                                              visited, validate);
-               if (ret > 0) {
+               if (ret > 0 &&
one_to_one_clock_topology(chip->ctrl_intf, proto)) {
                        err = uac_clock_selector_set_val(chip, entity_id, cur);
                        if (err < 0)
                                return err;



--- helper.5.14-rc2.c   2021-07-24 18:30:25.042526253 -0000
+++ helper-one-to-one.c 2021-07-24 18:35:45.019503597 -0000
@@ -64,6 +64,29 @@ void *snd_usb_find_csint_desc(void *buff
 }

 /*
+ * find every class-specified interface descriptor with the given subtype
+ * and return how many did it find
+ */
+int snd_usb_count_csint_desc(void *buffer, int buflen, void *after,
u8 dsubtype)
+{
+       int count = 0;
+        unsigned char *p = after;
+
+        while ((p = snd_usb_find_desc(buffer, buflen, p,
+                                      USB_DT_CS_INTERFACE)) != NULL) {
+                if (p[0] >= 3 && p[2] == dsubtype)
+                        count++;
+        }
+
+       if (count > 0) {
+               return count;
+       }
+
+        return 0;
+}
+
+
+/*
  * Wrapper for usb_control_msg().
  * Allocates a temp buffer to prevent dmaing from/to the stack.
  */



--- helper.5.14-rc2.h   2021-07-24 18:30:35.219398312 -0000
+++ helper-one-to-one.h 2021-07-24 18:29:34.139166195 -0000
@@ -7,6 +7,8 @@ unsigned int snd_usb_combine_bytes(unsig
 void *snd_usb_find_desc(void *descstart, int desclen, void *after, u8 dtype);
 void *snd_usb_find_csint_desc(void *descstart, int desclen, void
*after, u8 dsubtype);

+int snd_usb_count_csint_desc(void *descstart, int desclen, void
*after, u8 dsubtype);
+
 int snd_usb_ctl_msg(struct usb_device *dev, unsigned int pipe,
                    __u8 request, __u8 requesttype, __u16 value, __u16 index,
                    void *data, __u16 size);

On Sat, Jul 24, 2021 at 3:20 PM Geraldo Nascimento
<geraldogabriel@gmail.com> wrote:
>
> > Dr. Iwai, perhaps we could restrict the generalized fix for the
> > Behringer UFX1604 / UFX1204 with some simple logic to devices that
> > only have *one* clock source.
>
> Okay, rereading the original commit log from Cihhao Chen I gather
> Samsung USBC Headset (AKG) with VID/PID (0x04e8/0xa051) actually has
> two clock selectors and only one clock source.
>
> Correct me if I'm wrong.
>
> This is complicated by the fact I haven't been able to find a lsusb -v
> of Samsung USBC Headset (AKG) with VID/PID (0x04e8/0xa051)
>
> Even so, my proposition still stands: devices with only one clock
> source and only one clock selector should be able to handle us
> selecting the clock selector to the only clock source.
