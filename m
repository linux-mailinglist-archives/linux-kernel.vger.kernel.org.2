Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC6B031CDEF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 17:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhBPQZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 11:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhBPQZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 11:25:06 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF65C061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 08:24:26 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id e9so5760809plh.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 08:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JT99kJbdPlhIu/0TowIURKsvoVzFDyN/pQVtyCtqv1A=;
        b=mGtOjvRdKBKLndMLC58MjliqHoj61eZp6LR6snXXa2lhUVw5TJJ6NUx3VJ7pvfhCq8
         0GUbZ0dQqLSbl8KAHXkJd1P2I1g8UnSg85+kgYSdEJsLnXZMM3poJt8qE8jd1hirkX5N
         Us7oP5m5er5ImPMXAY6gPK2/00HrbjhXgt8JeiZjRzYzYqDcjk/7HdXpTS+dEwEKZ+5D
         1Orp4ecwCTLm7RUQrXxkyLrtEAjYngOEogWZ7iNmHatsfopLWE1GGcLdd15vcOVrigee
         YslFWrIZz+1p7Mc+rGMIBPnHUMwxtRYyGmkCoEQTsi3TWxQicivOAFqGM1SKNViZCZUa
         RI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JT99kJbdPlhIu/0TowIURKsvoVzFDyN/pQVtyCtqv1A=;
        b=tQgggaVdV7zVMMMVWndOHM9fMm0VNEI55ejnuKm1aOksK1ED+yKccCnnX/gTFe/6ke
         eNykAUbB/uhL9WzGI3vrYIoWjYIn8s8p3jOdmyKCqosIgpQd+1Q1jxjaQ4or99OYLdys
         mko2Mwx97UjssJ6I0Fmu5vqhuzBTsxqFgSqgFs4w/svvQpJ8m5j/OM+T5CxmaYObA7U7
         06jzIpxKb9w2jfuJlNi7teYLY/kmcrl/MnB+m3n7EYVFAcpmsTvVXMxGvmapA6Bt6MHh
         GCUBxFor1mIw5JIZ3TI06MmN2GyoGFqzAvsVG5fno3KM1yKQUt+IGJPpnkxrE0ZqD+sp
         r9mw==
X-Gm-Message-State: AOAM530b8BSzpTh7+Xwtm6bJwMxtNfmBugKsBlVHLa8OcVUY6pYZi6FG
        svc0ZJ5Th1MFyeshOFnf0Kqjk1h2t1JSDKuB
X-Google-Smtp-Source: ABdhPJw9uY5E0tuQjCz2+2HB8BHQeX/rAtdev8nofs6lEJ6ENJkXmcykk3SniQ2JnQpRuyOCEXaNDQ==
X-Received: by 2002:a17:90a:12c5:: with SMTP id b5mr4309128pjg.89.1613492666031;
        Tue, 16 Feb 2021 08:24:26 -0800 (PST)
Received: from nuc10 (104.36.148.139.aurocloud.com. [104.36.148.139])
        by smtp.gmail.com with ESMTPSA id q22sm22111838pgi.66.2021.02.16.08.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 08:24:25 -0800 (PST)
Date:   Tue, 16 Feb 2021 08:24:20 -0800
From:   Rustam Kovhaev <rkovhaev@gmail.com>
To:     Anton Altaparmakov <anton@tuxera.com>
Cc:     "linux-ntfs-dev@lists.sourceforge.net" 
        <linux-ntfs-dev@lists.sourceforge.net>,
        LKML <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] ntfs: move check for valid resident attribute offset and
 length
Message-ID: <YCvxtL5WYeO3ofKW@nuc10>
References: <20210214221247.621431-1-rkovhaev@gmail.com>
 <2727F0B7-4992-4B24-963F-CC3C4D94CFD2@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2727F0B7-4992-4B24-963F-CC3C4D94CFD2@tuxera.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 02:40:37AM +0000, Anton Altaparmakov wrote:
> Hi Rustam,
> 
> Thank you for the patch but it is not quite correct:
> 
> 1) The first delta: yes that is a good idea to add this check but the error message is incorrect.  It should say "Corrupt standard information attribute in inode." instead.
> 
> 2) The second delta: The check of the attribute list attribute needs to remain, i.e. your second delta needs to be deleted.
> 
> Please could you address both of the above comments and then resend?  Please then also add: "Acked-by: Anton Altaparmakov <anton@tuxera.com>" to the patch.
> 
> Thanks a lot in advance!
> 
> Best regards,
> 
> 	Anton
> 
hi Anton, thank you for the review! I'll resend the patch!
