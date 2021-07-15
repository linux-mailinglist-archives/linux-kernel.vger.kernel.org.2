Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF5403CA34D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 18:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236052AbhGOQ4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 12:56:37 -0400
Received: from foss.arm.com ([217.140.110.172]:55170 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229695AbhGOQ4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 12:56:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60D286D;
        Thu, 15 Jul 2021 09:53:41 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 93E883F7D8;
        Thu, 15 Jul 2021 09:53:40 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Colin King <colin.king@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] smpboot: remove inline from __always_inline'd function idle_init
In-Reply-To: <20210715164018.62712-1-colin.king@canonical.com>
References: <20210715164018.62712-1-colin.king@canonical.com>
Date:   Thu, 15 Jul 2021 17:53:34 +0100
Message-ID: <87czrjmsc1.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/07/21 17:40, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Declaring a idle_init as inline when it is __always_inline is redundant
> so this can be removed. Also swap the order of __always_inline and void
> to match the more usual coding style.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
