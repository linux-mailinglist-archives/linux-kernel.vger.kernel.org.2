Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 585C53308D7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 08:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbhCHHem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 02:34:42 -0500
Received: from foss.arm.com ([217.140.110.172]:33240 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232097AbhCHHed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 02:34:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CB25ED1;
        Sun,  7 Mar 2021 23:34:32 -0800 (PST)
Received: from bogus (unknown [10.57.15.109])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0437B3F70D;
        Sun,  7 Mar 2021 23:34:28 -0800 (PST)
Date:   Mon, 8 Mar 2021 07:34:25 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lukasz.luba@arm.com, james.quinlan@broadcom.com,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, thara.gopinath@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
Subject: Re: [PATCH v6 36/37] firmware: arm_scmi: add protocol modularization
 support
Message-ID: <20210308073425.g7zkpoamxu2m67tj@bogus>
References: <20210202221555.41167-1-cristian.marussi@arm.com>
 <20210202221555.41167-37-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202221555.41167-37-cristian.marussi@arm.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 10:15:54PM +0000, Cristian Marussi wrote:
> Extend SCMI protocols accounting mechanism to address possible module
> usage and add the support to possibly define new protocols as loadable
> modules.
>
> Keep Standard protocols built into the SCMI core.
>

The changes look good, however without any users I am bit hesitant to add
this yet. However if you think it is hard to maintain it outside the tree
until first user gets merged, we can merge provided we test this every
release. Let me know your thoughts.

Also any comment from users requesting this would be useful.

--
Regards,
Sudeep
