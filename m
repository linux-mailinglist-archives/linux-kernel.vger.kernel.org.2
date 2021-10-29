Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856FB43FA95
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 12:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbhJ2KTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 06:19:34 -0400
Received: from foss.arm.com ([217.140.110.172]:36738 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231564AbhJ2KTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 06:19:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E1361FB;
        Fri, 29 Oct 2021 03:17:05 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B8C53F5A1;
        Fri, 29 Oct 2021 03:17:04 -0700 (PDT)
Date:   Fri, 29 Oct 2021 11:17:01 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v8 2/2] firmware: arm_scmi: Add optee transport
Message-ID: <20211029101701.GF6526@e120937-lin>
References: <20211028140009.23331-1-etienne.carriere@linaro.org>
 <20211028140009.23331-2-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028140009.23331-2-etienne.carriere@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 04:00:09PM +0200, Etienne Carriere wrote:
> Add a new transport channel to the SCMI firmware interface driver for
> SCMI message exchange based on optee transport channel. The optee
> transport is realized by connecting and invoking OP-TEE SCMI service
> interface PTA.
> 

Hi Etienne,

retested a bit...just in case :P

LGTM.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian

