Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7912C39B78E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 13:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhFDLIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 07:08:15 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]:46738 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbhFDLIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 07:08:14 -0400
Received: by mail-qt1-f172.google.com with SMTP id m13so6618865qtk.13;
        Fri, 04 Jun 2021 04:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=31BYKdbJxrPdqEtOr42QXo/HKbEy/sWpfzrsrC3WpUM=;
        b=UiiGflEP1HrffqGwWBGwrJ8RxSAKt/rvG/RgDm+S7toN/hj5iXMSPbxFn0aLpOGiZN
         7cKUVN6vxPXIVRUF2RiTnok1A3AWsrvPLxTWOJDG12FwJdzI6o5bcbEiFl64999bZ2BZ
         aSjwa2Zmx5vbcWbwyG2lvMh7bG3pteaEzlT9/OgEinDnnEVELtkJgp8EL9Di61Me4OwG
         w26El0LZVue8SorIkmuTtEeZWGRZ6g9LTfaaRiJb1AkKF0LCR5FVsOM8bX/7qdQXRsRs
         Mf4s1OWMEMzgiDiaSGiadEH2Tu614+1OwMVPaC3sPqkCxciHlw14DnmvDI7E0DNebff2
         D+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=31BYKdbJxrPdqEtOr42QXo/HKbEy/sWpfzrsrC3WpUM=;
        b=NWQgqCtiHDfEu1EFUoZSPZ4pX9iExL2SgLwKbtsLylYXQmcLUyuA8uvNcUnyBM36o2
         xvGK8WvdIClfVP72HNTV0GIQpoUkWIeeGUi4tu1Q16IPlCAOBfRkLxaTGlTgBWP35oun
         bDErmtf+IE6/4mx9VUVMw4xAWQCwi+kXWfJNvjkJEZn1Vae0Z4332VrCWb3ppFjDWRaS
         aQ2m0fhc37GFyhqzSYAcIW4zSUbhZ62gBz5URg+ETuS9PK6i8G7QkT9hDiMUqC/hdJxg
         ugcP5Vts2vaKfYTgwRKlIxTJSON9Hbfui9zpgvhYAyYw7eY234J1iHOPUWyI+rtnBbY7
         AnzA==
X-Gm-Message-State: AOAM532dgjFcRZ0qSAk9rQp1K/lT0MmXgvVk6/sEZzUIjKpppLtoxowI
        GIgn9unyttims1QUqNbCY/0=
X-Google-Smtp-Source: ABdhPJyjpj664lRiztRMQzmPYK+WmIIgcjTf3eXby5++q50z3CV7vpXYA58cpuGEZbjor+LeUWd+TA==
X-Received: by 2002:ac8:6a15:: with SMTP id t21mr4042882qtr.301.1622804716917;
        Fri, 04 Jun 2021 04:05:16 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l7sm3654786qki.135.2021.06.04.04.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 04:05:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 4 Jun 2021 04:05:14 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: corsair-psu: fix suspend behavior
Message-ID: <20210604110514.GA1445546@roeck-us.net>
References: <YLjCJiVtu5zgTabI@monster.powergraphx.local>
 <20210603160533.GA3952041@roeck-us.net>
 <20210604071711.78271072@monster.powergraphx.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604071711.78271072@monster.powergraphx.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 05:17:11AM +0000, Wilken Gottwalt wrote:
> On Thu, 3 Jun 2021 09:05:33 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > On Thu, Jun 03, 2021 at 11:51:02AM +0000, Wilken Gottwalt wrote:
> > > During standby some PSUs turn off the microcontroller. A re-init is
> > > required during resume or the microcontroller stays unresponsive.
> > > 
> > > Fixes: d115b51e0e56 ("hwmon: add Corsair PSU HID controller driver")
> > > Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
> > 
> > Applied.
> 
> Thank you. Though I have an odd question. I would like to change the licensing to
> a dual license (GPL/MPL) to support the LibreHardwareMonitor project. They want
> to use my code but use a MPL license. What would be the best way to do this?

Submit a patch which would need an Acked-by: from everyone who contributed
to the driver. As far as I can see, that would be Wan Jiabing
<wanjiabing@vivo.com>, Jack Doan <me@jackdoan.com>, and Colin Ian King
<colin.king@canonical.com>. I would suggest to ask them first if the license
change is ok with them.

Guenter

> 
> greetings,
> Will
> 
> > Thanks,
> > Guenter
> > 
> > > ---
> > > Changes in v2:
> > >   - corrected fixes commit
> > > ---
> > >  drivers/hwmon/corsair-psu.c | 14 ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > > 
> > > diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
> > > index 02298b86b57b..731d5117f9f1 100644
> > > --- a/drivers/hwmon/corsair-psu.c
> > > +++ b/drivers/hwmon/corsair-psu.c
> > > @@ -771,6 +771,16 @@ static int corsairpsu_raw_event(struct hid_device *hdev, struct hid_report
> > > *repo return 0;
> > >  }
> > >  
> > > +#ifdef CONFIG_PM
> > > +static int corsairpsu_resume(struct hid_device *hdev)
> > > +{
> > > +	struct corsairpsu_data *priv = hid_get_drvdata(hdev);
> > > +
> > > +	/* some PSUs turn off the microcontroller during standby, so a reinit is required */
> > > +	return corsairpsu_init(priv);
> > > +}
> > > +#endif
> > > +
> > >  static const struct hid_device_id corsairpsu_idtable[] = {
> > >  	{ HID_USB_DEVICE(0x1b1c, 0x1c03) }, /* Corsair HX550i */
> > >  	{ HID_USB_DEVICE(0x1b1c, 0x1c04) }, /* Corsair HX650i */
> > > @@ -793,6 +803,10 @@ static struct hid_driver corsairpsu_driver = {
> > >  	.probe		= corsairpsu_probe,
> > >  	.remove		= corsairpsu_remove,
> > >  	.raw_event	= corsairpsu_raw_event,
> > > +#ifdef CONFIG_PM
> > > +	.resume		= corsairpsu_resume,
> > > +	.reset_resume	= corsairpsu_resume,
> > > +#endif
> > >  };
> > >  module_hid_driver(corsairpsu_driver);
> > >  
> 
