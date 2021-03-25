Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2AE2349AB7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 20:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhCYTz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 15:55:58 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63350 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbhCYTzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 15:55:45 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 763B7132693;
        Thu, 25 Mar 2021 15:55:45 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=rHRnYKKhAcD9UZjS9+xd9QNDSUM=; b=vHLaGU
        HCr5cnGtdMQKJrX3v1esXJw2dY0PyLDMCHv0gEzKibWyrOxRag2yRWQw+yEPJnJK
        43CW4qawoJJvdDP/kWgwjcqWYLDANVEPSWXMDD1nKPWmzQnS92J+H85MvwcDWG/e
        gqAHm5bnw7fQBaUOBiIjI2UKAVl0uV+l/qF9Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6FD1B132692;
        Thu, 25 Mar 2021 15:55:45 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=YztIcC1Qncz7Kox/lNy2qQQLh9Y1lY5UmmJSBkF/+n8=; b=CrRmM76fixQYJMjKNWqzL/oeiTOddILivMPIz02iWrGjDus4o93HC4+HnHMmTnYhIU6C/noi3aLtKDQgF8JG6gNFh+VGtqm6yRZwnuQT2N59VdwD3n3DRs+V+9K+izkepDxrck00XY40H0kBZCet+AIb/+twlIp8eVcYtrLqdz4=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 65A9B132691;
        Thu, 25 Mar 2021 15:55:42 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id B071F2DA0080;
        Thu, 25 Mar 2021 15:55:40 -0400 (EDT)
Date:   Thu, 25 Mar 2021 15:55:40 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Jann Horn <jannh@google.com>
cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Tavis Ormandy <taviso@google.com>
Subject: Re: ARM FDPIC_FUNCPTRS personality flag handling looks broken
In-Reply-To: <CAG48ez1wLkMCiyY+bWVonXZr2TjzhwKZjNZLD3Ads=Rds8YJSw@mail.gmail.com>
Message-ID: <72pn55r-r95-9ns6-7p9r-4940r6834nq9@syhkavp.arg>
References: <CAG48ez1wLkMCiyY+bWVonXZr2TjzhwKZjNZLD3Ads=Rds8YJSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 1493E7B0-8DA4-11EB-BC11-E43E2BB96649-78420484!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Mar 2021, Jann Horn wrote:

> Hi!
> 
> Tavis noticed that on ARM kernels with CONFIG_BINFMT_ELF_FDPIC, it
> looks like the FDPIC_FUNCPTRS personality flag is not reset on
> execve(). This would mean that if a process first executes an ELF
> FDPIC binary (which forces the personality to PER_LINUX_FDPIC), and
> then executes a non-FDPIC binary, the signal handling code
> (setup_return()) will have bogus behavior (interpreting a normal
> function pointer as an FDPIC function handle).
> 
> I think FDPIC_FUNCPTRS should probably either be reset on every
> execve() or not be a personality flag at all (since AFAIU pretty much
> the whole point of personality flags is that they control behavior
> even across execve()).

I think you're right. This is probably true for SH as well.
I'd recommend the former solution as being the least intrusive one.


Nicolas
