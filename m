Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D158411357
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 13:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236563AbhITLIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 07:08:20 -0400
Received: from foss.arm.com ([217.140.110.172]:45876 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232382AbhITLIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 07:08:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C469B1FB;
        Mon, 20 Sep 2021 04:06:52 -0700 (PDT)
Received: from bogus (unknown [10.57.23.241])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 56A443F719;
        Mon, 20 Sep 2021 04:06:51 -0700 (PDT)
Date:   Mon, 20 Sep 2021 12:06:32 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Igor Skalkin <igor.skalkin@opensynergy.com>,
        Peter Hilber <peter.hilber@opensynergy.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] firmware: arm_scmi: remove __exit annotation
Message-ID: <163213566221.1958937.10094633298863951666.b4-ty@arm.com>
References: <20210920100301.1466486-1-arnd@kernel.org>
 <20210920100301.1466486-2-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920100301.1466486-2-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 12:02:52PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> virtio_scmi_exit() is only called from __exit function, so the annotation
> is correct, but when the driver is built-in, the section gets discarded
> and the reference from a callback pointer causes a link-time error:
>
> `virtio_scmi_exit' referenced in section `.rodata' of drivers/firmware/arm_scmi/virtio.o: defined in discarded section `.exit.text' of drivers/firmware/arm_scmi/virtio.o
>
> I could not figure out a better workaround, so let's just remove that
> annotation even if it wastes a couple of bytes in .text.
>

[...]

Applied to sudeep.holla/linux (for-next/scmi), thanks!

[2/2] firmware: arm_scmi: remove __exit annotation
      https://git.kernel.org/sudeep.holla/c/1cd73200da

--
Regards,
Sudeep
