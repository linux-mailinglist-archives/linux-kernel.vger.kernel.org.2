Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA8893A59E6
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 19:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbhFMRpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 13:45:43 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:42953 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbhFMRpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 13:45:42 -0400
Received: by mail-ot1-f53.google.com with SMTP id w23-20020a9d5a970000b02903d0ef989477so8560846oth.9;
        Sun, 13 Jun 2021 10:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b1k7TRHF20GQ9+ZiP+urohHT5ori3/TwFMUw8md/cUw=;
        b=OI/uVMgeyrToSFf4lQlsPUXtIRYLcTRwn/8/y6zkiCWzcr073eSmMkLpC1GzOV2xGE
         ixffTw8p0qwS81giz3GhUXOMraIVOEfsg5EQ8GDZaRTSDZVgb8qbw7E6ad8JJ72ArpMh
         3d/YoFp4mOZV+FGbHHqd+LfuHSGRamLG203Gc1axC4OtJ4PvJmQVnfHwH+MYIqcR01KU
         AlB5Dq6g71fdET3PReDv6HknSlY6Ujn+kyMGCKiHoyUEjuSPerkKy8ZvY9dWdxnKH9aQ
         fDQ1ftI5fJuXdhUk7cPzuhBDvb/E9tt+zHgApkta5gKj71PdtZ8b5C3XNP5O9+/o15Ch
         QS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=b1k7TRHF20GQ9+ZiP+urohHT5ori3/TwFMUw8md/cUw=;
        b=bmiudGcDNm/8BD96QXPomIalJqlPmrp/MMScBHZZtC5i1xhBj8wOih15TsR6qfWJiE
         U1SF3vl/MToiGADJ9QcgMKXQhD1c1aUoF8ytTnFwR3lYNlu0JkssKCBURWWDxRnRfkX+
         6YqqlbiOJh/NZ1ML3TWLKY9pOFSGwdinKyRxfdwmyriOWJxLsqn+Cz2dw7EZhOaQqs6o
         hnXWEbxoiRya9Tj50Qy9sb/k0KevSp7si/CrxGxkwvTKbVKX4Y4GKF95xf6eQKkkYRoG
         xsiLBM+dIt+uj2Ub+OBn9ggZtPvxLo66sII0Iqs7ZXOV+LsJSvJLcqq8kZ4RWFJ4lRx+
         amKQ==
X-Gm-Message-State: AOAM531qenNzXHKFuCEDnao9TlVEY/nTLfYv9dOKD7a/tETpRtEL6MIX
        r2wrGCYmrVj+cUJcotu3Tow=
X-Google-Smtp-Source: ABdhPJwbm1lPnINWkb/BOTCBmtuBsGBw1nUxiAS05u5e4Rs4GIzJk51O4PLjrH83hSlKUnr9kJeUuA==
X-Received: by 2002:a05:6830:2157:: with SMTP id r23mr11092364otd.138.1623606160838;
        Sun, 13 Jun 2021 10:42:40 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z5sm1143021oth.6.2021.06.13.10.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 10:42:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 13 Jun 2021 10:42:38 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: corsair-psu: fix suspend behavior
Message-ID: <20210613174238.GA3573626@roeck-us.net>
References: <YLjCJiVtu5zgTabI@monster.powergraphx.local>
 <20210603160533.GA3952041@roeck-us.net>
 <20210604071711.78271072@monster.powergraphx.local>
 <20210604110514.GA1445546@roeck-us.net>
 <20210613160634.52d90cc5@monster.powergraphx.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210613160634.52d90cc5@monster.powergraphx.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 13, 2021 at 02:06:34PM +0000, Wilken Gottwalt wrote:
> On Fri, 4 Jun 2021 04:05:14 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > On Fri, Jun 04, 2021 at 05:17:11AM +0000, Wilken Gottwalt wrote:
> > > On Thu, 3 Jun 2021 09:05:33 -0700
> > > Guenter Roeck <linux@roeck-us.net> wrote:
> > > 
> > > > On Thu, Jun 03, 2021 at 11:51:02AM +0000, Wilken Gottwalt wrote:
> > > > > During standby some PSUs turn off the microcontroller. A re-init is
> > > > > required during resume or the microcontroller stays unresponsive.
> > > > > 
> > > > > Fixes: d115b51e0e56 ("hwmon: add Corsair PSU HID controller driver")
> > > > > Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
> > > > 
> > > > Applied.
> > > 
> > > Thank you. Though I have an odd question. I would like to change the licensing to
> > > a dual license (GPL/MPL) to support the LibreHardwareMonitor project. They want
> > > to use my code but use a MPL license. What would be the best way to do this?
> > 
> > Submit a patch which would need an Acked-by: from everyone who contributed
> > to the driver. As far as I can see, that would be Wan Jiabing
> > <wanjiabing@vivo.com>, Jack Doan <me@jackdoan.com>, and Colin Ian King
> > <colin.king@canonical.com>. I would suggest to ask them first if the license
> > change is ok with them.
> 
> I got the okay from Jack who had the idea for the precision patch. But the other
> two, who did the semicolon and long cast patches do not reply. So what now?
> 

I see two options:
- Publish your original code (not including the semicolon and long cast
  patches) as an out-of-tree driver at github or some other open source
  repository site, with whatever license you want, and ask
  LibreHardwareMonitor pull it from there.
- Submit the driver yourself into LibreHardwareMonitor, again not
  including the problematic changes, with whatever license you want.

Disclaimer: I am not an attorney, and this is not legal advice.

Guenter
