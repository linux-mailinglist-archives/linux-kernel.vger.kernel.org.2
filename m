Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 620B5455B4C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 13:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344627AbhKRMOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 07:14:05 -0500
Received: from foss.arm.com ([217.140.110.172]:40104 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344541AbhKRMNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 07:13:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D1411FB;
        Thu, 18 Nov 2021 04:10:42 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A7E3F3F766;
        Thu, 18 Nov 2021 04:10:41 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     cristian.marussi@arm.com, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, Peng Fan <peng.fan@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_scmi: pm: propagate return value to caller
Date:   Thu, 18 Nov 2021 12:10:35 +0000
Message-Id: <163723741005.4014297.11285288772838306024.b4-ty@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211116064227.20571-1-peng.fan@oss.nxp.com>
References: <20211116064227.20571-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2021 14:42:27 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> of_genpd_add_provider_onecell may return error, so let's propagate
> its return value to caller
> 
> 

Applied to sudeep.holla/linux (for-next/scmi), thanks!

[1/1] firmware: arm_scmi: pm: propagate return value to caller
      https://git.kernel.org/sudeep.holla/c/1446fc6c67

--
Regards,
Sudeep

