Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B4E3309BC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 09:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbhCHIup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 03:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhCHIuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 03:50:44 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F8EC06174A;
        Mon,  8 Mar 2021 00:50:43 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id lr13so18656087ejb.8;
        Mon, 08 Mar 2021 00:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=32H/9kq3kkSKIKkC6rU2T+kJc+RIITmk29bb5zIT9oI=;
        b=KIaCm3pHjqR7urou0oY5u7V1njgbFztsypDixLXkQI0JsQeGbPNrSN9X3vPk6QOuNx
         VnsX5BVJBzcjB/2khvP8baPNXzjMoieUTFr/P2U+WyBfDWu5N/IHG8UvVv380/RBTTSw
         mP5VN/RZ/0RK257r2w9XCeY4z2t4Ejpc/WLTROXxjeXtoaDP5tY6OoAq2xGQ2OKtFXGQ
         4OvA+tokBNZTusVVIugxkDg6+nzwCsmXnoeUqlf3UKUDCHsgiHGkkJpQ6FbnFYOqpHzM
         YHBOFYssopaaPZweAVzoIm5mvgNAb4w65I3WauIoi2XUCIIP6LKwdPyY5XM/Sy6DkWg+
         I1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=32H/9kq3kkSKIKkC6rU2T+kJc+RIITmk29bb5zIT9oI=;
        b=ax0gO7ncexZycw2CKzY02egWGylYcAQNmdnuMfKNANa2h78CtGcnZaESxXuV7BRrux
         ISJG/K4dvp/krdHMd6HUWDHP91byKvbWtp3u1f4ZkTNJdyoKOcciHVjpgouRZTJ5vkEO
         HS4YL+j79V7WCHwnj789nJiYSamwze+Ad3W3jT/UMg/5J7AJSFZ29G6TScce+YzuzLXk
         KZmV0S/iTxOEmYLIIO4cMQTunMBeDQdZmAXKbPfLeSSBMBnYl9KHDDDF7g8guFGJkRkp
         DgYFPd4MdhpE4oZNk/d8Jsm8+DknFzdPvTPs/SnYMST4OYQRwN9muL5wndEowtHhdx+m
         Iklw==
X-Gm-Message-State: AOAM533P1pvpfRIEt2cpjnSpRQrd7NzI8n7zhqIO+ri2eVh/CkDSBRbR
        +bF9/i3lyfBcVv9/7KhK3Pnk3WgqaCRF1x7aBww=
X-Google-Smtp-Source: ABdhPJyHK1zsY+M9ptcXWeAhgfGYn+JUy3cLX12D8KVwzBqaClqjEVyBfEFjDKMY5XH78exAfT4lMM1YQvXeu4+xjMg=
X-Received: by 2002:a17:906:b80c:: with SMTP id dv12mr14187321ejb.110.1615193442483;
 Mon, 08 Mar 2021 00:50:42 -0800 (PST)
MIME-Version: 1.0
References: <CAH+2xPCmZNW0ct8XoBmAnd0QK53guv2e4HLn40NvWrEA7pj3qw@mail.gmail.com>
 <CAH+2xPCkKRhXJSqMx7kzsO53JwXbrmYPLLL-_ANO9waNJREDWA@mail.gmail.com>
 <777991bb72f8842e3e730f9b600b2086478f5d36.camel@suse.com> <CAH+2xPAB4bWN9NiTQr4WggUX6eDXzMikzYJySx3sAj3Ho3AdxA@mail.gmail.com>
 <b71b85a588c3e27d2de129723468263d932ab435.camel@suse.com> <CAH+2xPA4yUwbcOaO4OH-LaAwC820ZoFmAf_eUdf6+xgiTPWz8g@mail.gmail.com>
In-Reply-To: <CAH+2xPA4yUwbcOaO4OH-LaAwC820ZoFmAf_eUdf6+xgiTPWz8g@mail.gmail.com>
From:   Bruno Thomsen <bruno.thomsen@gmail.com>
Date:   Mon, 8 Mar 2021 09:50:26 +0100
Message-ID: <CAH+2xPC0sbqvsiBgsemHxrmE=JgnuOK6mzJ6pQ_G-ihqswAvPQ@mail.gmail.com>
Subject: Re: usb: cdc-acm: BUG kmalloc-128 Poison overwritten
To:     Oliver Neukum <oneukum@suse.com>
Cc:     linux-usb@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Bruno Thomsen <bth@kamstrup.com>,
        Lars Alex Pedersen <laa@kamstrup.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Den fre. 26. feb. 2021 kl. 15.14 skrev Bruno Thomsen <bruno.thomsen@gmail.com>:
>
> Den tor. 25. feb. 2021 kl. 10.57 skrev Oliver Neukum <oneukum@suse.com>:
> >
> > Am Mittwoch, den 24.02.2021, 16:21 +0100 schrieb Bruno Thomsen:
> >
> > Hi,
> >
> > > No, this is not a regression from 5.10. It seems that many attempts to
> > > fix cdc-acm in the 5.x kernel series have failed to fix the root cause of
> > > these oops. I have not seen this on 4.14 and 4.19, but I have observed
> > > it on at least 5.3 and newer kernels in slight variations.
> > > I guess this is because cdc-acm is very common in the embedded
> > > ARM world and rarely used on servers or laptops. Combined with
> > > ARM devices still commonly use 4.x LTS kernels. Not sure if
> > > hardening options on the kernel has increased change of reproducing
> > > oops.
> >
> > OK, so this is not an additional problem.
> > According to your logs, an URB that should have been killed wasn't.
>
> Thanks for looking into this bug rapport.
>
> > > I am ready to test new patches and will continue to report oops
> >
> > Could you test the attached patches?
>
> Yes, I am already running tests on the patches.
> I have not seen any oops yet and it seems the USB cdc-acm driver is still
> working as intended.
>
> The only notable trace I have seen is this new error from the cdc-acm driver
> but everything kept on working.
> kernel: cdc_acm 1-1.1:1.7: acm_start_wb - usb_submit_urb(write bulk) failed: -19
>
> Other then that I see this common error (should probably be a warning) during
> device enumeration:
> kernel: cdc_acm 1-1.2:1.0: failed to set dtr/rts
>
> I will post an update next week when the patches have survived some
> more runtime.

Tested-by: Bruno Thomsen <bruno.thomsen@gmail.com>

I have not observed any oops with patches applied. Patches have seen
more than 10 weeks of runtime testing across multiple devices.

/Bruno
