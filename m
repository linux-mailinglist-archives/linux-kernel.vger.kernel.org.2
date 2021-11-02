Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01480442E65
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 13:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhKBMrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 08:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbhKBMrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 08:47:51 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E997CC061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 05:45:16 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id r9-20020a7bc089000000b00332f4abf43fso1527017wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 05:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZZkZVqa+3Plnn+r7mlQ/DHzi6CEkEgG/JnTm+RoF3Os=;
        b=a5BUgCpSrtUkDJpbZB1JWGRjd29moku/hgoRNXpgoUydTPcHt/wZ+Mn2D21V4PyZZ9
         Vx8dSEvCioF/cLT6iQgvNOKDrGVK4aGS/oMld+LZZ7+gWvsmWzTKnmhwPf5wKO+GE5s0
         Dl1PgbJsFtIvBSshpJxhmJ39uAK2LAFN+N+KVJIgjucoTmfsOz00WhzY+J9cZoMceF/X
         zkruyXFjaQ8nhIV+zS6svKW6vGw0/RHvrayN7hEZSTJvAofn1mY50hLttZvDBV5xezi8
         gnQJtbXquJcW43+wuhCkoQudE+sJgwjiEISmCRgTmzcMMFTolHy2g4YDijtOwwTN65rA
         zCSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZZkZVqa+3Plnn+r7mlQ/DHzi6CEkEgG/JnTm+RoF3Os=;
        b=Bicv4qIZhmwVGvE6TuU+s3RJ7Qq3PrzAA2KGarMyFDuMcBETOgLSHF8qYj54C9Ncwk
         dwWK1592+yMwda7L2JyWskHqRP42VUzDy4cU/yZxdLPVR3qCl5y1CosDbbHtxDuVFjTS
         p1qLN6s+9hiB8YhN0BpZ6ha2Qivt9zRLdZKaMcdH6GFBc2YnA7i92v47qwQyAtGH2Vac
         Jap3hbQrZuMOAFIQgySICBLup9LfHZ/5+rdb92TlYLVSkzUp633CQWc7s9gZB8z9mJRG
         X+R6+UhI0H61yKApVZAlVDdvpnS8eUAlvk0NzPQG9UPNHt67lKK4phQwJBa7AYdCmx8b
         rKHA==
X-Gm-Message-State: AOAM530eKbnwOKJppKk1hUQzAPonnkmEaRrYoeDyanJkCVlNMnKYzaHh
        Ojdmn9E8ae9ke59/mBWWYg==
X-Google-Smtp-Source: ABdhPJzKEJONKSknqb28hjNBtqlKzn1WjVheQ7JDq8SUVGJAbIFvwd7VSeromLyp3heo9ZB3kOmWqA==
X-Received: by 2002:a7b:c76e:: with SMTP id x14mr6612110wmk.27.1635857115568;
        Tue, 02 Nov 2021 05:45:15 -0700 (PDT)
Received: from rampage-hp2 ([80.169.207.154])
        by smtp.gmail.com with ESMTPSA id y12sm15437552wrn.73.2021.11.02.05.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 05:45:15 -0700 (PDT)
Date:   Tue, 2 Nov 2021 12:45:13 +0000
From:   Jonathan Clarke <jonathan.a.clarke@gmail.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH] Make top/rear speaker, mute and micmute leds work on HP
 x360 14-ea000 laptops that use Realtek 245 codec
Message-ID: <20211102124513.GA1298862@rampage-hp2>
References: <20211029154313.1005394-1-jonathan.a.clarke@gmail.com>
 <s5h35oisug0.wl-tiwai@suse.de>
 <20211101103445.GA1064130@rampage-hp2>
 <s5hzgqnotpu.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hzgqnotpu.wl-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2021 at 09:19:25AM +0100, Takashi Iwai wrote:
> Could you try just to flip the bit 0x08?  At LED off state?
> 
> % hda-verb /dev/snd/hwC0D0 0x20 SET_COEF_INDEX 0x0b
> % hda-verb /dev/snd/hwC0D0 0x20 SET_PROC_COEF 0x77f4
> 
> That is, the implementation in alc286_fixup_hp_mute_led_coefbit(),
> which is used by many other HP laptops.

Ah, I see what you mean.  

Yes, you're right, changing from 0x77f4 to 0x77fc makes the mute led light up.
The changes to the other proc_coef bits in my patch are not needed.

I will revise and revert in next few days.  Thanks
