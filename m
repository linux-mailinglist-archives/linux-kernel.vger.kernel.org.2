Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4EF631F92E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 13:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhBSMN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 07:13:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbhBSMNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 07:13:20 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4200FC061756
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 04:12:40 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id k22so3260384pll.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 04:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fr73k0oFNcOMq5EUpeQYfmWohZLzAZP/+I818Q2oXuY=;
        b=kbRqUBNjEh6WC4dMLAAMumlsH02hDzKSgaicJoO3BeUC1yL5Wuk9VNVh0ZCs0bIeJu
         fC3gb1qW3dMb8zF20fAgDn/O7tYQHfiU26QLvf11TiaIoehOFHLqSS5CLLZNsvgEnpz3
         uwbFspDdkfiws7cDA2/aV2Y+tzAe2qwmfQNLEH0ILgjHe4aesc/hZ5LDU555BoCht1hn
         rUWzICGzdc5PvRaCLrGigFvhOYreenaWiBk7lvlzYyQ31ZSV7GODRM8m9ZKGBoyx58cI
         L0aBuJ4VXEUQwZgopv+mVNUgBiPEB3heR9RTve/5wR5hDpUlXGRd2oxhn/Hh4yGN7UZE
         TyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fr73k0oFNcOMq5EUpeQYfmWohZLzAZP/+I818Q2oXuY=;
        b=UccMxTYty53fA+ZXfak+8CgkPeytHCqGdf+4oWtYJOcQVyrb8+yAtaKa05Na3Znh42
         Ll8l4CREo+9hFMMilMhKvB3liHSbqSNKg1Zca9hm/EkoPdsMnuJX6WYJEquk9VtpUnZO
         yUiBXV0fc5ljxbkguH9qqiVfGWp4q2HQ7QrCQ+eZxcSVbxsg8aamEVqNxSkYOBeQKdk0
         JeeFovUO/j3V3DoE/pz2mt1Hd8aymVjJbUgCxCCgjFJX2TKFU+jtQfDiQDUOPl1YwVG8
         9ySAqPDmo1Fcm/B2oO28xkf8afhKPtxt30bx8BAbkY+yFNhSjd47h4B95ZcEDYDKTCJg
         gc+A==
X-Gm-Message-State: AOAM533GinsR3CKmIOebHj9jNSUek5Lce0ICwcYdGKGSZkJG21YJ5YER
        T4wscm6uONZWo0XMviDmnmE=
X-Google-Smtp-Source: ABdhPJxL4SZltxfc5BhDYGRd70PqUkr0oHOaHi8XUXUffDyYYhA+8Nn0boYhejfQNmZ/4Z6nb2SA5g==
X-Received: by 2002:a17:90a:1a0b:: with SMTP id 11mr8708576pjk.58.1613736759769;
        Fri, 19 Feb 2021 04:12:39 -0800 (PST)
Received: from gmail.com ([2401:4900:3847:831e:690e:964b:81e9:e810])
        by smtp.gmail.com with ESMTPSA id c29sm2608427pgb.58.2021.02.19.04.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 04:12:39 -0800 (PST)
Date:   Fri, 19 Feb 2021 17:42:33 +0530
From:   Prakash Dubey <prakashdubey1999@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fwserial: Fix alignment of function parameters
Message-ID: <20210219121233.GA16568@gmail.com>
References: <20210218102851.GA20810@gmail.com>
 <YC9zNVWX7R9kD0Rq@kroah.com>
 <CALVjNJP=iXH+u2zUB93UZo+1+Ly0g23k5JtPXFbx=vaO+5-0Gw@mail.gmail.com>
 <YC+VX4NpOWX1z3+V@kroah.com>
 <20210219115221.GW2087@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219115221.GW2087@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 02:52:21PM +0300, Dan Carpenter wrote:
> On Fri, Feb 19, 2021 at 11:39:27AM +0100, Greg KH wrote:
> > On Fri, Feb 19, 2021 at 03:25:38PM +0530, 17UCS047_Prakash Dubey wrote:
> > > I was unable to align it right below the opening parenthesis, just by using
> > > tabs. And when I did that with spaces, the checkpatch yelled at me for
> > > using spaces. Any suggestions how to do this without using spaces? I am
> > > using vim, I will try to find a workaround meanwhile.
> > 
> 
> Your comment hasn't made it to the list yet.  Sometimes there is a delay
> or maybe it was blocked for some reason (html email?).
> 
> You are allowed to use spaces but you can't have 8 consecutive spaces
> and spaces are not allowed before a tab character.  The way to align it
> is:
> 
> 		ret = wait_event_interruptible_timeout(port->wait_tx,
> 						       !test_bit(IN_TX, &port->flags),
> 						       10);
> 
> [tab x6][space x7]!test_bit(IN_TX, &port->flags)
> 
> regards,
> dan carpenter

Thank you Dan, I figured that out after a few failed attempts to align properly. 

I was replying through Gmail web client, as I am new to mutt. I am getting the hang of it.

-- 
Regards,
Prakash
