Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E092137A9EF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 16:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbhEKOzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 10:55:01 -0400
Received: from foss.arm.com ([217.140.110.172]:49406 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231684AbhEKOzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 10:55:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F387C1692;
        Tue, 11 May 2021 07:53:52 -0700 (PDT)
Received: from bogus (unknown [10.57.33.10])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7B4C3F718;
        Tue, 11 May 2021 07:53:51 -0700 (PDT)
Date:   Tue, 11 May 2021 15:53:49 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Nicolas Pitre <npitre@baylibre.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Dien Pham <dien.pham.ry@renesas.com>,
        Gaku Inami <gaku.inami.xh@renesas.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_scmi: add clock management to the SCMI
 power domain
Message-ID: <20210511145349.b3gzogrdhl74oq5o@bogus>
References: <5q88n947-pon-4940-3or6-s54o4r361o5s@onlyvoer.pbz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5q88n947-pon-4940-3or6-s54o4r361o5s@onlyvoer.pbz>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nico,

On Fri, May 07, 2021 at 04:20:36PM -0400, Nicolas Pitre wrote:
> Clocks requiring non-atomic contexts are supported by the generic clock
> PM layer since commit 0bfa0820c274 ("PM: clk: make PM clock layer
> compatible with clocks that must sleep"). That means we can have
> SCMI-based clocks be managed by the SCMI power domain now.
>

Looks good to me, I will apply this soon for v5.14.
I will reply with details once it is applied.

--
Regards,
Sudeep
