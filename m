Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D16371F65
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 20:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbhECSR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 14:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhECSRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 14:17:22 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22123C061763
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 11:16:27 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 15so8800145ybc.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 11:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Reczk2pU6XhSh3ePtelqj5oU3zOAelzaFV/c9zrpX4=;
        b=cIkaw53UK0YemVAZfbs3QzE9GbAx6wugK130duG3mwqCKuZd9+FVQULFiJWwPnOJgU
         yR04Vq3ecnx7Agi3Onuvt3AFwlBb0AuaYyNrzyArJLdX7Ro3zL6kXixppT4ax+WGgGV9
         g0zgMJcl4/sp9YjWn01+NFwqwwcGSYETpciErUB0R3Ex7I//SqqruNotqNS3nG8nws/h
         IUv/ANW+q7Z5P0cLsQXgzvU3D99N4LP+6YqbVUuujJ5X0WQsPeG8O/MvkoNArP7VffdM
         ymIY1Cu8702BNW3HIDYWXMqfHQiWrWBmWMD168VAos8vwExhaLeK9msjzAkGag23D+WS
         rEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Reczk2pU6XhSh3ePtelqj5oU3zOAelzaFV/c9zrpX4=;
        b=GgU+zOto6tO/gQx7ruonoKjLr9xwVw23HnZ24i/wygVqN0RTCtZKwutRiZwBaP3e9N
         LbKRB9pvDuiIcnaNnepMQwhjv+5Td5tZOyNgnO1zxPRJR1glvn2tE7vmKdhCNg3/5Mkv
         tZ9fpe6ZwGgeaKMgfGs3NAsN9UGVOp9L11uKuMnVNTs1wbm0/jfcFZXVp6fAg1IPiqHX
         JzYAy2fFbKSYi5omSDaiGaLV5KV9sAORbMLHGOSFkmGTu+7fwinFIfPWj2xhlzTM/IDH
         lxRseWEJnaqaKzH+YC6Lt98joOJihYGpZdHCG8JZIdEGP9D8ZHAbV90xQaZSZ6+7ZV3a
         wB/Q==
X-Gm-Message-State: AOAM531Ec/UsFO48KtkBGmLJQXolvgUsMjROPc1qBD38egisMR7IDW2V
        iOzgi3n5oT9QU9E+cMLnltxuaD7XwEyJeK5PW+uYBQ==
X-Google-Smtp-Source: ABdhPJzuTz8PJg7hIT1ZXdEYyj1jty71yGvb5QELrY/GEQav4jx7ika22HA6C+BWi8pstk09tKQip79KKHGfRfbu3ME=
X-Received: by 2002:a25:a107:: with SMTP id z7mr27636496ybh.228.1620065786350;
 Mon, 03 May 2021 11:16:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210426235638.1285530-1-saravanak@google.com>
 <20210503100733.GA8114@wunner.de> <CAGETcx8qPg9NUS6BJLEJCZ-2La32_NPeaMf1GDArcWT6tsf_AQ@mail.gmail.com>
 <20210503175600.GA3864@wunner.de>
