Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E47E641B66B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 20:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhI1Sft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 14:35:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:43986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242312AbhI1Sfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 14:35:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B8D096103E;
        Tue, 28 Sep 2021 18:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632854045;
        bh=yatOfEZCG35taMbc6RN96f4TL49hkZJdqHa9Wh8F1Jw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=aLJSFtjSQ3Ph/2Sqoip0dlh0K4tMVVjiyzvEENPDVr7MXl1kqqNWYwx+snsa8Sjrr
         RWcB4bpj6gYLhV/eWdvVSm7w0QgKYd09oNA0C9ySSZUvbJNAyNAn7GhaUTMBGkReCM
         XpJhGt+257pccSLaYwcMz4edFqQORsgji4HQWrVZLULgck8Kt8LsSr7dCLedjIB27A
         XRoO9gnA1utUNqlolEvrbD1bQvyo/7GmBCeZF9U8UtpHfFOXKp4thmSbYqZ6MYw1Qa
         Lm5CXeY2nL4hjOrwsAoyHKERhKOKnB2hXhKWJ0IIVKOKy0jyJYOA1Mu1P1fVcmN/lN
         ubhqFltEg1u6Q==
Date:   Tue, 28 Sep 2021 13:34:03 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Carlos Bilbao <bilbao@vt.edu>,
        Leon Romanovsky <leon@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/17] ABI: sysfs-bus-pci: add a alternative What fields
Message-ID: <20210928183403.GA715406@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15ba8c07f1b0fd7359106920c8e34a7b9af7aea6.1632750608.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Probably already queued up, but:

s/add a alternative/add alternative/ (in subject)

On Mon, Sep 27, 2021 at 03:59:43PM +0200, Mauro Carvalho Chehab wrote:
> There are some PCI ABI that aren't shown under:
> 
> 	/sys/bus/pci/drivers/.../
> 
> Because they're registered with a different class. That's
> the case of, for instance:
> 
> 	/sys/bus/i2c/drivers/CHT Whiskey Cove PMIC/unbind
> 
> This one is not present under /sys/bus/pci:
> 
> 	$ find /sys/bus/pci -name 'CHT Whiskey Cove PMIC'
> 
> Although clearly this is provided by a PCI driver:
> 
> 	/sys/devices/pci0000:00/0000:00:02.0/i2c-4/subsystem/drivers/CHT Whiskey Cove PMIC/unbind
> 
> So, add an altertate What location in order to match bind/unbind
> to such devices.

s/altertate/alternate/

> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
> 
> See [PATCH 00/17] at: https://lore.kernel.org/all/cover.1632750608.git.mchehab+huawei@kernel.org/
> 
>  Documentation/ABI/testing/sysfs-bus-pci | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index 1eeac7f59672..16afe3f59cbd 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -1,4 +1,5 @@
>  What:		/sys/bus/pci/drivers/.../bind
> +What:		/sys/devices/pciX/.../bind

Wasn't somebody just updating these wildcard-ish items in pathnames?

Ah, it was you :)

  https://lore.kernel.org/all/4ede4ec98e295f054f3e5a6f3f9393b5e3d5d2a7.1631782432.git.mchehab+huawei@kernel.org/

Changing "virtfnN" to "virtfn<N>".

Is that same sort of thing applicable here?  My system has

  /sys/devices/pci0000:00/...

Bjorn
