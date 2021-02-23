Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 301C73227E8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 10:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbhBWJfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 04:35:00 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:60594 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbhBWJeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 04:34:01 -0500
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.2.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 80BDD200E5C;
        Tue, 23 Feb 2021 09:33:19 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 64A4421174; Tue, 23 Feb 2021 10:32:43 +0100 (CET)
Date:   Tue, 23 Feb 2021 10:32:43 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia: Switch to using the new API kobj_to_dev()
Message-ID: <YDTLu8pRP6C4dPd8@light.dominikbrodowski.net>
References: <1614072410-32725-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614072410-32725-1-git-send-email-yang.lee@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Tue, Feb 23, 2021 at 05:26:50PM +0800 schrieb Yang Li:
> fixed the following coccicheck:
> ./drivers/pcmcia/cistpl.c:1584:53-54: WARNING opportunity for
> kobj_to_dev()
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Sorry, an equivalent patch is already in pcmcia-next and about to be sent
upstream.

Thanks,
	Dominik