In-Reply-To: <20210503175600.GA3864@wunner.de>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 3 May 2021 11:15:50 -0700
Message-ID: <CAGETcx_Z9kjzjTaNUBgKNte8UZcT5HJ5tjkmRmFqddy78Nj9Qw@mail.gmail.com>
Subject: Re: [PATCH] spi: Fix spi device unregister flow
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Android Kernel Team <kernel-team@android.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 3, 2021 at 10:56 AM Lukas Wunner <lukas@wunner.de> wrote:
>
> On Mon, May 03, 2021 at 10:21:59AM -0700, Saravana Kannan wrote:
> > On Mon, May 3, 2021 at 3:07 AM Lukas Wunner <lukas@wunner.de> wrote:
> > > On Mon, Apr 26, 2021 at 04:56:38PM -0700, Saravana Kannan wrote:
> > > > When an SPI device is unregistered, the spi->controller->cleanup() is
> > > > called in the device's release callback. That's wrong for a couple of
> > > > reasons:
> > > >
> > > > 1. spi_dev_put() can be called before spi_add_device() is called. And
> > > >    it's spi_add_device() that calls spi_setup(). This will cause clean()
> > > >    to get called without the spi device ever being setup.
> > >
> > > Well, yes, but it's not a big problem in practice so far:
> > >
> > > I've checked all drivers and there are only four which are affected
> > > by this: spi-mpc512x-psc.c spi-pic32.c spi-s3c64xx.c spi-st-ssc4.c
> > >
> > > They all fiddle with the chipselect GPIO in their ->cleanup hook
> > > and the GPIO may not have been requested yet because that happens
> > > during ->setup.
> > >
> > > All the other drivers merely invoke kzalloc() on ->setup and kfree()
> > > on ->cleanup.  The order doesn't matter in this case because
> > > kfree(NULL) is a no-op.
> >
> > That's making a lot of assumptions about drivers not doing certain
> > things in the future or making assumptions about the hardware (chip
> > select or whatever other configuration that might happen). Totally
> > unnecessary and error prone.
>
> I agree, I'm just not happy with the solution presented.
>
> This could be solved by setting a flag in struct spi_device
> once ->setup has returned successfully.
>
>
> > > > 2. There's no guarantee that the controller's driver would be present by
> > > >    the time the spi device's release function gets called.
> > >
> > > How so?  spi_devices are instantiated on ->probe of the controller
> > > via spi_register_controller() and destroyed on ->remove via
> > > spi_unregister_controller().  I don't see how the controller driver
> > > could ever be unavailable, so this point seems moot.
> >
> > Just because put_device() is called on a struct device doesn't mean
> > it's getting destroyed immediately. The refcount needs to reach zero
> > for ->cleanup() to be called eventually. And there's no guarantee that
> > by the time the ref count hits zero that your controller driver is
> > still around. So, it's not a moot point.
>
> In theory, yes, but concretely, how is that going to happen?
>
> We remove all the things that might be holding a ref on the spi_device
> (such as sysfs entries, child devices), so when device_unregister()
> is called from spi_unregister_device(), the expectation is really that
> that's the last reference being dropped.
>
> In theory it would be possible for some other driver to hold a ref,
> but I don't see why it would be doing that.
>
> Perhaps spidev.c makes it possible to keep an spi_device around even
> though the controller has been removed, simply by keeping the device
> file open from user space.  I'm not sure if that's the case but it's
> probably something worth checking.

We can't rule out all the cases and assume refcount would hit zero
when the framework does put_device() on the spi_device. So I don't
think there's even a point in trying to find if this can happen. But
since you asked, creating device links to this device is just one
example of how this could happen.

>
> > > > Fix these issues by simply moving the cleanup from the device release
> > > > callback to the actual spi_unregister_device() function.
> > >
> > > Unfortunately the fix is wrong, it introduces a new problem:
> > >
> > > > @@ -713,6 +717,8 @@ void spi_unregister_device(struct spi_device *spi)
> > > >       if (!spi)
> > > >               return;
> > > >
> > > > +     spi_cleanup(spi);
> > > > +
> > > >       if (spi->dev.of_node) {
> > > >               of_node_clear_flag(spi->dev.of_node, OF_POPULATED);
> > > >               of_node_put(spi->dev.of_node);
> > >
> > > Now you're running ->cleanup before the SPI slave's driver is unbound.
> >
> > By "slave" device, you mean struct spi_device, right?
>
> Yes.
>
>
> > Sorry if I'm mistaken about my understanding of the SPI framework.
> > Please explain how that's happening here. The main place
> > spi_unregister_device() is getting called from is
> > spi_controller_unregister(). If the controller's child/slave
> > spi_device's aren't unbound by then, you've got bigger problems even
> > without my patch?
>
> Without your patch:
>
> spi_unregister_device()
>   device_unregister()
>     device_del()
>       bus_remove_device()
>         device_release_driver() # access to physical SPI device in ->remove()
>     put_device()
>       kobject_put()
>         kref_put()
>           kobject_release()
>             kobject_cleanup()
>               device_release()
>                 spidev_release()
>                   spi->controller->cleanup() # controller_state freed
>
> With your patch:
>
> spi_unregister_device()
>   spi_cleanup()
>     spi->controller->cleanup() # controller_state freed
>   device_unregister()
>     device_del()
>       bus_remove_device()
>         device_release_driver() # access to physical SPI device in ->remove()
>
> As a case in point, an SPI Ethernet driver I'm familiar with,
> drivers/net/ethernet/micrel/ks8851_common.c, performs various
> register accesses on driver unbind in ks8851_net_stop().
> So on driver unbind, the SPI device still needs to be accessible.
>
> However the controller_state may be necessary to access the device,
> so freeing that before unbind is a no-go.
>
> Let me know if this explanation wasn't sufficient.

Ah, make sense. My bad. I saw the of_node_put() in
spi_unregister_device() and glossed over the rest of the code because
I assumed the of_node_put() wouldn't have been done before the device
was released.

So, it looks like the fix is simple. We just need to move
spi_cleanup() to the bottom of spi_unregister_device(). I'll send a
patch for that rather than reverting this and bringing back the other
bugs.

-Saravana
