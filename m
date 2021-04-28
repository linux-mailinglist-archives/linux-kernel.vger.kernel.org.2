Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A59736D55B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 12:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238984AbhD1KE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 06:04:27 -0400
Received: from foss.arm.com ([217.140.110.172]:38716 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238991AbhD1KET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 06:04:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77F1C1FB;
        Wed, 28 Apr 2021 03:03:34 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 85E3C3F70D;
        Wed, 28 Apr 2021 03:03:33 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org, Wan Jiabing <wanjiabing@vivo.com>,
        linux-arm-kernel@lists.infradead.org,
        Cristian Marussi <cristian.marussi@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, kael_w@yeah.net
Subject: Re: [PATCH] firmware: arm_scmi: Remove repeated struct declaration
Date:   Wed, 28 Apr 2021 11:03:29 +0100
Message-Id: <161960405992.396847.7773596762858834965.b4-ty@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210427033031.4580-1-wanjiabing@vivo.com>
References: <20210427033031.4580-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Apr 2021 11:30:31 +0800, Wan Jiabing wrote:
> struct scmi_protocol_handle is declared at 34th line.
> The declaration here is duplicate. Remove it.

Applied to sudeep.holla/linux (for-next/scmi), thanks!

[1/1] firmware: arm_scmi: Remove repeated struct declaration
      https://git.kernel.org/sudeep.holla/c/03f840c492

--
Regards,
Sudeep

