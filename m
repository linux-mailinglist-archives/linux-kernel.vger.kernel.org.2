Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAE239B1E1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 07:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhFDFTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 01:19:01 -0400
Received: from mout01.posteo.de ([185.67.36.65]:34565 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229800AbhFDFTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 01:19:00 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 71AEE240027
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 07:17:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1622783833; bh=3cQbfQYwjrES5LvXEXh7AoPjA40u751RgjxAkq98j8c=;
        h=Date:From:To:Cc:Subject:From;
        b=m6KiiR/bm4hhK1bsVH+hHyAl3WdFRr+tlxLR565cW8ozB+9d8E3BKREXVSQ7TueaS
         YmboNjA1JSSzLpl+7bfJIGCKD9epZMObzHVsPS0Y9ZiwhMvBvDfUPNI6BFH+Qczhwj
         p2O/SC4u55BurYZwGlZ/bwCVhUOmLCJYUekWymua+1ehPe/BycFKTLP1bJukop6LuX
         PSlasIEwAZIoAMlaiFXa/hwBj8zFVkJBVF5di+noJg6YqKxcZzY1lc4h89qYaodP8K
         Oa2xaFJ56wf0ZqE2+1Gge+A7Tahmkxw6fIGvnd1p76GiaWTXEgk/U64a2GjcFSe1pt
         Lp3BTvbrkjLxA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Fx9xN6D0Bz6tm9;
        Fri,  4 Jun 2021 07:17:12 +0200 (CEST)
Date:   Fri,  4 Jun 2021 05:17:11 +0000
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: corsair-psu: fix suspend behavior
Message-ID: <20210604071711.78271072@monster.powergraphx.local>
In-Reply-To: <20210603160533.GA3952041@roeck-us.net>
References: <YLjCJiVtu5zgTabI@monster.powergraphx.local>
        <20210603160533.GA3952041@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jun 2021 09:05:33 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> On Thu, Jun 03, 2021 at 11:51:02AM +0000, Wilken Gottwalt wrote:
> > During standby some PSUs turn off the microcontroller. A re-init is
> > required during resume or the microcontroller stays unresponsive.
> > 
> > Fixes: d115b51e0e56 ("hwmon: add Corsair PSU HID controller driver")
> > Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
> 
> Applied.

Thank you. Though I have an odd question. I would like to change the licensing to
a dual license (GPL/MPL) to support the LibreHardwareMonitor project. They want
to use my code but use a MPL license. What would be the best way to do this?

greetings,
Will

> Thanks,
> Guenter
> 
> > ---
> > Changes in v2:
> >   - corrected fixes commit
> > ---
> >  drivers/hwmon/corsair-psu.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
> > index 02298b86b57b..731d5117f9f1 100644
> > --- a/drivers/hwmon/corsair-psu.c
> > +++ b/drivers/hwmon/corsair-psu.c
> > @@ -771,6 +771,16 @@ static int corsairpsu_raw_event(struct hid_device *hdev, struct hid_report
> > *repo return 0;
> >  }
> >  
> > +#ifdef CONFIG_PM
> > +static int corsairpsu_resume(struct hid_device *hdev)
> > +{
> > +	struct corsairpsu_data *priv = hid_get_drvdata(hdev);
> > +
> > +	/* some PSUs turn off the microcontroller during standby, so a reinit is required */
> > +	return corsairpsu_init(priv);
> > +}
> > +#endif
> > +
> >  static const struct hid_device_id corsairpsu_idtable[] = {
> >  	{ HID_USB_DEVICE(0x1b1c, 0x1c03) }, /* Corsair HX550i */
> >  	{ HID_USB_DEVICE(0x1b1c, 0x1c04) }, /* Corsair HX650i */
> > @@ -793,6 +803,10 @@ static struct hid_driver corsairpsu_driver = {
> >  	.probe		= corsairpsu_probe,
> >  	.remove		= corsairpsu_remove,
> >  	.raw_event	= corsairpsu_raw_event,
> > +#ifdef CONFIG_PM
> > +	.resume		= corsairpsu_resume,
> > +	.reset_resume	= corsairpsu_resume,
> > +#endif
> >  };
> >  module_hid_driver(corsairpsu_driver);
> >  

