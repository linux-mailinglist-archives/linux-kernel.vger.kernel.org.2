Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDCC23A4771
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 19:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbhFKRIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 13:08:10 -0400
Received: from foss.arm.com ([217.140.110.172]:36002 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231199AbhFKRIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 13:08:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 942FED6E;
        Fri, 11 Jun 2021 10:06:08 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 264083F719;
        Fri, 11 Jun 2021 10:06:06 -0700 (PDT)
Date:   Fri, 11 Jun 2021 18:06:00 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com
Subject: Re: [PATCH v2 0/5] Review/Extend SCMI Transport Core layer
Message-ID: <20210611170600.GA35183@e120937-lin>
References: <20210601102421.26581-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601102421.26581-1-cristian.marussi@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 01, 2021 at 11:24:16AM +0100, Cristian Marussi wrote:
> Hi all,
> 
> this short series is meant to review and extend a couple of SCMI transport
> core layer mechanisms in order to ease the interaction with more complex
> SCMI transport driver like the upcoming virtio-scmi and optee-scmi.
> 

I'm going to retire this series as standalone and post these changes
only together with the SCMI VirtIO series that need them at:

https://lore.kernel.org/linux-arm-kernel/20210611165937.701-1-cristian.marussi@arm.com/T/#t

Thanks,
Cristian

