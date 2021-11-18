Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEE4455B3D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 13:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344518AbhKRMLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 07:11:23 -0500
Received: from foss.arm.com ([217.140.110.172]:40062 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344494AbhKRMLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 07:11:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3460B1FB;
        Thu, 18 Nov 2021 04:08:15 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0C78D3F766;
        Thu, 18 Nov 2021 04:08:13 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     virtio-dev@lists.oasis-open.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, peter.hilber@opensynergy.com,
        igor.skalkin@opensynergy.com
Subject: Re: [PATCH] firmware: arm_scmi: Fix null de-reference on error path
Date:   Thu, 18 Nov 2021 12:08:04 +0000
Message-Id: <163723724296.4014039.8488368572572858524.b4-ty@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211112180705.41601-1-cristian.marussi@arm.com>
References: <20211112180705.41601-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Nov 2021 18:07:05 +0000, Cristian Marussi wrote:
> During channel setup a failure in the call of scmi_vio_feed_vq_rx() leads
> to an attempt to access a dev pointer by dereferencing vioch->cinfo at
> a time when vioch->cinfo has still to be initialized.
> 
> Fix it by providing the device reference directly to scmi_vio_feed_vq_rx.
> 
> 
> [...]

Applied to sudeep.holla/linux (for-next/scmi), thanks!

[1/1] firmware: arm_scmi: Fix null de-reference on error path
      https://git.kernel.org/sudeep.holla/c/9516116572

--
Regards,
Sudeep

