Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4B7350E68
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 07:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbhDAFYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 01:24:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:36040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230291AbhDAFYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 01:24:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 24F3960698;
        Thu,  1 Apr 2021 05:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617254684;
        bh=BRPNGHFq9n8qHOWZs3Z9xHbkEAkNiy/Yclwd+wHA1Nw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E+wj1eNWvmWW7hOVckRKHD3fCJ0ZqwUYd5wDnWUsHIhKkJz0yAms8iqFdv7b7bS44
         D/USeu8n+Erqt+I4oiQLgXaF3jMLbMgGSVj/SUgCmwSZ+ba4Yv0F80r0FKgXFEPo0o
         nxjyXLNjpWR+a+l7Ad9paOjOnytgpW7vV6nZJSeZAezfT/0fpDFFAEMtvtTbNfrr5p
         hUt6iuZAQ0L6CH2gnDSLPegydhp7OUqkGbMfz8JoVOq+3djuP60zyKP8UeRSh1s6ob
         n9U9WeJKbgqvJIs82hqQG+g5dziqPKxL7mvvbGX/sa/Jw35LGrh6U5W+t+5IdCcJG+
         RHCocMiCb1Svg==
Date:   Thu, 1 Apr 2021 10:54:38 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Add support for Actions Semi Owl socinfo
Message-ID: <20210401052438.GB14052@work>
References: <cover.1617110420.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617110420.git.cristian.ciocaltea@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 04:48:15PM +0300, Cristian Ciocaltea wrote:
> This patchset adds a socinfo driver which provides information about
> Actions Semi Owl SoCs to user space via sysfs: machine, family, soc_id,
> serial_number.
> 
> Please note the serial number is currently available only for the S500
> SoC variant.
> 
> This has been tested on the S500 SoC based RoseapplePi SBC.
> 

Is this the soc_id provided by the vendor bootloader (uboot)? If so, under
what basis it provides? I don't think the SoC has the provision for
soc_id based on HW parameters.

Thanks,
Mani

> Thanks,
> Cristi
> 
> Changes in v2:
>  - Exposed the memory range for reading the SoC serial number under
>    /reserved-memory DT node, according to Rob's review; as a consequence
>    added a new binding document (actions,owl-soc-serial.yaml) and updated
>    owl-socinfo.yaml
> 
>  - Replaced the unportable usage of system_serial_{low,high} globals
>    with a public API to provide external access to SoC serial number
>    parts (e.g. Owl Ethernet MAC driver will use this to generate a
>    stable MAC address)
> 
>  - Rebased patch series on v5.12-rc5
> 
> Cristian Ciocaltea (6):
>   dt-bindings: reserved-memory: Add Owl SoC serial number binding
>   dt-bindings: soc: actions: Add Actions Semi Owl socinfo binding
>   soc: actions: Add Actions Semi Owl socinfo driver
>   arm: dts: owl-s500: Add reserved-memory range for Owl SoC serial
>     number
>   arm: dts: owl-s500: Add socinfo support
>   MAINTAINERS: Add entries for Owl reserved-memory and socinfo bindings
> 
>  .../actions,owl-soc-serial.yaml               |  53 ++++++
>  .../bindings/soc/actions/owl-socinfo.yaml     |  57 +++++++
>  MAINTAINERS                                   |   2 +
>  arch/arm/boot/dts/owl-s500.dtsi               |  13 +-
>  drivers/soc/actions/Kconfig                   |   8 +
>  drivers/soc/actions/Makefile                  |   1 +
>  drivers/soc/actions/owl-socinfo.c             | 152 ++++++++++++++++++
>  include/linux/soc/actions/owl-serial-number.h |  20 +++
>  8 files changed, 305 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/reserved-memory/actions,owl-soc-serial.yaml
>  create mode 100644 Documentation/devicetree/bindings/soc/actions/owl-socinfo.yaml
>  create mode 100644 drivers/soc/actions/owl-socinfo.c
>  create mode 100644 include/linux/soc/actions/owl-serial-number.h
> 
> -- 
> 2.31.1
> 
