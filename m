Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE38305C29
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 13:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343500AbhA0Myv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 07:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238055AbhA0Mwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 07:52:32 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AB1C06174A;
        Wed, 27 Jan 2021 04:51:50 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id a20so1200447pjs.1;
        Wed, 27 Jan 2021 04:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AgqQhBKOPlB7DDmVKm31upDgAqlEXZFPIdQm63gX/8E=;
        b=V4St0wI5fQKkXrZ74W0M3bU05pM5Oq4IcZbxR89XfPEjNctU+Jb8U7axZdD1r9xsf4
         DgWYvvzln+j9ov0bZwsq6iCLVM6M2RsmVeTEB/pyDZHq89sNe4n74GNuyRnCV4AUk0KJ
         Cm0aJ6xaSSu6gpNkTHqG35Jv9/5bcWwVx9DboiYqyNDBSWFno4PU+s5BPk10eh4RYg4N
         sbOpeWhqRsXt02lLO7aQ9RDesvFJIRyLsk3R2vlK2QM6nuZb2SaYKo1FqlMxZAxIW+2u
         64GHWw9ZvEm8oFasjVxw6hZzkCjgcP4qe4qFmZT41ob/DrtqjcegYyn9cjn+NWR7pm59
         qENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=AgqQhBKOPlB7DDmVKm31upDgAqlEXZFPIdQm63gX/8E=;
        b=K2JYDdu/H8YafT80caXXLI59PQfkATOCU+HhSDgbESmzPkVbw6FmWt/CZ6pyrwVF3b
         Cw/LXcbDWvus64eNinLAULfbHvXxjrx6jX5Clgp0gA6pGHfuqU82P9vNhqToQz0MUOK9
         Sz1Btk8uwrtgiBSYbFSEBgJDiK6sZIkUgmq36ZkkdIhLSgGjmauEkwmNfxHT13XA2vtu
         b713Wg6sfD5yyZbifKt6NaAtCL94gc245driGwz16oUZwIGiN02tHWumWTFynSIZA3CA
         qm/sio+jhmf+hqRwdk4wEvC6r9/KWfMLXFET46m0UVgKLivSs5f4S9Az5bcyD/0IieGr
         Q0MA==
X-Gm-Message-State: AOAM531VUE72uFs4EcxhxVCT7IBbGTwMOvZ5HB20bjTw0h7evxOPicfb
        qxSJOx/V36VwYTbNwgBUAZc=
X-Google-Smtp-Source: ABdhPJzypEqDO3UkyOMukD6w2/snr04J/NQVEac1wKbepaUY+63ufUOw8R8KUA4FH6cJqBXR1eETug==
X-Received: by 2002:a17:90a:670f:: with SMTP id n15mr5704625pjj.175.1611751910461;
        Wed, 27 Jan 2021 04:51:50 -0800 (PST)
Received: from lenovo ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id me3sm1954459pjb.32.2021.01.27.04.51.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jan 2021 04:51:49 -0800 (PST)
Date:   Wed, 27 Jan 2021 20:51:26 +0800
From:   Orson Zhai <orsonzhai@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Joe Perches <joe@perches.com>,
        Denis Efremov <efremov@linux.com>,
        "David S. Miller" <davem@davemloft.net>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Orson Zhai <orson.zhai@unisoc.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] include: sysfs: Add macro to assign show for RO
 attributes
Message-ID: <20210127125126.GA7813@lenovo>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Joe Perches <joe@perches.com>, Denis Efremov <efremov@linux.com>,
        "David S. Miller" <davem@davemloft.net>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Orson Zhai <orson.zhai@unisoc.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1611721162-29982-1-git-send-email-orsonzhai@gmail.com>
 <YBEbRDOQhczI5/yC@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBEbRDOQhczI5/yC@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 08:50:28AM +0100, Greg Kroah-Hartman wrote:
> On Wed, Jan 27, 2021 at 12:19:22PM +0800, Orson Zhai wrote:
> > In some circumstances, multiple __ATTR_RO attributes need to be assigned
> > with a single show function.
> > 
> > Add this macro to make life easier with simple code.
> > 
> > Signed-off-by: Orson Zhai <orsonzhai@gmail.com>
> > ---
> >  Documentation/filesystems/sysfs.rst | 2 ++
> >  include/linux/sysfs.h               | 5 +++++
> >  2 files changed, 7 insertions(+)
> > 
> > diff --git a/Documentation/filesystems/sysfs.rst b/Documentation/filesystems/sysfs.rst
> > index 004d490..0e2274a 100644
> > --- a/Documentation/filesystems/sysfs.rst
> > +++ b/Documentation/filesystems/sysfs.rst
> > @@ -141,6 +141,8 @@ __ATTR_RO_MODE(name, mode):
> >  	         fore more restrictive RO access currently
> >                   only use case is the EFI System Resource Table
> >                   (see drivers/firmware/efi/esrt.c)
> > +__ATTR_RO_SHOW(name, show):
> > +		 assumes default mode 0444 with specified show.
> >  __ATTR_RW(name):
> >  	         assumes default name_show, name_store and setting
> >                   mode to 0644.
> > diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
> > index 2caa34c..c851592 100644
> > --- a/include/linux/sysfs.h
> > +++ b/include/linux/sysfs.h
> > @@ -117,6 +117,11 @@ struct attribute_group {
> >  	.show	= _name##_show,						\
> >  }
> >  
> > +#define __ATTR_RO_SHOW(_name, _show) {					\
> > +	.attr	= { .name = __stringify(_name), .mode = 0444 },		\
> > +	.show	= _show,						\
> > +}
> 
> Do you have a real user for this?  Using "raw" kobject attributes is

Yes, I have found at least one user in current kernel code.

Please refer to [1].

The author implemented a similar marcro __ATRR_MRO as mine, plus an
__ATRR_MWO with specified restore.

If this patch merged, I'd to replace his marcro with mine.

> rare and should not be used often, so who needs this?

Agree. But for some device drivers it might be useful without side effect.

Another example is from Android increment-fs code out there.
That driver has 3 sysfs attributes which shared with same show function
which only prints "support" to userland.

Best Regards,
Orson

> 
> thanks,
> 
> greg k-h

[1] https://elixir.bootlin.com/linux/v5.11-rc5/source/drivers/media/pci/ddbridge/ddbridge-core.c#L2735
