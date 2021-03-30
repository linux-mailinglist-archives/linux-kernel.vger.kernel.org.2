Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2549734EA7C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 16:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbhC3Ofg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 10:35:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:50032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231979AbhC3OfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 10:35:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA4DE619BD;
        Tue, 30 Mar 2021 14:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617114901;
        bh=y9vTpArr668coIo/fWm0yFXeT29uVy1Ruq0ivcNKoYI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iTAnTiIH0M0HEBYsX/OzXjnWeRPCkofl/3M5ntHXGvO5a1GwHhsTRe+YAyGO8Vb2d
         86brPS8MjL7IhpXh/uf08AepqoKLz6Lg/N7mJn9ozh/98g1swRpPNoNCY6PMCXiISm
         VNaLSeVdUekbdf+CzM9wCIVwOZlZoNWFkzusvW8ygso1EVvsR0o7WEcCxXTgirIPOb
         5xnWY8mFBePyDWbf4vY30atrYFg9yvZ4pezTzlY6I84yNNf568qQcaabSsZkZSGNOw
         DEkhoZjUHrqiSD2x7IrfgbeqnD8WYChihQUYJzKAnEMXYdM5OtPL1cALJgvH0x+Q9J
         p1hIxGFM4N5bw==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lRFSk-0002Je-Ua; Tue, 30 Mar 2021 16:35:23 +0200
Date:   Tue, 30 Mar 2021 16:35:22 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 0/7] Add support for the other MaxLinear/Exar UARTs
Message-ID: <YGM3KqV7t6wblXYM@hovoldconsulting.com>
References: <cover.1616571453.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1616571453.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 08:41:04AM +0100, Mauro Carvalho Chehab wrote:
> The current version of the xr_serial driver handles one one of the several
> MaxLinear/Exar UARTs and UART bridges. There are currently 12 such
> models. Only one is currently supported.

As I mentioned earlier, proper handling of the CDC devices requires
support in USB serial core, which I've now implemented.

With that and by parsing the Union descriptor to determine the interface
layout, probing can also be cleaned up quite a bit.

Looking at this series I found a few things that have been overlooked,
such as the device types having different register widths (and one even
differing register address widths), the custom driver flag not being set
and a memory leak. I'll comment on some of these separately.

It also seems the type abstraction can be handled better by using a
more structured approach, which also allows getting rid of some of the
type conditionals spread throughout the code.

Another key observation here is that it's the currently supported type
which is the one that stands out from the rest. And while all four types
supports CDC requests, it's only the SET_LINE_CODING one which is
actually required to be used (by the three new types). This also allows
for a cleaner implementation.

I ended up implementing support myself in order to make sense of all the
ways these device types differ while digging through the datasheets and
thinking about how best to implement this.

I'll be posting a fix and two series while keeping you on CC. Would you
mind giving it a spin with your XR21B142X?

Johan
