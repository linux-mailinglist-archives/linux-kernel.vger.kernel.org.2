Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D44730C514
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 17:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236030AbhBBQMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 11:12:07 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:38549 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236077AbhBBQJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 11:09:32 -0500
Received: by mail-oi1-f180.google.com with SMTP id h6so23284636oie.5;
        Tue, 02 Feb 2021 08:09:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7PQG9RXohKjGhW43A7xg3RzujYsI/E/4b2SuZLXEZ6I=;
        b=d59NYYJ9DQjYeSai5F85JAf5cx8gcdqCWfoa8qBR1uvI5DgYqn/VDYxW402k15ACaA
         Ocmi7PukCtau6TJsJ/X+xgPv/oR37ao0reCfdSmywyp3MbDNwINjgutDIoWosVeJYfIk
         j1keuvz2keGAUEoLXHABNbfFxCGzEPqE9tLV4J+jecWQA+uhoW9/TpjuPm24eWP9XgYn
         x2S+cbb/GKsoB24VY8N2RrUcEEHhlzT7rTbGM5C5RFz5TRZtrSvuz/V/V1g6PMKfmTRo
         yHMEAa4yeQJlaRc+sqyzyRqGe0ZJcj7nsbd9GZWg1jR83l+viK5siKj7wEq6DGNlCmMk
         HKHw==
X-Gm-Message-State: AOAM531ssFDbHeTeVPp/bISN+hDTcnjHEgYtMZt0prGBywgBg2A4kmlu
        xKbw/p1GoZwsYzB7ZyePqGbT38AqruE24EaNxag=
X-Google-Smtp-Source: ABdhPJxPoQ82zmpLYTTPWXui4Jn5z0yBniLWotpEdWfv3jV6Oj3XJPigMDWtQ5fYbzGY4WDPugXFkAWX2in98Z72e+8=
X-Received: by 2002:aca:308a:: with SMTP id w132mr3059387oiw.69.1612282131472;
 Tue, 02 Feb 2021 08:08:51 -0800 (PST)
MIME-Version: 1.0
References: <20210202125032.64982-1-heikki.krogerus@linux.intel.com>
 <20210202125032.64982-2-heikki.krogerus@linux.intel.com> <CAJZ5v0gMEBV=Gm-R=5zkN-J_p7cMTBwoOJrv=ec1j6SfSYRg_w@mail.gmail.com>
 <20210202150102.GA1687065@kuha.fi.intel.com>
In-Reply-To: <20210202150102.GA1687065@kuha.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 2 Feb 2021 17:08:40 +0100
Message-ID: <CAJZ5v0hVZBhqzLPGPHDZYPcYyJPfwgYwjzKGYaUMZOBw7Eh7CQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] software node: Provide replacement for device_add_properties()
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 2, 2021 at 4:01 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On Tue, Feb 02, 2021 at 03:44:05PM +0100, Rafael J. Wysocki wrote:
> > > +/**
> > > + * device_create_managed_software_node - Create a software node for a device
> > > + * @dev: The device the software node is assigned to.
> > > + * @properties: Device properties for the software node.
> > > + * @parent: Parent of the software node.
> > > + *
> > > + * Creates a software node as a managed resource for @dev, which means the
> > > + * lifetime of the newly created software node is tied to the lifetime of @dev.
> > > + * Software nodes created with this function should not be reused or shared
> > > + * because of that. The function takes a deep copy of @properties for the
> > > + * software node.
> > > + *
> > > + * Since the new software node is assigned directly to @dev, and since it should
> > > + * not be shared, it is not returned to the caller. The function returns 0 on
> > > + * success, and errno in case of an error.
> > > + */
> > > +int device_create_managed_software_node(struct device *dev,
> > > +                                       const struct property_entry *properties,
> > > +                                       const struct software_node *parent)
> > > +{
> > > +       struct fwnode_handle *p = software_node_fwnode(parent);
> > > +       struct fwnode_handle *fwnode;
> > > +
> > > +       if (parent && !p)
> > > +               return -EINVAL;
> > > +
> > > +       fwnode = fwnode_create_software_node(properties, p);
>                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> To answer your question below: here.
>
> > > +       if (IS_ERR(fwnode))
> > > +               return PTR_ERR(fwnode);
> > > +
> > > +       to_swnode(fwnode)->managed = true;
> > > +       set_secondary_fwnode(dev, fwnode);
> > > +
> > > +       return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(device_create_managed_software_node);
> > > +
> > >  int software_node_notify(struct device *dev, unsigned long action)
> > >  {
> > >         struct swnode *swnode;
> > > @@ -1073,6 +1111,11 @@ int software_node_notify(struct device *dev, unsigned long action)
> > >                 sysfs_remove_link(&swnode->kobj, dev_name(dev));
> > >                 sysfs_remove_link(&dev->kobj, "software_node");
> > >                 kobject_put(&swnode->kobj);
> > > +
> > > +               if (swnode->managed) {
> > > +                       set_secondary_fwnode(dev, NULL);
> > > +                       kobject_put(&swnode->kobj);
> >
> > Where does the corresponding kobject_get() get called?
>
> So in function fwnode_create_software_node() we use
> kobject_init_and_add().

OK

It looks like there is a use case that cannot be addressed by using
device_add_properties() and that's why you need this new function.

Can you describe that use case, please, and explain what the problem
with using device_add_properties() in it is?
