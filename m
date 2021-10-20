Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C84744354E3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 23:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhJTVEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 17:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbhJTVEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 17:04:32 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64272C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 14:02:16 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id r2so23610257pgl.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 14:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aEJ4aClzzu5M+yXLNrCl94comgnOtbH7g1x4aaTR2/c=;
        b=GikTc+5IV3eD51X5uI3yzoZYmKC7Yr4vKdZ8qjxkUY583xnRiFULZuVXqgMwYtozXx
         l0FPaxlD8F+TzqockpUYUWpMmEQo3U9W6kw3lbKMqNLyxxfqhSWuA9GCoBeAqkVP02jD
         j5n27xv7ljZTpnFM+m24txDgSGIisdFK/lbVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aEJ4aClzzu5M+yXLNrCl94comgnOtbH7g1x4aaTR2/c=;
        b=6gfA4a+ApdT5jqNxUtBEg+Gw9SXNLxWtD9LmCPL16WGTzB+SHavWroynztX6wwyBIc
         GqYizto8WuZTqfJxJgDcHM7F+PWpRv7cHLSvqg52psI3Q4mI86Aj4raL98zYNsd2iiwT
         tpYdZp+h8yijjvxn/U5twPj+LP8SPqZOHg8Yy7M+Yyr60Mu8vr6xM4z/lleQztZlcQD/
         0NsohhqTgHH5EYzKV1b1MKXRzDNGSUZSwXKY1UQc2m2YhbVPJREMP6jTt8aMDCeknL9r
         1UwL3BqxA1vJgf9m3ej0uF7XdxO4Bw9ptZt3KUcyYMznMnow1OJMVVBA3AtlEqQbxfUx
         WuhQ==
X-Gm-Message-State: AOAM5326ozIIG5NsZ7d6ZfHBYv+nBI6cPCWbGNdBysaf+H9MP0jRp8Sm
        AHaqyK6Lt8A7Oc/0UoO0p8NuIw==
X-Google-Smtp-Source: ABdhPJz2CgbXheR9DbGF3q23WRYHZCtYywJXpdmuXkB5TBHsWGRJt2taiEpwvmG0a/on2vqLgOQXpQ==
X-Received: by 2002:a63:7119:: with SMTP id m25mr1185739pgc.253.1634763735988;
        Wed, 20 Oct 2021 14:02:15 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:d5fe:85e9:caf2:ec4e])
        by smtp.gmail.com with UTF8SMTPSA id p25sm4319527pfh.86.2021.10.20.14.01.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 14:01:54 -0700 (PDT)
Date:   Wed, 20 Oct 2021 14:01:21 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
        Peter Chen <peter.chen@kernel.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Bastien Nocera <hadess@hadess.net>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Douglas Anderson <dianders@chromium.org>,
        Roger Quadros <rogerq@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v16 6/7] usb: host: xhci-plat: Create platform device for
 onboard hubs in probe()
Message-ID: <YXCDobJSuytwthoA@google.com>
References: <20210813195228.2003500-1-mka@chromium.org>
 <20210813125146.v16.6.I7a3a7d9d2126c34079b1cab87aa0b2ec3030f9b7@changeid>
 <dfac0025-b693-2431-04c8-1dba7ef32141@linux.intel.com>
 <YXB7vIP6ifQS3T4o@google.com>
 <20211020203720.GA1137200@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211020203720.GA1137200@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 04:37:20PM -0400, Alan Stern wrote:
> On Wed, Oct 20, 2021 at 01:27:40PM -0700, Matthias Kaehlcke wrote:
> > Hi Mathias,
> > 
> > On Wed, Oct 20, 2021 at 04:05:37PM +0300, Mathias Nyman wrote:
> > > If separate devices for controlling onboard hub power is the right solution then
> > > how about creating the onboard hub device in usb_add_hcd() (hcd.c), and
> > > store it in struct usb_hcd.
> > > 
> > > A bit like how the roothub device is created, or PHYs are tuned.
> > 
> > Sure, that sounds feasible, even better if it's handled in a single place
> > and different types of controllers don't have to add support separately.
> 
> Bear in mind that this would prevent you from working with onboard
> non-root hubs.

My goal is to (architecturally) support nested hubs, but TBH I haven't
looked much into such a configuration since I don't have hardware for
testing. My assumption was that support for onboard hubs connected to
non-root hubs whould have to be added to the generic hub driver.

Could you elaborate in how far you think it would be different for
xhci_plat vs generic hcd?
