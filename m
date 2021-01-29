Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABFD9308B84
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 18:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbhA2R1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 12:27:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54556 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231658AbhA2RZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 12:25:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611941065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1tJEDpVaTU2o7pEzEYi/Itw24bwaC7NiGn/22B7qnc4=;
        b=bv1dP1r6yRx8HvpRiBl5i+lknLWT7YZ1pHsDaSX7hU6Sew/ngFeRVFgKyd1lkPvJP1L9Pm
        DZ4vNSGWWozd1bGBGAvyEiPoGJo8CMSNwBkttKFJTBU58yzJgEZQ6b+owyryzUIK673q+U
        cHIQGrL1kG/oyAz4Pt2X63HjFwofiO0=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-FoqXsFDcPmGG2qidoeVqRQ-1; Fri, 29 Jan 2021 12:24:24 -0500
X-MC-Unique: FoqXsFDcPmGG2qidoeVqRQ-1
Received: by mail-il1-f200.google.com with SMTP id x11so8239703ill.17
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 09:24:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :references:mime-version;
        bh=1tJEDpVaTU2o7pEzEYi/Itw24bwaC7NiGn/22B7qnc4=;
        b=Cqw0ce/XjFpo+Dv7/ENdWW6gzgWy3qu2dNmakCQsj4dPrPeDJZPZ14+Xw/u9JEgY0p
         B3+cneMrVjfHem05micseZmqKoQ907X6JRC4E7WXqxqTfCDu0Re2ZqW8QSZVf8kHbqn8
         tiAjL8dmW5dCXQcHU6SfEIC1U1UeuzSmuxpH6pmHwAsD4P0MX5G1pYIyzNM2nDg9ueh1
         /ZU2bL3xyTCvaGBCfLXHmWbXhD2Vk8VhRlcARCNZE/rcuD1XwyD8ZO0FKVSZ9s9MoBs8
         195CngD21ysys1GE+nd2I/rL1qJzLiC477cPVVOJ1s7gMA7bDRVxp6eDiJ6epHr01ob/
         +BNQ==
X-Gm-Message-State: AOAM532nbUBTK2yL7mMkZSvee18hNDex2qXqJHBu6zGF54a4vdT7P9EN
        GvqyLFAOZtzUQ5i1GJxaOrH3Jau/6bhPRojvira4NgbyU0WnLX608BRjuH4f42Ee03c9EZUGA5/
        jG2BXUtsk1NpVp92Ad5HrBuk0
X-Received: by 2002:a05:6638:229b:: with SMTP id y27mr4571999jas.136.1611941063553;
        Fri, 29 Jan 2021 09:24:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxBQCa/aQwAwI0WBJb/kQp4EcDUYeQ7uixWQ+zr7FFHIFR0qu+Poa5+gr/i329TB8Xg1vOo1g==
X-Received: by 2002:a05:6638:229b:: with SMTP id y27mr4571989jas.136.1611941063408;
        Fri, 29 Jan 2021 09:24:23 -0800 (PST)
Received: from chargestone-cave ([2607:9000:0:57::8e])
        by smtp.gmail.com with ESMTPSA id b16sm4761308ile.32.2021.01.29.09.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 09:24:22 -0800 (PST)
Date:   Fri, 29 Jan 2021 11:24:16 -0600
From:   Michael Catanzaro <mcatanzaro@redhat.com>
Subject: Re: [REGRESSION] "ALSA: HDA: Early Forbid of runtime PM" broke
 =?UTF-8?Q?my=0D=0A?= laptop's internal audio
To:     Takashi Iwai <tiwai@suse.de>
Cc:     "N, Harshapriya" <harshapriya.n@intel.com>,
        alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        kai.vehmanen@intel.com, stable@vger.kernel.org
Message-Id: <GOHPNQ.RTPVHYRR9NQ62@redhat.com>
In-Reply-To: <s5hft2jlnt4.wl-tiwai@suse.de>
References: <EM1ONQ.OL5CFJTBEBBW@redhat.com>
        <BY5PR11MB430713319F12454CF71A1E73FDB99@BY5PR11MB4307.namprd11.prod.outlook.com>
        <U3BPNQ.P8Q6LYEGXHB5@redhat.com> <s5hsg6jlr4q.wl-tiwai@suse.de>
        <9ACPNQ.AF32G3OJNPHA3@redhat.com> <IECPNQ.0TZXZXWOZX8L2@redhat.com>
        <8CEPNQ.GAG87LR8RI871@redhat.com> <s5hft2jlnt4.wl-tiwai@suse.de>
X-Mailer: geary/3.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 29, 2021 at 5:17 pm, Takashi Iwai <tiwai@suse.de> wrote:
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -2217,8 +2217,6 @@ static const struct snd_pci_quirk 
> power_save_denylist[] = {
>  	/* https://bugzilla.redhat.com/show_bug.cgi?id=1525104 */
>  	SND_PCI_QUIRK(0x1043, 0x8733, "Asus Prime X370-Pro", 0),
>  	/* https://bugzilla.redhat.com/show_bug.cgi?id=1525104 */
> -	SND_PCI_QUIRK(0x1558, 0x6504, "Clevo W65_67SB", 0),
> -	/* https://bugzilla.redhat.com/show_bug.cgi?id=1525104 */
>  	SND_PCI_QUIRK(0x1028, 0x0497, "Dell Precision T3600", 0),
>  	/* https://bugzilla.redhat.com/show_bug.cgi?id=1525104 */
>  	/* Note the P55A-UD3 and Z87-D3HP share the subsys id for the HDA 
> dev */

Hi,

This patch works fine on my laptop. I have no clue whether that means 
it's really safe to remove the quirk. I've never noticed any clicking 
noise myself, but I understand it has been a problem for other System76 
laptops.

Michael


