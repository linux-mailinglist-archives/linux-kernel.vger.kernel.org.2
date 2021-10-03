Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423BB420113
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 11:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhJCJ3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 05:29:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:60782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229512AbhJCJ3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 05:29:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BECAC6136A;
        Sun,  3 Oct 2021 09:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633253238;
        bh=Z+JKvj4sN+KWKBgRz5Yx0sp0MJ32bjEtWch2TgPTOuE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NR1vzFmoGwwm80elhuJ9ZJ/BQ6NRrvnRbz88Yez0x5TeUJQSvZSX/1P4oKt3gGdbI
         eUmosuobMB0Tiw1lOoc1/L9zuJqKv68PWG/62G7p7BG6RDk3AdrE3x7sS+DMw88xkJ
         FqY4iKV+9UUnWElfR3PcPkD4cT6TqWVcqm4yeUkk=
Date:   Sun, 3 Oct 2021 11:27:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Len Baker <len.baker@gmx.com>
Cc:     Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: Convert platform driver to
 use dev_groups
Message-ID: <YVl3c7iprlLbMoFJ@kroah.com>
References: <20211003091949.7339-1-len.baker@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211003091949.7339-1-len.baker@gmx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 03, 2021 at 11:19:49AM +0200, Len Baker wrote:
> Platform drivers have the option of having the platform core create and
> remove any needed sysfs attribute files. So take advantage of that and
> refactor the attributes management to avoid to register them "by hand".
> 
> Also, due to some attributes are optionals, refactor the code and move
> the logic inside the "is_visible" callbacks of the attribute_group
> structures.
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Len Baker <len.baker@gmx.com>
> ---
>  drivers/platform/x86/thinkpad_acpi.c | 536 ++++++++++++---------------
>  1 file changed, 236 insertions(+), 300 deletions(-)

Nice!

At first glance this looks great to me, thanks for doing this.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
