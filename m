Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E478399FEE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 13:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhFCLjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 07:39:13 -0400
Received: from mout01.posteo.de ([185.67.36.65]:44709 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229950AbhFCLjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 07:39:13 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 16F03240027
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 13:37:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1622720245; bh=VK9fcZ01IcuMVfo0nR6TgCfnH/EpeC6PBFr09prL+wo=;
        h=Date:From:To:Cc:Subject:From;
        b=NfpaM2/5AzJ+pUQZPRGmwWglg4v3KQL6Q4v9R3ttshNBMoJiWfAzvt6wyVlnKAEFX
         0ePlClXc52Z2uFPL6/fAl1KaOiHYqoEmZxsbbQc0GsWkfVgMFXCF4VoGM6hbPnd+p7
         8KBwIrSy6q22B8gDcgGiqj3WcJBwLAW2nYDtX7IUJ+rNgbjjnwi61JreAZ6wcLEpj4
         cHMeJ/zOWd02STMVxTk1bmtjdxaQQ3Mdl/0xwyZMFN7lH18va9bD3/k7qWGKuCmXS0
         8ZzS5hBXRM5UKKKy6UL/0dh3JMMmjSCJ+PcrmarGQbHEOeRlHTnpKT6sxjqgWXoa3n
         4vd1y49Sz+hRw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4FwkQX16CMz6tm9;
        Thu,  3 Jun 2021 13:37:23 +0200 (CEST)
Date:   Thu,  3 Jun 2021 11:37:23 +0000
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] hwmon: corsair-psu: fix suspend behavior
Message-ID: <20210603133723.1cf62b93@monster.powergraphx.local>
In-Reply-To: <20210603104156.GA644104@roeck-us.net>
References: <YLhnWiI9mI3l5u/s@monster.powergraphx.local>
        <20210603104156.GA644104@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jun 2021 03:41:56 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> On Thu, Jun 03, 2021 at 05:23:38AM +0000, Wilken Gottwalt wrote:
> > During standby some PSUs turn off the microcontroller. A re-init is
> > required during resume or the microcontroller stays unresponsive.
> > 
> > Fixes: 726c945ab2eb ("hwmon: (corsair-psu) Remove unneeded semicolons")
> 
> That seems wrong. Removing semicolons doesn't typically introduce resume bugs.
> This should fix the patch introducing the driver.

Oh yes, you are right. Wasn't really thinking about it. I will send a proper
patch.

greetings,
Will

> Guenter
> 
> > Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
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
> > -- 
> > 2.31.1
> > 

