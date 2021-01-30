Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F394830935D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 10:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbhA3J2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 04:28:41 -0500
Received: from smtprelay0013.hostedemail.com ([216.40.44.13]:45002 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231843AbhA3J0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 04:26:43 -0500
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave02.hostedemail.com (Postfix) with ESMTP id E87B61801B76B
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 07:03:16 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 1E126181D341E;
        Sat, 30 Jan 2021 07:01:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:2895:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3871:3872:4250:4321:5007:6737:7576:7652:10004:10400:10848:11026:11232:11473:11658:11914:12043:12048:12297:12438:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21627:21990:30046:30054:30055:30064:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: tail00_061180a275af
X-Filterd-Recvd-Size: 2026
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Sat, 30 Jan 2021 07:01:31 +0000 (UTC)
Message-ID: <5137ab3793f03c17a719445f14131c16e7766434.camel@perches.com>
Subject: Re: [PATCH v3 28/34] misc: Intel tsens IA host driver.
From:   Joe Perches <joe@perches.com>
To:     mgross@linux.intel.com, markgross@kernel.org, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        palmerdabbelt@google.com, paul.walmsley@sifive.com,
        peng.fan@nxp.com, robh+dt@kernel.org, shawnguo@kernel.org,
        jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        "C, Udhayakumar" <udhayakumar.c@intel.com>, C@linux.intel.com
Date:   Fri, 29 Jan 2021 23:01:30 -0800
In-Reply-To: <20210130022124.65083-29-mgross@linux.intel.com>
References: <20210130022124.65083-1-mgross@linux.intel.com>
         <20210130022124.65083-29-mgross@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-01-29 at 18:20 -0800, mgross@linux.intel.com wrote:
> From: "C, Udhayakumar" <udhayakumar.c@intel.com>
> 
> Add Intel tsens IA host driver for Intel Edge.AI Computer Vision
> platforms.
[]
> diff --git a/drivers/misc/intel_tsens/intel_tsens_host.c b/drivers/misc/intel_tsens/intel_tsens_host.c
[]
> +static int tsens_i2c_smbus_read_byte_data(struct i2c_client *i2c, u8 command,
> +					  u8 *i2c_val)
> +{
> +	union i2c_smbus_data data;
> +	int status;
> +
> +	status = i2c_smbus_xfer(i2c->adapter, i2c->addr, i2c->flags,
> +				I2C_SMBUS_READ, command,
> +				I2C_SMBUS_BYTE_DATA, &data);

this can fail

> +	*i2c_val = data.byte;

Is it appropriate to set the value if it failed and data was
not initialized?

> +	return status;
> +}
> +
> +/**
> + * intel_tsens_get_temp - get updated temperatue

Might want to use codespell on all files.


