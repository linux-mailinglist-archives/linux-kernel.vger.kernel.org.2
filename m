Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57FE6320939
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 09:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbhBUIiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 03:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhBUIh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 03:37:57 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1F9C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 00:37:16 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id q14so46002924ljp.4
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 00:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IPMH2ktLsQGjYBF5VkN+rsh/vb/FpswWk5aiR20zfQs=;
        b=XXHI6FSrFrNPbVDB7HBA9DOtFlNwuEMKFNDt9Hg/C1BoIAij1p3CBTJ4lnzZxLm8z6
         1dVPtNAXWSWNun+Pb/bPnm2zh2sjgmlFYnC1B9PS/DDvpBBb+r8jM48Iy8dhkPcVZagG
         nJOfvmlcu3eFtFXbCGkgniIQ3KBddyVKyzN4YXTIq5EJY823og+MtlNxbhj5i8XaHj/J
         1ysS/4WctmHK8D9vHhbclOV6hVN7pOxn4fR4rEVdIlIXq+Hvjl/2B48AR9jSw2kpb6Xi
         8yd0n+sulIU6/kRY+hZ91duN9tMh0XYwgP98tRgImtAdHGmZbBRMFpQAXonminz0xhIY
         MBQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IPMH2ktLsQGjYBF5VkN+rsh/vb/FpswWk5aiR20zfQs=;
        b=qk+WhMEKa+gnj90DnBOeb0qLoFN18N6RtZ4ho0Oqpq96viLV1jm7xQeNb1NoOaBEoW
         0dNxfoplyHbQUjkhISpDWCuOLg0jk3eP3nmRCG9XNC7N7huBR6dT5AiswR6oDtkZHF6Z
         UTHf4gck5PD/DUWJU3PMlr8I3d2g5ufzhV38ytF5rDkaSVkOwECBYB1iE+GaWE00J09M
         I0F9Umuju0ssnI1yjefjUX+ALyTODkPslGQLEnCSolIpDVspJuQTBwlakxpI+2Bpz2fb
         yOnjoR30AyLgoT2yEoPG9qq7AOgzSKiKyEoMgFSN/baCt9Bpitc3SkfGi75O9drKdvJY
         gRPg==
X-Gm-Message-State: AOAM530zANOK+cYg/XSFdtxGxqygiJrM8g3CzNrLl0j4qDYJKYD1eLIx
        T1/lfeORaSwi+ZwFNq+9zBo=
X-Google-Smtp-Source: ABdhPJzU4eRyHypN2ilMPJcML5h6c5ZyD8TEn5ufzxtuV04wVh6D5FZxu5Tbz/tMaL+LAeKrlvOVmg==
X-Received: by 2002:a05:6512:3190:: with SMTP id i16mr10412806lfe.200.1613896634971;
        Sun, 21 Feb 2021 00:37:14 -0800 (PST)
Received: from localhost.localdomain ([37.150.90.70])
        by smtp.googlemail.com with ESMTPSA id d17sm1490285lfa.297.2021.02.21.00.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 00:37:14 -0800 (PST)
From:   Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To:     torvalds@linux-foundation.org
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+3d2c27c2b7dc2a94814d@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: WARNING in iov_iter_revert (2)
Date:   Sun, 21 Feb 2021 14:37:05 +0600
Message-Id: <20210221083705.3075978-1-snovitoll@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAHk-=wgJuiASyuFSBR9GgN2iPSL7Ep7G_GR1kKsGTL=qhDTDUg@mail.gmail.com>
References: <CAHk-=wgJuiASyuFSBR9GgN2iPSL7Ep7G_GR1kKsGTL=qhDTDUg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>    --- a/drivers/tty/tty_io.c
>    +++ b/drivers/tty/tty_io.c
>    @@ -961,6 +961,9 @@ static inline ssize_t do_tty_write(
>                 ret = write(tty, file, tty->write_buf, size);
>                 if (ret <= 0)
>                         break;
>    +            /* ttyprintk historical oddity */
>    +            if (ret > size)
>    +                    break;
> 
>                 /* FIXME! Have Al check this! */
>                 if (ret != size)
> 
> in there. Because right now we clearly do strange and not-so-wonderful
> things if the write routine returns a bigger value than it was
> passed.. Not limited to that iov_iter_revert() thing, but the whole
> loop.
> 
> Comments?

Just want to comment that this fix is correct (tested),
rather than what I did [1] to return abruptly
in the beginning of do_tty_write() for write(fd, NULL, 0) case.

Let me know if I can prepare a patch with Linus's fix above.

[1] https://lore.kernel.org/lkml/20210217155536.2986178-1-snovitoll@gmail.com
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -905,6 +905,9 @@ static inline ssize_t do_tty_write(
 	ssize_t ret, written = 0;
 	unsigned int chunk;
 
+	if (!count)
+		return -EFAULT;
+
 	ret = tty_write_lock(tty, file->f_flags & O_NDELAY);
 	if (ret < 0)
 		return ret;
