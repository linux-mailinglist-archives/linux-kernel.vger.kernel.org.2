Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECD731253D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 16:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhBGPYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 10:24:48 -0500
Received: from mail-pj1-f50.google.com ([209.85.216.50]:55093 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhBGPUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 10:20:39 -0500
Received: by mail-pj1-f50.google.com with SMTP id gb24so365406pjb.4
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 07:20:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KcivAwLPb+NPRY/Mz707MC1A947GT+MxLHVC301t2cI=;
        b=DffWmSsyVHFW43AS6gKO64LxmLrxySepSsyoOabldzmZIhwbDY0GhxJ+RRurfnATMb
         qlbw6gITi4qywUvNr8xOTPllA730TYKahMHzBAMwNFlEveVLFJ2kVmHEUNkD2vfKoz/i
         oUIjjJ1UQrCvbnVFU+ZW6hezch863tZpsZQh4M2vZha2uUWls/wRVXUBy1H87P5gkQTC
         fubyUBSJLYliR+P7s45uWGNyZsWWKSlS6g9D2AjNKN1O3pagexRCzMAI7+YKY3XlL0ZH
         +jIBJZUVLWNWNnVR6vALLjCv5/McF1qCfIKDdbk+NHsHJm8NWybxJfqQp8kGij9GLAC7
         Gskw==
X-Gm-Message-State: AOAM530LItHGkt7z0II1KN3yXah55Bz1KGdqPZ9pzFmQP9msLRP+Pmev
        SHjLQ1D3V5U0As25jtazL2W0ozHw97U/GA==
X-Google-Smtp-Source: ABdhPJy9/LC4x8XsvTBrgYemgCwpabFtAg9SQGjdMW1PSjr2WqNDJGQR0Td/y24lYoWPmbuT3avDsQ==
X-Received: by 2002:a17:90a:d101:: with SMTP id l1mr12784356pju.151.1612711191151;
        Sun, 07 Feb 2021 07:19:51 -0800 (PST)
Received: from karthik-strix-linux.karthek.com ([192.140.154.2])
        by smtp.gmail.com with ESMTPSA id v31sm16925857pgl.76.2021.02.07.07.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 07:19:50 -0800 (PST)
Date:   Sun, 7 Feb 2021 20:49:46 +0530
From:   karthek <mail@karthek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: fix block comments alignment
Message-ID: <YCAFEvCySI8u2059@karthik-strix-linux.karthek.com>
References: <YB/2Uvj99+sReckM@karthik-strix-linux.karthek.com>
 <YB/6ZmZwCF3jeEue@kroah.com>
 <YB/9hS2S1oaCmuDq@karthik-strix-linux.karthek.com>
 <YB//EZl0aeLk/y+E@kroah.com>
 <YCADP8ijAYvrsU7F@karthik-strix-linux.karthek.com>
 <YCAEL9Eed6ijeeR+@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCAEL9Eed6ijeeR+@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 07, 2021 at 04:15:59PM +0100, Greg Kroah-Hartman wrote:
> On Sun, Feb 07, 2021 at 08:41:59PM +0530, karthek wrote:
> > On Sun, Feb 07, 2021 at 03:54:09PM +0100, Greg Kroah-Hartman wrote:
> > > On Sun, Feb 07, 2021 at 08:17:33PM +0530, karthek wrote:
> > > 
> > > <snip>
> > > 
> > > For some reason you sent this only to me, which is a bit rude to
> > > everyone else on the mailing list.  I'll be glad to respond if you
> > > resend it to everyone.
> > > 
> > > thanks,
> > > 
> > i> greg k-h
> > 
> > ok anyway
> > 
> > Those both lines(from, signed-off-by) are exactly same, what's problem
> > with them?
> 
> I don't see the context here...
are you real greg or bot?
> 
> Anyway, if you do sign documents with just "karthek" (lowercase and
> all), that's fine, but I do have to ask, right?
I do sign just karthek everywhere(bank,gov docs,etc), thats my legal
signature
> 
> thanks,
> 
> greg k-h
