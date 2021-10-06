Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADA842353B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 02:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236953AbhJFAnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 20:43:24 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:51138 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234027AbhJFAnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 20:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=fWCUHyISCTCbKil27s1A/LIjDfVPLiq7C06yAw+SbzM=; b=AEZk+ri5lO1h5vrLb7HEoHJLjI
        RIlm+msrgZT1uAXsJ8I6LoUvaKsMC2D6CzB6OB0xRXRCnFYn32RMgS/waKBdvH+XdWgo+is90ryMJ
        WaTPJU2Gjmgml+bEhOkMPxEjjYhtNJpAaqKh5rbuodKyd1KXVm+tVKfu0jOpamzTUFDc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1mXuzj-009lfN-NO; Wed, 06 Oct 2021 02:41:15 +0200
Date:   Wed, 6 Oct 2021 02:41:15 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Rajat Jain <rajatxjain@gmail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Dmitry Torokhov <dtor@google.com>,
        Rajat Jain <rajatja@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        levinale@google.com, bleung@google.com, jsbarnes@google.com,
        pmalani@google.com
Subject: Re: [PATCH 2/2] usb: hub: Mark devices downstream a removable hub,
 as removable
Message-ID: <YVzwq0bFKvKyO1TN@lunn.ch>
References: <20210929224823.556943-1-rajatja@google.com>
 <20210929224823.556943-2-rajatja@google.com>
 <YVVLxi/on9x6nfCZ@kroah.com>
 <CACK8Z6EamamgYExt629gyNrYKpvnu2Gh0eGOOvOa5LH-jnOmaQ@mail.gmail.com>
 <20211005145655.GJ621017@rowland.harvard.edu>
 <CAE_wzQ-XG3YBtKTmbn1LSGETCUg5AYjTmcnwOnc1h57OaL9+Cw@mail.gmail.com>
 <20211005195929.GA634685@rowland.harvard.edu>
 <CAA93t1qzJuN8M2zbs+Kt9JXWP1H2kjKSxBp8-TXEfaMeZ1iggQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA93t1qzJuN8M2zbs+Kt9JXWP1H2kjKSxBp8-TXEfaMeZ1iggQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> AFAIK, the primary reason / use of this attribute was to distinguish
> devices that can be removed by the user, and really all such devices
> (at least the ones that matter to user) today sit either on PCI or USB
> bus.

Hard disk on SATA? You can hot plug them.

SFP modules on i2c?

I'm sure there are others, which are not PCI or USB.

     Andrew
