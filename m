Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47497308131
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 23:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhA1Wld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 17:41:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54774 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229561AbhA1Wl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 17:41:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611873602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=D1asM/mdpxR1vYWT48GbcZmtlsbJYFV6SyTJkmfAp54=;
        b=gRA7Ss7DXy+pMROj3gz4284bPVeRPi+mUPZjVVJI3NoOSC4UL6r6+V8tTkuCz48cZQmx4e
        9TVWMtOJWt95PfbB8sLN/Km6P1pdQ9uwdCcg85jIj/Oy5fN8VYdkPPDPkjDkRNjx63LHfz
        kBtMnCQ2MEpdc+DEx+jpnXTzJ918+FM=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-LA2L0HQ2PZOO8OHkDg8naQ-1; Thu, 28 Jan 2021 17:39:58 -0500
X-MC-Unique: LA2L0HQ2PZOO8OHkDg8naQ-1
Received: by mail-il1-f198.google.com with SMTP id l68so6017271ild.21
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 14:39:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:mime-version;
        bh=D1asM/mdpxR1vYWT48GbcZmtlsbJYFV6SyTJkmfAp54=;
        b=rS9va9vot1VGgRbwq7s5JeGMkU+S40s/Xgsok0kZqxCsrolntn69qmrYNKA79tOhkf
         H/doBxPlJvjBL2ettvqll0TobzSQnB6uVCBGiHGfyBUCCjLex5xueHOq7wQFAk3VTud9
         PmLUrz5O9RV0exyUtP2vd3HsW695CXgDKVla1v5fHTT/uCArfNnmhEWO1PTABQ/ReyLd
         0OvKaK45W6TGat816vVxx/DgkdMOaFU132pQfWu0vhpQYZILLYkyf5+K6Jnah7xkeQdg
         Vlc+7VzaXIGz+Y9kWrBa1dq5Ts1GrYPBzmisVIaZ8NOeeii5YoGi99kpOBHJhLRnRjCS
         PiDA==
X-Gm-Message-State: AOAM5312iFD3+2Qsu32UZJkwO/t8pz8MEdCAcC8F0o2RuiK3wfZi9GAm
        7qjvXB4bYVuD2JbBO1pWC5bIm/7l2zPYMwODEjznWsG4xvB9PY+XBFVw0ZrDJV55E5b619wYs0T
        aq9tXQ7qFZkz3eIHbh59gqnrC
X-Received: by 2002:a02:cc43:: with SMTP id i3mr1266656jaq.58.1611873597735;
        Thu, 28 Jan 2021 14:39:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzcaTSXcL4AYZdldj4cezSvP2lg+1lhTtXjvAHJFF8aCcJcvdASnKcaPNsTC8bU8dAa7/nETQ==
X-Received: by 2002:a02:cc43:: with SMTP id i3mr1266647jaq.58.1611873597445;
        Thu, 28 Jan 2021 14:39:57 -0800 (PST)
Received: from chargestone-cave ([2607:9000:0:57::8e])
        by smtp.gmail.com with ESMTPSA id j7sm2822590ilo.52.2021.01.28.14.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 14:39:56 -0800 (PST)
Date:   Thu, 28 Jan 2021 16:39:50 -0600
From:   Michael Catanzaro <mcatanzaro@redhat.com>
Subject: [REGRESSION] "ALSA: HDA: Early Forbid of runtime PM" broke my
 laptop's internal audio
To:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Harsha Priya <harshapriya.n@intel.com>
Cc:     linux-kernel@vger.kernel.org
Message-Id: <EM1ONQ.OL5CFJTBEBBW@redhat.com>
X-Mailer: geary/3.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On my System76 Gazelle Pro (gazp9) laptop, internal audio broke after 
upgrading to kernel 5.10.

The laptop's speakers produce no sound. Audio from headphones still 
works fine. A quick test is to visit GNOME System Settings -> Sound -> 
Output, select Test, click Front Left or Front Right and notice there 
is no sound. I tested a mainline kernel revision from yesterday 
(5.11-rc5+) and the regression is not yet fixed. I bisected the 
regression to "ALSA: HDA: Early Forbid of runtime PM":

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a0645daf16101bb9a6d87598c17e9a8b7bd60ea7

I created a downstream bug report here, including some bits from dmesg 
that may or may not be relevant in comment #2:

https://bugzilla.redhat.com/show_bug.cgi?id=1918933

Audio devices:

$ lspci | grep -i audio
00:03.0 Audio device: Intel Corporation Xeon E3-1200 v3/4th Gen Core 
Processor HD Audio Controller (rev 06)
00:1b.0 Audio device: Intel Corporation 8 Series/C220 Series Chipset 
High Definition Audio Controller (rev 05)

OS: Fedora 33

I'm happy to provide any additional required info or test patches if 
you CC me, since I'm not a kernel developer and am not subscribed to 
these lists. Thanks.


