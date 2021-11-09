Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF7B744B942
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 00:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242688AbhKIXP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 18:15:59 -0500
Received: from smtprelay0210.hostedemail.com ([216.40.44.210]:39438 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229850AbhKIXP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 18:15:56 -0500
Received: from omf13.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id C0E3218039537;
        Tue,  9 Nov 2021 23:13:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf13.hostedemail.com (Postfix) with ESMTPA id 132EF1124F3;
        Tue,  9 Nov 2021 23:13:08 +0000 (UTC)
Message-ID: <3c5e49d49a1cb5c2a54fe75ba315fe563e6575d9.camel@perches.com>
Subject: Re: [RFC Patch Resend 1/2] i2c debug counters as sysfs attributes
From:   Joe Perches <joe@perches.com>
To:     Sui Chen <suichen@google.com>, linux-kernel@vger.kernel.org
Date:   Tue, 09 Nov 2021 15:13:07 -0800
In-Reply-To: <20211109225321.618688-2-suichen@google.com>
References: <20211109225321.618688-1-suichen@google.com>
         <20211109225321.618688-2-suichen@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.60
X-Stat-Signature: qtinamsx4j97k4y4gkkbu8jh53km5tgo
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 132EF1124F3
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18yA6h4mWIeIUX7rhc2fReAzD2up4lukOU=
X-HE-Tag: 1636499588-7090
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-11-09 at 14:53 -0800, Sui Chen wrote:
> This change adds a few example I2C debug counters as sysfs attributes:
> - ber_cnt (bus error count)
> - nack_cnt (NACK count)
> - rec_fail_cnt, rec_succ_cnt (recovery failure/success count)
> - timeout_cnt (timeout count)
> - i2c_speed (bus frequency)
> 
> The function i2c_adapter_create_stats_folder creates a stats directory
> in the device's sysfs directory to hold the debug counters. The platform
> drivers will instantiate the counters in the stats directory if
> available.
[]
> diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
[]
> +static ssize_t ber_cnt_show(struct device* pdev,
> +	struct device_attribute* attr, char* buf) {
> +	u64* ber_cnt = kobj_to_adapter(pdev)->stats->ber_cnt;
> +	if (ber_cnt == NULL) return 0;
> +	ssize_t ret = sprintf(buf, "%llu\n", *ber_cnt);

Please do not declare after code.

And this should instead use:

	return sysfs_emit(buf, "%llu\n", *ber_cnt);

> +	return ret;
> +}
> +DEVICE_ATTR_RO(ber_cnt);
> +
> +ssize_t nack_cnt_show(struct device* pdev,
> +	struct device_attribute* attr, char* buf) {
> +	u64* nack_cnt = kobj_to_adapter(pdev)->stats->nack_cnt;
> +	if (nack_cnt == NULL) return 0;
> +	ssize_t ret = sprintf(buf, "%llu\n", *nack_cnt);

etc...


