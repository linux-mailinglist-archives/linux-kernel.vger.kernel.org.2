Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08ECB45DA36
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 13:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347774AbhKYMo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 07:44:26 -0500
Received: from foss.arm.com ([217.140.110.172]:50372 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347542AbhKYMmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 07:42:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02C901042;
        Thu, 25 Nov 2021 04:39:14 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9CD8C3F66F;
        Thu, 25 Nov 2021 04:39:12 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     virtio-dev@lists.oasis-open.org,
        linux-arm-kernel@lists.infradead.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, souvik.chakravarty@arm.com,
        igor.skalkin@opensynergy.com, vincent.guittot@linaro.org,
        peter.hilber@opensynergy.com
Subject: Re: [PATCH] firmware: arm_scmi: Make virtio Version_1 compliance optional
Date:   Thu, 25 Nov 2021 12:39:09 +0000
Message-Id: <163784392480.133830.14389696502966369436.b4-ty@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211115102910.7639-1-cristian.marussi@arm.com>
References: <20211115102910.7639-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Nov 2021 10:29:10 +0000, Cristian Marussi wrote:
> Introduce a compilation option to disable strict enforcement of compliance
> against VirtIO Version_1 backends, so as to allow to support also Legacy
> VirtIO devices implementations.
> 
> 

Applied to sudeep.holla/linux (for-next/scmi), thanks!

[1/1] firmware: arm_scmi: Make virtio Version_1 compliance optional
      https://git.kernel.org/sudeep.holla/c/530897ecdb

--
Regards,
Sudeep

