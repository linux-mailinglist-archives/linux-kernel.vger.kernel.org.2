Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 336F53D7F93
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 22:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhG0U4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 16:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhG0U4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 16:56:43 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA7EC061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 13:56:42 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id 190so87060qkk.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 13:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5//oOHuSPsYAOusVOhmt6ZgP2slz+I2zua77g1mYYaA=;
        b=SUbPn6lwVRpg1qvmx2Gz6SGev667SkmIlLC/m7IhRKiH13GNsAYsP6ceNmlSECoogo
         nkUxieCmaA6gHCBrORehT7/zuQDVdvcxyM5CAUWDRDRn/2PE6uir8Ri9Z89RCmfsVWCT
         aPxawqBaLqgfs43o4nVcV+RI8II0loe3NcE7JeSmTdyQA6FzkgytjyOr5Df3/Jd7IpTy
         CrMBrXo8up0luhc2QJH74bL1KMWojl9pnq/3IPjCiMZvAh2eC4QwAi+8Roa1GgrPoAVG
         kvfaqUEutJ87vTsLV5o9SrsihgvRXZkTRPQisvdm6liznJ5jrMuL22lO2hIEYgHbOzVA
         CLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5//oOHuSPsYAOusVOhmt6ZgP2slz+I2zua77g1mYYaA=;
        b=S856oPD+YTtqGG+CB5lHAKLG+IgdjglxQCD8RtmYOHcSONLv18L4V/XpgqtDsyCAk0
         cGweZf3EuSZD1tZa2OsxQ2hnS1tBWoS/0hWOJzaw39Zliq4pn9/H3zztGQRFUKYLYP3Y
         zcNN4nfn5AuMk+j33pQ2HZGfPcX/SdKF4QwMpN7bBDRVMq6oGAZWbnyZiMIyACpcsCSp
         0WFym9I4u1t9J/ybIcSbbN/CNqe+RPVUIcFyXMpK967F9HP/UbDU1lzohx7i0Rpfb1iD
         Jyad/xLHqBeQjNXJ07Bz0lAPTc3oj7TdaZPC0rWOTuD1SM+y/z6TUYXsL5f9JxPjqnK6
         ZbuA==
X-Gm-Message-State: AOAM5304H2x/rCsO8otFGMw2lZXA6Twd3CHvuxtS2GkyJBB1ttOpB5VQ
        3VAYp7e+HiSL7JKzTNp/QRAkkCI4XGdC21tDCP4=
X-Google-Smtp-Source: ABdhPJz7USORpL2+8VeyVekCt4fwAiubyQ7qL3dJ1KSS2Qo5gpjZOC1Sc8LR8htHJIar5jyg7NMKFHtV5DGPf2kytGM=
X-Received: by 2002:a37:e44:: with SMTP id 65mr23697309qko.193.1627419401647;
 Tue, 27 Jul 2021 13:56:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAEsQvctJDnsaRTXAGAJ6==juKazoo2=AJrWabLzqE=jCfg5EEA@mail.gmail.com>
 <20210727102744.30364-1-chihhao.chen@mediatek.com>
In-Reply-To: <20210727102744.30364-1-chihhao.chen@mediatek.com>
From:   Geraldo Nascimento <geraldogabriel@gmail.com>
Date:   Tue, 27 Jul 2021 17:56:33 +0000
Message-ID: <CAEsQvcuOQ_Tg0bRbsegECdBUsGxa61ei9-Z2bRbGvQ9FmEUPbA@mail.gmail.com>
Subject: Re: [PATCH] ALSA: usb-audio: fix incorrect clock source setting
To:     chihhao chen <chihhao.chen@mediatek.com>
Cc:     alsa-devel@alsa-project.org, damien@zamaudio.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        tiwai@suse.com, Takashi Iwai <tiwai@suse.de>,
        wsd_upstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 10:28 AM <chihhao.chen@mediatek.com> wrote:
>
> From: chihhao chen <chihhao.chen@mediatek.com>
>
> Hello
>
> <6>[  150.347456][ T2768] __uac_clock_find_source: FOR EP 81: Clock Selector c has pin 2 for Clock Source ID a selected
> <6>[  150.347517][ T2768] __uac_clock_find_source: FOR EP 81: Found Source! Clock Selector c has pin 2 for Clock Source ID a about to be reselected
> <6>[  150.384289][ T2768] __uac_clock_find_source: FOR EP 81: Clock Selector c has pin 2 for Clock Source ID a selected
> <6>[  150.390920][ T2768] __uac_clock_find_source: FOR EP 81: Found Source! Clock Selector c has pin 2 for Clock Source ID a about to be reselected
> <6>[  150.438156][ T2768] __uac_clock_find_source: FOR EP 81: Clock Selector c has pin 2 for Clock Source ID a selected
> <6>[  150.438226][ T2768] __uac_clock_find_source: FOR EP 81: Found Source! Clock Selector c has pin 2 for Clock Source ID a about to be reselected
> <6>[  150.473547][ T2768] __uac_clock_find_source: FOR EP 81: Clock Selector c has pin 2 for Clock Source ID a selected
> <6>[  150.480165][ T2768] __uac_clock_find_source: FOR EP 81: Found Source! Clock Selector c has pin 2 for Clock Source ID a about to be reselected
> <6>[  150.513375][ T2768] __uac_clock_find_source: FOR EP 1: Clock Selector b has pin 2 for Clock Source ID a selected
> <6>[  150.513439][ T2768] __uac_clock_find_source: FOR EP 1: Found Source! Clock Selector b has pin 2 for Clock Source ID a about to be reselected
> <6>[  150.546161][ T2768] __uac_clock_find_source: FOR EP 1: Clock Selector b has pin 2 for Clock Source ID a selected
> <6>[  150.552678][ T2768] __uac_clock_find_source: FOR EP 1: Found Source! Clock Selector b has pin 2 for Clock Source ID a about to be reselected
> <6>[  150.584347][ T2768] __uac_clock_find_source: FOR EP 1: Clock Selector b has pin 2 for Clock Source ID a selected
> <6>[  150.584418][ T2768] __uac_clock_find_source: FOR EP 1: Found Source! Clock Selector b has pin 2 for Clock Source ID a about to be reselected
> <6>[  150.617760][ T2768] __uac_clock_find_source: FOR EP 1: Clock Selector b has pin 2 for Clock Source ID a selected
> <6>[  150.624253][ T2768] __uac_clock_find_source: FOR EP 1: Found Source! Clock Selector b has pin 2 for Clock Source ID a about to be reselected
> <6>[  150.657906][ T2768] __uac_clock_find_source: FOR EP 1: Clock Selector b has pin 2 for Clock Source ID a selected
> <6>[  150.657982][ T2768] __uac_clock_find_source: FOR EP 1: Found Source! Clock Selector b has pin 2 for Clock Source ID a about to be reselected
> <6>[  150.689571][ T2768] __uac_clock_find_source: FOR EP 1: Clock Selector b has pin 2 for Clock Source ID a selected
> <6>[  150.696109][ T2768] __uac_clock_find_source: FOR EP 1: Found Source! Clock Selector b has pin 2 for Clock Source ID a about to be reselected
>
> Chihhao
>

Thank you. Chihhao Chen!

I see both EPs have their Clock Selectors (ID 0xC for EP 81 and ID 0xB
for EP 1) selected to pin 2, i.e. Clock Source ID 0xA.

I'm assuming this log is for the vanilla kernel without Chihhao's fix.
Please correct me if I'm wrong, Chihhao.

From the original commit message for the fix, we know the correct
setting for Clock Selector 0xB should be pin 1, with Clock Source ID
0x9.


Takashi Iwai already shared his perspective that this is a firmware
bug on the device.

I have a hunch that the firmware bug is setting both Clock Selectors
at the same time regardless of which one we want to select
specifically.


Chihhao, please try the below patch and perform another echo test.

Let us know if the echo test works or if it still fails and please
remember to share with us the relevant dmesg logs.


Thank you,
Geraldo Nascimento


--- clock.c.orig        2021-07-17 12:15:06.416028360 -0000
+++ clock.c     2021-07-27 17:36:16.954774954 -0000
@@ -324,9 +324,45 @@ static int __uac_clock_find_source(struc
                                              sources[ret - 1],
                                              visited, validate);
                if (ret > 0) {
-                       err = uac_clock_selector_set_val(chip, entity_id, cur);
-                       if (err < 0)
-                               return err;
+                       if (chip->usb_id == USB_ID(0x04e8, 0xa051)) {
+                               if (entity_id == 0xc) {
+                                       err =
uac_clock_selector_set_val(chip, entity_id, 2);
+                                       if (err < 0)
+                                               return err;
+
+                                       err =
uac_clock_selector_get_val(chip, 0xc);
+                                       if (err > 0) {
+                                               printk(KERN_ERR
"__uac_clock_find_source: Clock Selector 0xc has pin %d selected",
err);
+                                       }
+
+                                       err =
uac_clock_selector_get_val(chip, 0xb);
+                                       if (err > 0) {
+                                               printk(KERN_ERR
"__uac_clock_find_source: Clock Selector 0xb has pin %d selected",
err);
+                                       }
+                               }
+
+                               else if (entity_id == 0xb) {
+                                       err =
uac_clock_selector_set_val(chip, entity_id, 1);
+                                       if (err < 0)
+                                               return err;
+
+                                       err =
uac_clock_selector_get_val(chip, 0xc);
+                                       if (err > 0) {
+                                               printk(KERN_ERR
"__uac_clock_find_source: Clock Selector 0xc has pin %d selected",
err);
+                                       }
+
+                                       err =
uac_clock_selector_get_val(chip, 0xb);
+                                       if (err > 0) {
+                                               printk(KERN_ERR
"__uac_clock_find_source: Clock Selector 0xb has pin %d selected",
err);
+                                       }
+                               }
+                       }
+
+                       else {
+                               err = uac_clock_selector_set_val(chip,
entity_id, cur);
+                               if (err < 0)
+                                       return err;
+                       }
                }

                if (!validate || ret > 0 || !chip->autoclock)
