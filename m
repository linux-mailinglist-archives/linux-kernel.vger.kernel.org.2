Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 835B1443837
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 23:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbhKBWIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 18:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhKBWIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 18:08:43 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04040C061714;
        Tue,  2 Nov 2021 15:06:08 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A356E2D3;
        Tue,  2 Nov 2021 22:06:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A356E2D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1635890767; bh=f4OxnCrCU+use/uDf/rLRiwPVwXVcr8YdVf9LX3I0ok=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Xr+0C9M31zQS9KRBuQlNGLNkQ35QZI2REOkwdRnMDslWxyVkFMIfOY1k+UDjXCWtD
         Lqe/ogHSkyXJCOuiP2r5EagScAzSY6K9JsBhV4RfNcm2p2QyG9kowvKGRCd1oYfQt4
         6Zj/FtFDJaVM1GWn/3HhVU84eb36PnjuO5WNRvGa2/y5TL2emgIUmbkbnUGQv6Tr0W
         KCYl0ath87oIskLEBfBF1GlTGJVDR3dv4i8R6MqfPzXLFbkToMcvV4fum/tqeetY3I
         haA+jEGx7RaQMbgUS7sBENFqbPn5pgiwE+BtraNOeEiZChayNiwF6tP9yIn9RchQeo
         5J7wKoJJCGZcQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     ira.weiny@intel.com
Cc:     Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/3] Documentation/auxiliary_bus: Clarify
 auxiliary_device creation
In-Reply-To: <20211102215317.3676782-2-ira.weiny@intel.com>
References: <20211102215317.3676782-1-ira.weiny@intel.com>
 <20211102215317.3676782-2-ira.weiny@intel.com>
Date:   Tue, 02 Nov 2021 16:06:07 -0600
Message-ID: <87k0hq2oxc.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ira.weiny@intel.com writes:

> From: Ira Weiny <ira.weiny@intel.com>
>
> The documentation for creating an auxiliary device is a 3 step not a 2
> step process.  Specifically the requirements of setting the name, id,
> dev.release, and dev.parent fields was not clear as a precursor to the '2
> step' process documented.
>
> Clarify by declaring this a 3 step process starting with setting the
> fields of struct auxiliary_device correctly.
>
> Also add some sample code and tie the change into the rest of the
> documentation.
>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Looks generally good but ...

>  Documentation/driver-api/auxiliary_bus.rst | 77 +++++++++++++++++-----
>  1 file changed, 59 insertions(+), 18 deletions(-)
>
> diff --git a/Documentation/driver-api/auxiliary_bus.rst b/Documentation/driver-api/auxiliary_bus.rst
> index ef902daf0d68..8b3e795f3691 100644
> --- a/Documentation/driver-api/auxiliary_bus.rst
> +++ b/Documentation/driver-api/auxiliary_bus.rst
> @@ -79,18 +79,6 @@ is given a name that, combined with the registering drivers KBUILD_MODNAME,
>  creates a match_name that is used for driver binding, and an id that combined
>  with the match_name provide a unique name to register with the bus subsystem.
>  
> -Registering an auxiliary_device is a two-step process.  First call
> -auxiliary_device_init(), which checks several aspects of the auxiliary_device
> -struct and performs a device_initialize().  After this step completes, any
> -error state must have a call to auxiliary_device_uninit() in its resolution path.
> -The second step in registering an auxiliary_device is to perform a call to
> -auxiliary_device_add(), which sets the name of the device and add the device to
> -the bus.
> -
> -Unregistering an auxiliary_device is also a two-step process to mirror the
> -register process.  First call auxiliary_device_delete(), then call
> -auxiliary_device_uninit().
> -
>  .. code-block:: c
>  
>  	struct auxiliary_device {
> @@ -99,15 +87,68 @@ auxiliary_device_uninit().
>  		u32 id;
>  	};
>  
> -If two auxiliary_devices both with a match_name "mod.foo" are registered onto
> -the bus, they must have unique id values (e.g. "x" and "y") so that the
> -registered devices names are "mod.foo.x" and "mod.foo.y".  If match_name + id
> -are not unique, then the device_add fails and generates an error message.
> +Registering an auxiliary_device is a three-step process.
> +
> +First, a 'struct auxiliary_device' needs to be defined or allocated for each
> +sub-device desired.  The name, id, dev.release, and dev.parent fields of this
> +structure must be filled in as follows.
> +
> +The 'name' field is to be given a name that is recognized by the auxiliary
> +driver.  If two auxiliary_devices with the same match_name, eg
> +"mod.MY_DEVICE_NAME", are registered onto the bus, they must have unique id
> +values (e.g. "x" and "y") so that the registered devices names are "mod.foo.x"
> +and "mod.foo.y".  If match_name + id are not unique, then the device_add fails
> +and generates an error message.
>  
>  The auxiliary_device.dev.type.release or auxiliary_device.dev.release must be
> -populated with a non-NULL pointer to successfully register the auxiliary_device.
> +populated with a non-NULL pointer to successfully register the
> +auxiliary_device.  This release call is where resources associated with the
> +auxiliary device must be free'ed.  Because once the device is placed on the bus
> +the parent driver can not tell what other code may have a reference to this
> +data.
> +
> +The auxiliary_device.dev.parent should be set.  Typically to the registering
> +drivers device.
> +
> +Second, call auxiliary_device_init(), which checks several aspects of the
> +auxiliary_device struct and performs a device_initialize().  After this step
> +completes, any error state must have a call to auxiliary_device_uninit() in its
> +resolution path.
> +
> +The third and final step in registering an auxiliary_device is to perform a
> +call to auxiliary_device_add(), which sets the name of the device and adds the
> +device to the bus.
> +
> +.. code-block:: c
> +
> +	struct axiliary_device *my_aux_dev = my_aux_dev_alloc(xxx);

This ----------^  would appear to be a typo...

Thanks,

jon
