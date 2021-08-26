Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABB23F8E49
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 20:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243455AbhHZS5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 14:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243319AbhHZS5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 14:57:03 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D7CC061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 11:56:15 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id e21so8389192ejz.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 11:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KvsflDkWCpoXreowakAw0AK8LR1AdIFSNtPrQ0bbYKA=;
        b=Iax5JdHSO25jzMdGpGlFcbTS4M1JwI/9rDANeDgNfRC0gTNsw3xctsB3T+wSsghh3I
         KovLg45CVQFbtcmRNSSskWUkrp7Rjqj9+coIzQJiQEAn7IDPB3pp6qXFCYDbjdgjO/wA
         7RLXeZYCeiV1Lvmja43d6amw2xjSaChiX1v8KB6vE1b0F/Bs10JpW3rYQWmk67uK7TWq
         HFaRxh92IrGbyzlraTkYfSILab3idPhbBXSzgqUS0CuoOYvUcpLqKcYBk+wV0N1v+0GG
         IqKRGtFsVB8ta+dXo4w6h2mICjpsPJHl61omxBk/GXUaHH4GgTmhVNXpFyOt84+jDiyb
         6F+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KvsflDkWCpoXreowakAw0AK8LR1AdIFSNtPrQ0bbYKA=;
        b=mfLeZl9Zn/9zM/PLVeE0iycmcB17SFAwPBlwO4qwwkqBRptGVIZC2JW8rb53+qxLul
         fA2xvHsoeIS8oEz2qyKHGsa92ElHXIRL9runtaFzfWiCHFv9CFu5Fj5yNpS54YgoF5Sn
         Lfm+jtXm1WbKKrdX52z7QVKFFN3RMO3o39ZwdZdSYfS/3wUsOyg73ukkchSbRO9uoJjO
         p6IJEhPf4NrufBDQq7nvFGLUrawyHei55Qy6BbSxoCs4rxLJY1phgTYPEuQDJ3ZKUHf/
         5tMNa8PAmlKw2poFusYhn8CShulWiYeBAw4o3uYGRPW0V4VKuz1kXonCxW0qNZxYtr9u
         oX1A==
X-Gm-Message-State: AOAM531OBYKGP5OUKiPk7fzeL1n+Ij2ghcVi95csSLGZSxKKlCZJq5GB
        h7i+SaJfZYV11wm4oHZhw+0=
X-Google-Smtp-Source: ABdhPJydXFiZSOFxFhWFdXE6EPtNX1nsMbnIY4T03nP/8c2jVk7Vm0ANbA0yUcpGMuSXzKJKts0WzA==
X-Received: by 2002:a17:906:3497:: with SMTP id g23mr5875986ejb.85.1630004173984;
        Thu, 26 Aug 2021 11:56:13 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id r16sm2255443edt.15.2021.08.26.11.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 11:56:13 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: Re: [PATCH v3 1/2] staging: r8188eu: Use usb_control_msg_recv/send() in usbctrl_vendorreq()
Date:   Thu, 26 Aug 2021 20:56:12 +0200
Message-ID: <1954117.IISOP8hFdM@localhost.localdomain>
In-Reply-To: <f2360c8c-e001-70d6-daeb-03ca5b718d84@gmail.com>
References: <20210825035311.8910-1-fmdefrancesco@gmail.com> <20210825035311.8910-2-fmdefrancesco@gmail.com> <f2360c8c-e001-70d6-daeb-03ca5b718d84@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, August 26, 2021 8:18:23 PM CEST Pavel Skripkin wrote:
> On 8/25/21 6:53 AM, Fabio M. De Francesco wrote:
> > Replace usb_control_msg() with the new usb_control_msg_recv() and
> > usb_control_msg_send() API of USB Core in usbctrl_vendorreq().
> > Remove no more needed variables. Move out of an if-else block
> > some code that it is no more dependent on status < 0. Remove
> > redundant code depending on status > 0 or status == len.
> > 
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> 
> FYI, I've tested this patch with TP-Link TL-WN722N v3 + qemu :)
> 
> 
> Tested-by: Pavel Skripkin <paskripkin@gmail.com>
> 
> 
> NOTE: I am still not able to apply 2/2, so tested tag is only for 1/2
> 
> 
> With regards,
> Pavel Skripkin

Dear Pavel,

Thanks for testing. It was very kind from you.I'll add this to the Reviewed-tag
that you had already given to my patch.

However, I intend to rebase and resend this 1/2 and the 2/2 of this series, because
(as we already found) they logically follow another patch of mine that is still in the
queue ("staging: r8188eu: Remove _enter/_exit_critical_mutex()").

The patch above has already been reviewed by Greg and he found that it looks 
good, but he cannot apply it because it is not tested (for the reasons I've already
explained with a couple of messages)

Unfortunately, until "Remove _enter/_exit_critical_mutex()" is not tested, Greg 
won't apply it and the 2/2 of this series cannot be applied too.

Please, if you have time, do you mind to test also that? It would allow me to resend 
it with your "Tested-by" tag and Greg will surely apply it. No worries if you have no
time for doing this test, otherwise you may find it at:

https://lore.kernel.org/lkml/20210819221241.31987-1-fmdefrancesco@gmail.com/

Please, if you are interested, read the whole thread. You'll see that Greg would apply
it, only if tested.

Thanks very much for your help and kindness,

Fabio




