Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D0C3D6A78
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 01:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234217AbhGZXRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 19:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233580AbhGZXRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 19:17:09 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53978C061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 16:57:36 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id az7so10675143qkb.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 16:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+c223BNKCjVr89i78fnlRgBQMhpUOGJDxxcmZA/6yCE=;
        b=OwnYV9rlnUfJo2RkKot5+W+rdsLUN7+zWrFy/pz8wdfqaTIej2jOIu+LgE2i3AE2nf
         wJ1xojtvCrbUirSLD83/obiHk9C0NaQJeHN84Jvf8rNF9IdC2bfeMHCV4XWuHaSVYrzn
         Mf0g4AHDMwR19nzAkIKwpw/xksa2aupVpgwHzQVzd5/2A18a0DQzcSpL0ShCOPBLYxVB
         sGy/zrevQ2P/oSF7X0G3mwfdXv5hq+PmtMBMMe12omsVY03LP7HoWRAj/hD9/rRbfCXh
         foGUXykUrM0OvoCBuftU56SdJXlPp3be6Gs2ybNAIsDSFfIlanwbCXWzPUtECc8aQpMk
         7tJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+c223BNKCjVr89i78fnlRgBQMhpUOGJDxxcmZA/6yCE=;
        b=TzL26TPFJz8Je5ebKkUXHuxdpf4LBUGHG2BepeuOpx6j6kcyZ7pSAejnm/LL2QgaJs
         D4WUqlrut0D2lW721mfSUbBlvG30xbz4neNNdwxt3sdFlcPnKLC5VKJqwUSvfBkGsm9x
         irhGY7nkF1StxPfVOMjqfWH9FF26IciiumzmSH2m/2kBc52PVXAAEysRVmZgvCKozF6j
         e5hA5D9u/Q74nWD/WuCYgsF8U3e6xPWjNWaOvHXnpmRVQvu6LzGHEvTV0jy4kDY2rzor
         s3hwkszu8K1Krz4dH6I7H2dKxNm9WndpuZcPMUbsFsuIibctgWO0brDM/KpSva0F2NMx
         4d7Q==
X-Gm-Message-State: AOAM533THdE/eAXu2ezpWXVRe3h6Ro5aOQ9Nc3pJCQGDAcJhm1X5FL5L
        UB/1vYnndzDW/kEyAeup2QPM12b2rnN0QbD4TDg=
X-Google-Smtp-Source: ABdhPJy2JU1ynaciVOwS/iwo88bT89yMDXeJN4d1VYgvkEp69wZdpxn6I/9NlfOvGTmgOWQap/tbBlqfqfI1ksBQUCg=
X-Received: by 2002:a05:620a:893:: with SMTP id b19mr19600194qka.487.1627343855508;
 Mon, 26 Jul 2021 16:57:35 -0700 (PDT)
MIME-Version: 1.0
References: <1627100621-19225-1-git-send-email-chihhao.chen@mediatek.com>
 <s5h7dhgi1e2.wl-tiwai@suse.de> <CAEsQvcs3P+TqQFzQetPfRycpo66eJFwnzwhk2JyCXFaCLFHmFg@mail.gmail.com>
 <s5hwnpehm7y.wl-tiwai@suse.de> <CAEsQvcumEDOKgUB6h2-im5QabhPfaSaU63RF8pegPt5ZCPx+Pw@mail.gmail.com>
 <2db5d44b88ace1c25af4a45b3469a425fe1d81a5.camel@mediatek.com>
In-Reply-To: <2db5d44b88ace1c25af4a45b3469a425fe1d81a5.camel@mediatek.com>
From:   Geraldo Nascimento <geraldogabriel@gmail.com>
Date:   Mon, 26 Jul 2021 20:57:27 +0000
Message-ID: <CAEsQvctJDnsaRTXAGAJ6==juKazoo2=AJrWabLzqE=jCfg5EEA@mail.gmail.com>
Subject: Re: [PATCH] ALSA: usb-audio: fix incorrect clock source setting
To:     chihhao chen <chihhao.chen@mediatek.com>
Cc:     Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
        wsd_upstream@mediatek.com, damien@zamaudio.com, tiwai@suse.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 8:42 AM chihhao chen <chihhao.chen@mediatek.com> wrote:
