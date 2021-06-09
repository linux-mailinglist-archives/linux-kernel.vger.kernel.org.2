Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33D7A3A1E41
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 22:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbhFIUsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 16:48:38 -0400
Received: from foss.arm.com ([217.140.110.172]:42430 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229639AbhFIUsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 16:48:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B97B3ED1;
        Wed,  9 Jun 2021 13:46:41 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 07FD63F719;
        Wed,  9 Jun 2021 13:46:40 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] firmware: arm_scmi: Add delayed response status check
Date:   Wed,  9 Jun 2021 21:46:34 +0100
Message-Id: <162327154478.2648287.13789567557699425300.b4-ty@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210608103056.3388-1-cristian.marussi@arm.com>
References: <20210608103056.3388-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jun 2021 11:30:56 +0100, Cristian Marussi wrote:
> A successfully received delayed response could anyway report a failure at
> the protocol layer in the message status field.
> 
> Add a check also for this error condition.

Applied to sudeep.holla/linux (master), thanks!

[1/1] firmware: arm_scmi: Add delayed response status check
      https://git.kernel.org/sudeep.holla/c/f1748b1ee1

--
Regards,
Sudeep

