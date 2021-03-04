Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D61BD32D22B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 13:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239742AbhCDMAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 07:00:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:45948 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239709AbhCDMAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 07:00:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D505AAD57;
        Thu,  4 Mar 2021 11:59:35 +0000 (UTC)
Date:   Thu, 4 Mar 2021 12:59:35 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Justin Ernst <justin.ernst@hpe.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Tom Rix <trix@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mike Travis <mike.travis@hpe.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/platform/uv: Fix indentation warning in
 Documentation/ABI/testing/sysfs-firmware-sgi_uv
Message-ID: <20210304115935.GC30413@zn.tnic>
References: <20210219172835.253610-1-justin.ernst@hpe.com>
 <4b30e296-e4d2-c8af-a920-72a09932d3d1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b30e296-e4d2-c8af-a920-72a09932d3d1@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 12:55:49PM +0100, Hans de Goede wrote:
> Since this documentation documents the interface exposed by:
> drivers/platform/x86/uv_sysfs.c
> 
> I've applied this patch to the pdx86 tree now:

I've queued it already:

https://git.kernel.org/tip/2430915f8291212f2bd2155176b817c34a18a2b1

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