>
> Hello,
>
> Attach USB descriptor of clock source and selectior for this earphone.
>
> AC Clock Source Descriptor:
> ------------------------------
>
> Value   Valuename
> 0x08    bLength
> 0x24    bDescriptorType
> 0x0A    bDescriptorSubtype
> 0x09    bClockID
> 0x03    bmAttributes
> 0x07    bmControls
> 0x00    bAssocTerminal
> 0x00    iClockSource
> Hex dump:
> 0x08 0x24 0x0A 0x09 0x03 0x07 0x00 0x00
>
> AC Clock Selector Descriptor:
> ------------------------------
>
> Value   Valuename
> 0x09    bLength
> 0x24    bDescriptorType
> 0x0B    bDescriptorSubtype
> 0x0B    bClockID
> 0x02    bNrInPins
> 0x09    baCSourceID(1)
> 0x0A    baCSourceID(2)
> 0x03    bmControls
> 0x00    iClockSelector
> Hex dump:
> 0x09 0x24 0x0B 0x0B 0x02 0x09 0x0A 0x03 0x00
>
> AC Clock Source Descriptor:
> ------------------------------
>
> Value   Valuename
> 0x08    bLength
> 0x24    bDescriptorType
> 0x0A    bDescriptorSubtype
> 0x0A    bClockID
> 0x03    bmAttributes
> 0x07    bmControls
> 0x00    bAssocTerminal
> 0x00    iClockSource
> Hex dump:
> 0x08 0x24 0x0A 0x0A 0x03 0x07 0x00 0x00
>
> AC Clock Selector Descriptor:
> ------------------------------
>
> Value   Valuename
> 0x09    bLength
> 0x24    bDescriptorType
> 0x0B    bDescriptorSubtype
> 0x0C    bClockID
> 0x02    bNrInPins
> 0x09    baCSourceID(1)
> 0x0A    baCSourceID(2)
> 0x03    bmControls
> 0x00    iClockSelector
> Hex dump:
> 0x09 0x24 0x0B 0x0C 0x02 0x09 0x0A 0x03 0x00
>
> Thanks
> Chihhao

Thank you, Chihhao.

So I was wrong about Samsung USBC Headset (AKG) with VID/PID
(0x04e8/0xa051) having a Clock Multiplier.

There are two Clock Sources, both linked to the USB SOF with fixed sample rate.

Plus two Clock Selectors which are host-programmable and can be set to
either of the two Clock Sources.


I'm still at a loss to explain what is going wrong here.

Would a printk() reveal the first explicit
uac_clock_selector_set_val() on the Clock Selector associated with
USB_IN sets Clock Source ID to pin 1 with Clock Source ID 0x9?

Or is it the other way around, i.e. it sets the Clock Source ID to pin
2 with Clock ID 0xA for the capture stream Clock Selector?


Chihhao Chen, could you please try the following patch for debugging
purposes and share what is printed in dmesg?

Please try one time with your fix applied and one time without, i.e.
with an otherwise unmodified vanilla kernel.

Thank you,
Geraldo Nascimento

--- clock.c.orig    2021-07-17 12:15:06.416028360 -0000
+++ clock.c    2021-07-26 20:45:58.713881962 -0000
@@ -300,6 +300,7 @@ static int __uac_clock_find_source(struc
         /* the entity ID we are looking for is a selector.
          * find out what it currently selects */
         ret = uac_clock_selector_get_val(chip, clock_id);
+        printk(KERN_ERR "FOR EP %x: Clock Selector %x has pin %d for
Clock Source ID %x selected\n", (unsigned int)fmt->endpoint, clock_id,
ret, sources[ret - 1]);
         if (ret < 0) {
             if (!chip->autoclock)
                 return ret;
@@ -324,6 +325,7 @@ static int __uac_clock_find_source(struc
                           sources[ret - 1],
                           visited, validate);
         if (ret > 0) {
+            printk(KERN_ERR "FOR EP %x: Found Source! Clock Selector
%x has pin %d for Clock Source ID %x about to be reselected\n",
(unsigned int)fmt->endpoint, entity_id, cur, sources[cur - 1]);
             err = uac_clock_selector_set_val(chip, entity_id, cur);
             if (err < 0)
                 return err;
@@ -344,6 +346,7 @@ static int __uac_clock_find_source(struc
             if (ret < 0)
                 continue;

+            printk(KERN_ERR "FOR EP %x: Found source by trial and
error! Clock Selector %x has pin %d for Clock Source ID %x about to be
selected\n", (unsigned int)fmt->endpoint, entity_id, i, sources[i -
1]);
             err = uac_clock_selector_set_val(chip, entity_id, i);
             if (err < 0)
                 continue;
