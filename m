Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1543407CC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 15:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbhCROZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 10:25:49 -0400
Received: from smtprelay0161.hostedemail.com ([216.40.44.161]:55062 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231410AbhCROZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 10:25:18 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id F3759100E7B4B;
        Thu, 18 Mar 2021 14:25:17 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3350:3622:3865:3866:3867:3871:4321:5007:7652:10004:10400:10848:11026:11657:11658:11783:11914:12043:12048:12297:12438:12740:12895:13069:13311:13357:13439:13894:14659:14721:21080:21627:30054:30080:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: eye42_4b0a25727747
X-Filterd-Recvd-Size: 1482
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Thu, 18 Mar 2021 14:25:16 +0000 (UTC)
Message-ID: <49d9c9372870da1c235b0afb01f5eab4385cbf0b.camel@perches.com>
Subject: Re: [PATCH] drm: Few typo fixes
From:   Joe Perches <joe@perches.com>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Date:   Thu, 18 Mar 2021 07:25:14 -0700
In-Reply-To: <20210318103739.27849-1-unixbhaskar@gmail.com>
References: <20210318103739.27849-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-03-18 at 16:07 +0530, Bhaskar Chowdhury wrote:
> s/instatiated/instantiated/
> s/unreference/unreferenced/

[]> diff --git a/drivers/gpu/drm/drm_property.c b/drivers/gpu/drm/drm_property.c
[]
> @@ -644,7 +644,7 @@ EXPORT_SYMBOL(drm_property_blob_get);
>   * @id: id of the blob property
>   *
>   * If successful, this takes an additional reference to the blob property.
> - * callers need to make sure to eventually unreference the returned property
> + * callers need to make sure to eventually unreferenced the returned property

I think this is worse.


