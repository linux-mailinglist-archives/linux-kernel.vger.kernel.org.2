Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4563387B9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 09:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbhCLIjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 03:39:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:38054 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232416AbhCLIjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 03:39:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 082D4AF39;
        Fri, 12 Mar 2021 08:39:32 +0000 (UTC)
Subject: Re: [PATCH 1/1] ARM: owl: Add Actions Semi Owl S500 SoC machine
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Manivannan Sadhasivam <mani@kernel.org>
References: <c560f4c188e39c4100e330ed4bc2d277c5ad6905.1615490186.git.cristian.ciocaltea@gmail.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <47295735-2792-a517-b96a-a00a68496846@suse.de>
Date:   Fri, 12 Mar 2021 09:39:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <c560f4c188e39c4100e330ed4bc2d277c5ad6905.1615490186.git.cristian.ciocaltea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cristian,

On 11.03.21 20:19, Cristian Ciocaltea wrote:
> Add machine entry for the S500 variant of the Actions Semi Owl SoCs
> family.
> 
> For the moment the only purpose is to provide the system serial
> information which will be used by the Owl Ethernet MAC driver to
> generate a stable MAC address.

Can't that be done in either a sys_soc driver or U-Boot?

Regards,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
