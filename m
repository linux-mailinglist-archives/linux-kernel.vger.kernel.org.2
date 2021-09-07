Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B20440254A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 10:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243013AbhIGIlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 04:41:44 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:56459 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242641AbhIGIln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 04:41:43 -0400
Received: from [141.14.13.3] (g258.RadioFreeInternet.molgen.mpg.de [141.14.13.3])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4E4CA61E5FE00;
        Tue,  7 Sep 2021 10:40:32 +0200 (CEST)
To:     Guenter Roeck <linux@roeck-us.net>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: QA: Monitor Linux log messages as port of release (candidate) testing
Cc:     LKML <linux-kernel@vger.kernel.org>
Message-ID: <458e0604-1fe9-bed0-d22f-84540b05ffb1@molgen.mpg.de>
Date:   Tue, 7 Sep 2021 10:40:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Guenter,


Thank you for testing release candidates and releases [1]. Is your test 
setup documented somewhere?

If not happening already, could the Linux messages (at least up to log 
level warning) also be monitored? For example, in Linux 5.14, a new 
warning snuck in by cefc7ca462 (ACPI: PRM: implement OperationRegion 
handler for the PlatformRtMechanism subtype) [2], which could have been 
caught early on, and fixed before the release.

The test summaries would then also notify about possible behavior change.


Kind regards,

Paul


[1]: https://lkml.org/lkml/2021/7/11/326
[2]: 
https://lore.kernel.org/linux-acpi/54b6f8cb-4714-587c-b2d0-98134473293d@linux.intel.com/T/#m3f54733714381765c8bb5bfa5b2aa3969407931e
