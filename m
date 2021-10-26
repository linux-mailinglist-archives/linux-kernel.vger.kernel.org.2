Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B84E43B31C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 15:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236197AbhJZNXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 09:23:53 -0400
Received: from foss.arm.com ([217.140.110.172]:58522 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231178AbhJZNXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 09:23:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31CD2101E;
        Tue, 26 Oct 2021 06:21:28 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 27A523F73D;
        Tue, 26 Oct 2021 06:21:27 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Marc Bonnici <marc.bonnici@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_ffa: remove unused 'compat_version' variable
Date:   Tue, 26 Oct 2021 14:21:16 +0100
Message-Id: <163525446779.1920033.12521678281656448408.b4-ty@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211026083400.3444946-1-arnd@kernel.org>
References: <20211026083400.3444946-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2021 10:33:50 +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The newly added ffa_compatible_version_find() function causes a
> build warning because of a variable that is never used:
> 
> drivers/firmware/arm_ffa/driver.c:180:6: error: unused variable 'compat_version' [-Werror,-Wunused-variable]
>         u32 compat_version;
> 
> [...]


Applied to sudeep.holla/linux (for-linux-next), thanks!




[1/1] firmware: arm_ffa: remove unused 'compat_version' variable
      https://git.kernel.org/sudeep.holla/c/01537a078b

--

Regards,
Sudeep

