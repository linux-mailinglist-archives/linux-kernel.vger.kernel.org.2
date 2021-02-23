Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3091E322A2A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 13:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbhBWMBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 07:01:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:40378 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232845AbhBWL6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 06:58:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3E215AC1D;
        Tue, 23 Feb 2021 11:57:40 +0000 (UTC)
Subject: Re: [PATCH] docs: reporting-issues.rst: explain how to decode stack
 traces
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Damian Tometzki <linux@tometzki.de>
References: <20210215172857.382285-1-linux@leemhuis.info>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <aedcc7df-b30b-ebfe-9654-c2c572889d3f@suse.cz>
Date:   Tue, 23 Feb 2021 12:57:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210215172857.382285-1-linux@leemhuis.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/21 6:28 PM, Thorsten Leemhuis wrote:
> Replace placeholder text about decoding stack traces with a section that
> properly describes what a typical user should do these days. To make
> it works for them, add a paragraph in an earlier section to ensure
> people build their kernels with everything that's needed to decode stack
> traces later.

Looks good!

> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> Reviewed-by: Qais Yousef <qais.yousef@arm.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!
