Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE268406A96
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 13:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbhIJLQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 07:16:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:32866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232513AbhIJLQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 07:16:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 533D660FE3;
        Fri, 10 Sep 2021 11:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631272515;
        bh=wqZHkOETegfv4rOlmrPi3OSOXK3l/6cS5xQfWfMI/qc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RLeL11IIh08iqK5hbesqBO2B3pd9+OPRcbll/fop+sIVKCO2Msf/vyVyM3h5efOzh
         y0NlPkF5OctYtvSQTz3jTlm77UKvY6YWbQ+KLoYjUCqOgt3JA8UiG3/mhAQDaN6Vwe
         yZPS7JIYWOmOCvAy5Eson2siU+J30iwLiKlxCgPE=
Date:   Fri, 10 Sep 2021 13:15:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andre Muller <andre.muller@web.de>
Cc:     Saravana Kannan <saravanak@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>, kernel-team@android.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: property: Disable fw_devlink DT support for X86
Message-ID: <YTs+QSJ+eCBbS2ew@kroah.com>
References: <20210910011446.3208894-1-saravanak@google.com>
 <YTr4CZW+rOXAjNq9@kroah.com>
 <5064e6ca-344d-7eda-3264-50fb63e2e3f3@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5064e6ca-344d-7eda-3264-50fb63e2e3f3@web.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 12:37:01PM +0200, Andre Muller wrote:
> On 10/09/2021 08.15, Greg Kroah-Hartman wrote:
> > On Thu, Sep 09, 2021 at 06:14:45PM -0700, Saravana Kannan wrote:
> > > Andre reported fw_devlink=on breaking OLPC XO-1.5 [1].
> > > 
> > > OLPC XO-1.5 is an X86 system that uses a mix of ACPI and OF to populate
> > > devices. The root cause seems to be ISA devices not setting their fwnode
> > > field. But trying to figure out how to fix that doesn't seem worth the
> > > trouble because the OLPC devicetree is very sparse/limited and fw_devlink
> > > only adds the links causing this issue. Considering that there aren't many
> > > users of OF in an X86 system, simply fw_devlink DT support for X86.
> > > 
> > > [1] - https://lore.kernel.org/lkml/3c1f2473-92ad-bfc4-258e-a5a08ad73dd0@web.de/
> > > Fixes: ea718c699055 ("Revert "Revert "driver core: Set fw_devlink=on by default""")
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > Cc: Andre Muller <andre.muller@web.de>
> > > ---
> > >   drivers/of/property.c | 3 +++
> > >   1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > > index 0c0dc2e369c0..3fd74bb34819 100644
> > > --- a/drivers/of/property.c
> > > +++ b/drivers/of/property.c
> > > @@ -1444,6 +1444,9 @@ static int of_fwnode_add_links(struct fwnode_handle *fwnode)
> > >   	struct property *p;
> > >   	struct device_node *con_np = to_of_node(fwnode);
> > > 
> > > +	if (IS_ENABLED(CONFIG_X86))
> > > +		return 0;
> > 
> > I love it :)
> > 
> > Anyway, getting a "Tested-by:" would be great to have here.  Andre, can
> > you verify this solves your issue?
> 
> Yes, this patch fixes the issue, the drives work fine.
> Tested-by: Andre Müller <andre.muller@web.de>

Wonderful!

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Or Rob, want me to take this through my tree?

thanks,

greg k-h
