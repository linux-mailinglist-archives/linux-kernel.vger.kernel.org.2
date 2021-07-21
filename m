Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 997CF3D121D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 17:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239708AbhGUOfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 10:35:13 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33280 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238083AbhGUOfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 10:35:11 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 10AA122543;
        Wed, 21 Jul 2021 15:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626880547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KmTDg6qwR3xk6mE+VQ6wYydTAWq0Kbym5zE62l8asCw=;
        b=2RaBea43HXZIwITZnNeWb5YTk4FIC3p0+hh0l/jujpaahqnsDs68xhzQlM8uQUEe1TmlCI
        Uwbr4ybtzUhwUYmEXJrEF9aDmFFkwoMa3Rw2Z0Bt/FqpmSVbpwXJ/f/ZZOhyIQCax0HyUe
        GMoOsXonIa5SXzWttO2oH/JlZe2JwBE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626880547;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KmTDg6qwR3xk6mE+VQ6wYydTAWq0Kbym5zE62l8asCw=;
        b=9rIM9JRfIMEqj340Jl8Fkfd/2Ut7wCO8/jcHcbHgOR8ZJCchwn32aei8zcgfQB1Lu2Kg5F
        SG4GwUUJaiL/lmCw==
Received: from hawking.suse.de (hawking.suse.de [10.160.4.0])
        by relay2.suse.de (Postfix) with ESMTP id 04048A3B88;
        Wed, 21 Jul 2021 15:15:47 +0000 (UTC)
Received: by hawking.suse.de (Postfix, from userid 17005)
        id EB516446119; Wed, 21 Jul 2021 17:15:46 +0200 (CEST)
From:   Andreas Schwab <schwab@suse.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Tobias Schramm <t.schramm@manjaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: mmc_spi: add spi:mmc-spi-slot alias
References: <mvmtukn6bmu.fsf@suse.de> <YPgwHcbK7XoXL/mD@smile.fi.intel.com>
        <mvmpmvb68cg.fsf@suse.de> <YPg3VS/Ure6VRsuJ@smile.fi.intel.com>
X-Yow:  NOW do I get to blow out the CANDLES??
Date:   Wed, 21 Jul 2021 17:15:46 +0200
In-Reply-To: <YPg3VS/Ure6VRsuJ@smile.fi.intel.com> (Andy Shevchenko's message
        of "Wed, 21 Jul 2021 18:03:49 +0300")
Message-ID: <mvmlf5z66l9.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 21 2021, Andy Shevchenko wrote:

> Can you explain what is the _practical_ issue here?

The module is not loaded by udev.

> What is your HW setup and what you are trying to do?

Booting the HiFive board without having to force loading the mmc_spi
module.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
