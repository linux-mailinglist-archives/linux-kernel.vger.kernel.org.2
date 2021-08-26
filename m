Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A828F3F8472
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 11:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240950AbhHZJXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 05:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbhHZJX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 05:23:29 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B9DC061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 02:22:42 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id l18so3859242lji.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 02:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6K808PPjkpTkbnbXiY0eI5Jv3rPmmxFhKf+SD20t3Yw=;
        b=jNbx/CXFJ1awFZl7w0ExP7cey9tcu5AznJzGiOYNNLAK43p44dAebQ6A0vjlReUkjO
         TNI1IqL3rSa+b0Vir7td6Footj1xXylICv/fmelssTYfz4QASNDahohRy1iuD8CYmIx5
         +6TWawSxNC4Gdr8N7HOuUESpr9BKnjZaBBqBhscH0VPL92CFF2avXpLDmuMBSCXw112G
         7VXxkEk8+aWh8crWn13n2MYo8sdTtQdwL5uz/qqwiHrwir53wFCaL/rESzCPe6LVnjnM
         yLmzwWlqORX81g7KqbuuK6eYRVlsCqGKlwUO1oAWW8ubr2Smpn/NOPfr1jm8FkSP2qsr
         FTDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6K808PPjkpTkbnbXiY0eI5Jv3rPmmxFhKf+SD20t3Yw=;
        b=YxDAXiXIC6rpK2rqBjRK+RS8KLvaheI+I+0IbV6OoB8BVBkG9zKrf6N7IcsIhpQgxM
         TAsg4KeubwGnUByJyvHNqiLN9nDtfxMkQKR3qVro38z6bjBABVIDRMm7A/8ofX6uKo58
         1hMGQWmnWwM81TTZROzxBrWWbg36Ho0TM2X0cKyrPAkZw0FwH8x7rYhpEukClmvvID2d
         dOuwr4RgftFB6lNL8eh+0sa0UMQRL50veOTIgGzxTwtzkH7hCsPZuvdZUtiV78o4dg5X
         9FVCUYfsyXTRnevuTiiwUskvZy82ysQTB5B8Veiedoc1Pwgicxo/WSuqKuNcdeJpA6Yt
         k7GA==
X-Gm-Message-State: AOAM533Ft7phZ2jxQF8lYmeQeOkJi4IQnNoeRQU6XPyZZT+Dba8ABRT9
        B/eGWmmZb/XCZdC5Xq7XCWOTIxRzgaucvg==
X-Google-Smtp-Source: ABdhPJw5oZHivTTL7qyRo6XSuDvVM9/9//tYX4v4wmnz4hk38RJ/BZo4mw0rSrjRJnuspTmwxBqo+w==
X-Received: by 2002:a2e:a88a:: with SMTP id m10mr2197733ljq.440.1629969760985;
        Thu, 26 Aug 2021 02:22:40 -0700 (PDT)
Received: from localhost.localdomain ([46.61.204.60])
        by smtp.gmail.com with ESMTPSA id z13sm285020ljo.37.2021.08.26.02.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 02:22:40 -0700 (PDT)
Date:   Thu, 26 Aug 2021 12:22:21 +0300
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "phil@philpotter.co.uk" <phil@philpotter.co.uk>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "straube.linux@gmail.com" <straube.linux@gmail.com>,
        "fmdefrancesco@gmail.com" <fmdefrancesco@gmail.com>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 5/6] staging: r8188eu: add error handling of
 rtw_read32
Message-ID: <20210826122221.5d2b0f37@gmail.com>
In-Reply-To: <27f5e52d520b453cbcabb3d72f0f5d15@AcuMS.aculab.com>
References: <cover.1629789580.git.paskripkin@gmail.com>
        <93bf46ce2d0ce12e94672acf28b64dc341fde038.1629789580.git.paskripkin@gmail.com>
        <27f5e52d520b453cbcabb3d72f0f5d15@AcuMS.aculab.com>
X-Mailer: Claws Mail 3.17.8git77 (GTK+ 2.24.33; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Aug 2021 08:51:23 +0000
David Laight <David.Laight@ACULAB.COM> wrote:

> From: Pavel Skripkin <paskripkin@gmail.com>
> > Sent: 24 August 2021 08:28
> > 
> > _rtw_read32 function can fail in case of usb transfer failure. But
> > previous function prototype wasn't designed to return an error to
> > caller. It can cause a lot uninit value bugs all across the driver
> > code, since rtw_read32() returns local stack variable to caller.
> > 
> > Fix it by changing the prototype of this function. Now it returns an
> > int: 0 on success, negative error value on failure and callers
> > should pass the pointer to storage location for register value.
> 
> Pretty horrid API interface.
> Functions like readl() - which can fail just return ~0u and let
> the caller worry about whether that causes serious grief.
> 
> You could make all the read functions return __u64 and return ~0ull
> on error.
> Testing for (value & 1ull << 63) will be reasonable even on 32bit.
> 

I am not the best at API related questions, so can you, please,
explain why your approach is better? 

As I can see, most of the drivers in usb/ directory use smth like this
interface for private reading funcions. We anyway creating tmp variable
(but 64 bit _always_) and checking for mistery error, which we cannot
pass up to callers.

Sorry, if it's _too_ dumb question, but I really can't get your
point....



 

> ...
> > -static u32 usb_read32(struct intf_hdl *pintfhdl, u32 addr)
> > +static int usb_read32(struct intf_hdl *pintfhdl, u32 addr, u32
> > *data) {
> >  	u8 requesttype;
> >  	u16 wvalue;
> >  	u16 len;
> > -	__le32 data;
> > +	int res;
> > +	__le32 tmp;
> > +
> > +	if (WARN_ON(unlikely(!data)))
> > +		return -EINVAL;
> > 
> 
> Kill the NULL check - it is a silly coding error.
> An OOPS is just as easy to debug.
> 


I don't think that one single driver should kill the whole system. It's
100% an error, but kernel can recover from it (for example disconnect
the driver, since it's broken).


AFIAK, Greg and Linus do not like BUG_ONs in recoverable state...
Correct me, if I am wrong




With regards,
Pavel Skripkin


