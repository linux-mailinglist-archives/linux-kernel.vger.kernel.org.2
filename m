Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F4434F0A3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 20:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbhC3SNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 14:13:14 -0400
Received: from smtprelay0095.hostedemail.com ([216.40.44.95]:36168 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232714AbhC3SMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 14:12:47 -0400
Received: from omf20.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 3AC15180355C1;
        Tue, 30 Mar 2021 18:12:46 +0000 (UTC)
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA id AF43D18A614;
        Tue, 30 Mar 2021 18:12:44 +0000 (UTC)
Message-ID: <703d46e209b0e7163e46b807aba761c93b4a90c9.camel@perches.com>
Subject: Re: [PATCH] mtd: intel-spi: add is_protected and is_bios_locked
 knobs
From:   Joe Perches <joe@perches.com>
To:     Tomas Winkler <tomas.winkler@intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tamar Mashiah <tamar.mashiah@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Date:   Tue, 30 Mar 2021 11:12:43 -0700
In-Reply-To: <20210330155414.58343-1-tomas.winkler@intel.com>
References: <20210330155414.58343-1-tomas.winkler@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.10
X-Stat-Signature: gpcomsfuenzpb86i8o6mfuisqwfphgw8
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: AF43D18A614
X-HE-Tag: 1617127964-882415
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-03-30 at 18:54 +0300, Tomas Winkler wrote:
> From: Tamar Mashiah <tamar.mashiah@intel.com>
[]
> the region protection status is exposed via sysfs file
> as the manufacturing will need the both files in order to validate
> that the device is properly sealed.
[]
> diff --git a/drivers/mtd/spi-nor/controllers/intel-spi.c b/drivers/mtd/spi-nor/controllers/intel-spi.c
[]
> +static ssize_t intel_spi_is_protected_show(struct device *dev,
> +					   struct device_attribute *attr, char *buf)
> +{
> +	struct intel_spi *ispi = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%d", ispi->is_protected);

These should also include a newline in the format.  i.e.:

	return sysfs_emit(buf, "%d\n", ispi->is_protected);


> +static ssize_t intel_spi_bios_lock_show(struct device *dev,
> +					struct device_attribute *attr, char *buf)
> +{
> +	struct intel_spi *ispi = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%d", ispi->is_bios_locked);

etc...


