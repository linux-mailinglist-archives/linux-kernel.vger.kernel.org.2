Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48D234BBBB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 10:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbhC1IuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 04:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhC1Ito (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 04:49:44 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BD1C061762
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 01:49:43 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 12so3544028lfq.13
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 01:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ztGmBqotixPRZflx2J/booXl45uDsbsceMPBD6M+nqY=;
        b=f+nF2uWGye8i7l0T+NvpVMQqvplMo+nGFzn7Fegc9rtkxmWAREuTNbiSwgizH+7SGg
         4KHOWONNdiiDg8WG2oieV9lZyEaGuFH1MWCwx1JFOIi7QMoYNdJYwkRQpewrT31fHapz
         IuQPORt9xqjM9fPo/OhYNRzN2w/nJtdFfuY3ezcnt57KYTXipynqwHlvEtiacl1SI4AD
         dv/GkDshuLYsCQkoX4CSimmeBPDQ5HlTozzWCQ4SEsfk9+nkiSAFYjCj2sXnOTau/ZEW
         hlqNBR9F8tF00zE0GILmfjL6hCAjl8g8uN4vfFpNTkm+8i8e/xk/M1ej7caosBKA9gE1
         lEiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ztGmBqotixPRZflx2J/booXl45uDsbsceMPBD6M+nqY=;
        b=VE++kAzzMoqcb6tCvXffz1HH9qvalECESNH8w4TwVqxV7c9F9+Q2mTyOboHjDpf8IW
         dXQRi69mbE10CDciIGcvJ7h35Hr6TqfaGWE4WYJEVqySrIWAihvmRBHIHYiCiuKuDHU9
         32cXtw27+3KfMGDz4/58xM1nBoxjZmhdy8LYeTBs7Re8ATEPpCNtMZ+VkdkVuPCnqxrt
         rPRzKX2LqyBxI0A4tu1H7KUkIGWJBHdasiI8OUVJU2RJvexTS3ZUOJNF7rAwTBKVlp/g
         uHLZZwmqjt652DOhgSfHWQPdSGsTqaoPPG2v1rCL8IsIQoOkam+U2Qp2X7KS4M+p2/Zt
         r7eA==
X-Gm-Message-State: AOAM5334X20Qm26q2dQ8dsN+g872hygwtDRr5PAzcR1T1ywWZvMRpHhy
        RuQrfI1nPhWu7cUSEmkdIB69OCHpZIiVbPyRIrQ=
X-Google-Smtp-Source: ABdhPJzz2EgsI5GXhM7PmRSYcVT13Gkx0T1qdXZuRoZfvaGGBSLJpUzn3wZderxg5E/yxyU6bzlbvw==
X-Received: by 2002:ac2:5ed0:: with SMTP id d16mr12831714lfq.569.1616921381657;
        Sun, 28 Mar 2021 01:49:41 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.227.42])
        by smtp.gmail.com with ESMTPSA id h28sm1415616lfv.26.2021.03.28.01.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 01:49:41 -0700 (PDT)
Message-ID: <385f9b15d528a678333b4d008a8dbacc513f2408.camel@gmail.com>
Subject: Re: [PATCH] tty: fix memory leak in vc_deallocate
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        syzbot+bcc922b19ccc64240b42@syzkaller.appspotmail.com
Date:   Sun, 28 Mar 2021 11:49:40 +0300
In-Reply-To: <YGBCKBtrirh5GmVP@kroah.com>
References: <20210327214443.21548-1-paskripkin@gmail.com>
         <YGBCKBtrirh5GmVP@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
On Sun, 2021-03-28 at 10:45 +0200, Greg KH wrote:
> On Sun, Mar 28, 2021 at 12:44:43AM +0300, Pavel Skripkin wrote:
> > syzbot reported memory leak in tty/vt.
> > The problem was in VT_DISALLOCATE ioctl cmd.
> > After allocating unimap with PIO_UNIMAP it wasn't
> > freed via VT_DISALLOCATE, but vc_cons[currcons].d was
> > zeroed.
> > 
> > Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> > Reported-by: syzbot+bcc922b19ccc64240b42@syzkaller.appspotmail.com
> > ---
> >  drivers/tty/vt/vt.c | 1 +
> >  1 file changed, 1 insertion(+)
> 
> Is this patch tested by syzbot to fix the problem?
> 
Yeah, it's tested.
https://syzkaller.appspot.com/bug?id=083cb8bd8468537151a57339ae72d505bb5bded0
> thanks,
> 
> greg k-h

-- 
With regards,
Pavel Skripkin


