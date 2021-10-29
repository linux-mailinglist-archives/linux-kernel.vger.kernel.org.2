Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F79043FAA5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 12:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbhJ2KXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 06:23:51 -0400
Received: from foss.arm.com ([217.140.110.172]:36770 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231622AbhJ2KXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 06:23:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB0171FB;
        Fri, 29 Oct 2021 03:21:21 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C132C3F5A1;
        Fri, 29 Oct 2021 03:21:20 -0700 (PDT)
Date:   Fri, 29 Oct 2021 11:21:18 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v8 1/2] dt-bindings: arm: Add OP-TEE transport for SCMI
Message-ID: <20211029102118.GG6526@e120937-lin>
References: <20211028140009.23331-1-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028140009.23331-1-etienne.carriere@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 04:00:08PM +0200, Etienne Carriere wrote:
> Introduce compatible "linaro,scmi-optee" for SCMI transport channel
> based on an OP-TEE service invocation. The compatible mandates a
> channel ID defined with property "linaro,optee-channel-id".
> 
> Cc: devicetree@vger.kernel.org
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> ---

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian

