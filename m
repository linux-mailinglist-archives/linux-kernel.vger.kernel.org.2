Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14BFA36728A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 20:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245218AbhDUS3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 14:29:49 -0400
Received: from thorn.bewilderbeest.net ([71.19.156.171]:47885 "EHLO
        thorn.bewilderbeest.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244543AbhDUS3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 14:29:46 -0400
Received: from hatter.bewilderbeest.net (unknown [IPv6:2600:6c44:7f:ba20::7c6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 5FB4D123;
        Wed, 21 Apr 2021 11:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1619029750;
        bh=svOYheueA79L0peCZXaDTla1aQaIMKCRlqEeIVwaGSQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vn7+E2N4nZ6IElUJ1gv2/zXNP4ngmrZu6MUT0y5WDoYg+cz4GEKmsmtY2Ndjaa/LN
         Ae4s7xGOH+pBXNMeNRGDuEeedvFZzR+fetarTa2lDjPDk6Q9PaeoURF4ODoQfAhVbE
         JIpaZtiEgz6ctXgLtdbzyiOFOgTaFuARIgopvnI4=
Date:   Wed, 21 Apr 2021 13:29:07 -0500
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Mark Brown <broonie@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Andrew Jeffery <andrew@aj.id.au>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: Re: Enabling pmbus power control
Message-ID: <YIBu8w5w8r0j03PP@hatter.bewilderbeest.net>
References: <YH5rky8nA4nKAVdg@hatter.bewilderbeest.net>
 <9639fa33-01ca-9802-e745-5e3edb81e305@roeck-us.net>
 <YH59WOg0iKbz1d0l@hatter.bewilderbeest.net>
 <fe111c8a-9588-dbfb-624a-29bb3a5efe13@roeck-us.net>
 <YH7w6HUtBSCZRWq4@hatter.bewilderbeest.net>
 <20210420161317.GE6073@sirena.org.uk>
 <YH8D+LWxWPqnFd2h@hatter.bewilderbeest.net>
 <20210420171540.GG6073@sirena.org.uk>
 <YH8jUuOEJKDDDoMb@hatter.bewilderbeest.net>
 <20210421110540.GA4617@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210421110540.GA4617@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 06:05:40AM CDT, Mark Brown wrote:
>On Tue, Apr 20, 2021 at 01:54:10PM -0500, Zev Weiss wrote:
>
>> Consider the power shelf I mentioned earlier -- it's a rackmount power
>> supply and that's about it.  It provides DC power to arbitrary devices that
>> it has no other connection to, just ground and +12V.  Those devices might be
>> servers, or cooling fans, or vacuum cleaners or floodlights -- the power
>> shelf doesn't know, or care.  It's a lot like a switchable network PDU in
>
>If your chassis is particularly simple then it will be particularly
>simple to fit into a generic framework so that should make your life a
>lot easier here.  Generally the simpler your system is the easier it
>will be to use in something generic, it's not going to be stretching
>ideas about how things should look and is more likely to have good
>helpers available already.

The simplicity of the use-case should make it easy to implement via a 
generic framework, yes.  But at the same time, if we're talking about 
that being a new framework that doesn't currently exist, the minimal 
needs of this case make it difficult for me to see what sort of 
structure or additional functionality would be required of such a 
framework to support more complex cases, because the simple/minimal case 
is the only example I have at hand.  I think there's also (quite 
reasonably) a general reluctance to merge infrastructure that doesn't 
have any users.

Given that, I'd think the appropriate approach for a first-cut 
implementation of that would be to only implement what's presently 
needed, and put off incorporating any other bells and whistles until 
there's something that would use them.  It seems like a minimal, 
only-what's-needed version of that at present would end up looking 
extremely similar to reg-userspace-consumer though.  Would that not be 
problematic?


Zev

