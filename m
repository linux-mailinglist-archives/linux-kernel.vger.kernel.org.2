Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67FA738E8DE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 16:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbhEXOmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 10:42:22 -0400
Received: from foss.arm.com ([217.140.110.172]:42752 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232882AbhEXOmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 10:42:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19311ED1;
        Mon, 24 May 2021 07:40:52 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0DFA63F73D;
        Mon, 24 May 2021 07:40:50 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>,
        Nicolas Pitre <npitre@baylibre.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Gaku Inami <gaku.inami.xh@renesas.com>,
        Dien Pham <dien.pham.ry@renesas.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] firmware: arm_scmi: add clock management to the SCMI power domain
Date:   Mon, 24 May 2021 15:40:31 +0100
Message-Id: <162186717336.304123.2079683023194359078.b4-ty@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <5q88n947-pon-4940-3or6-s54o4r361o5s@onlyvoer.pbz>
References: <5q88n947-pon-4940-3or6-s54o4r361o5s@onlyvoer.pbz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 May 2021 16:20:36 -0400 (EDT), Nicolas Pitre wrote:
> Clocks requiring non-atomic contexts are supported by the generic clock
> PM layer since commit 0bfa0820c274 ("PM: clk: make PM clock layer
> compatible with clocks that must sleep"). That means we can have
> SCMI-based clocks be managed by the SCMI power domain now.


Applied to sudeep.holla/linux (for-next/scmi), thanks!

[1/1] firmware: arm_scmi: add clock management to the SCMI power domain
      https://git.kernel.org/sudeep.holla/c/a3b884cef8

--
Regards,
Sudeep

